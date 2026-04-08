package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum ContactUsReason implements EnumWithValue {
    PAYMENT("Payment"),
    APP("Application"),
    PRODUCT("Product"),;

    public final String value;
    ContactUsReason(String value) {
        this.value = value;
    }
}
