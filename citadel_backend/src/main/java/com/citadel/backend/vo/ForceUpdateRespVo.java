package com.citadel.backend.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ForceUpdateRespVo extends BaseResp {
    Boolean updateRequired;
    String updateLink;
}
