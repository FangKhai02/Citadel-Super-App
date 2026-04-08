package com.citadel.backend.entity.Products;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "product")
public class Product {

    public enum BankFile {
        AFFIN, CIMB
    }

    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "product_type_id")
    private ProductType productType;

    @Column(name = "name")
    private String name;

    @Column(name = "code")
    private String code;

    @Column(name = "tranche_size")
    private Double trancheSize;

    @Column(name = "minimum_subscription_amount")
    private Double minimumSubscriptionAmount;

    @Column(name = "is_prorated")
    private Boolean isProrated;

    @Column(name = "lock_in_period_option")
    private String lockInPeriodOption;

    @Column(name = "lock_in_period_value")
    private Integer lockInPeriodValue;

    @Column(name = "bank_name")
    private String bankName;

    @Column(name = "bank_account_name")
    private String bankAccountName;

    @Column(name = "bank_account_number")
    private String bankAccountNumber;

    @Column(name = "product_description")
    private String productDescription;

    @Column(name = "incremental")
    private Double incremental;

    @Column(name = "investment_tenure_month")
    private Integer investmentTenureMonth;

    @Column(name = "product_catalogue_url")
    private String productCatalogueUrl;

    @Column(name = "image_of_product_url")
    private String imageOfProductUrl;

    @Column(name = "profit_sharing_footer_note")
    private String profitSharingFooterNote;

    @Column(name = "status")
    private Boolean status;

    @Column(name = "is_published")
    private Boolean isPublished;

    @JsonIgnore
    @Column(name = "created_at")
    private Date createdAt;

    @JsonIgnore
    @Column(name = "updated_at")
    private Date updatedAt;

    @JsonIgnore
    @Column(name = "created_by")
    private String createdBy;

    @JsonIgnore
    @Column(name = "updated_by")
    private String updatedBy;

    @Column(name = "enable_living_trust")
    private Boolean enableLivingTrust;

    @Column(name = "trustee_fee_first_dividend")
    private Double trusteeFeeFirstDividend;

    @Column(name = "trustee_fee_last_dividend")
    private Double trusteeFeeLastDividend;
}

