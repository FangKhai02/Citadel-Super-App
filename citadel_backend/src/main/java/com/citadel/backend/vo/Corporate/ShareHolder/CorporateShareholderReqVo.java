package com.citadel.backend.vo.Corporate.ShareHolder;

import com.citadel.backend.vo.Enum.IdentityDocumentType;
import com.citadel.backend.vo.SignUp.PepDeclarationVo;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class CorporateShareholderReqVo {
    @NotBlank
    private String name;
    @NotBlank
    private String identityCardNumber;
    @NotNull
    private Double percentageOfShareholdings;
    @NotBlank
    private String mobileCountryCode;
    @NotBlank
    private String mobileNumber;
    @NotBlank
    private String email;
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
    private IdentityDocumentType identityDocumentType;
    @NotBlank
    private String identityCardFrontImage;
    private String identityCardBackImage;
    private PepDeclarationVo pepDeclaration;
}
