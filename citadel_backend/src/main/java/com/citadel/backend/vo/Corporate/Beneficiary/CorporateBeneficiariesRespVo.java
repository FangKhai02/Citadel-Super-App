package com.citadel.backend.vo.Corporate.Beneficiary;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class CorporateBeneficiariesRespVo extends BaseResp {
    private List<CorporateBeneficiaryBaseVo> corporateBeneficiaries;
}
