package com.citadel.backend.vo.Corporate.Bank;

import com.citadel.backend.vo.BankDetails.BankDetailsVo;
import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

@Getter@Setter
public class CorporateBankDetailsRespVo extends BaseResp {
    BankDetailsVo corporateBankDetailsVo;
}
