package com.citadel.backend.vo.Agent;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AgentDownLineRespVo extends BaseResp {
    private Integer totalDownLine = 0;
    private Integer newRecruitThisMonth = 0;
}
