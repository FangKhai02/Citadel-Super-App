package com.citadel.backend.vo.Migration;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Data;

@Data
public class ProductOrderRedemptionMigrationVo {
    @ExcelColumn("agreement_number")
    private String agreementNumber;
    @ExcelColumn("withdrawal_method")
    private String withdrawalMethod;
    @ExcelColumn("withdrawal_amount")
    private String withdrawalAmount;
    @ExcelColumn("payment_status")
    private String paymentStatus;
    @ExcelColumn("payment_date")
    private String paymentDate;
}
