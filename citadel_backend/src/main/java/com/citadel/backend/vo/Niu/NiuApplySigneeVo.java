package com.citadel.backend.vo.Niu;

import jakarta.validation.Valid;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@Valid
public class NiuApplySigneeVo {
    String fullName;//e.g. Ong Seau Meng
    String nric;//e.g. 900909-10-5090
    Date signedDate;//in milliseconds, 1731311107212
    String signature;//in base64 format
}
