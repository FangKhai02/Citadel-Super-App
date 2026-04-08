package com.citadel.backend.vo.Migration;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Data;

@Data
public class ClientBankDetailsMigrationVo {
    @ExcelColumn("client_identity_card_number")
    private String clientIdentityCardNumber;
    @ExcelColumn("bank_account_number")
    private String bankAccountNumber;
    @ExcelColumn("bank_account_holder_name")
    private String bankAccountHolderName;
    @ExcelColumn("bank_name")
    private String bankName;
    @ExcelColumn("bank_swift_code")
    private String bankSwiftCode;
    @ExcelColumn("bank_address")
    private String bankAddress;
    @ExcelColumn("bank_postcode")
    private String bankPostcode;
    @ExcelColumn("bank_city")
    private String bankCity;
    @ExcelColumn("bank_state")
    private String bankState;
    @ExcelColumn("bank_country")
    private String bankCountry;
}
