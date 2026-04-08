package com.citadel.backend.vo.Constants;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class KeyValueMapVo {
    String key;
    String value;

    public KeyValueMapVo(String key, String value) {
        this.key = key;
        this.value = value;
    }
}
