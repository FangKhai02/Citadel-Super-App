package com.citadel.backend.vo;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BankPaymentRecordVo {

    /* NOTE : Column Name should match the column name in the Excel file */

    @ExcelColumn("Reference Number")
    private String referenceNumber;

    @ExcelColumn("Csv File Name")
    private String csvFileName;

    @ExcelColumn("Agreement No")
    private String agreementNo;

    @ExcelColumn("Payment Status")
    private String paymentStatus;

    @ExcelColumn("Payment Date")
    private String paymentDate;
}
