package com.citadel.backend.vo.Corporate;

import jakarta.validation.Valid;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class CorporateAddressDetailsVo {
    private Boolean isDifferentRegisteredAddress;
    private String businessAddress;
    private String businessPostcode;
    private String businessCity;
    private String businessState;
    private String businessCountry;
}