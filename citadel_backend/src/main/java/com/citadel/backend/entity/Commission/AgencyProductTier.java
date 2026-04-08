package com.citadel.backend.entity.Commission;

import com.citadel.backend.vo.Enum.ProductOrderType;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "agency_product_tier")
public class AgencyProductTier {
    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "agency_id")
    private Long agencyId;

    @Column(name = "product_id")
    private Long productId;

    @Enumerated(EnumType.STRING)
    @Column(name = "product_order_type")
    private ProductOrderType productOrderType;

    @Column(name = "year")
    private Integer year;

    @Column(name = "commission")
    private Double commission;
}
