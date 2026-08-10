package com.localb2b.marketplace.common;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Locale;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;

@Controller
public class LanguageController {

    private final LocaleResolver localeResolver;

    public LanguageController(LocaleResolver localeResolver) {
        this.localeResolver = localeResolver;
    }

    @GetMapping("/web/lang/{lang}")
    public String changeLanguage(@PathVariable String lang,
                                 @RequestParam(required = false) String redirect,
                                 HttpServletRequest request,
                                 HttpServletResponse response) {
        Locale locale = resolveLocale(lang);
        if (locale != null && localeResolver instanceof CookieLocaleResolver) {
            // Persist the locale in a cookie so it survives across requests.
            ((CookieLocaleResolver) localeResolver).setLocale(request, response, locale);
        } else if (locale != null) {
            localeResolver.setLocale(request, response, locale);
        }

        if (redirect != null && !redirect.isBlank() && redirect.startsWith("/") && !redirect.startsWith("//")) {
            return "redirect:" + redirect;
        }
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isBlank() && !referer.contains("/web/lang/")) {
            return "redirect:" + referer;
        }
        return "redirect:/";
    }

    private Locale resolveLocale(String lang) {
        if (lang == null) {
            return null;
        }
        return switch (lang.toLowerCase()) {
case "hi", "hin", "hindi" -> new Locale("hi", "IN");
            case "en", "eng", "english" -> Locale.ENGLISH;
            default -> Locale.ENGLISH;
        };
    }
}
