package com.citadel.backend.vo.SignUp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CorrespondingAddress {
    private Boolean isSameCorrespondingAddress = Boolean.TRUE;
    private String correspondingAddress;
    private String correspondingPostcode;
    private String correspondingCity;
    private String correspondingState;
    private String correspondingCountry;
    private String correspondingAddressProofKey;
}