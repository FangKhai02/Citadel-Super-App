package com.citadel.backend.vo.Client;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ClientAgentDetailsVo {
    private String agentName;
    private String agentReferralCode;
    private String agentId;
    private String agencyName;
    private String agencyId;
    private String agentCountryCode;
    private String agentMobileNumber;
}
