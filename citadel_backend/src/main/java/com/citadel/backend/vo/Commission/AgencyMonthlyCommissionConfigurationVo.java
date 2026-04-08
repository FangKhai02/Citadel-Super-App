package com.citadel.backend.vo.Commission;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class AgencyMonthlyCommissionConfigurationVo {
    private Double threshold;
    private Integer year;
    private Double commission;
}
