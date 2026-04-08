package com.citadel.backend.vo.Login;

import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Enum.UserType;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginRespVo extends BaseResp {
    private String apiKey;
    private boolean hasPin;
    private UserType userType;
}
