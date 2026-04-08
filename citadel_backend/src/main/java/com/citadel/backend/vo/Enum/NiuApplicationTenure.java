package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum NiuApplicationTenure implements EnumWithValue {
    MONTHS_3("3 months"),
    MONTHS_6("6 months"),
    MONTHS_12("12 months"),
    MONTHS_24("24 months"),
    MONTHS_36("36 months");

    public final String value;
    NiuApplicationTenure(String value) {
        this.value = value;
    }
}
