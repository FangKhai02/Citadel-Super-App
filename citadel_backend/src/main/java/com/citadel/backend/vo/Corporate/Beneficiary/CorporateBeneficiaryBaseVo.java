package com.citadel.backend.vo.Corporate.Beneficiary;

import com.citadel.backend.vo.Corporate.Guardian.CorporateGuardianVo;
import com.citadel.backend.vo.Enum.Relationship;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CorporateBeneficiaryBaseVo {
    private Long corporateBeneficiaryId;
    private String fullName;
    private Relationship relationshipToSettlor;
    private Relationship relationshipToGuardian;
    private Boolean isUnderAge;
    private CorporateGuardianVo corporateGuardianVo;
}
