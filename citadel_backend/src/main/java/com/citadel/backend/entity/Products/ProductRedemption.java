package com.citadel.backend.entity.Products;

import com.citadel.backend.entity.AppUser;
import com.citadel.backend.entity.BaseEntity;
import com.citadel.backend.vo.Enum.CmsAdmin;
import com.citadel.backend.vo.Enum.ProductOrderOptions;
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
@Table(name = "product_redemption")
public class ProductRedemption extends BaseEntity implements PortfolioProductOrderOptionsInterface {

    public enum RedemptionType {
        FULL, PARTIAL, REFUND
    }

    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_order_id")
    private ProductOrder productOrder;

    @Enumerated(EnumType.STRING)
    @Column(name = "fund_status")
    private ProductOrder.ProductOrderStatus fundStatus;

    @Enumerated(EnumType.STRING)
    @Column(name = "type")
    private RedemptionType redemptionType;

    @Column(name = "amount")
    private Double amount;

    //IN_REVIEW->APPROVED/REJECTED->SUCCESS
    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private Status status;

    @Enumerated(EnumType.STRING)
    @Column(name = "status_checker")
    private CmsAdmin.CheckerStatus statusChecker;

    @Column(name = "remark_checker")
    private String remarkChecker;

    @Column(name = "checked_by")
    private String checkedBy;

    @Column(name = "checker_updated_at")
    private Date checkerUpdatedAt;

    @Enumerated(EnumType.STRING)
    @Column(name = "status_approver")
    private CmsAdmin.ApproverStatus statusApprover;

    @Column(name = "remark_approver")
    private String remarkApprover;

    @Column(name = "approved_by")
    private String approvedBy;

    @Column(name = "approver_updated_at")
    private Date approverUpdatedAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by")
    private AppUser createdBy;

    @Enumerated(EnumType.STRING)
    @Column(name = "payment_status")
    private Status paymentStatus;

    @Column(name = "payment_date")
    private Date paymentDate;

    @Column(name = "generated_bank_file")
    private Boolean generatedBankFile;

    @Column(name = "bank_result_csv")
    private String bankResultCsv;

    @Column(name = "updated_bank_result")
    private Boolean updatedBankResult;

    @Transient
    public LocalDate getRedemptionPaymentDate() {
        LocalDate today = LocalDate.now();
        if (this.productOrder.getEndTenure().isAfter(today)) {
            return productOrder.getEndTenure().plusDays(1);
        } else {
            return today;
        }
    }

    //PortfolioProductOrderOptionsInterface methods
    @Override
    public String getReferenceNumber() {
        return this.productOrder.getOrderReferenceNumber();
    }

    @Override
    public ProductOrderOptions getOptionType() {
        return ProductOrderOptions.FULL_REDEMPTION;
    }

    @Override
    public String getStatusString() {
        if (this.status == Status.IN_REVIEW) {
            return "Pending Redemption";
        } else if (this.status == Status.APPROVED) {
            return "Redemption Approved";
        } else if (this.status == Status.REJECTED) {
            return "Redemption Rejected";
        } else if (this.status == Status.SUCCESS) {
            return "Trust Product is successfully redeemed";
        }
        return "N/A";
    }

    @Override
    public Status getClientSignatureStatus() {
        return null;
    }

    @Override
    public Status getWitnessSignatureStatus() {
        return null;
    }
}



