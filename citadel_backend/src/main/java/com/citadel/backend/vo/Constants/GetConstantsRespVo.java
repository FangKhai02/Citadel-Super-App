package com.citadel.backend.vo.Constants;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class GetConstantsRespVo extends BaseResp {
    List<ConstantVo> constants;
}
