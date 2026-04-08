package com.citadel.backend.vo.Product;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductBankDetailsRespVo extends BaseResp {
    private String bankName;
    private String bankAccountName;
    private String bankAccountNumber;

    public ProductBankDetailsRespVo(String bankName, String bankAccountName, String bankAccountNumber) {
        this.bankName = bankName;
        this.bankAccountName = bankAccountName;
        this.bankAccountNumber = bankAccountNumber;
    }
}