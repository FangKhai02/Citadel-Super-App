package com.citadel.backend.vo.Agent;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class AgentPersonalSalesDetailsRespVo extends BaseResp {
//    private Integer totalProductSold;
//    private String paymentMethod;
    private List<AgentPersonalSalesDetailsVo> salesDetails;
}
