package com.citadel.backend.utils;

public final class Constant {

    //HttpCode
    public enum HttpCode {
        SUCCESS("200", "Request Successful."),
        RESOURCE_NOT_FOUND("404", "Resource Not Found!"),
        ERROR_EXCEPTION("500", "Internal Server Error!"),
        TOO_MANY_REQUESTS("429", "Rate limit exceeded!");

        final String code;
        final String message;

        HttpCode(String code, String message) {
            this.code = code;
            this.message = message;
        }

        public String getCode() {
            return code;
        }

        public String getMessage() {
            return message;
        }
    }

    public static final String PLATFORM_ANDROID = "android";
    public static final String PLATFORM_IOS = "ios";

}
