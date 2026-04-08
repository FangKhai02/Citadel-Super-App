package com.citadel.backend.vo.Migration;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Data;

@Data
public class CorporateMigrationVo {
    @ExcelColumn("client_identity_card_number")
    private String clientIdentityCardNumber;
    @ExcelColumn("entity_name")
    private String entityName;
    @ExcelColumn("entity_type")
    private String entityType;
    @ExcelColumn("registration_number")
    private String registrationNumber;
    @ExcelColumn("date_incorporation")
    private String dateIncorporation;
    @ExcelColumn("place_incorporation")
    private String placeIncorporation;
    @ExcelColumn("business_type")
    private String businessType;
    @ExcelColumn("registered_address")
    private String registeredAddress;
    @ExcelColumn("postcode")
    private String postcode;
    @ExcelColumn("city")
    private String city;
    @ExcelColumn("state")
    private String state;
    @ExcelColumn("country")
    private String country;
    @ExcelColumn("is_different_business_address")
    private String isDifferentBusinessAddress;
    @ExcelColumn("business_address")
    private String businessAddress;
    @ExcelColumn("business_postcode")
    private String businessPostcode;
    @ExcelColumn("business_city")
    private String businessCity;
    @ExcelColumn("business_state")
    private String businessState;
    @ExcelColumn("business_country")
    private String businessCountry;
    @ExcelColumn("contact_is_myself")
    private String contactIsMyself;
    @ExcelColumn("contact_name")
    private String contactName;
    @ExcelColumn("contact_designation")
    private String contactDesignation;
    @ExcelColumn("contact_mobile_country_code")
    private String contactMobileCountryCode;
    @ExcelColumn("contact_mobile_number")
    private String contactMobileNumber;
    @ExcelColumn("contact_email")
    private String contactEmail;
    @ExcelColumn("annual_income_declaration")
    private String annualIncomeDeclaration;
    @ExcelColumn("source_of_income")
    private String sourceOfIncome;
    @ExcelColumn("source_of_income_remark")
    private String sourceOfIncomeRemark;
}
