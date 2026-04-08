package com.citadel.backend.vo.Product.resp;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ProductOrderPaymentUploadRespVo extends BaseResp {
    List<ProductOrderPaymentReceiptVo> paymentReceipts;
}
