package com.citadel.backend.vo.Product;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ProductDetailsRespVo extends BaseResp {
    private String name;
    private String productDescription;
    private String productCode;

    // Assuming FundAmountVo represents individual amount-dividend pairs
    private List<FundAmountVo> fundAmounts; // List to hold multiple fund amounts with dividends
    private Integer investmentTenureMonth;
    private String productCatalogueUrl;
    private String imageOfProductUrl;
    private Boolean status;
    private Boolean livingTrustOptionEnabled;
}
