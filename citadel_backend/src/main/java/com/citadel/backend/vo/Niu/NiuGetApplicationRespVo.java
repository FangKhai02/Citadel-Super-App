package com.citadel.backend.vo.Niu;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class NiuGetApplicationRespVo extends BaseResp {
    List<NiuGetApplicationDetailsVo> applications;
}
