package com.citadel.backend.vo.Login;

import jakarta.validation.Valid;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Valid
public class ChangePasswordReqVo {
    String oldPassword;
    String newPassword;
}
