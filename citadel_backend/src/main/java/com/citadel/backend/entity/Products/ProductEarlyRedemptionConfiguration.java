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
@Table(name = "product_early_redemption_configuration")
public class ProductEarlyRedemptionConfiguration {

    public enum PeriodType {
        DAY, MONTH, YEAR
    }

    public enum Condition {
        NOT_ALLOWED, ALLOWED, ALLOWED_WITH_PENALTY, PENALTY
    }

    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;

    @Enumerated(EnumType.STRING)
    @Column(name = "period_type")
    private PeriodType periodType;

    @Column(name = "period")
    private Integer period;

    @Enumerated(EnumType.STRING)
    @Column(name = "condition")
    private Condition condition;

    @Column(name = "penalty_percentage")
    private Double penaltyPercentage;

    @Column(name = "created_at")
    private Date createdAt;

    @Column(name = "updated_at")
    private Date updatedAt;

    @Column(name = "created_by")
    private String createdBy;

    @Column(name = "updated_by")
    private String updatedBy;
}
