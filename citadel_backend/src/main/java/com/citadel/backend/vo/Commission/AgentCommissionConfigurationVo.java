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
public class AgentCommissionConfigurationVo {
    private Long productId;
    private ProductOrderType productOrderType;
    private Integer year;
    private Double mgrCommissionPercentage;
    private Double p2pCommissionPercentage;
    private Double smCommissionPercentage;
    private Double avpCommissionPercentage;
    private Double vpCommissionPercentage;
}
