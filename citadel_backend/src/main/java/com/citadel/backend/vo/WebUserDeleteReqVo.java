package com.citadel.backend.vo;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class WebUserDeleteReqVo {
    @NotNull
    private String email;
    @NotNull
    private String password;
    @NotNull
    private String reason;
}
