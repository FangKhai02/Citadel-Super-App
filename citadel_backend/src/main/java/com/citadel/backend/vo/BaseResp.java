package com.citadel.backend.vo;

import com.citadel.backend.utils.Constant;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BaseResp {
    private String code = Constant.HttpCode.SUCCESS.getCode();
    private String message = Constant.HttpCode.SUCCESS.getMessage();
}
