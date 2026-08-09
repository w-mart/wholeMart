package com.localb2b.marketplace.web;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.LocaleResolver;

import java.util.Locale;

public class WmLocaleResolver implements LocaleResolver {

    @Override
    public Locale resolveLocale(HttpServletRequest request) {
        String lang = request.getParameter("lang");
        if (lang == null || lang.isBlank()) {
            lang = resolveFromSession(request);
        }
        if (lang == null || lang.isBlank()) {
            lang = resolveFromCookie(request);
        }
        if (lang == null || lang.isBlank()) {
            return Locale.getDefault();
        }

        return toLocale(lang);
    }

    @Override
    public void setLocale(HttpServletRequest request, HttpServletResponse response, Locale locale) {
        String code = locale == null ? null : locale.getLanguage();
        if (code == null || code.isBlank()) {
            code = "en";
        }

        if ("eng".equalsIgnoreCase(code)) {
            code = "en";
        } else if ("hin".equalsIgnoreCase(code)) {
            code = "hi";
        }

        request.getSession().setAttribute("lang", code);

        Cookie cookie = new Cookie("wm_lang", code);
        cookie.setPath("/");
        cookie.setMaxAge(60 * 60 * 24 * 365);
        response.addCookie(cookie);
    }

    private String resolveFromSession(HttpServletRequest request) {
        Object sessionLang = request.getSession(false) != null ? request.getSession(false).getAttribute("lang") : null;
        return sessionLang == null ? null : String.valueOf(sessionLang);
    }

    private String resolveFromCookie(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies == null) {
            return null;
        }
        for (Cookie cookie : cookies) {
            if ("wm_lang".equals(cookie.getName())) {
                return cookie.getValue();
            }
        }
        return null;
    }

    private Locale toLocale(String lang) {
        String normalized = lang == null ? "" : lang.trim().toLowerCase();
        if ("eng".equals(normalized) || "en".equals(normalized)) {
            return Locale.ENGLISH;
        }
        if ("hin".equals(normalized) || "hi".equals(normalized)) {
            return Locale.forLanguageTag("hi");
        }
        return Locale.forLanguageTag(normalized);
    }
}
