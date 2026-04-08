package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum Gender implements EnumWithValue {
    MALE("Male"), FEMALE("Female");

    public final String value;
    Gender(String value) {
        this.value = value;
    }
}
