package com.citadel.backend.vo.Product.req;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AgentProductPurchaseUpdateReqVo extends ProductPurchaseUpdateReqVo {

    @NotBlank
    private String clientId;
}
