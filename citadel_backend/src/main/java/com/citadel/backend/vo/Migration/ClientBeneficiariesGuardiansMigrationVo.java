package com.citadel.backend.vo.Migration;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Data;

@Data
public class ClientBeneficiariesGuardiansMigrationVo {
    @ExcelColumn("client_identity_card_number")
    private String clientIdentityCardNumber;
    @ExcelColumn("beneficiary_identity_card_number")
    private String beneficiaryIdentityCardNumber;
    @ExcelColumn("guardian_identity_card_number")
    private String guardianIdentityCardNumber;
    @ExcelColumn("relationship_to_guardian")
    private String relationshipToGuardian;
    @ExcelColumn("relationship_to_beneficiary")
    private String relationshipToBeneficiary;
}
