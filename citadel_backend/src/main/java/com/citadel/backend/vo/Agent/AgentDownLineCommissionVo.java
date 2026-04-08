package com.citadel.backend.vo.Agent;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class AgentDownLineCommissionVo {
    private String productCode;
    private List<AgentDownLineProductOrderCommissionDetailsVo> commissionList;
}
