package com.citadel.backend.vo.Agreement;

import com.citadel.backend.utils.Constant;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SecondSigneeAgreementRespVo {
    private String code = Constant.HttpCode.SUCCESS.getCode();
    private String message = Constant.HttpCode.SUCCESS.getMessage();
    private String link;
    private String html;
}
