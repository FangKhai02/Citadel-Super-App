package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum AgencyType implements EnumWithValue {
    CITADEL("CWP Agent"), OTHER("Other agency");

    public final String value;
    AgencyType(String value) {
        this.value = value;
    }
}
