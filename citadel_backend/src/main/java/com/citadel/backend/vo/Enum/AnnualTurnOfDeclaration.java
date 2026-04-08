package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum AnnualTurnOfDeclaration implements EnumWithValue {
    BELOW_500K("Below RM500,000"),
    ABOVE_500K("Above RM500,000");

    public final String value;
    AnnualTurnOfDeclaration(String value) {
        this.value = value;
    }
}
