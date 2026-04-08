package com.citadel.backend.vo.Agent;

import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Commission.AgentEarningVo;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class AgentEarningRespVo extends BaseResp {
    private List<AgentEarningVo> earningDetails;
}
