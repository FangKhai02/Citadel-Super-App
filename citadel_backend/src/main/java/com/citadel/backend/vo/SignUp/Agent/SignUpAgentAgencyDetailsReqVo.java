package com.citadel.backend.vo.SignUp.Agent;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class SignUpAgentAgencyDetailsReqVo {
    @NotNull
    private String agencyId;
    @NotNull
    private String recruitManagerCode;
}
