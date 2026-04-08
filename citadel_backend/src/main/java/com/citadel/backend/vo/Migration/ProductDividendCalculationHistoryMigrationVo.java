package com.citadel.backend.vo.Migration;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Data;

@Data
public class ProductDividendCalculationHistoryMigrationVo {
    @ExcelColumn("agreement_number")
    private String agreementNumber;
    @ExcelColumn("dividend_amount")
    private String dividendAmount;
    @ExcelColumn("quarter_starting_date")
    private String quarterStartingDate;
    @ExcelColumn("quarter_ending_date")
    private String quarterEndingDate;
    @ExcelColumn("calculated_date")
    private String calculatedDate;
    @ExcelColumn("payment_status")
    private String paymentStatus;
    @ExcelColumn("payment_date")
    private String paymentDate;
}
