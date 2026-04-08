package com.citadel.backend.entity.Products;

import com.citadel.backend.entity.*;
import com.citadel.backend.entity.Corporate.CorporateClient;
import com.citadel.backend.entity.Corporate.CorporateDetails;
import com.citadel.backend.vo.Enum.*;
import com.citadel.backend.vo.Product.PhysicalTrustDeedReminderInterfaceVo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.util.Date;
import java.util.Optional;

@Getter
@Setter
@Entity
@NoArgsConstructor
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "product_order")
public class ProductOrder extends BaseEntity {

    public enum ProductOrderStatus {
        //Product status before approved
        DRAFT, IN_REVIEW, REJECTED, PENDING_PAYMENT,

        //Product status after approved
        ACTIVE, MATURED, FLOAT, WITHDRAWN, AGREEMENT, SECOND_SIGNEE, PENDING_ACTIVATION, COMPLETED
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "order_reference_number")
    private String orderReferenceNumber;

    @Enumerated(EnumType.STRING)
    @Column(name = "product_order_type")
    private ProductOrderType productOrderType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "client_id", referencedColumnName = "id")
    private Client client;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "corporate_client_id", referencedColumnName = "id")
    private CorporateClient corporateClient;

    @Column(name = "client_name")
    private String clientName;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "agent_id", referencedColumnName = "id")
    private Agent agent;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "agency_id", referencedColumnName = "id")
    private Agency agency;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "product_id", referencedColumnName = "id")
    private Product product;

    @Column(name = "purchased_amount")
    private Double purchasedAmount;

    @Column(name = "dividend")
    private Double dividend;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "bank_details_id", referencedColumnName = "id")
    private BankDetails bank;

    @Column(name = "investment_tenure_month")
    private Integer investmentTenureMonth;

    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private ProductOrderStatus status; //IF ACTIVE START CALCULATING DIVIDEND

    @Column(name = "remark")
    private String remark;

    @Column(name = "submission_date")
    private Date submissionDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by")
    private AppUser createdBy;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "updated_by")
    private AppUser updatedBy;

    @Enumerated(EnumType.STRING)
    @Column(name = "payment_method")
    private PaymentMethod paymentMethod;

    @Enumerated(EnumType.STRING)
    @Column(name = "payment_status")
    private Status paymentStatus;

    @Column(name = "payment_date")
    private Date paymentDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "status_finance")
    private CmsAdmin.FinanceStatus statusFinance;

    @Column(name = "remark_finance")
    private String remarkFinance;

    @Column(name = "financed_by")
    private String financedBy;

    @Column(name = "finance_updated_at")
    private Date financeUpdatedAt;

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

    @Column(name = "agreement_file_name")
    private String agreementFileName;

    @Column(name = "agreement_key")
    private String agreementKey;

    @Column(name = "agreement_date")
    private LocalDate agreementDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "client_agreement_status")
    private Status clientAgreementStatus;

    @Column(name = "client_signature_key")
    private String clientSignatureKey;

    @Column(name = "client_signature_date")
    private LocalDate clientSignatureDate;

    // Second client signee fields for corporate clients
    @Enumerated(EnumType.STRING)
    @Column(name = "client_two_agreement_status")
    private Status clientTwoAgreementStatus;

    @Column(name = "client_two_signature_key")
    private String clientTwoSignatureKey;

    @Column(name = "client_two_signature_date")
    private LocalDate clientTwoSignatureDate;

    @Column(name = "client_two_signature_name")
    private String clientTwoSignatureName;

    @Column(name = "client_two_signature_id_number")
    private String clientTwoSignatureIdNumber;

    @Column(name = "client_two_role")
    private String clientTwoRole;

    @Enumerated(EnumType.STRING)
    @Column(name = "witness_agreement_status")
    private Status witnessAgreementStatus;

    @Column(name = "witness_signature_date")
    private LocalDate witnessSignatureDate;

    @Column(name = "profit_sharing_schedule_key")
    private String profitSharingScheduleKey;

    @Column(name = "start_tenure")
    private LocalDate startTenure;

    @Column(name = "end_tenure")
    private LocalDate endTenure;

    @Column(name = "official_receipt_key")
    private String officialReceiptKey;

    @Column(name = "official_receipt_date")
    private Date officialReceiptDate;

    @Column(name = "soa_key")
    private String soaKey;

    @Column(name = "soa_date")
    private Date soaDate;

    //Dividend Calculation parameters

    //For fixed and flexible
    @Column(name = "is_prorated")
    private Boolean isProrated;

    //For fixed and flexible
    @Enumerated(EnumType.STRING)
    @Column(name = "payout_frequency")
    private ProductDividendSchedule.FrequencyOfPayout payoutFrequency;

    @Enumerated(EnumType.STRING)
    @Column(name = "structure_type")
    private ProductDividendSchedule.StructureType structureType;

    //For fixed and flexible
    @Column(name = "period_starting_date")
    private LocalDate periodStartingDate;

    //For fixed and flexible
    @Column(name = "period_ending_date")
    private LocalDate periodEndingDate;

    //For fixed and flexible
    @Column(name = "last_dividend_calculation_date")
    private Date lastDividendCalculationDate;

    @Column(name = "dividend_counter")
    private Integer dividendCounter = 0;

    @Column(name = "enable_living_trust")
    private Boolean enableLivingTrust = Boolean.FALSE;

    @Column(name = "imported")
    private Boolean imported = Boolean.FALSE;

    // New fields for agreement and physical signed files
    @Column(name = "unsigned_agreement_key")
    private String unsignedAgreementKey;

    @Column(name = "physical_signed_agreement_files")
    private String physicalSignedAgreementFiles;

    @Column(name = "physical_signed_agreement_files_updated_at")
    private Date physicalSignedAgreementFilesUpdatedAt;

    @Column(name = "physical_signed_agreement_files_updated_by")
    private String physicalSignedAgreementFilesUpdatedBy;

    @Column(name = "received_physical_signed_agreement_files")
    private Boolean receivedPhysicalSignedAgreementFiles = false;

    @Column(name = "received_physical_signed_agreement_files_updated_at")
    private Date receivedPhysicalSignedAgreementFilesUpdatedAt;

    @Column(name = "received_physical_signed_agreement_files_updated_by")
    private String receivedPhysicalSignedAgreementFilesUpdatedBy;

    @Column(name = "physical_signed_agreement_files_reminder_sent")
    private Boolean physicalSignedAgreementFilesReminderSent = false;

    @Column(name = "client_role")
    private String clientRole;

    @Transient
    public String getClientId() {
        if (client != null) {
            return client.getClientId();
        } else {
            return corporateClient.getCorporateClientId();
        }
    }

    @Transient
    public String getClientEmail() {
        if (client != null) {
            return client.getUserDetail().getEmail();
        } else {
            return corporateClient.getCorporateDetails().getContactEmail();
        }
    }

    @Transient
    public String getClientIdentityId() {
        if (client != null) {
            return client.getUserDetail().getIdentityCardNumber();
        } else {
            return corporateClient.getCorporateDetails().getRegistrationNumber();
        }
    }

    @Transient
    public IdentityDocumentType getClientIdentityType() {
        if (client != null) {
            return client.getUserDetail().getIdentityDocumentType();
        } else {
            return corporateClient.getUserDetail().getIdentityDocumentType();
        }
    }

    @Transient
    public ResidentialStatus getClientResidentialStatus() {
        if (client != null) {
            return client.getUserDetail().getResidentialStatus();
        } else {
            return corporateClient.getUserDetail().getResidentialStatus();
        }
    }

    @Transient
    public String getClientCountry() {
        if (client != null) {
            return client.getUserDetail().getCountry();
        } else {
            return corporateClient.getUserDetail().getCountry();
        }
    }

    @Transient
    public String getClientCountryCode() {
        if (client != null) {
            return client.getUserDetail().getCountryCode();
        } else {
            return corporateClient.getUserDetail().getCountryCode();
        }
    }

    @Transient
    public boolean requireSecondSigneeSignature() {
        return Optional.ofNullable(this.getCorporateClient())
                .map(CorporateClient::getCorporateDetails)
                .map(CorporateDetails::getEntityType)
                .filter(entityType -> CorporateTypeOfEntity.PRIVATE_LIMITED.equals(entityType) || CorporateTypeOfEntity.PUBLIC_LIMITED.equals(entityType))
                .filter(entityType -> Status.SUCCESS.equals(this.getClientAgreementStatus()))
                .isPresent();
    }

    @Transient
    public boolean isCorporateClientWithSecondSigneeRequirement() {
        return Optional.ofNullable(this.getCorporateClient())
                .map(CorporateClient::getCorporateDetails)
                .map(CorporateDetails::getEntityType)
                .filter(entityType -> CorporateTypeOfEntity.PRIVATE_LIMITED.equals(entityType) || CorporateTypeOfEntity.PUBLIC_LIMITED.equals(entityType))
                .isPresent();
    }
}
