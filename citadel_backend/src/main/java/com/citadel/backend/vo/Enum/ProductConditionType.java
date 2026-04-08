package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum ProductConditionType implements EnumWithValue {
    BELOW("Below"),
    ABOVE("Above"),
    RANGE("Range");

    public final String value;

    ProductConditionType(String value) {
        this.value = value;
    }
}
