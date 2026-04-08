package com.citadel.backend.vo.Agent;

import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Client.ClientPortfolioVo;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class AgentPendingSignatureRespVo extends BaseResp {
    private List<ClientPortfolioVo> productOrders;
    private List<ClientPortfolioVo> earlyRedemptions;
}
