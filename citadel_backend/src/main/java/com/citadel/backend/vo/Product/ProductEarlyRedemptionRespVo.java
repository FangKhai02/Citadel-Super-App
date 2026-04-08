package com.citadel.backend.vo.Product;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductEarlyRedemptionRespVo extends BaseResp {
    private Double penaltyPercentage;
    private Double penaltyAmount;
    private Double redemptionAmount;
    private String redemptionReferenceNumber;
}
