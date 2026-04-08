package com.citadel.backend.entity.Commission;

import com.citadel.backend.entity.BaseEntity;
import com.citadel.backend.vo.Enum.Status;
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
@Table(name = "agent_commission_history")
public class AgentCommissionHistory extends BaseEntity {

    public enum CommissionType {
        PERSONAL, OVERRIDING
    }

    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(name = "commission_type")
    private CommissionType commissionType;

    @Column(name = "agent_id")
    private String agentId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "agent_commission_calculation_history_id")
    private AgentCommissionCalculationHistory agentCommissionCalculationHistory;

    @Column(name = "commission_percentage")
    private Double commissionPercentage;

    @Column(name = "commission_amount")
    private Double commissionAmount;

    @Enumerated(EnumType.STRING)
    @Column(name = "payment_status")
    private Status paymentStatus;

    @Column(name = "payment_date")
    private Date paymentDate;

    @Column(name = "payment_transaction_id")
    private String paymentTransactionId;
}
