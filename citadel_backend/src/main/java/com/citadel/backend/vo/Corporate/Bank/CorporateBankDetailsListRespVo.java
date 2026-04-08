package com.citadel.backend.vo.Corporate.Bank;

import com.citadel.backend.vo.BankDetails.BankDetailsVo;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Corporate.Bank.CorporateBankDetailsBaseVo;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class CorporateBankDetailsListRespVo extends BaseResp {
    private List<BankDetailsVo> corporateBankDetails;
}
