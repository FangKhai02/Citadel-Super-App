package com.citadel.backend.entity.Products;

import com.citadel.backend.entity.BaseEntity;
import com.citadel.backend.entity.Corporate.CorporateBeneficiaries;
import com.citadel.backend.entity.IndividualBeneficiary;
import com.citadel.backend.vo.Enum.UserType;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "product_beneficiaries")
public class ProductBeneficiaries extends BaseEntity {

    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_order_id", referencedColumnName = "id")
    private ProductOrder productOrder;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "individual_beneficiary_id")
    private IndividualBeneficiary beneficiary;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "main_beneficiary_id")
    private IndividualBeneficiary mainBeneficiary;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "corporate_beneficiary_id")
    private CorporateBeneficiaries corporateBeneficiary;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "corporate_main_beneficiary_id")
    private CorporateBeneficiaries corporateMainBeneficiary;

    @Column(name = "percentage")
    private Double percentage;

    @Enumerated(EnumType.STRING)
    @Column(name = "beneficiary_type")
    private UserType type;
}
