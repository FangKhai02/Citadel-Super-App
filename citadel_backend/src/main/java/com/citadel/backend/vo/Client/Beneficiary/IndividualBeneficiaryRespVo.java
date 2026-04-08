package com.citadel.backend.vo.Client.Beneficiary;

import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Client.Guardian.GuardianVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class IndividualBeneficiaryRespVo extends BaseResp {
    private Boolean isUnderAge;
    private GuardianVo guardianVo;
    private Long individualBeneficiaryId;
}
