package com.citadel.backend.vo.Client;

import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.SignUp.PepDeclarationVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ClientPepRespVo extends BaseResp {
    private PepDeclarationVo pepDeclaration;
}
