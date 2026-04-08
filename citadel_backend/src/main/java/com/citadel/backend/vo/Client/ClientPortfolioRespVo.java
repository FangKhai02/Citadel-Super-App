package com.citadel.backend.vo.Client;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ClientPortfolioRespVo extends BaseResp {
    private List<ClientPortfolioVo> portfolio;
}
