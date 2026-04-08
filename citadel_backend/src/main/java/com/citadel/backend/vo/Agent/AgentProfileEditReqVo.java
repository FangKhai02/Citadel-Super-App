package com.citadel.backend.vo.Agent;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class AgentProfileEditReqVo {
    private String address;
    private String postcode;
    private String city;
    private String state;
    private String country;
    private String mobileCountryCode;
    private String mobileNumber;
    private String email;
}
