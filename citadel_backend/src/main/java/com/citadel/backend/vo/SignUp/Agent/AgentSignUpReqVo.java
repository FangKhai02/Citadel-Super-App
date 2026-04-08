package com.citadel.backend.vo.SignUp.Agent;

import com.citadel.backend.vo.BankDetails.BankDetailsReqVo;
import com.citadel.backend.vo.BankDetails.BankDetailsVo;
import com.citadel.backend.vo.SignUp.SignUpBaseContactDetailsVo;
import com.citadel.backend.vo.SignUp.SignUpBaseIdentityDetailsVo;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@NotNull
@Valid
public class AgentSignUpReqVo {
    @NotNull
    @Valid
    private SignUpBaseIdentityDetailsVo identityDetails;
    @NotNull
    @Valid
    private SignUpBaseContactDetailsVo contactDetails;
    @NotBlank
    private String selfieImage;
    @NotNull
    @Valid
    private SignUpAgentAgencyDetailsReqVo agencyDetails;
    @NotNull
    @Valid
    private BankDetailsReqVo bankDetails;
    @NotBlank
    private String digitalSignature;
    @NotBlank
    private String password;
}
