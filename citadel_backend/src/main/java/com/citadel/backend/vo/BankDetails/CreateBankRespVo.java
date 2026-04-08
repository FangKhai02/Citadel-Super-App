package com.citadel.backend.vo.BankDetails;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateBankRespVo extends BaseResp {
    private BankDetailsVo bankDetails;
}
