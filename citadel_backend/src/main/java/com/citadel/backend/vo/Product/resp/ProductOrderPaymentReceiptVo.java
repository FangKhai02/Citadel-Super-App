package com.citadel.backend.vo.Product.resp;

import com.citadel.backend.entity.Products.ProductOrderPaymentReceipt;
import com.citadel.backend.utils.AwsS3Util;
import com.citadel.backend.utils.StringUtil;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductOrderPaymentReceiptVo {
    private Long id;
    private String fileName;
    private String file;
    private ProductOrderPaymentReceipt.UploadStatus uploadStatus;

    public static ProductOrderPaymentReceiptVo fromEntity(ProductOrderPaymentReceipt productOrderPaymentReceipt) {
        ProductOrderPaymentReceiptVo productOrderPaymentReceiptVo = new ProductOrderPaymentReceiptVo();
        if (productOrderPaymentReceipt != null) {
            productOrderPaymentReceiptVo.setId(productOrderPaymentReceipt.getId());
            productOrderPaymentReceiptVo.setFileName(StringUtil.extractFilenameFromS3Key(productOrderPaymentReceipt.getPaymentReceiptKey()));
            productOrderPaymentReceiptVo.setFile(AwsS3Util.getS3DownloadUrl(productOrderPaymentReceipt.getPaymentReceiptKey()));
            productOrderPaymentReceiptVo.setUploadStatus(productOrderPaymentReceipt.getUploadStatus());
        }
        return productOrderPaymentReceiptVo;
    }
}
