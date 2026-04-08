package com.citadel.backend.vo.Agent;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class AgentDownLineCommissionRespVo extends BaseResp {
    private List<AgentDownLineCommissionVo> downLineCommissionList;
}
