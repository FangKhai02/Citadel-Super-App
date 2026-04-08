package com.citadel.backend.entity.Products;

import com.citadel.backend.vo.Enum.ProductConditionType;
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
@Table(name = "product_target_return")
public class ProductTargetReturn {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;

    @Enumerated(EnumType.STRING)
    @Column(name = "condition_type")
    private ProductConditionType conditionType;

    @Column(name = "threshold_amount")
    private Double thresholdAmount;

    @Column(name = "minimum")
    private Double minimum;

    @Column(name = "maximum")
    private Double maximum;

    @Column(name = "target_return_per_annum")
    private Double targetReturnPerAnnum;

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
