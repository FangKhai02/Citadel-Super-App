package com.citadel.backend.vo.Corporate;

import com.citadel.backend.entity.Corporate.CorporateClient;
import com.citadel.backend.utils.DateToMillisecondsSerializer;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class CorporateClientVo {
    private Long id;
    private String corporateClientId;
    private String referenceNumber;
    private String profilePicture;
    private String name;
    private String identityCardNumber;
    @JsonSerialize(using = DateToMillisecondsSerializer.class)
    private Date dob;
    private String address;
    private String postcode;
    private String city;
    private String state;
    private String country;
    private String mobileCountryCode;
    private String mobileNumber;
    private String email;
    private String annualIncomeDeclaration;
    private String sourceOfIncome;
    private String digitalSignature;
    private CorporateClient.CorporateClientStatus status;
    private String approvalRemark;
}
