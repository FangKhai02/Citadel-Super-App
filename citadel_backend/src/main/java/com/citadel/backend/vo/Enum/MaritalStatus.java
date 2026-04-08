package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum MaritalStatus implements EnumWithValue {
    SINGLE("Single"),
    MARRIED("Married"),
    DIVORCED("Divorced"),
    WIDOWED("Widowed"),
    SEPARATED("Separated"),
    OTHER("Other");

    public final String value;
    MaritalStatus(String value) {
        this.value = value;
    }
}
