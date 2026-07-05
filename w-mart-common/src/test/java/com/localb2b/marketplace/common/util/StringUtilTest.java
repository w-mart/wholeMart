package com.localb2b.marketplace.common.util;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

class StringUtilTest {

    @Test
    void shouldDetectBlankStrings() {
        assertTrue(StringUtil.isBlank("   "));
        assertFalse(StringUtil.isBlank("value"));
    }

    @Test
    void shouldSlugifyText() {
        assertTrue(StringUtil.slugify("Hello World").contains("hello-world"));
    }
}
