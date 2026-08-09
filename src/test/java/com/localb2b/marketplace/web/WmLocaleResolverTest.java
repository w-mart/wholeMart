package com.localb2b.marketplace.web;

import org.junit.jupiter.api.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import java.util.Locale;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

class WmLocaleResolverTest {

    @Test
    void resolvesEnglishAndStoresSessionLanguage() {
        WmLocaleResolver resolver = new WmLocaleResolver();
        MockHttpServletRequest request = new MockHttpServletRequest();
        MockHttpServletResponse response = new MockHttpServletResponse();

        request.setParameter("lang", "eng");

        Locale locale = resolver.resolveLocale(request);
        resolver.setLocale(request, response, locale);

        assertEquals(Locale.ENGLISH, locale);
        assertEquals("en", request.getSession().getAttribute("lang"));
        assertNotNull(response.getCookie("wm_lang"));
    }

    @Test
    void resolvesHindiAndStoresSessionLanguage() {
        WmLocaleResolver resolver = new WmLocaleResolver();
        MockHttpServletRequest request = new MockHttpServletRequest();
        MockHttpServletResponse response = new MockHttpServletResponse();

        request.setParameter("lang", "hin");

        Locale locale = resolver.resolveLocale(request);
        resolver.setLocale(request, response, locale);

        assertEquals(Locale.forLanguageTag("hi"), locale);
        assertEquals("hi", request.getSession().getAttribute("lang"));
    }
}
