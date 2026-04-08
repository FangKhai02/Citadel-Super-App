package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum PaymentMethod implements EnumWithValue {
    MANUAL_TRANSFER("Manual Transfer"),
    ONLINE_BANKING("Online Banking");

    public final String value;

    PaymentMethod(String value) {
        this.value = value;
    }
}