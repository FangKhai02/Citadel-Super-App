package com.citadel.backend.vo.Product;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RolloverReqVo {
    @NotNull
    private Double rolloverAmount;
}
