package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum EmploymentType implements EnumWithValue {
    RETIRED("Retired"),
    UNEMPLOYED("Unemployed"),
    EMPLOYED("Employed"),
    SELF_EMPLOYED("Self-Employed"),
    HOUSEWIFE("Housewife"),
    OTHER("Other");

    public final String value;
    EmploymentType(String value) {
        this.value = value;
    }
}
