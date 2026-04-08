package com.citadel.backend.vo.Product.Redemption;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RedemptionPaymentRecordVo {

    @ExcelColumn("Agreement No")
    private String agreementNo;

    @ExcelColumn("Payment Status")
    private String paymentStatus;

    @ExcelColumn("Payment Date")
    private String paymentDate;
}
