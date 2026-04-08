package com.citadel.backend.vo.Migration;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Data;

@Data
public class AgentCommissionHistoryMigrationVo {
    @ExcelColumn("agreement_number")
    private String agreementNumber;
    @ExcelColumn("manager_identity_card_number")
    private String managerIdentityCardNumber;
    @ExcelColumn("manager_role")
    private String managerRole;
    @ExcelColumn("manager_commission_percentage")
    private String managerCommissionPercentage;
    @ExcelColumn("manager_commission_amount")
    private String managerCommissionAmount;
    @ExcelColumn("p2p_identity_card_number")
    private String p2pIdentityCardNumber;
    @ExcelColumn("p2p_commission_percentage")
    private String p2pCommissionPercentage;
    @ExcelColumn("p2p_commission_amount")
    private String p2pCommissionAmount;
    @ExcelColumn("sm_identity_card_number")
    private String smIdentityCardNumber;
    @ExcelColumn("sm_commission_percentage")
    private String smCommissionPercentage;
    @ExcelColumn("sm_commission_amount")
    private String smCommissionAmount;
    @ExcelColumn("avp_identity_card_number")
    private String avpIdentityCardNumber;
    @ExcelColumn("avp_commission_percentage")
    private String avpCommissionPercentage;
    @ExcelColumn("avp_commission_amount")
    private String avpCommissionAmount;
    @ExcelColumn("vp_identity_card_number")
    private String vpIdentityCardNumber;
    @ExcelColumn("vp_commission_percentage")
    private String vpCommissionPercentage;
    @ExcelColumn("vp_commission_amount")
    private String vpCommissionAmount;
    @ExcelColumn("svp_identity_card_number")
    private String svpIdentityCardNumber;
    @ExcelColumn("commission_calculated_date")
    private String commissionCalculatedDate;
    @ExcelColumn("payment_status")
    private String paymentStatus;
    @ExcelColumn("payment_date")
    private String paymentDate;
}
