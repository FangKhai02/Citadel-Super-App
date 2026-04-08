package com.citadel.backend.vo.Corporate;

import jakarta.validation.Valid;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class CorporateClientSignUpReqVo {
    private CorporateDetailsReqVo corporateDetails;
    private String annualIncomeDeclaration;
    private String sourceOfIncome;
    private String digitalSignature;
}
