package com.citadel.backend.vo.Login;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Valid
public class ResetPasswordReqVo {
    @NotNull
    private String email;
    @NotNull
    private String password;
    @NotNull
    private String token;
}
