package com.citadel.backend.vo.Commission;

import com.citadel.backend.vo.Enum.ProductOrderType;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.Date;

@Getter
@Setter
public class CommissionProductOrderVo {
    //product order details
    private Long id;
    private Long agencyId;
    private String agencyName;
    private ProductOrderType productOrderType;
    private Date submissionDate;
    private LocalDate agreementDate;
    private String clientName;
    private String agreementFileName;
    private Double purchasedAmount;
    //parameters for commission calculation
    private Long productId;
    private Double previousTotalSales;
    private Double threshold;
    private Double baseCommissionRate;
    private Double commissionAboveThreshold;
    //commission result
    private Double commissionRate;
    private Double commissionAmount;
    private LocalDate calculatedDate;
    private Double ytdSales;

    public CommissionProductOrderVo() {
    }

    public CommissionProductOrderVo(Long id, Long agencyId, String agencyName, ProductOrderType productOrderType, Date submissionDate, LocalDate agreementDate,
                                    String clientName, String agreementFileName, Double purchasedAmount, Long productId) {
        this.id = id;
        this.agencyId = agencyId;
        this.agencyName = agencyName;
        this.productOrderType = productOrderType;
        this.submissionDate = submissionDate;
        this.agreementDate = agreementDate;
        this.clientName = clientName;
        this.agreementFileName = agreementFileName;
        this.purchasedAmount = purchasedAmount;
        this.productId = productId;
    }
}
