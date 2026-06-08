package com.localb2b.marketplace.security;

import jakarta.servlet.http.HttpServletResponse;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http, JwtAuthenticationFilter jwtAuthenticationFilter, SessionAuthenticationFilter sessionAuthenticationFilter) throws Exception {
        return http
                .csrf(csrf -> csrf.ignoringRequestMatchers("/api/**", "/web/auth/**"))
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED))
                .exceptionHandling(exceptions -> exceptions
                        .authenticationEntryPoint((request, response, authException) -> {
                            if (request.getRequestURI().startsWith("/web/")) {
                                response.sendRedirect("/web/auth/login");
                                return;
                            }
                            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
                        })
                        .accessDeniedHandler((request, response, accessDeniedException) -> {
                            if (request.getRequestURI().startsWith("/web/")) {
                                Object role = request.getSession(false) == null ? null : request.getSession(false).getAttribute("role");
                                response.sendRedirect(dashboardPath(role));
                                return;
                            }
                            response.sendError(HttpServletResponse.SC_FORBIDDEN);
                        }))
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/", "/css/**", "/js/**", "/images/**", "/webjars/**",
                                "/web/auth/**", "/api/v1/auth/**", "/WEB-INF/views/**", "/error",
                                "/swagger-ui.html", "/swagger-ui/**", "/api-docs/**", "/actuator/health").permitAll()
                        .requestMatchers("/web/admin/**", "/api/v1/admin/**").hasAuthority("ROLE_ADMIN")
                        .requestMatchers("/web/retailer/**").hasAuthority("ROLE_RETAILER")
                        .requestMatchers("/web/distributor/**").hasAuthority("ROLE_DISTRIBUTOR")
                        .requestMatchers("/web/driver/**").hasAuthority("ROLE_DRIVER")
                        .anyRequest().authenticated())
                .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class)
                .addFilterBefore(sessionAuthenticationFilter, UsernamePasswordAuthenticationFilter.class)
                .build();
    }

    private static String dashboardPath(Object role) {
        if ("ROLE_ADMIN".equals(role)) {
            return "/web/admin/dashboard";
        }
        if ("ROLE_RETAILER".equals(role)) {
            return "/web/retailer/dashboard";
        }
        if ("ROLE_DRIVER".equals(role)) {
            return "/web/driver/dashboard";
        }
        if ("ROLE_DISTRIBUTOR".equals(role)) {
            return "/web/distributor/dashboard";
        }
        return "/web/auth/login";
    }
}
