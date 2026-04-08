package com.citadel.backend.vo.BankDetails;


import com.citadel.backend.entity.BankDetails;
import com.citadel.backend.utils.StringUtil;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
@Valid
public class BankDetailsVo {
    @NotBlank
    private Long id;
    @NotBlank
    private String bankName;
    @NotBlank
    private String bankAccountNumber;
    @NotBlank
    private String bankAccountHolderName;
    @NotBlank
    private String bankAddress;
    @NotBlank
    private String bankPostcode;
    @NotBlank
    private String bankCity;
    @NotBlank
    private String bankState;
    @NotBlank
    private String bankCountry;
    private String swiftCode;
    @NotBlank
    private String bankAccountProofFile;

    public static BankDetailsVo bankDetailsToBankDetailsVo(BankDetails bankDetails) {
        BankDetailsVo bankDetailsVo = new BankDetailsVo();
        if (bankDetails != null) {
            bankDetailsVo.setId(bankDetails.getId());
            bankDetailsVo.setBankName(bankDetails.getBankName());
            bankDetailsVo.setBankAccountNumber(bankDetails.getAccountNumber());
            bankDetailsVo.setBankAccountHolderName(bankDetails.getAccountHolderName());
            bankDetailsVo.setBankAddress(StringUtil.capitalizeEachWord(bankDetails.getBankAddress()));
            bankDetailsVo.setBankPostcode(bankDetails.getPostcode());
            bankDetailsVo.setBankCity(StringUtil.capitalizeEachWord(bankDetails.getCity()));
            bankDetailsVo.setBankState(StringUtil.capitalizeEachWord(bankDetails.getState()));
            bankDetailsVo.setBankCountry(StringUtil.capitalizeEachWord(bankDetails.getCountry()));
            bankDetailsVo.setSwiftCode(bankDetails.getSwiftCode());
            bankDetailsVo.setBankAccountProofFile(bankDetails.getBankAccountProofKey());
        }
        return bankDetailsVo;
    }
}
