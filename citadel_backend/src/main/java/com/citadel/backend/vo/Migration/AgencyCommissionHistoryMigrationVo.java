package com.citadel.backend.vo.Migration;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Data;

@Data
public class AgencyCommissionHistoryMigrationVo {
    @ExcelColumn("agreement_number")
    private String agreementNumber;
    @ExcelColumn("agency_registration_number")
    private String agencyRegistrationNumber;
    @ExcelColumn("agency_commission_percentage")
    private String agencyCommissionPercentage;
    @ExcelColumn("agency_commission_amount")
    private String agencyCommissionAmount;
    @ExcelColumn("ytd_sales")
    private String ytdSales;
    @ExcelColumn("calculated_date")
    private String calculatedDate;
    @ExcelColumn("payment_status")
    private String paymentStatus;
    @ExcelColumn("payment_date")
    private String paymentDate;
}
