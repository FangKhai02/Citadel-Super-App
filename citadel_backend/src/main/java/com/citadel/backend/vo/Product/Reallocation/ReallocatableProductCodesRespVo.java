package com.citadel.backend.vo.Product.Reallocation;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.Set;

@Getter
@Setter
public class ReallocatableProductCodesRespVo extends BaseResp {
    List<String> productCodes;
}
