package com.citadel.backend.vo.BankDetails;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BankDetailsReqVo {
    private String bankName;
    private String accountNumber;
    private String accountHolderName;
    private String bankAddress;
    private String postcode;
    private String city;
    private String state;
    private String country;
    private String swiftCode;
    private String bankAccountProofFile;
}
