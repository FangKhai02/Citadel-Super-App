package com.citadel.backend.entity.Corporate;

import com.citadel.backend.entity.BaseEntity;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "corporate_shareholders_pivot")
@Getter
@Setter
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class CorporateShareholdersPivot extends BaseEntity {

    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "corporate_client_id")
    private CorporateClient corporateClient;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "corporate_shareholder_id")
    private CorporateShareholder corporateShareholder;

    @Column(name = "is_deleted")
    private Boolean isDeleted = Boolean.FALSE;
}
