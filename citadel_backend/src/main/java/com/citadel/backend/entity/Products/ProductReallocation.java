package com.citadel.backend.entity.Products;

import com.citadel.backend.entity.AppUser;
import com.citadel.backend.vo.Enum.ProductOrderOptions;
import com.citadel.backend.vo.Enum.Status;
import com.citadel.backend.vo.Product.PortfolioProductOrderOptionsInterface;
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
@Table(name = "product_reallocation")
public class ProductReallocation implements RolloverReallocationInterface, PortfolioProductOrderOptionsInterface {
    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_order_id")
    private ProductOrder productOrder;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reallocate_product_order_id")
    private ProductOrder reallocateProductOrder;

    @Column(name = "amount")
    private Double amount;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reallocate_product_id")
    private Product reallocateProduct;

    //IN_REVIEW->APPROVED->REJECTED->SUCCESS
    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private Status status;

    @JsonIgnore
    @Column(name = "created_at")
    private Date createdAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by")
    private AppUser createdBy;

    @JsonIgnore
    @Column(name = "updated_at")
    private Date updatedAt;

    //PortfolioProductOrderOptionsInterface methods
    @Override
    public String getReferenceNumber() {
        return this.reallocateProductOrder.getOrderReferenceNumber();
    }

    @Override
    public ProductOrderOptions getOptionType() {
        return ProductOrderOptions.REALLOCATION;
    }

    @Override
    public String getStatusString() {
        if (this.status == Status.IN_REVIEW) {
            return "Pending Reallocation";
        } else if (this.status == Status.APPROVED) {
            return "Reallocation Approved";
        } else if (this.status == Status.REJECTED) {
            return "Reallocation Rejected";
        } else if (this.status == Status.SUCCESS) {
            return "Trust Product is successfully reallocated";
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
