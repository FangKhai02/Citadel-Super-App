package com.citadel.backend.vo.Agreement;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AgreementRespVo extends BaseResp {
    private String link;
    private String html;
}
