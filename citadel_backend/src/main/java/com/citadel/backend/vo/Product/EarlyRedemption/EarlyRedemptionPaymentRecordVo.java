package com.citadel.backend.vo.Product.EarlyRedemption;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EarlyRedemptionPaymentRecordVo {

    @ExcelColumn("Reference Number")
    private String referenceNumber;

    @ExcelColumn("Agreement No")
    private String agreementNo;

    @ExcelColumn("Payment Status")
    private String paymentStatus;

    @ExcelColumn("Payment Date")
    private String paymentDate;
}
