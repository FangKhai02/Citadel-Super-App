package com.citadel.backend.vo.SignUp;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
@NotNull
public class SignUpBaseContactDetailsVo {
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
    private CorrespondingAddress correspondingAddress = new CorrespondingAddress();
    @NotBlank
    private String mobileCountryCode;
    @NotBlank
    private String mobileNumber;
    @NotBlank
    private String email;
    private String proofOfAddressFile;
}
