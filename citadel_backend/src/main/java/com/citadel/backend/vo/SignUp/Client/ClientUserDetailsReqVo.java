package com.citadel.backend.vo.SignUp.Client;

import com.citadel.backend.vo.Enum.Gender;
import com.citadel.backend.vo.Enum.MaritalStatus;
import com.citadel.backend.vo.Enum.ResidentialStatus;
import com.citadel.backend.vo.SignUp.SignUpBasePersonalDetailsVo;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
@Valid
public class ClientUserDetailsReqVo extends SignUpBasePersonalDetailsVo {
    @NotNull
    private Gender gender;
    @NotBlank
    private String nationality;
    @NotNull
    private ResidentialStatus residentialStatus;
    @NotNull
    private MaritalStatus maritalStatus;
    //Optional
    private String agentReferralCode;
}
