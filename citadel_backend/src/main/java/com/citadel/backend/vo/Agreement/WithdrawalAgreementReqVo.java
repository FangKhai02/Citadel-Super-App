package com.citadel.backend.vo.Agreement;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
public class WithdrawalAgreementReqVo {
    @NotNull
    private String digitalSignature;
    private String fullName;
    private String identityCardNumber;
}
