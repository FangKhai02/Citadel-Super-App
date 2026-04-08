package com.citadel.backend.vo.Corporate.Beneficiary;

import com.citadel.backend.vo.Enum.*;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class CorporateBeneficiaryCreationReqVo {
    @NotNull
    private Relationship relationshipToSettlor;
    @NotBlank
    private String fullName;
    @NotBlank
    private String identityCardNumber;
    @NotNull
    private Long dob;
    @NotNull
    private Gender gender;
    @NotBlank
    private String nationality;
    @NotBlank
    private String address;
    @NotBlank
    private String postcode;
    @NotBlank
    private String city;
    @NotBlank
    private String state;
    @NotBlank
    private String country;
    @NotNull
    private ResidentialStatus residentialStatus;
    @NotNull
    private MaritalStatus maritalStatus;
    @NotBlank
    private String mobileCountryCode;
    @NotBlank
    private String mobileNumber;
    private String email;
    @NotNull
    private IdentityDocumentType documentType;
    @NotBlank
    private String identityCardFrontImage;
    private String identityCardBackImage;
}
