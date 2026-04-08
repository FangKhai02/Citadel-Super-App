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
public class SignUpBasePersonalDetailsVo {
    @NotBlank(message = "Full name is required")
    @Size(max = 100, message = "Full name must not exceed 100 characters")
    private String fullName;
    @NotBlank(message = "Identity number is required")
    private String identityCardNumber;
    @NotNull(message = "Date of birth is required")
    private Long dob;
    @NotBlank(message = "Address is required")
    private String address;
    @NotBlank(message = "Postcode is required")
    private String postcode;
    @NotBlank(message = "City is required")
    private String city;
    @NotBlank(message = "State is required")
    private String state;
    @NotBlank(message = "Country is required")
    private String country;
    @NotBlank(message = "Country code is required")
    private String mobileCountryCode;
    @NotBlank(message = "Phone number is required")
    @Size(min = 9, max = 11, message = "Phone number must be at most 11 characters")
    private String mobileNumber;
    @NotBlank
    private String email;
    @NotBlank(message = "Identity card image is required")
    private String identityCardImage;
    @NotBlank(message = "Identity type is required")
    private String idType;
}
