package com.citadel.backend.vo.Client;

import com.citadel.backend.utils.DateToMillisecondsSerializer;
import com.citadel.backend.vo.Enum.Gender;
import com.citadel.backend.vo.Enum.IdentityDocumentType;
import com.citadel.backend.vo.Enum.MaritalStatus;
import com.citadel.backend.vo.Enum.ResidentialStatus;
import com.citadel.backend.vo.SignUp.CorrespondingAddress;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class ClientPersonalDetailsVo {
    private String name;
    private IdentityDocumentType identityDocumentType;
    private String identityCardNumber;
    @JsonSerialize(using = DateToMillisecondsSerializer.class)
    private Date dob;
    private String address;
    private String postcode;
    private String city;
    private String state;
    private String country;
    private CorrespondingAddress correspondingAddress;
    private String nationality;
    private String mobileCountryCode;
    private String mobileNumber;
    private Gender gender;
    private String email;
    private MaritalStatus maritalStatus;
    private ResidentialStatus residentialStatus;
    private String profilePicture;
}
