package com.citadel.backend.vo.Login;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginRequestVo {
    String email;
    String password;
    String oneSignalSubscriptionId;
}
