package com.citadel.backend.entity.Commission;

import com.citadel.backend.entity.BaseEntity;
import com.citadel.backend.vo.Enum.ProductOrderType;
import com.citadel.backend.vo.Enum.Status;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.Date;

@Getter
@Setter
@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "agency_commission_calculation_history")
public class AgencyCommissionCalculationHistory extends BaseEntity {
    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "reference_number")
    private String referenceNumber;

    @Column(name = "agency_id")
    private Long agencyId;

    @Column(name = "agency_name")
    private String agencyName;

    @Column(name = "product_id")
    private Long productId;

    @Column(name = "product_order_id")
    private Long productOrderId;

    @Enumerated(EnumType.STRING)
    @Column(name = "product_order_type")
    private ProductOrderType productOrderType;

    @Column(name = "purchased_amount")
    private Double purchasedAmount;

    @Column(name = "ytd_sales")
    private Double ytdSales;

    @Column(name = "commission_rate")
    private Double commissionRate;

    @Column(name = "commission_amount")
    private Double commissionAmount;

    @Column(name = "client_name")
    private String clientName;

    @Column(name = "order_submission_date")
    private Date orderSubmissionDate;

    @Column(name = "order_agreement_date")
    private LocalDate orderAgreementDate;

    @Column(name = "order_agreement_number")
    private String orderAgreementNumber;

    @Column(name = "calculated_date")
    private LocalDate calculatedDate;

    @Column(name = "generated_commission_file")
    private Boolean generatedCommissionFile;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_commission_history_id", referencedColumnName = "id")
    private ProductCommissionHistory productCommissionHistory;

    @Enumerated(EnumType.STRING)
    @Column(name = "payment_status")
    private Status paymentStatus;

    @Column(name = "payment_date")
    private Date paymentDate;

    @Column(name = "payment_transaction_id")
    private String paymentTransactionId;

    @Column(name = "remark")
    private String remark;
}
