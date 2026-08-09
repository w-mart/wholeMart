package com.localb2b.marketplace.web;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.jsp.jstl.core.Config;
import jakarta.servlet.jsp.jstl.fmt.LocalizationContext;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;

import java.io.IOException;
import java.util.Locale;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

public class WmLocaleFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        Locale locale = resolveLocale(request);
        LocaleContextHolder.setLocale(locale);

        Config.set(request, Config.FMT_LOCALE, locale);
        Config.set(request, Config.FMT_FALLBACK_LOCALE, Locale.ENGLISH);

        try {
            ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);
            Config.set(request, Config.FMT_LOCALIZATION_CONTEXT, new LocalizationContext(bundle));
        } catch (MissingResourceException ex) {
            ResourceBundle fallbackBundle = ResourceBundle.getBundle("messages", Locale.ENGLISH);
            Config.set(request, Config.FMT_LOCALIZATION_CONTEXT, new LocalizationContext(fallbackBundle));
        }

        try {
            filterChain.doFilter(request, response);
        } finally {
            LocaleContextHolder.resetLocaleContext();
        }
    }

    private Locale resolveLocale(HttpServletRequest request) {
        LocaleResolver resolver = RequestContextUtils.getLocaleResolver(request);
        if (resolver != null) {
            Locale resolved = resolver.resolveLocale(request);
            if (resolved != null) {
                return resolved;
            }
        }
        return request.getLocale() != null ? request.getLocale() : Locale.getDefault();
    }
}
