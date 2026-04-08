package com.citadel.backend.vo.Product;

import com.citadel.backend.utils.DoubleSerializer;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FundAmountVo {
    @JsonSerialize(using = DoubleSerializer.class)
    private Double amount;
    @JsonSerialize(using = DoubleSerializer.class)
    private Double dividend;
}
