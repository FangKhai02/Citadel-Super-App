package com.citadel.backend.vo.Product;

import com.citadel.backend.entity.Products.ProductOrder;
import com.citadel.backend.vo.Enum.PaymentMethod;
import com.citadel.backend.vo.Enum.Status;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductOrderPaymentDetailsBaseVo {
    private PaymentMethod paymentMethod;
    private Status paymentStatus;

    public static ProductOrderPaymentDetailsBaseVo productOrderToPaymentDetailsBaseVo(ProductOrder productOrder) {
        ProductOrderPaymentDetailsBaseVo productOrderPaymentDetailsBaseVo = new ProductOrderPaymentDetailsBaseVo();
        if (productOrder != null) {
            productOrderPaymentDetailsBaseVo.setPaymentMethod(productOrder.getPaymentMethod());
            productOrderPaymentDetailsBaseVo.setPaymentStatus(productOrder.getPaymentStatus());
        }
        return productOrderPaymentDetailsBaseVo;
    }
}
