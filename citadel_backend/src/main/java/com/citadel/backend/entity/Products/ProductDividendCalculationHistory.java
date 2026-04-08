package com.citadel.backend.entity.Products;

import com.citadel.backend.entity.BaseEntity;
import com.citadel.backend.vo.Enum.Status;
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
@Table(name = "product_dividend_calculation_history")
public class ProductDividendCalculationHistory extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "reference_number")
    private String referenceNumber;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "product_order_id")
    private ProductOrder productOrder;

    @Column(name = "dividend_amount")
    private Double dividendAmount;

    @Column(name = "trustee_fee_amount")
    private Double trusteeFeeAmount = 0.0;

    @Column(name = "period_starting_date")
    private LocalDate periodStartingDate;

    @Column(name = "period_ending_date")
    private LocalDate periodEndingDate;

    @Column(name = "closing_date")
    private LocalDate closingDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "payment_status")
    private Status paymentStatus;

    @Column(name = "payment_date")
    private Date paymentDate;

    @Column(name = "payment_transaction_id")
    private String paymentTransactionId;

    @Column(name = "dividend_quarter")
    private Integer dividendQuarter = 0;
}
