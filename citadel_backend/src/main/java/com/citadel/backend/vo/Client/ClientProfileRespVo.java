package com.citadel.backend.vo.Client;

import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Client.Beneficiary.IndividualBeneficiaryVo;
import com.citadel.backend.vo.SignUp.PepDeclarationVo;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ClientProfileRespVo extends BaseResp {
    private String clientId;
    private ClientPersonalDetailsVo personalDetails;
    private ClientEmploymentDetailsVo employmentDetails;
    private ClientWealthSourceDetailsVo wealthSourceDetails;
    private ClientAgentDetailsVo agentDetails;
    private PepDeclarationVo pepDeclaration;
}
