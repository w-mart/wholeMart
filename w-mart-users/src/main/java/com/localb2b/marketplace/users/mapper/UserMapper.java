package com.localb2b.marketplace.users.mapper;

import com.localb2b.marketplace.users.dto.response.UserResponse;
import com.localb2b.marketplace.users.entity.User;

public class UserMapper {
    public UserResponse toResponse(User entity) {
        UserResponse response = new UserResponse();
        response.setId(entity.getId() != null ? entity.getId().toString() : null);
        response.setUsername(entity.getFirstName()); // Changed from getUsername() which does not exist
        return response;
    }
}
