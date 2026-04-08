package com.citadel.backend.vo.Agent;


import com.citadel.backend.entity.Commission.AgentCommissionHistory;
import com.citadel.backend.utils.LocalDateToMillisecondSerializer;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class AgentDownLineProductOrderCommissionDetailsVo {
    private String status = "Success";
    private String agentName;
    private String agentRole;
    private double commissionPercentage;
    private double commissionAmount;
    @JsonSerialize(using = LocalDateToMillisecondSerializer.class)
    private LocalDate calculatedDate;
    @JsonIgnore
    private Long productId;
    @JsonIgnore
    private Long productOrderId;

    public static AgentDownLineProductOrderCommissionDetailsVo fromAgentCommissionHistory(AgentCommissionHistory commissionHistory) {
        AgentDownLineProductOrderCommissionDetailsVo commissionDetailsVo = new AgentDownLineProductOrderCommissionDetailsVo();
        if (commissionHistory != null) {
            commissionDetailsVo.setAgentName(commissionHistory.getAgentCommissionCalculationHistory().getMgrName());
            commissionDetailsVo.setAgentRole(commissionHistory.getAgentCommissionCalculationHistory().getMgrRole().getValue());
            commissionDetailsVo.setCommissionPercentage(commissionHistory.getCommissionPercentage());
            commissionDetailsVo.setCommissionAmount(commissionHistory.getCommissionAmount());
            commissionDetailsVo.setCalculatedDate(commissionHistory.getAgentCommissionCalculationHistory().getCalculatedDate());
            commissionDetailsVo.setProductId(commissionHistory.getAgentCommissionCalculationHistory().getProductId());
            commissionDetailsVo.setProductOrderId(commissionHistory.getAgentCommissionCalculationHistory().getProductOrderId());
        }
        return commissionDetailsVo;
    }
}
