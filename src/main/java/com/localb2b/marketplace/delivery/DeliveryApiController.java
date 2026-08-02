package com.localb2b.marketplace.delivery;
import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.common.CurrentUserProvider;
import com.localb2b.marketplace.driver.DriverLocation;
import com.localb2b.marketplace.driver.DriverLocationRepository;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/deliveries")
public class DeliveryApiController {
    private final DeliveryService deliveryService;
    private final CurrentUserProvider currentUserProvider;
    private final DriverLocationRepository driverLocationRepository;
    public DeliveryApiController(DeliveryService deliveryService,
                                  CurrentUserProvider currentUserProvider,
                                  DriverLocationRepository driverLocationRepository) {
        this.deliveryService = deliveryService;
        this.currentUserProvider = currentUserProvider;
        this.driverLocationRepository = driverLocationRepository;
    }


    @GetMapping
    public Page<DeliveryDto> mine(@RequestParam(defaultValue = "0") int page,
                                   @RequestParam(defaultValue = "20") int size) {
        return deliveryService.getMyDeliveries(currentUserProvider.requireCurrentUser(), page, size);
    }

    @GetMapping("/active")
    public List<DeliveryDto> activeDeliveries() {
        CurrentUser currentUser = currentUserProvider.requireCurrentUser();
        return deliveryService.getActiveDeliveries(currentUser.userId());
    }



    // ===== DRIVER MATCHING =====
    @PostMapping("/match/{orderId}")
    public ResponseEntity<?> initiateMatching(@PathVariable Long orderId,
                                               @RequestParam BigDecimal distLat,
                                               @RequestParam BigDecimal distLng) {
        Optional<DeliveryAssignment> assignment = deliveryService.initiateDriverMatching(orderId, distLat, distLng);
        if (assignment.isPresent()) {
            return ResponseEntity.ok(toDto(assignment.get()));
        }
        return ResponseEntity.accepted().body("No driver available at the moment. Order is waiting for driver.");
    }



    // ===== DRIVER ACCEPT/REJECT =====
    @PostMapping("/{id}/accept")
    public DeliveryDto accept(@PathVariable Long id) {
        return toDto(deliveryService.acceptDelivery(id, currentUserProvider.requireCurrentUser()));
    }

    @PostMapping("/{id}/reject")
    public ResponseEntity<?> reject(@PathVariable Long id, @RequestParam(required = false) String reason) {
        CurrentUser currentUser = currentUserProvider.requireCurrentUser();
        Optional<DeliveryAssignment> nextAssignment = deliveryService.rejectDelivery(id, currentUser.userId(), reason);
        if (nextAssignment.isPresent()) {
            return ResponseEntity.ok(toDto(nextAssignment.get()));
        }
        return ResponseEntity.ok("No more drivers available. Order is waiting for driver.");
    }



    // ===== PICKUP/DELIVERY OTP VERIFICATION =====
    @PostMapping("/{id}/verify-pickup")
    public DeliveryDto verifyPickup(@PathVariable Long id, @RequestParam String otp) {
        return toDto(deliveryService.verifyPickup(id, otp));
    }

    @PostMapping("/{id}/verify-delivery")
    public DeliveryDto verifyDelivery(@PathVariable Long id, @RequestParam String otp) {
        return toDto(deliveryService.verifyDelivery(id, otp));
    }



    // ===== DRIVER LOCATION =====
    @PostMapping("/driver/go-online")
    public DriverLocation goOnline(@RequestParam BigDecimal latitude,
                                    @RequestParam BigDecimal longitude) {
        CurrentUser currentUser = currentUserProvider.requireCurrentUser();
        DriverLocation dl = driverLocationRepository.findByDriverUserId(currentUser.userId())
                .orElseGet(() -> new DriverLocation(currentUser.userId(), latitude, longitude, ""));
        dl.goOnline(latitude, longitude);
        return driverLocationRepository.save(dl);
    }

    @PostMapping("/driver/go-offline")
    public void goOffline() {
        CurrentUser currentUser = currentUserProvider.requireCurrentUser();
        driverLocationRepository.findByDriverUserId(currentUser.userId()).ifPresent(dl -> {
            dl.goOffline();
            driverLocationRepository.save(dl);
        });
    }
    
    @PostMapping("/driver/update-location")
    public void updateLocation(@RequestParam BigDecimal latitude,
                                @RequestParam BigDecimal longitude) {
        CurrentUser currentUser = currentUserProvider.requireCurrentUser();
        deliveryService.updateDriverLocation(currentUser.userId(), latitude, longitude);
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
