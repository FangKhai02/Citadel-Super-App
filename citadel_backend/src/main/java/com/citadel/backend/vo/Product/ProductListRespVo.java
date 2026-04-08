package com.citadel.backend.vo.Product;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ProductListRespVo extends BaseResp {
    private List<ProductVo> productList;
}