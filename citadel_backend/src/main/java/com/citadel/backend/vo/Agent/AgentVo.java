package com.citadel.backend.vo.Agent;

import com.citadel.backend.utils.DateToMillisecondsSerializer;
import com.citadel.backend.vo.Enum.AgencyType;
import com.citadel.backend.vo.Enum.AgentRole;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class AgentVo {
    private String agentId;
    private String agentName;
    private String referralCode;
    private AgentRole agentRole;
    private AgencyType agentType;
    private String agencyId;
    private String agencyName;
    private String recruitManagerId;
    private String recruitManagerName;
    @JsonSerialize(using = DateToMillisecondsSerializer.class)
    private Date joinedDate;
}
