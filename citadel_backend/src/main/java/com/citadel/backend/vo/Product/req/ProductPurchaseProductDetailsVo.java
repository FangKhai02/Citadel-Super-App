package com.citadel.backend.vo.Product.req;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductPurchaseProductDetailsVo {
    private Long productId;
    private Double amount;
    private Double dividend;
    private Integer investmentTenureMonth;
}
