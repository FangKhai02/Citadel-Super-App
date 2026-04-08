package com.citadel.backend.vo;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class DividendExcelRecordUpdateVo {

    @ExcelColumn("Reference Number")
    private String referenceNumber;

    @ExcelColumn("Dividend")
    private String dividend;

    @ExcelColumn("Trustee Fee")
    private String trusteeFee;
}
