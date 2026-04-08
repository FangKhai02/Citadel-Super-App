package com.citadel.backend.vo.Corporate.Beneficiary;

import com.citadel.backend.vo.Enum.Gender;
import com.citadel.backend.vo.Enum.MaritalStatus;
import com.citadel.backend.vo.Enum.Relationship;
import com.citadel.backend.vo.Enum.ResidentialStatus;
import jakarta.validation.Valid;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class CorporateBeneficiaryUpdateReqVo {
    private Relationship relationshipToSettlor;
    private Relationship relationshipToGuardian;
    private String fullName;
    private Gender gender;
    private String nationality;
    private String address;
    private String postcode;
    private String city;
    private String state;
    private String country;
    private ResidentialStatus residentialStatus;
    private MaritalStatus maritalStatus;
    private String mobileCountryCode;
    private String mobileNumber;
    private String email;
}
