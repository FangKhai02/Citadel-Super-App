package com.citadel.backend.entity;

import com.citadel.backend.vo.Enum.Relationship;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "individual_beneficiary_guardian")
public class IndividualBeneficiaryGuardian extends BaseEntity {
    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "individual_beneficiary_id")
    private IndividualBeneficiary individualBeneficiary;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "individual_guardian_id")
    private IndividualGuardian individualGuardian;

    @Enumerated(EnumType.STRING)
    @Column(name = "relationship_to_guardian")
    private Relationship relationshipToGuardian;

    @Enumerated(EnumType.STRING)
    @Column(name = "relationship_to_beneficiary")
    private Relationship relationshipToBeneficiary;

    @Column(name = "is_deleted")
    private Boolean isDeleted;
}
