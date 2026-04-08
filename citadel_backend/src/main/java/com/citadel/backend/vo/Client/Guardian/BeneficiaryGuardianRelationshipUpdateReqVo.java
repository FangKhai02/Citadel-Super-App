package com.citadel.backend.vo.Client.Guardian;

import com.citadel.backend.vo.Enum.Relationship;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class BeneficiaryGuardianRelationshipUpdateReqVo {
    @NotNull
    private Long guardianId;
    @NotNull
    private Long beneficiaryId;
    private Relationship relationshipToGuardian;
    private Relationship relationshipToBeneficiary;
}
