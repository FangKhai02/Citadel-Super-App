package com.citadel.backend.vo.Corporate.ShareHolder;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CorporateShareholderEditReqVo {
    private Long corporateShareholderId;
    private String name;
    private Double percentageOfShareholdings;
    private String mobileCountryCode;
    private String mobileNumber;
    private String email;
    private String address;
    private String postcode;
    private String city;
    private String state;
    private String country;
}
