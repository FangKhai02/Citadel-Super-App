package com.citadel.backend.entity;

import com.citadel.backend.vo.Enum.Relationship;
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
@Table(name = "pep_info")
public class PepInfo extends BaseEntity {

    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "pep")
    private Boolean pep;

    @Enumerated(EnumType.STRING)
    @Column(name = "pep_type")
    private Relationship pepType;

    @Column(name = "pep_immediate_family_name")
    private String pepImmediateFamilyName;

    @Column(name = "pep_position")
    private String pepPosition;

    @Column(name = "pep_organisation")
    private String pepOrganisation;

    @Column(name = "pep_supporting_documents_key")
    private String pepSupportingDocumentsKey;

    public static PepInfo createNewPepInfoFromSignUpHistory(SignUpHistory signUpHistory) {
        PepInfo pepInfo = new PepInfo();
        pepInfo.setPep(signUpHistory.getPep());
        if (pepInfo.getPep()) {
            pepInfo.setPepType(signUpHistory.getPepType());
            pepInfo.setPepImmediateFamilyName(signUpHistory.getPepImmediateFamilyName());
            pepInfo.setPepPosition(signUpHistory.getPepPosition());
            pepInfo.setPepOrganisation(signUpHistory.getPepOrganisation());
            pepInfo.setPepSupportingDocumentsKey(signUpHistory.getPepSupportingDocumentsKey());
        }
        pepInfo.setCreatedAt(new Date());
        pepInfo.setUpdatedAt(new Date());
        return pepInfo;
    }
}
