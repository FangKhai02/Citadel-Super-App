package com.citadel.backend.vo.Migration;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Data;

@Data
public class CorporateShareholderMigrationVo {
    @ExcelColumn("company_registration_number")
    private String companyRegistrationNumber;
    @ExcelColumn("name")
    private String name;
    @ExcelColumn("percentage_of_shareholdings")
    private String percentageOfShareholdings;
    @ExcelColumn("mobile_country_code")
    private String mobileCountryCode;
    @ExcelColumn("mobile_number")
    private String mobileNumber;
    @ExcelColumn("email")
    private String email;
    @ExcelColumn("identity_card_number")
    private String identityCardNumber;
    @ExcelColumn("identity_doc_type")
    private String identityDocType;
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
    @ExcelColumn("is_pep")
    private String isPep;
    @ExcelColumn("pep_relationship")
    private String pepRelationship;
    @ExcelColumn("pep_relationship_name")
    private String pepRelationshipName;
    @ExcelColumn("pep_position")
    private String pepPosition;
    @ExcelColumn("pep_organisation")
    private String pepOrganisation;
}
