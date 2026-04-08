package com.citadel.backend.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AppUserDeleteReqVo {
    private String name;
    private String mobileCountryCode;
    private String mobileNumber;
    private String reason;
    private String pin;
}
