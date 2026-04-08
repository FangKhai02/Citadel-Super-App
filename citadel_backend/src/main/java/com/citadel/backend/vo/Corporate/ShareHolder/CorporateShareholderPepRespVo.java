package com.citadel.backend.vo.Corporate.ShareHolder;

import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.SignUp.PepDeclarationVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CorporateShareholderPepRespVo extends BaseResp {
    private PepDeclarationVo pepDeclaration;
}
