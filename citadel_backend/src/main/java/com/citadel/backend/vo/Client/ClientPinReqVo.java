package com.citadel.backend.vo.Client;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class ClientPinReqVo {

    private String newPin;
    private String oldPin;
}
