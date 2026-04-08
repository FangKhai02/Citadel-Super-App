package com.citadel.backend.vo.Migration;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Data;

@Data
public class CorporateBeneficiariesGuardiansMigrationVo {
    @ExcelColumn("company_registration_number")
    private String companyRegistrationNumber;
    @ExcelColumn("beneficiary_identity_card_number")
    private String beneficiaryIdentityCardNumber;
    @ExcelColumn("guardian_identity_card_number")
    private String guardianIdentityCardNumber;
    @ExcelColumn("relationship_to_guardian")
    private String relationshipToGuardian;
    @ExcelColumn("relationship_to_beneficiary")
    private String relationshipToBeneficiary;
}
