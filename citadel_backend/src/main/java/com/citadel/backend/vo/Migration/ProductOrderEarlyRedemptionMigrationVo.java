package com.citadel.backend.vo.Migration;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Data;

@Data
public class ProductOrderEarlyRedemptionMigrationVo {
    @ExcelColumn("agreement_number")
    private String agreementNumber;
    @ExcelColumn("withdrawal_method")
    private String withdrawalMethod;
    @ExcelColumn("withdrawal_amount")
    private String withdrawalAmount;
    @ExcelColumn("penalty_amount")
    private String penaltyAmount;
    @ExcelColumn("penalty_percentage")
    private String penaltyPercentage;
    @ExcelColumn("payment_status")
    private String paymentStatus;
    @ExcelColumn("payment_date")
    private String paymentDate;
}
