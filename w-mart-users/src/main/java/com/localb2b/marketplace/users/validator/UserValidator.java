package com.localb2b.marketplace.users.validator;

import com.localb2b.marketplace.users.entity.User;

public class UserValidator {
    public boolean isValid(User entity) {
        return entity != null && entity.getFirstName() != null;
    }
}
