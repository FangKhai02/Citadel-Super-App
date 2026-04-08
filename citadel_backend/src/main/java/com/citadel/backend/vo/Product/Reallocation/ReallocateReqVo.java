package com.citadel.backend.vo.Product.Reallocation;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReallocateReqVo {
    @NotNull
    private String productCode;
    @NotNull
    private Double amount;
}
