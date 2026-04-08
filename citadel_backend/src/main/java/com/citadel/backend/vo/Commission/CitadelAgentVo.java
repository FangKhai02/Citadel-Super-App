package com.citadel.backend.vo.Commission;

import com.citadel.backend.vo.Enum.AgentRole;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
public class CitadelAgentVo {
    private Long agentId;
    private String agentDigitalId;
    private String agentName;
    private AgentRole agentRole;
    private Date agentJoinDate;
    private Long recruitManagerId;
    private String recruitManagerDigitalId;
    private String recruitManagerName;
    private AgentRole recruitManagerRole;

    public CitadelAgentVo(Long agentId, String agentDigitalId, String agentName, AgentRole agentRole, Date agentJoinDate, Long recruitManagerId, String recruitManagerDigitalId, String recruitManagerName, AgentRole recruitManagerRole) {
        this.agentId = agentId;
        this.agentDigitalId = agentDigitalId;
        this.agentName = agentName;
        this.agentRole = agentRole;
        this.agentJoinDate = agentJoinDate;
        this.recruitManagerId = recruitManagerId;
        this.recruitManagerDigitalId = recruitManagerDigitalId;
        this.recruitManagerName = recruitManagerName;
        this.recruitManagerRole = recruitManagerRole;
    }
}
