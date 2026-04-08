package com.citadel.backend.vo.Setting;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Getter
@Setter
public class SettingsItemVo {
    private String key;
    private String value;
    private String displayName;
}
