package com.citadel.backend.vo;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DividendExcelRecordVo {
    @ExcelColumn("Reference Number")
    private String referenceNumber;
    
    @ExcelColumn("Closing Date")
    private String closingDate;
    
    @ExcelColumn("Client name")
    private String clientName;
    
    @ExcelColumn("Digital ID")
    private String digitalId;
    
    @ExcelColumn("Agreement No")
    private String agreementNo;
    
    @ExcelColumn("Fund Amount")
    private String fundAmount;
    
    @ExcelColumn("Dividend")
    private String dividend;
    
    @ExcelColumn("Percentage")
    private String percentage;
    
    @ExcelColumn("Bank Name")
    private String bankName;
    
    @ExcelColumn("Bank Account Number")
    private String bankAccountNumber;
}
