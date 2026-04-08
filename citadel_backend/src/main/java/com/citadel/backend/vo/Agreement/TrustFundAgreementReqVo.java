package com.citadel.backend.vo.Agreement;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TrustFundAgreementReqVo {
    @NotNull
    private String digitalSignature;
    private String fullName;
    private String identityCardNumber;
    private String role;
}
