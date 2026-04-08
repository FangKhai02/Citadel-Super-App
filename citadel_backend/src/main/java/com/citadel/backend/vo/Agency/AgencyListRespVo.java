package com.citadel.backend.vo.Agency;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class AgencyListRespVo extends BaseResp {
    private List<AgencyVo> agencyList;
}
