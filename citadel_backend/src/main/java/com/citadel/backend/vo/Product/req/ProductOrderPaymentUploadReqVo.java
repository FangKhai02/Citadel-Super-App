package com.citadel.backend.vo.Product.req;

import com.citadel.backend.vo.Product.resp.ProductOrderPaymentReceiptVo;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ProductOrderPaymentUploadReqVo {
    private List<ProductOrderPaymentReceiptVo> receipts;
}
