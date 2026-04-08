package com.citadel.backend.vo.Commission;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AgentUpLineCommissionVo extends AgentUpLineVo {
    private Double mgrCommissionPercentage;
    private Double p2pCommissionPercentage;
    private Double smCommissionPercentage;
    private Double avpCommissionPercentage;
    private Double vpCommissionPercentage;
    private Double totalMaxCommissionPercentage;

    public static AgentUpLineCommissionVo agentUpLineToAgentUpLineCommissionVo(AgentUpLineVo agentUpLineVo) {
        AgentUpLineCommissionVo agentUpLineCommissionVo = new AgentUpLineCommissionVo();
        agentUpLineCommissionVo.setMgrId(agentUpLineVo.getMgrId());
        agentUpLineCommissionVo.setMgrDigitalId(agentUpLineVo.getMgrDigitalId());
        agentUpLineCommissionVo.setMgrName(agentUpLineVo.getMgrName());
        agentUpLineCommissionVo.setMgrRole(agentUpLineVo.getMgrRole());
        agentUpLineCommissionVo.setRecruitMangerId(agentUpLineVo.getRecruitMangerId());
        agentUpLineCommissionVo.setRecruitManagerDigitalId(agentUpLineVo.getRecruitManagerDigitalId());
        agentUpLineCommissionVo.setRecruitManagerName(agentUpLineVo.getRecruitManagerName());
        agentUpLineCommissionVo.setP2pAgentId(agentUpLineVo.getP2pAgentId());
        agentUpLineCommissionVo.setP2pAgentDigitalId(agentUpLineVo.getP2pAgentDigitalId());
        agentUpLineCommissionVo.setP2pAgentName(agentUpLineVo.getP2pAgentName());
        agentUpLineCommissionVo.setSmAgentId(agentUpLineVo.getSmAgentId());
        agentUpLineCommissionVo.setSmAgentDigitalId(agentUpLineVo.getSmAgentDigitalId());
        agentUpLineCommissionVo.setSmAgentName(agentUpLineVo.getSmAgentName());
        agentUpLineCommissionVo.setAvpAgentId(agentUpLineVo.getAvpAgentId());
        agentUpLineCommissionVo.setAvpAgentDigitalId(agentUpLineVo.getAvpAgentDigitalId());
        agentUpLineCommissionVo.setAvpAgentName(agentUpLineVo.getAvpAgentName());
        agentUpLineCommissionVo.setVpAgentId(agentUpLineVo.getVpAgentId());
        agentUpLineCommissionVo.setVpAgentDigitalId(agentUpLineVo.getVpAgentDigitalId());
        agentUpLineCommissionVo.setVpAgentName(agentUpLineVo.getVpAgentName());
        agentUpLineCommissionVo.setSvpAgentId(agentUpLineVo.getSvpAgentId());
        agentUpLineCommissionVo.setSvpAgentDigitalId(agentUpLineVo.getSvpAgentDigitalId());
        agentUpLineCommissionVo.setSvpAgentName(agentUpLineVo.getSvpAgentName());
        return agentUpLineCommissionVo;
    }
}
