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
@Table(name = "product_dividend_schedule")
public class ProductDividendSchedule {

    public enum FrequencyOfPayout {
        MONTHLY,
        QUARTERLY,
        ANNUALLY
    }

    public enum StructureType {
        FIXED, FLEXIBLE
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;

    //Accepts integer value from 1 to 31 and 99. 99 = Last day of month
    @Column(name = "date_of_month")
    private Integer dateOfMonth;

    @Enumerated(EnumType.STRING)
    @Column(name = "frequency_of_payout")
    private FrequencyOfPayout frequencyOfPayout;

    @Enumerated(EnumType.STRING)
    @Column(name = "structure_type")
    private StructureType structureType;

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
