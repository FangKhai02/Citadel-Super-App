package com.citadel.backend.vo.Agent;

import jakarta.validation.Valid;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class AgentPinReqVo {

    private String newPin;
    private String oldPin;
}
