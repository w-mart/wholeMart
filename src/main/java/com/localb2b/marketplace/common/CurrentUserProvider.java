package com.localb2b.marketplace.common;

import com.localb2b.marketplace.security.MarketplacePrincipal;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Component
public class CurrentUserProvider {
    public CurrentUser requireCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof MarketplacePrincipal principal) {
            return new CurrentUser(principal.userId(), principal.role(), principal.mobile());
        }

        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        if (requestAttributes instanceof ServletRequestAttributes servletAttributes) {
            HttpSession session = servletAttributes.getRequest().getSession(false);
            if (session != null) {
                return requireSessionUser(session);
            }
        }

        throw new IllegalStateException("No authenticated user found");
    }

    public CurrentUser requireSessionUser(HttpSession session) {
        Object userId = session.getAttribute("userId");
        Object role = session.getAttribute("role");
        Object mobile = session.getAttribute("mobile");
        Long id = null;

        if (userId instanceof Number number) {
            id = number.longValue();
        } else if (userId instanceof String text && !text.isBlank()) {
            try {
                id = Long.parseLong(text.trim());
            } catch (NumberFormatException ignored) {
            }
        }

        if (id != null && role instanceof String roleName) {
            return new CurrentUser(id, com.localb2b.marketplace.user.UserRole.valueOf(roleName), mobile == null ? "" : mobile.toString());
        }
        return requireCurrentUser();
    }
}
