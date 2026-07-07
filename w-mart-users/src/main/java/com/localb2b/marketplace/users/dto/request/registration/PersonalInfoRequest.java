package com.localb2b.marketplace.users.dto.request.registration;

import com.localb2b.marketplace.users.enums.UserRole;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class PersonalInfoRequest {
    private String firstName;
    private String middleName;
    private String lastName;
    private String mobileNumber;
    private String alternateMobileNumber;
    private String email;
    private String password;
    private String confirmPassword;
    private UserRole role;
}
