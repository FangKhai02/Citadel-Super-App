package com.citadel.backend.vo.SignUp;


import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.SignUp.Client.EmploymentDetailsVo;
import com.citadel.backend.vo.SignUp.Client.ClientIdentityDetailsReqVo;
import com.citadel.backend.vo.SignUp.Client.ClientPersonalDetailsReqVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ExistingClientRespVo extends BaseResp {
    private ClientIdentityDetailsReqVo identityDetails;
    private ClientPersonalDetailsReqVo personalDetails;
    private String selfieImage;
    private PepDeclarationVo pepDeclaration;
    private EmploymentDetailsVo employmentDetails;
    private String digitalSignature;
    private String agentReferralCode;
    private String password;
}
