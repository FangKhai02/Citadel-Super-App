package com.citadel.backend.entity.Commission;

import com.citadel.backend.entity.BaseEntity;
import com.citadel.backend.vo.Enum.AgentRole;
import com.citadel.backend.vo.Enum.ProductOrderType;
import com.fasterxml.jackson.annotation.JsonIgnore;
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
@Table(name = "agent_commission_calculation_history")
public class AgentCommissionCalculationHistory extends BaseEntity {
    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "reference_number")
    private String referenceNumber;

    @Column(name="order_submission_date")
    private Date orderSubmissionDate;

    @Column(name = "order_agreement_date")
    private LocalDate orderAgreementDate;

    @Column(name = "client_name")
    private String clientName;

    @Column(name = "order_agreement_number")
    private String orderAgreementNumber;

    @Column(name = "purchased_amount")
    private Double purchasedAmount;

    @Column(name = "mgr_id")
    private Long mgrId;

    @Column(name = "mgr_digital_id")
    private String mgrDigitalId;

    @Column(name = "mgr_name")
    private String mgrName;

    @Enumerated(EnumType.STRING)
    @Column(name = "mgr_role")
    private AgentRole mgrRole;

    @Column(name = "mgr_commission_percentage")
    private Double mgrCommissionPercentage = 0.0;

    @Column(name = "mgr_commission_amount")
    private Double mgrCommissionAmount = 0.0;

    @Column(name = "p2p_id")
    private Long p2pId;

    @Column(name = "p2p_digital_id")
    private String p2pDigitalId;

    @Column(name = "p2p_name")
    private String p2pName;

    @Column(name = "p2p_commission_percentage")
    private Double p2pCommissionPercentage = 0.0;

    @Column(name = "p2p_commission_amount")
    private Double p2pCommissionAmount = 0.0;

    @Column(name = "sm_id")
    private Long smId;

    @Column(name = "sm_digital_id")
    private String smDigitalId;

    @Column(name = "sm_name")
    private String smName;

    @Column(name = "sm_commission_percentage")
    private Double smCommissionPercentage = 0.0;

    @Column(name = "sm_commission_amount")
    private Double smCommissionAmount = 0.0;

    @Column(name = "avp_id")
    private Long avpId;

    @Column(name = "avp_digital_id")
    private String avpDigitalId;

    @Column(name = "avp_name")
    private String avpName;

    @Column(name = "avp_commission_percentage")
    private Double avpCommissionPercentage = 0.0;

    @Column(name = "avp_commission_amount")
    private Double avpCommissionAmount = 0.0;

    @Column(name = "vp_id")
    private Long vpId;

    @Column(name = "vp_digital_id")
    private String vpDigitalId;

    @Column(name = "vp_name")
    private String vpName;

    @Column(name = "vp_commission_percentage")
    private Double vpCommissionPercentage = 0.0;

    @Column(name = "vp_commission_amount")
    private Double vpCommissionAmount = 0.0;

    @Column(name = "svp_id")
    private Long svpId;

    @Column(name = "svp_digital_id")
    private String svpDigitalId;

    @Column(name = "svp_name")
    private String svpName;

    @Column(name = "svp_commission_percentage")
    private Double svpCommissionPercentage = 0.0;

    @Column(name = "product_id")
    private Long productId;

    @Column(name = "product_order_id")
    private Long productOrderId;

    @Enumerated(EnumType.STRING)
    @Column(name = "product_order_type")
    private ProductOrderType productOrderType;

    @Column(name = "calculated_date")
    private LocalDate calculatedDate;

    @Column(name = "generated_commission_file")
    private Boolean generatedCommissionFile;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_commission_history_id", referencedColumnName = "id")
    private ProductCommissionHistory productCommissionHistory;

    @Column(name = "remark")
    private String remark;
}
