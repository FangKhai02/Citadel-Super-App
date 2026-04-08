package com.citadel.backend.entity.Commission;

import com.citadel.backend.entity.Products.Product;
import com.citadel.backend.vo.Enum.ProductOrderType;
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
@Table(name = "agency_commission_configuration")
public class AgencyCommissionConfiguration {
    public enum AgencyCommissionConfigCondition {
        BELOW,
        ABOVE,
        TIER2;
    }

    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "product_id")
    private Product product;

    @Enumerated(EnumType.STRING)
    @Column(name = "product_order_type")
    private ProductOrderType productOrderType;

    @Enumerated(EnumType.STRING)
    @Column(name = "condition")
    private AgencyCommissionConfigCondition condition;

    @Column(name = "threshold")
    private Double threshold;

    @Column(name = "year")
    private Integer year;

    @Column(name = "commission")
    private Double commission;

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
}
