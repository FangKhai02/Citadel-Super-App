package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum ProductOrderType implements EnumWithValue {
    NEW("New"),
    ROLLOVER("Rollover"),
    REALLOCATE("Reallocate");

    public final String value;
    ProductOrderType(String reallocate) {
        this.value = reallocate;
    }
}
