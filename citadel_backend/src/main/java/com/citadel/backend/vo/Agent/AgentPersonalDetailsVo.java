package com.citadel.backend.vo.Agent;

import com.citadel.backend.utils.DateToMillisecondsSerializer;
import com.citadel.backend.vo.Enum.IdentityDocumentType;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class AgentPersonalDetailsVo {
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
    private String mobileCountryCode;
    private String mobileNumber;
    private String email;
    private String profilePicture;
}
