package com.citadel.backend.utils;

import jakarta.servlet.http.HttpServletRequest;

public class HttpHeader {
    public static String getApiKey(HttpServletRequest req) {
        return req.getHeader("apiKey");
    }

    public static String getSecretKey(HttpServletRequest req) {
        return req.getHeader("secretKey");
    }
}
