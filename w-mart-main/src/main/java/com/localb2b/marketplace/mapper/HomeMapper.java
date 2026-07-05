package com.localb2b.marketplace.mapper;

import com.localb2b.marketplace.dto.LoginRequest;
import org.springframework.stereotype.Component;

@Component
public class HomeMapper {

    public String mapLoginRequestToString(LoginRequest loginRequest) {
        return loginRequest.getUsername() + ":" + loginRequest.getRole();
    }
}
