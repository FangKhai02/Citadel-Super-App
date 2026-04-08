package com.citadel.backend.vo.Commission;

import com.citadel.backend.vo.Enum.ProductOrderType;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class AgencyYearlyCommissionConfigurationVo {
    private Long productId;
    private ProductOrderType productOrderType;
    private Integer year;
    private Double commission;
}
