package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum NiuApplicationType implements EnumWithValue {
    PERSONAL("Personal"), COMPANY("Company");

    public final String value;
    NiuApplicationType(String value) {
        this.value = value;
    }
}
