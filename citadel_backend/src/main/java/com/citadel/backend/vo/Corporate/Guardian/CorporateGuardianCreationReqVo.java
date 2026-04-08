package com.citadel.backend.vo.Corporate.Guardian;

import com.citadel.backend.vo.Enum.*;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class CorporateGuardianCreationReqVo {
    @NotNull
    private Long corporateBeneficiaryId;
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
    private IdentityDocumentType identityDocumentType;
    @NotBlank
    private String identityCardFrontImage;
    @NotBlank
    private String identityCardBackImage;
    @NotNull
    private Relationship relationshipToGuardian;
}
