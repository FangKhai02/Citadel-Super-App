package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum RedemptionMethod implements EnumWithValue {
    ALL("All"),
    PARTIAL_AMOUNT("Partial Amount");

    public final String value;

    RedemptionMethod(String value) {
        this.value = value;
    }
}
