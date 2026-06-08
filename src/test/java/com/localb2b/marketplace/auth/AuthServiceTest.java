package com.localb2b.marketplace.auth;

import com.localb2b.marketplace.auth.dto.AuthDtos.LoginRequest;
import com.localb2b.marketplace.distributor.DistributorProfile;
import com.localb2b.marketplace.distributor.DistributorProfileRepository;
import com.localb2b.marketplace.driver.DriverProfileRepository;
import com.localb2b.marketplace.retailer.RetailerProfileRepository;
import com.localb2b.marketplace.security.JwtService;
import com.localb2b.marketplace.user.UserAccount;
import com.localb2b.marketplace.user.UserRepository;
import com.localb2b.marketplace.user.UserRole;
import com.localb2b.marketplace.user.UserStatus;
import java.math.BigDecimal;
import java.util.Optional;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import static org.junit.jupiter.api.Assertions.assertThrows;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.util.ReflectionTestUtils;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class AuthServiceTest {
    @Mock
    private UserRepository userRepository;

    @Mock
    private JwtService jwtService;

    @Mock
    private RetailerProfileRepository retailerProfileRepository;

    @Mock
    private DistributorProfileRepository distributorProfileRepository;

    @Mock
    private DriverProfileRepository driverProfileRepository;

    private AuthService authService;

    @BeforeEach
    void setUp() {
        authService = new AuthService(
                userRepository,
                jwtService,
                retailerProfileRepository,
                distributorProfileRepository,
                driverProfileRepository);
    }

    @Test
    void loginCreatesMissingDistributorProfile() {
        UserAccount savedUser = new UserAccount("Asha Traders", "9999999999", UserRole.ROLE_DISTRIBUTOR);
        ReflectionTestUtils.setField(savedUser, "id", 7L);
        when(userRepository.findByMobile("9999999999")).thenReturn(Optional.empty());
        when(userRepository.save(any(UserAccount.class))).thenReturn(savedUser);
        when(distributorProfileRepository.findByUserId(7L)).thenReturn(Optional.empty());
        when(jwtService.createAccessToken(savedUser)).thenReturn("access");
        when(jwtService.createRefreshToken(savedUser)).thenReturn("refresh");

        var response = authService.login(new LoginRequest(
                "9999999999",
                UserRole.ROLE_DISTRIBUTOR,
                "Asha Traders",
                "Asha Wholesale",
                "Asha Patel",
                "Asha Shop",
                "29ABCDE1234F1Z5",
                "Bengaluru",
                "Karnataka",
                "12 Market Road",
                "560001",
                "asha@example.com",
                "9888888888",
                BigDecimal.valueOf(12.971599),
                BigDecimal.valueOf(77.594566)));

        ArgumentCaptor<DistributorProfile> profileCaptor = ArgumentCaptor.forClass(DistributorProfile.class);
        verify(distributorProfileRepository).save(profileCaptor.capture());
        assertThat(profileCaptor.getValue().getUserId()).isEqualTo(7L);
        assertThat(profileCaptor.getValue().getBusinessName()).isEqualTo("Asha Wholesale");
        assertThat(profileCaptor.getValue().getContactName()).isEqualTo("Asha Patel");
        assertThat(profileCaptor.getValue().getShopName()).isEqualTo("Asha Shop");
        assertThat(profileCaptor.getValue().getGstin()).isEqualTo("29ABCDE1234F1Z5");
        assertThat(profileCaptor.getValue().getCity()).isEqualTo("Bengaluru");
        assertThat(profileCaptor.getValue().getState()).isEqualTo("Karnataka");
        assertThat(profileCaptor.getValue().getAddressLine()).isEqualTo("12 Market Road");
        assertThat(profileCaptor.getValue().getPincode()).isEqualTo("560001");
        assertThat(profileCaptor.getValue().getEmail()).isEqualTo("asha@example.com");
        assertThat(profileCaptor.getValue().getAlternateMobile()).isEqualTo("9888888888");
        assertThat(response.userId()).isEqualTo(7L);
    }

    @Test
    void refreshFailsForSuspendedUser() {
        UserAccount suspended = new UserAccount("Bob Retail", "8888888888", UserRole.ROLE_RETAILER);
        ReflectionTestUtils.setField(suspended, "id", 9L);
        suspended.suspend();

        when(jwtService.parse("refresh-token")).thenReturn(new com.localb2b.marketplace.security.MarketplacePrincipal(9L, UserRole.ROLE_RETAILER, "8888888888"));
        when(userRepository.findById(9L)).thenReturn(Optional.of(suspended));

        assertThrows(org.springframework.web.server.ResponseStatusException.class, () -> authService.refresh("refresh-token"));
    }

    @Test
    void loginRejectsRoleMismatchForExistingUser() {
        UserAccount existingUser = new UserAccount("Asha Traders", "9999999999", UserRole.ROLE_RETAILER);
        ReflectionTestUtils.setField(existingUser, "id", 8L);
        when(userRepository.findByMobile("9999999999")).thenReturn(Optional.of(existingUser));

        assertThrows(IllegalArgumentException.class, () -> authService.login(new LoginRequest(
                "9999999999",
                UserRole.ROLE_DISTRIBUTOR,
                "Asha Traders",
                "Asha Wholesale",
                "Asha Patel",
                "Asha Shop",
                "29ABCDE1234F1Z5",
                "Bengaluru",
                "Karnataka",
                "12 Market Road",
                "560001",
                "asha@example.com",
                "9888888888",
                BigDecimal.valueOf(12.971599),
                BigDecimal.valueOf(77.594566))));
    }
}
