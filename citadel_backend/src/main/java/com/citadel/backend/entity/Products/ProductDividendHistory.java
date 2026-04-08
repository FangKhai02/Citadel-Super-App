package com.citadel.backend.entity.Products;

import com.citadel.backend.vo.Enum.CmsAdmin;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "product_dividend_history")
public class ProductDividendHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "csv_file_name")
    private String csvFileName;

    @Column(name = "dividend_csv_key")
    private String dividendCsvKey;

    @Column(name = "updated_dividend_csv_key")
    private String updatedDividendCsvKey;

    @Column(name = "created_at")
    private Date createdAt;

    @Column(name = "updated_at")
    private Date updatedAt;

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

    @Column(name = "generated_bank_file")
    private Boolean generatedBankFile;

    @Column(name = "bank_result_csv")
    private String bankResultCsv;

    @Column(name = "updated_bank_result")
    private Boolean updatedBankResult;
}
