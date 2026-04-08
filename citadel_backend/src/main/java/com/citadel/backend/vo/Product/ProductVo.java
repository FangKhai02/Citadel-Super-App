package com.citadel.backend.vo.Product;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductVo {
    private Long id;
    private String name;
    private String productDescription;
    private String productCatalogueUrl;
    private String imageOfProductUrl;
    private Boolean isSoldOut;
}