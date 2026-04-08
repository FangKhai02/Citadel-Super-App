package com.citadel.backend.vo.SignUp.Client;

import com.citadel.backend.vo.Enum.MaritalStatus;
import com.citadel.backend.vo.Enum.ResidentialStatus;
import com.citadel.backend.vo.SignUp.SignUpBaseContactDetailsVo;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
@NotNull
public class ClientPersonalDetailsReqVo extends SignUpBaseContactDetailsVo {
    @NotNull
    private MaritalStatus maritalStatus;
    @NotNull
    private ResidentialStatus residentialStatus;
    // Optional
    private String agentReferralCode;
}
