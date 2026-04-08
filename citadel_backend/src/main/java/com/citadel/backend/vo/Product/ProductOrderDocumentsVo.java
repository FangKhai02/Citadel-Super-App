package com.citadel.backend.vo.Product;

import com.citadel.backend.entity.Products.ProductOrder;
import com.citadel.backend.utils.AwsS3Util;
import com.citadel.backend.utils.StringUtil;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductOrderDocumentsVo {
    private String profitSharingSchedule;
    private String officialReceipt;
    private String statementOfAccount;

    public static ProductOrderDocumentsVo productOrderToProductOrderDocumentsVo(ProductOrder productOrder) {
        ProductOrderDocumentsVo documents = new ProductOrderDocumentsVo();
        if (productOrder != null) {
            if (StringUtil.isNotEmpty(productOrder.getProfitSharingScheduleKey())) {
                documents.setProfitSharingSchedule(AwsS3Util.getS3DownloadUrl(productOrder.getProfitSharingScheduleKey()));
            }
            if (StringUtil.isNotEmpty(productOrder.getOfficialReceiptKey())) {
                documents.setOfficialReceipt(AwsS3Util.getS3DownloadUrl(productOrder.getOfficialReceiptKey()));
            }
            if (StringUtil.isNotEmpty(productOrder.getSoaKey())) {
                documents.setStatementOfAccount(AwsS3Util.getS3DownloadUrl(productOrder.getSoaKey()));
            }
        }
        return documents;
    }
}
