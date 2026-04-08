package com.citadel.backend.vo.Migration;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Data;

@Data
public class ClientMigrationVo {
    @ExcelColumn("email")
    private String email;
    @ExcelColumn("password")
    private String password;
    @ExcelColumn("name")
    private String name;
    @ExcelColumn("client_id")
    private String clientId;
    @ExcelColumn("agent_identity_card_number")
    private String agentIdentityCardNumber;
    @ExcelColumn("mobile_country_code")
    private String mobileCountryCode;
    @ExcelColumn("mobile_number")
    private String mobileNumber;
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
    @ExcelColumn("is_same_corresponding_address")
    private String isSameCorrespondingAddress;
    @ExcelColumn("corresponding_address")
    private String correspondingAddress;
    @ExcelColumn("corresponding_postcode")
    private String correspondingPostcode;
    @ExcelColumn("corresponding_city")
    private String correspondingCity;
    @ExcelColumn("corresponding_state")
    private String correspondingState;
    @ExcelColumn("corresponding_country")
    private String correspondingCountry;
    @ExcelColumn("dob")
    private String dob;
    @ExcelColumn("gender")
    private String gender;
    @ExcelColumn("nationality")
    private String nationality;
    @ExcelColumn("marital_status")
    private String maritalStatus;
    @ExcelColumn("residential_status")
    private String residentialStatus;
    @ExcelColumn("employment_type")
    private String employmentType;
    @ExcelColumn("employer_name")
    private String employerName;
    @ExcelColumn("industry_type")
    private String industryType;
    @ExcelColumn("job_title")
    private String jobTitle;
    @ExcelColumn("employer_address")
    private String employerAddress;
    @ExcelColumn("employer_postcode")
    private String employerPostcode;
    @ExcelColumn("employer_city")
    private String employerCity;
    @ExcelColumn("employer_state")
    private String employerState;
    @ExcelColumn("employer_country")
    private String employerCountry;
    @ExcelColumn("annual_income_declaration")
    private String annualIncomeDeclaration;
    @ExcelColumn("source_of_income")
    private String sourceOfIncome;
    @ExcelColumn("source_of_income_remark")
    private String sourceOfIncomeRemark;
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
    @ExcelColumn("type")
    private String type;
}
