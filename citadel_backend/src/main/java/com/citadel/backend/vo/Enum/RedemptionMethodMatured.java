package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum RedemptionMethodMatured implements EnumWithValue {
    FULLY_REDEEM("Fully Redeem"),
    ROLLOVER("Rollover"),
    REALLOCATION("Reallocation"),;

    public final String value;

    RedemptionMethodMatured(String value) {
        this.value = value;
    }
}
