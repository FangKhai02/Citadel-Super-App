package com.citadel.backend.vo.Corporate;

import com.citadel.backend.utils.DateToMillisecondsSerializer;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Enum.CorporateTypeOfEntity;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class CorporateDetailsRespVo extends BaseResp {
    private String entityName;
    private CorporateTypeOfEntity entityType;
    private String registrationNumber;
    @JsonSerialize(using = DateToMillisecondsSerializer.class)
    private Date dateIncorporate;
    private String placeIncorporate;
    private String businessType;
    private String registeredAddress;
    private String city;
    private String state;
    private String postcode;
    private String country;
    private String businessAddress;
    private String businessPostcode;
    private String businessCity;
    private String businessState;
    private String businessCountry;
    private String contactName;
    private String contactDesignation;
    private String contactCountryCode;
    private String contactMobileNumber;
    private String contactEmail;
}
