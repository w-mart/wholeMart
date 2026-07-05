package com.localb2b.marketplace.service;

import com.localb2b.marketplace.dto.LoginRequest;
import com.localb2b.marketplace.dto.LoginResponse;

public interface LoginService {

    LoginResponse authenticate(LoginRequest loginRequest);

    void validateCredentials(String username, String password);
}
