package com.citadel.backend.utils.exception;

import com.citadel.backend.utils.Constant;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ErrorResp {
    private String code = Constant.HttpCode.ERROR_EXCEPTION.getCode();
    private String message;

    public String getClazz() {
        return this.getClass().getSimpleName();
    }
}
