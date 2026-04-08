package com.citadel.backend.vo.BankDetails;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class BankDetailsResp extends BaseResp {
    private List<BankDetailsVo> bankDetails;
}
