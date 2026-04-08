package com.citadel.backend.vo.Agent;

import com.citadel.backend.entity.Client;
import com.citadel.backend.entity.Corporate.CorporateClient;
import com.citadel.backend.utils.DateToMillisecondsSerializer;
import com.citadel.backend.vo.Enum.UserType;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class AgentClientVo {
    private UserType clientType;
    private String name;
    private String clientId;
    @JsonSerialize(using = DateToMillisecondsSerializer.class)
    private Date joinedDate;

    public static AgentClientVo clientToAgentClientVo(Client client) {
        AgentClientVo agentClientVo = new AgentClientVo();
        agentClientVo.setClientType(UserType.CLIENT);
        agentClientVo.setName(client.getUserDetail().getName());
        agentClientVo.setClientId(client.getClientId());
        agentClientVo.setJoinedDate(client.getCreatedAt());
        return agentClientVo;
    }

    public static AgentClientVo corporateClientToAgentClientVo(CorporateClient corporateClient) {
        AgentClientVo agentClientVo = new AgentClientVo();
        agentClientVo.setClientType(UserType.CORPORATE_CLIENT);
        agentClientVo.setName(corporateClient.getCorporateDetails().getEntityName());
        agentClientVo.setClientId(corporateClient.getCorporateClientId());
        agentClientVo.setJoinedDate(corporateClient.getCreatedAt());
        return agentClientVo;
    }
}
