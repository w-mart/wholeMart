package com.localb2b.marketplace.common;

import com.localb2b.marketplace.security.MarketplacePrincipal;
import com.localb2b.marketplace.user.UserRole;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

@Component
public class CurrentUserProvider {
    public CurrentUser requireCurrentUser() {
        var authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof MarketplacePrincipal principal) {
            return new CurrentUser(principal.userId(), principal.role(), principal.mobile());
        }
        throw new IllegalStateException("Current user is not authenticated");
    }

    public CurrentUser requireSessionUser(HttpSession session) {
        if (session == null) {
            throw new IllegalStateException("Current user session is not available");
        }
        Object userIdValue = session.getAttribute("userId");
        Object roleValue = session.getAttribute("role");
        Long userId = toLong(userIdValue);
        if (userId == null || roleValue == null) {
            throw new IllegalStateException("Current user session is not authenticated");
        }
        UserRole role = roleValue instanceof UserRole userRole ? userRole : UserRole.valueOf(String.valueOf(roleValue));
        Object mobileValue = session.getAttribute("mobile");
        return new CurrentUser(userId, role, mobileValue == null ? null : String.valueOf(mobileValue));
    }

    private static Long toLong(Object value) {
        if (value instanceof Number number) {
            return number.longValue();
        }
        if (value instanceof String text && !text.isBlank()) {
            return Long.parseLong(text);
        }
        return null;
    }
}
