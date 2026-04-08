package com.citadel.backend.vo.Agent;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class AgentClientRespVo extends BaseResp {
    private Integer totalClients = null;
    private Integer totalNewClients = null;
    private List<AgentClientVo> clients = new ArrayList<>();
}
