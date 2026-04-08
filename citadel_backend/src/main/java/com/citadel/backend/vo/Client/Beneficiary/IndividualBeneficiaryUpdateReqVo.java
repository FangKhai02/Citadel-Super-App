package com.citadel.backend.vo.Client.Beneficiary;

import com.citadel.backend.vo.Enum.Relationship;
import jakarta.validation.Valid;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class IndividualBeneficiaryUpdateReqVo extends IndividualBeneficiaryCreateReqVo {
    private Relationship relationshipToGuardian;
    private Relationship relationshipToBeneficiary;
    private Long guardianId;
}
