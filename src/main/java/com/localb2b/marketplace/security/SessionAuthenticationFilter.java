package com.localb2b.marketplace.security;

import com.localb2b.marketplace.user.UserRepository;
import com.localb2b.marketplace.user.UserRole;
import com.localb2b.marketplace.user.UserStatus;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

@Component
public class SessionAuthenticationFilter extends OncePerRequestFilter {
    private static final Logger log = LoggerFactory.getLogger(SessionAuthenticationFilter.class);

    private final UserRepository userRepository;

    public SessionAuthenticationFilter(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object sessionUserId = session.getAttribute("userId");
            Object sessionRole = session.getAttribute("role");
            Long userId = null;
            if (sessionUserId instanceof Number number) {
                userId = number.longValue();
            } else if (sessionUserId instanceof String text && !text.isBlank()) {
                try {
                    userId = Long.parseLong(text);
                } catch (NumberFormatException ignored) {
                }
            }
            if (userId != null && sessionRole != null) {
                try {
                    UserRole role = sessionRole instanceof UserRole ? (UserRole) sessionRole : UserRole.valueOf(String.valueOf(sessionRole));
                    Authentication currentAuthentication = SecurityContextHolder.getContext().getAuthentication();
                    if (shouldUseSessionAuthentication(currentAuthentication, userId, role)) {
                        var userOpt = userRepository.findById(userId);
                        if (userOpt.isEmpty() || userOpt.get().getStatus() != UserStatus.ACTIVE) {
                            SecurityContextHolder.clearContext();
                        } else {
                            String mobile = String.valueOf(session.getAttribute("mobile"));
                            MarketplacePrincipal principal = new MarketplacePrincipal(userId, role, mobile);
                            SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(
                                    principal, null, List.of(new SimpleGrantedAuthority(role.name()))));
                        }
                    }
                } catch (IllegalArgumentException ex) {
                    log.debug("Invalid session role '{}', clearing security context", sessionRole, ex);
                    SecurityContextHolder.clearContext();
                }
            }
        }
        filterChain.doFilter(request, response);
    }

    private boolean shouldUseSessionAuthentication(Authentication authentication, Long userId, UserRole role) {
        if (authentication == null) {
            return true;
        }
        if (authentication.getPrincipal() instanceof MarketplacePrincipal principal) {
            return !userId.equals(principal.userId()) || role != principal.role();
        }
        return false;
    }
}
