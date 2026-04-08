package com.citadel.backend.vo;

import com.citadel.backend.vo.Enum.ContactUsReason;
import jakarta.validation.Valid;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class ContactUsFormSubmitReqVo {
    String name;
    String mobileCountryCode;
    String mobileNumber;
    String email;
    ContactUsReason reason;
    String remark;
}
