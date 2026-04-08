package com.citadel.backend.vo.Product;

import com.citadel.backend.entity.Products.ProductOrder;
import com.citadel.backend.vo.Product.resp.ProductOrderPaymentReceiptVo;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ProductOrderPaymentDetailsVo extends ProductOrderPaymentDetailsBaseVo {
    private String transactionId;
    private String bankName;
    private List<ProductOrderPaymentReceiptVo> paymentReceipts;

    public static ProductOrderPaymentDetailsVo productOrderToPaymentDetailsVo(ProductOrder productOrder) {
        ProductOrderPaymentDetailsVo productOrderPaymentDetailsVo = new ProductOrderPaymentDetailsVo();
        if (productOrder != null) {
            productOrderPaymentDetailsVo.setPaymentMethod(productOrder.getPaymentMethod());
            productOrderPaymentDetailsVo.setPaymentStatus(productOrder.getPaymentStatus());
        }
        return productOrderPaymentDetailsVo;
    }
}
