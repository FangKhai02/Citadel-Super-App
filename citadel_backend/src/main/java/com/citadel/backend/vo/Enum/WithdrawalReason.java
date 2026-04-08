package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum WithdrawalReason implements EnumWithValue {
    MATURITY("Maturity");

    public final String value;
    WithdrawalReason(String value) {
        this.value = value;
    }
}
