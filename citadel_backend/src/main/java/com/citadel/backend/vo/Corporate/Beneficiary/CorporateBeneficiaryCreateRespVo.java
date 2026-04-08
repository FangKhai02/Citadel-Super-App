package com.citadel.backend.vo.Corporate.Beneficiary;

import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Corporate.Guardian.CorporateGuardianBaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CorporateBeneficiaryCreateRespVo extends BaseResp {
    private Boolean isUnderAge;
    private Long corporateBeneficiaryId;
    private CorporateGuardianBaseVo corporateGuardianBaseVo;
}
