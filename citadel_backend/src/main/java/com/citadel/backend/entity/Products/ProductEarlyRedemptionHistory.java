package com.citadel.backend.entity.Products;

import com.citadel.backend.entity.Agent;
import com.citadel.backend.entity.BaseEntity;
import com.citadel.backend.vo.Enum.CmsAdmin;
import com.citadel.backend.vo.Enum.ProductOrderOptions;
import com.citadel.backend.vo.Enum.RedemptionMethod;
import com.citadel.backend.vo.Enum.Status;
import com.citadel.backend.vo.Product.PortfolioProductOrderOptionsInterface;
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
@Table(name = "product_early_redemption_history")
public class ProductEarlyRedemptionHistory extends BaseEntity implements PortfolioProductOrderOptionsInterface {

    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "redemption_reference_number")
    private String redemptionReferenceNumber;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "product_order_id")
    private ProductOrder productOrder;

    @Column(name = "order_reference_number")
    private String orderReferenceNumber;

    @Enumerated(EnumType.STRING)
    @Column(name = "withdrawal_method")
    private RedemptionMethod withdrawalMethod;

    @Column(name = "withdrawal_amount")
    private Double amount;

    @Column(name = "penalty_amount")
    private Double penaltyAmount;

    @Column(name = "penalty_percentage")
    private Double penaltyPercentage;

    @Column(name = "withdrawal_reason")
    private String withdrawalReason;

    //PENDING->IN_REVIEW->APPROVED/REJECTED->SUCCESS
    @Enumerated(EnumType.STRING)
    @Column(name = "withdrawal_status")
    private Status status;

    @Column(name = "withdrawal_agreement_key")
    private String withdrawalAgreementKey;

    @Enumerated(EnumType.STRING)
    @Column(name = "client_signature_status")
    private Status clientSignatureStatus;

    @Column(name = "client_signature_key")
    private String clientSignatureKey;

    @Column(name="client_signature_date")
    private LocalDate clientSignatureDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "witness_signature_status")
    private Status witnessSignatureStatus;

    @Enumerated(EnumType.STRING)
    @Column(name = "payment_status")
    private Status paymentStatus;

    @Column(name = "payment_date")
    private Date paymentDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "status_checker")
    private CmsAdmin.CheckerStatus statusChecker;

    @Enumerated(EnumType.STRING)
    @Column(name = "status_approver")
    private CmsAdmin.ApproverStatus statusApprover;

    @Column(name = "generated_bank_file")
    private Boolean generatedBankFile;

    @Column(name = "bank_result_csv")
    private String bankResultCsv;

    @Column(name = "updated_bank_result")
    private Boolean updatedBankResult;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "agent_id")
    private Agent agent;

    @Column(name = "supporting_document_key")
    private String supportingDocumentKey;

    @Transient
    public double getRedemptionPaymentAmount() {
        return this.amount - this.penaltyAmount;
    }

    //Interface methods
    @Override
    public String getReferenceNumber() {
        return this.redemptionReferenceNumber;
    }

    @Override
    public ProductOrderOptions getOptionType() {
        return ProductOrderOptions.EARLY_REDEMPTION;
    }

    @Override
    public String getStatusString() {
        if (this.status == Status.IN_REVIEW) {
            return "Withdrawal In Review";
        } else if (this.status == Status.APPROVED) {
            return "Withdrawal Approved";
        } else if (this.status == Status.REJECTED) {
            return "Withdrawal Rejected";
        } else if (this.status == Status.SUCCESS) {
            return "Trust Product is successfully withdrawn";
        } else {
            return "Withdrawal Pending";
        }
    }
}
