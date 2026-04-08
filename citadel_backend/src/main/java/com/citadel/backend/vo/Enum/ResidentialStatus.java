package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum ResidentialStatus implements EnumWithValue {
    RESIDENT("Resident"),
    NON_RESIDENT("Non-Resident"),
    PERMANENT_RESIDENT("Permanent Resident"),
    CITIZEN("Citizen");

    public final String value;
    ResidentialStatus(String value) {
        this.value = value;
    }
}
