package com.citadel.backend.utils.Builder;

import lombok.Getter;
import lombok.Setter;

import java.util.Arrays;
import java.util.List;

@Getter
@Setter
public class RandomCodeBuilder {
    public final static char PATTERN_PLACEHOLDER = '#';
    public static final String ALPHABETIC_UPPERCASE = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    public static final String ALPHABETIC = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    public static final String ALPHABETIC_LOWERCASE = "abcdefghijklmnopqrstuvwxyz";
    public static final String ALPHANUMERIC = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    public static final String ALPHANUMERIC_UPPERCASE = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    public static final String NUMBERS = "0123456789";
    public static final int DEFAULT_LENGTH = 10;
    public static final List<Character> allowedChar = Arrays.asList(PATTERN_PLACEHOLDER, '-');

    private int length = DEFAULT_LENGTH;
    private String pattern;
    private String charset = ALPHANUMERIC;
    private String prefix;
    private Integer prefixLength;
    private String postfix;
    private Integer postfixLength;

    public RandomCodeBuilder length(int length) {
        this.length = length;
        return this;
    }

    public RandomCodeBuilder pattern(String pattern) {
        this.pattern = pattern;
        return this;
    }

    public RandomCodeBuilder charSet(String charset) {
        this.charset = charset;
        return this;
    }

    public RandomCodeBuilder prefix(String prefix) {
        this.prefix = prefix;
        return this;
    }

    public RandomCodeBuilder prefixLength(Integer prefixLength) {
        this.prefixLength = prefixLength;
        return this;
    }

    public RandomCodeBuilder postfix(String postfix) {
        this.postfix = postfix;
        return this;
    }

    public RandomCodeBuilder postfixLength(Integer postfixLength) {
        this.postfixLength = postfixLength;
        return this;
    }
}
