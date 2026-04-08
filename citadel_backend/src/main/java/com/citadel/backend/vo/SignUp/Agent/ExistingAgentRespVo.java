package com.citadel.backend.vo.SignUp.Agent;

import com.citadel.backend.vo.BankDetails.BankDetailsReqVo;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.SignUp.SignUpBaseContactDetailsVo;
import com.citadel.backend.vo.SignUp.SignUpBaseIdentityDetailsVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ExistingAgentRespVo extends BaseResp {
    private SignUpBaseIdentityDetailsVo identityDetails;
    private SignUpBaseContactDetailsVo contactDetails;
    private String selfieImage;
    private SignUpAgentAgencyDetailsReqVo agencyDetails;
    private String agencyCode;
    private BankDetailsReqVo bankDetails;
    private String digitalSignature;
}
