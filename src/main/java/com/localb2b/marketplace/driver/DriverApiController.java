package com.localb2b.marketplace.driver;

import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.common.CurrentUserProvider;
import com.localb2b.marketplace.delivery.DeliveryAssignment;
import com.localb2b.marketplace.delivery.DeliveryDto;
import com.localb2b.marketplace.delivery.DeliveryRepository;
import com.localb2b.marketplace.delivery.DeliveryService;
import com.localb2b.marketplace.delivery.DeliveryStatus;
import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;
import java.util.Optional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/driver")
public class DriverApiController {

    private final CurrentUserProvider currentUserProvider;
    private final DriverProfileRepository driverProfileRepository;
    private final DriverLocationRepository driverLocationRepository;
    private final DeliveryRepository deliveryRepository;
    private final DeliveryService deliveryService;

    public DriverApiController(CurrentUserProvider currentUserProvider,
                               DriverProfileRepository driverProfileRepository,
                               DriverLocationRepository driverLocationRepository,
                               DeliveryRepository deliveryRepository,
                               DeliveryService deliveryService) {
        this.currentUserProvider = currentUserProvider;
        this.driverProfileRepository = driverProfileRepository;
        this.driverLocationRepository = driverLocationRepository;
        this.deliveryRepository = deliveryRepository;
        this.deliveryService = deliveryService;
    }

    // ===== PROFILE =====

    @GetMapping("/profile")
    public DriverProfile getProfile() {
        CurrentUser cu = currentUserProvider.requireCurrentUser();
        return driverProfileRepository.findByUserId(cu.userId())
                .orElseThrow(() -> new IllegalArgumentException("Driver profile not found"));
    }

    @PostMapping("/profile/update")
    public DriverProfile updateProfile(@RequestParam(required = false) String displayName,
                                       @RequestParam(required = false) String licenseNumber,
                                       @RequestParam(required = false) String aadhaarNumber,
                                       @RequestParam(required = false) String panNumber,
                                       @RequestParam(required = false) String vehicleType,
                                       @RequestParam(required = false) String vehicleNumber,
                                       @RequestParam(required = false) String vehicleModel,
                                       @RequestParam(required = false) String vehicleColor,
                                       @RequestParam(required = false) String bankAccountNumber,
                                       @RequestParam(required = false) String bankIfscCode,
                                       @RequestParam(required = false) String bankName,
                                       @RequestParam(required = false) String upiId,
                                       @RequestParam(required = false) String addressLine,
                                       @RequestParam(required = false) String city,
                                       @RequestParam(required = false) String state,
                                       @RequestParam(required = false) String pincode) {
        CurrentUser cu = currentUserProvider.requireCurrentUser();
        DriverProfile profile = driverProfileRepository.findByUserId(cu.userId())
                .orElseGet(() -> new DriverProfile(cu.userId(), displayName != null ? displayName : "Driver"));
        if (displayName != null && !displayName.isBlank()) profile.setDisplayName(displayName);
        profile.updateKyc(licenseNumber, aadhaarNumber, panNumber);
        profile.updateVehicle(vehicleType, vehicleNumber, vehicleModel, vehicleColor);
        profile.updateBankDetails(bankAccountNumber, bankIfscCode, bankName, upiId);
        if (addressLine != null && !addressLine.isBlank()) profile.setAddressLine(addressLine);
        if (city != null && !city.isBlank()) profile.setCity(city);
        if (state != null && !state.isBlank()) profile.setState(state);
        if (pincode != null && !pincode.isBlank()) profile.setPincode(pincode);
        return driverProfileRepository.save(profile);
    }

    // ===== ONLINE / OFFLINE =====

    @PostMapping("/go-online")
    public DriverLocation goOnline(@RequestParam BigDecimal latitude,
                                   @RequestParam BigDecimal longitude,
                                   @RequestParam(required = false) String vehicleType) {
        CurrentUser cu = currentUserProvider.requireCurrentUser();
        DriverLocation dl = driverLocationRepository.findByDriverUserId(cu.userId())
                .orElseGet(() -> new DriverLocation(cu.userId(), latitude, longitude, vehicleType != null ? vehicleType : ""));
        dl.goOnline(latitude, longitude);
        if (vehicleType != null && !vehicleType.isBlank()) dl.setVehicleType(vehicleType);
        return driverLocationRepository.save(dl);
    }

    @PostMapping("/go-offline")
    public void goOffline() {
        CurrentUser cu = currentUserProvider.requireCurrentUser();
        driverLocationRepository.findByDriverUserId(cu.userId()).ifPresent(dl -> {
            dl.goOffline();
            driverLocationRepository.save(dl);
        });
    }

    @GetMapping("/status")
    public DriverLocation getStatus() {
        CurrentUser cu = currentUserProvider.requireCurrentUser();
        return driverLocationRepository.findByDriverUserId(cu.userId())
                .orElse(null);
    }

    // ===== STATS / DASHBOARD =====

    @GetMapping("/stats")
    public DriverStats getStats() {
        CurrentUser cu = currentUserProvider.requireCurrentUser();
        DriverProfile profile = driverProfileRepository.findByUserId(cu.userId()).orElse(null);

        // Today's deliveries
        ZoneId zone = ZoneId.systemDefault();
        Instant todayStart = LocalDate.now(zone).atStartOfDay(zone).toInstant();
        Instant todayEnd = LocalDate.now(zone).plusDays(1).atStartOfDay(zone).toInstant();

        List<DeliveryAssignment> allDeliveries = deliveryRepository.findByDriverUserId(cu.userId());
        List<DeliveryAssignment> todayDeliveries = allDeliveries.stream()
                .filter(d -> !d.getCreatedAt().isBefore(todayStart) && d.getCreatedAt().isBefore(todayEnd))
                .toList();

        long totalDeliveries = allDeliveries.size();
        long completedDeliveries = allDeliveries.stream()
                .filter(d -> d.getStatus() == DeliveryStatus.DELIVERED).count();
        long activeDeliveries = allDeliveries.stream()
                .filter(d -> d.getStatus() != DeliveryStatus.DELIVERED && d.getStatus() != DeliveryStatus.FAILED)
                .count();
        long todayDeliveriesCount = todayDeliveries.size();
        long rejectedDeliveries = allDeliveries.stream()
                .filter(d -> d.getStatus() == DeliveryStatus.DRIVER_REJECTED || d.getStatus() == DeliveryStatus.FAILED)
                .count();

        BigDecimal totalEarnings = profile != null && profile.getTotalEarnings() != null
                ? profile.getTotalEarnings() : BigDecimal.ZERO;
        BigDecimal todayEarnings = profile != null && profile.getTodayEarnings() != null
                ? profile.getTodayEarnings() : BigDecimal.ZERO;
        Integer totalTrips = profile != null && profile.getTotalTrips() != null
                ? profile.getTotalTrips() : 0;

        boolean isOnline = driverLocationRepository.findByDriverUserId(cu.userId())
                .map(DriverLocation::isOnline).orElse(false);

        return new DriverStats(totalDeliveries, completedDeliveries, activeDeliveries,
                todayDeliveriesCount, rejectedDeliveries, totalEarnings, todayEarnings,
                totalTrips, isOnline);
    }

    // ===== ACTIVE DELIVERIES =====

    @GetMapping("/active-deliveries")
    public List<DeliveryDto> activeDeliveries() {
        CurrentUser cu = currentUserProvider.requireCurrentUser();
        return deliveryService.getActiveDeliveries(cu.userId());
    }

    // ===== EARNINGS HISTORY =====

    @GetMapping("/earnings")
    public DriverEarningsResponse getEarnings() {
        CurrentUser cu = currentUserProvider.requireCurrentUser();
        DriverProfile profile = driverProfileRepository.findByUserId(cu.userId()).orElse(null);
        List<DeliveryAssignment> completed = deliveryRepository.findByDriverUserIdAndStatus(cu.userId(), DeliveryStatus.DELIVERED);

        BigDecimal totalEarnings = profile != null && profile.getTotalEarnings() != null
                ? profile.getTotalEarnings() : BigDecimal.ZERO;
        BigDecimal todayEarnings = profile != null && profile.getTodayEarnings() != null
                ? profile.getTodayEarnings() : BigDecimal.ZERO;
        Integer totalTrips = profile != null && profile.getTotalTrips() != null
                ? profile.getTotalTrips() : 0;

        // Calculate delivery fee earnings from completed deliveries
        BigDecimal deliveryFeeEarnings = completed.stream()
                .map(d -> d.getDeliveryFee() != null ? d.getDeliveryFee() : BigDecimal.ZERO)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        return new DriverEarningsResponse(totalEarnings, todayEarnings, totalTrips,
                completed.size(), deliveryFeeEarnings);
    }

    // ===== INNER RECORDS =====

    public record DriverStats(
            long totalDeliveries,
            long completedDeliveries,
            long activeDeliveries,
            long todayDeliveries,
            long rejectedDeliveries,
            BigDecimal totalEarnings,
            BigDecimal todayEarnings,
            int totalTrips,
            boolean isOnline) {
    }

    public record DriverEarningsResponse(
            BigDecimal totalEarnings,
            BigDecimal todayEarnings,
            int totalTrips,
            long completedDeliveries,
            BigDecimal deliveryFeeEarnings) {
    }

    private DeliveryDto toDto(DeliveryAssignment delivery) {
        return new DeliveryDto(
                delivery.getId(),
                delivery.getOrderId(),
                delivery.getDriverUserId(),
                delivery.getStatus(),
                delivery.getPickupOtp(),
                delivery.getDeliveryOtp(),
                delivery.getDriverAcceptedAt(),
                delivery.getPickedUpAt(),
                delivery.getDeliveredAt(),
                delivery.getRejectionReason(),
                delivery.getPickupLatitude(),
                delivery.getPickupLongitude(),
                delivery.getDeliveryLatitude(),
                delivery.getDeliveryLongitude(),
                delivery.getDeliveryFee(),
                delivery.getCreatedAt());
    }
}
