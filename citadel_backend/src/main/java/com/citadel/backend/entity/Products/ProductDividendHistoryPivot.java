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
@Table(name = "product_dividend_history_pivot")
public class ProductDividendHistoryPivot {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_dividend_history_id", referencedColumnName = "id")
    private ProductDividendHistory productDividendHistory;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_dividend_calculation_history_id", referencedColumnName = "id")
    private ProductDividendCalculationHistory productDividendCalculationHistory;

    @JsonIgnore
    @Column(name = "created_at")
    private Date createdAt;
}
