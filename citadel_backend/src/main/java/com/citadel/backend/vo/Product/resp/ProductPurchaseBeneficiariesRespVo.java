package com.citadel.backend.vo.Product.resp;

import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Product.FundBeneficiaryDetailsVo;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ProductPurchaseBeneficiariesRespVo extends BaseResp {
    private List<FundBeneficiaryDetailsVo> productBeneficiaries;
}
