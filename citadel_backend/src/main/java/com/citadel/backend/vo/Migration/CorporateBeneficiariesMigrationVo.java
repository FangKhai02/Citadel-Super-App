package com.citadel.backend.vo.Migration;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Data;

@Data
public class CorporateBeneficiariesMigrationVo {
    @ExcelColumn("company_registration_number")
    private String companyRegistrationNumber;
    @ExcelColumn("name")
    private String name;
    @ExcelColumn("identity_card_number")
    private String identityCardNumber;
    @ExcelColumn("identity_doc_type")
    private String identityDocType;
    @ExcelColumn("dob")
    private String dob;
    @ExcelColumn("gender")
    private String gender;
    @ExcelColumn("nationality")
    private String nationality;
    @ExcelColumn("address")
    private String address;
    @ExcelColumn("postcode")
    private String postcode;
    @ExcelColumn("city")
    private String city;
    @ExcelColumn("state")
    private String state;
    @ExcelColumn("country")
    private String country;
    @ExcelColumn("mobile_country_code")
    private String mobileCountryCode;
    @ExcelColumn("mobile_number")
    private String mobileNumber;
    @ExcelColumn("email")
    private String email;
    @ExcelColumn("marital_status")
    private String maritalStatus;
    @ExcelColumn("residential_status")
    private String residentialStatus;
}
