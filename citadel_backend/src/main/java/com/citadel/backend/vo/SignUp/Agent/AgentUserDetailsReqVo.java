package com.citadel.backend.vo.SignUp.Agent;

import com.citadel.backend.vo.SignUp.SignUpBasePersonalDetailsVo;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class AgentUserDetailsReqVo extends SignUpBasePersonalDetailsVo {
    @NotBlank
    private String proofOfAddressImage;
}
