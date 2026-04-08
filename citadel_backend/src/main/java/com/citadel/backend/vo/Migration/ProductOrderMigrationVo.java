package com.citadel.backend.vo.Migration;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Data;

@Data
public class ProductOrderMigrationVo {
    @ExcelColumn("purchaser_identity_number")
    private String purchaserIdentityNumber;
    @ExcelColumn("purchaser_type")
    private String purchaserType;
    @ExcelColumn("agreement_number")
    private String agreementNumber;
    @ExcelColumn("product_order_type")
    private String productOrderType;
    @ExcelColumn("product_code")
    private String productCode;
    @ExcelColumn("purchased_amount")
    private String purchasedAmount;
    @ExcelColumn("dividend_percentage")
    private String dividendPercentage;
    @ExcelColumn("investment_tenure_month")
    private String investmentTenureMonth;
    @ExcelColumn("status")
    private String status;
    @ExcelColumn("submission_date")
    private String submissionDate;
    @ExcelColumn("agreement_date")
    private String agreementDate;
    @ExcelColumn("start_tenure")
    private String startTenure;
    @ExcelColumn("end_tenure")
    private String endTenure;
    @ExcelColumn("purchaser_bank_account_number")
    private String purchaserBankAccountNumber;
    @ExcelColumn("is_prorated")
    private String isProrated;
    @ExcelColumn("current_dividend_cycle")
    private String currentDividendCycle;
    @ExcelColumn("dividend_type")
    private String dividendType;
}
