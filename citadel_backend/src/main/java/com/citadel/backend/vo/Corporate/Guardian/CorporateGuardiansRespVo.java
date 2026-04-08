package com.citadel.backend.vo.Corporate.Guardian;

import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Corporate.Guardian.CorporateGuardianBaseVo;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class CorporateGuardiansRespVo extends BaseResp {
    private List<CorporateGuardianBaseVo> corporateGuardians;
}
