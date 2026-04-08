package com.citadel.backend.vo.Corporate.Bank;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CorporateBankDetailsBaseVo {
    @NotBlank
    private Long id;
    @NotBlank
    private String bankName;
    @NotBlank
    private String bankAccountHolderName;
}
