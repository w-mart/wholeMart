package com.localb2b.marketplace.users.service;

import com.localb2b.marketplace.users.dto.request.UserRegistrationRequest;

public interface RegistrationService {

    void registerUser(UserRegistrationRequest request);

}