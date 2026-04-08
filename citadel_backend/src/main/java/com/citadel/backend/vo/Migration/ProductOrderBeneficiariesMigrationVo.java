package com.citadel.backend.vo.Migration;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Data;

@Data
public class ProductOrderBeneficiariesMigrationVo {
    @ExcelColumn("agreement_number")
    private String agreementNumber;
    @ExcelColumn("beneficiary_identity_card_number")
    private String beneficiaryIdentityCardNumber;
    @ExcelColumn("main_beneficiary_identity_card_number")
    private String mainBeneficiaryIdentityCardNumber;
    @ExcelColumn("percentage_of_distribution")
    private String percentageOfDistribution;
}
