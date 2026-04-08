package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum NotificationType implements EnumWithValue {
    PROMOTION("Promotion"), MESSAGE("Message");

    public final String value;
    NotificationType(String value) {
        this.value = value;
    }
}
