package com.citadel.backend.entity.Commission;

import com.citadel.backend.vo.Enum.AgencyType;
import com.citadel.backend.vo.Enum.CmsAdmin;
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
@Table(name = "product_commission_history")
public class ProductCommissionHistory {
    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(name = "agency_type")
    private AgencyType agencyType;

    @Column(name = "commission_file_id")
    private String commissionFileName;

    @Column(name = "commission_csv_key")
    private String commissionCsvKey;

    @Column(name = "updated_commission_csv_key")
    private String updatedCommissionCsvKey;

    @Enumerated(EnumType.STRING)
    @Column(name = "status_checker")
    private CmsAdmin.CheckerStatus statusChecker;

    @Column(name = "remarks_checker")
    private String remarkChecker;

    @Column(name = "checked_by")
    private String checkedBy;

    @Column(name = "checked_at")
    private Date checkedAt;

    @Enumerated(EnumType.STRING)
    @Column(name = "status_approver")
    private CmsAdmin.ApproverStatus statusApprover;

    @Column(name = "remarks_approver")
    private String remarkApprover;

    @Column(name = "approved_by")
    private String approvedBy;

    @Column(name = "approved_at")
    private Date approvedAt;

    @Column(name = "created_at")
    private Date createdAt;

    @Column(name = "updated_at")
    private Date updatedAt;

    @Column(name = "generated_bank_file")
    private Boolean generatedBankFile;

    @Column(name = "bank_result_csv")
    private String bankResultCsv;

    @Column(name = "updated_bank_result")
    private Boolean updatedBankResult;
}
