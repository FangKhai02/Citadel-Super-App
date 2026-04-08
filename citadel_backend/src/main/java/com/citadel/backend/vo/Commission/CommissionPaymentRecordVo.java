package com.citadel.backend.vo.Commission;

import com.citadel.backend.annotation.ExcelColumn;
import com.citadel.backend.vo.Enum.Status;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommissionPaymentRecordVo {
    /* NOTE : Column Name should match the column name in the Excel file */

    @ExcelColumn("Reference Number")
    private String referenceNumber;

    @ExcelColumn("Agreement No")
    private String agreementNo;

    @ExcelColumn("Payment Status")
    private String paymentStatus;

    @ExcelColumn("Payment Date")
    private String paymentDate;

    @ExcelColumn("Agency ID")
    private String agencyId;

    //Required for Agent Commission Payment Record
    @ExcelColumn("Agent ID")
    private String agentId;
}
