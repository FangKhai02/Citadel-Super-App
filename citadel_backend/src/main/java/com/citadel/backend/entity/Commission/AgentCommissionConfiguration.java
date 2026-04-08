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
@Table(name = "agent_commission_configuration")
public class AgentCommissionConfiguration {

    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;

    @Enumerated(EnumType.STRING)
    @Column(name = "product_order_type")
    private ProductOrderType productOrderType;

    @Column(name = "year")
    private Integer year;

    @Column(name = "mgr_commission")
    private Double mgrCommission;

    @Column(name = "p2p_commission")
    private Double p2pCommission;

    @Column(name = "sm_commission")
    private Double smCommission;

    @Column(name = "avp_commission")
    private Double avpCommission;

    @Column(name = "vp_commission")
    private Double vpCommission;

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
