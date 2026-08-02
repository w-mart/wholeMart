package com.localb2b.marketplace.admin;

import com.localb2b.marketplace.distributor.DistributorDto;
import com.localb2b.marketplace.common.Pageables;
import com.localb2b.marketplace.order.OrderDto;
import com.localb2b.marketplace.payment.PaymentDto;
import org.springframework.web.bind.annotation.RequestParam;
import com.localb2b.marketplace.distributor.DistributorService;
import com.localb2b.marketplace.order.MarketplaceOrder;
import com.localb2b.marketplace.order.OrderRepository;
import com.localb2b.marketplace.payment.Payment;
import com.localb2b.marketplace.payment.PaymentRepository;
import com.localb2b.marketplace.user.UserAccount;
import com.localb2b.marketplace.user.UserDto;
import com.localb2b.marketplace.user.UserRepository;
import com.localb2b.marketplace.driver.DriverProfile;
import com.localb2b.marketplace.driver.DriverProfileRepository;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/admin")
public class AdminApiController {
    private final DistributorService distributorService;
    private final OrderRepository orderRepository;
    private final PaymentRepository paymentRepository;
    private final UserRepository userRepository;
    private final DriverProfileRepository driverProfileRepository;
    private final com.localb2b.marketplace.audit.AuditRepository auditRepository;

    public AdminApiController(DistributorService distributorService,
            OrderRepository orderRepository, PaymentRepository paymentRepository, UserRepository userRepository,
            DriverProfileRepository driverProfileRepository,
            com.localb2b.marketplace.audit.AuditRepository auditRepository) {
        this.distributorService = distributorService;
        this.orderRepository = orderRepository;
        this.paymentRepository = paymentRepository;
        this.userRepository = userRepository;
        this.driverProfileRepository = driverProfileRepository;
        this.auditRepository = auditRepository;
    }

    @GetMapping("/distributors")
    public Page<DistributorDto> distributors(@RequestParam(defaultValue = "0") int page,
                                             @RequestParam(defaultValue = "20") int size) {
        Pageable pageable = Pageables.bounded(page, size);
        return distributorService.findAllProfiles(pageable)
                .map(serviceDto -> new DistributorDto(serviceDto.id(), serviceDto.userId(), serviceDto.businessName(), serviceDto.isApproved(), serviceDto.gstin()));
    }

    @GetMapping("/orders")
    public Page<OrderDto> orders(@RequestParam(defaultValue = "0") int page,
                                 @RequestParam(defaultValue = "20") int size) {
        Pageable pageable = Pageables.bounded(page, size);
        return orderRepository.findAll(pageable).map(this::toOrderDto);
    }

    @GetMapping("/payments")
    public Page<PaymentDto> payments(@RequestParam(defaultValue = "0") int page,
                                     @RequestParam(defaultValue = "20") int size) {
        Pageable pageable = Pageables.bounded(page, size);
        return paymentRepository.findAll(pageable).map(this::toPaymentDto);
    }

    @GetMapping("/users")
    public Page<UserDto> users(@RequestParam(defaultValue = "0") int page,
                               @RequestParam(defaultValue = "20") int size) {
        Pageable pageable = Pageables.bounded(page, size);
        return userRepository.findAll(pageable).map(this::toUserDto);
    }

    @PostMapping("/users/{id}/approve")
    public UserDto approveUser(@PathVariable Long id) {
        UserAccount user = userRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("User not found"));
        user.approve();
        userRepository.save(user);
        auditRepository.save(new com.localb2b.marketplace.audit.AuditEvent(getActorUserId(), "APPROVE_USER", "UserAccount", id));
        return toUserDto(user);
    }

    @PostMapping("/users/{id}/suspend")
    public UserDto suspendUser(@PathVariable Long id) {
        UserAccount user = userRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("User not found"));
        user.suspend();
        userRepository.save(user);
        auditRepository.save(new com.localb2b.marketplace.audit.AuditEvent(getActorUserId(), "SUSPEND_USER", "UserAccount", id));
        return toUserDto(user);
    }

    private Long getActorUserId() {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof com.localb2b.marketplace.security.MarketplacePrincipal p) {
            return p.userId();
        }
        return null;
    }

    @PostMapping("/distributors/{id}/approve")
    public DistributorDto approveDistributor(@PathVariable Long id) {
        Long actor = getActorUserId();
        // The approve method in DistributorService returns its nested DistributorDto, which needs to be converted to the top-level DistributorDto.
        com.localb2b.marketplace.distributor.DistributorService.DistributorDto serviceDto = distributorService.approve(id);
        auditRepository.save(new com.localb2b.marketplace.audit.AuditEvent(actor, "APPROVE_DISTRIBUTOR", "DistributorProfile", id));
        return new DistributorDto(serviceDto.id(), serviceDto.userId(), serviceDto.businessName(), serviceDto.isApproved(), serviceDto.gstin());
    }

    // ===== KYC & DRIVER APPROVAL =====

    @GetMapping("/drivers/pending")
    public List<DriverProfile> pendingDrivers() {
        return driverProfileRepository.findByApprovedFalse();
    }

    @PostMapping("/drivers/{id}/approve")
    public DriverProfile approveDriver(@PathVariable Long id) {
        DriverProfile profile = driverProfileRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Driver profile not found"));
        profile.approve();
        profile = driverProfileRepository.save(profile);
        auditRepository.save(new com.localb2b.marketplace.audit.AuditEvent(getActorUserId(), "APPROVE_DRIVER", "DriverProfile", id));
        return profile;
    }

    @PostMapping("/gst/verify/{distributorId}")
    public DistributorDto verifyGst(@PathVariable Long distributorId) {
        // The approve method in DistributorService returns its nested DistributorDto, which needs to be converted to the top-level DistributorDto.
        com.localb2b.marketplace.distributor.DistributorService.DistributorDto serviceDto = distributorService.approve(distributorId);
        return new DistributorDto(serviceDto.id(), serviceDto.userId(), serviceDto.businessName(), serviceDto.isApproved(), serviceDto.gstin());
    }

    private OrderDto toOrderDto(MarketplaceOrder order) {
        return new OrderDto(
                order.getId(),
                order.getRetailerUserId(),
                order.getDistributorUserId(),
                order.getTotalAmount(),
                order.getPartialAmount(),
                order.getPaidAmount(),
                order.getPaymentMode(),
                order.getStatus(),
                order.getDeliveryAddress(),
                order.getDeliverySlot(),
                order.getDeliveryPincode(),
                order.getPickupOtp(),
                order.getDeliveryOtp(),
                order.getRejectionReason(),
                order.getDistributorNotes(),
                order.getCodCollected(),
                order.getCodCollectedAmount(),
                order.getPackedAt(),
                order.getReadyForPickupAt(),
                order.getPickedUpAt(),
                order.getDeliveredAt(),
                order.getCompletedAt(),
                order.getCreatedAt());
    }

    private PaymentDto toPaymentDto(Payment payment) {
        return new PaymentDto(payment.getId(), payment.getOrderId(), payment.getAmount(), payment.getStatus(), payment.getPaymentMethod(), payment.getPaymentReference(), payment.getCreatedAt());
    }

    private UserDto toUserDto(UserAccount user) {
        return new UserDto(user.getId(), user.getName(), user.getMobile(), user.getRole(), user.getStatus(), user.getCreatedAt());
    }
}
