package com.citadel.backend.vo.Corporate;

import com.citadel.backend.vo.Enum.CorporateTypeOfEntity;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CorporateDetailsReqVo {
    private String entityName;
    private CorporateTypeOfEntity entityType;
    private String registrationNumber;
    private Long dateIncorporate;
    private String placeIncorporate;
    private String businessType;
    private String registeredAddress;
    private String city;
    private String state;
    private String postcode;
    private String country;
    private CorporateAddressDetailsVo corporateAddressDetails;
    private String contactName;
    private Boolean contactIsMyself;
    private String contactDesignation;
    private String contactMobileCountryCode;
    private String contactMobileNumber;
    private String contactEmail;
}
