package com.citadel.backend.vo.Commission;

import com.citadel.backend.annotation.ExcelColumn;
import com.citadel.backend.entity.Commission.AgencyCommissionCalculationHistory;
import com.citadel.backend.entity.Commission.AgentCommissionCalculationHistory;
import com.citadel.backend.utils.DateUtil;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.Date;

@Getter
@Setter
public class CommissionExcelVo {
    @ExcelColumn("Reference Number")
    private String referenceNumber;
    @ExcelColumn("Date of Submission")
    private Date dateOfSubmission;
    @ExcelColumn("Payout Date")
    private Date payoutDate;
    @ExcelColumn("Agreement Date")
    private LocalDate agreementDate;
    @ExcelColumn("Client name")
    private String clientName;
    @ExcelColumn("Agreement Number")
    private String agreementFileName;
    @ExcelColumn("Investment Amount in MYR")
    private Double purchasedAmount;
    @ExcelColumn("Agency ID")
    private String agencyId;
    @ExcelColumn("Agent")
    private String agentName;
    @ExcelColumn("Agent ID")
    private String mgrAgentId;
    @ExcelColumn("Position")
    private String agentPosition;
    @ExcelColumn("Amount")
    private Double agentCommissionAmount;
    @ExcelColumn("%")
    private Double agentCommissionRate;
    @ExcelColumn("P2P/A.Mgr")
    private String p2pName;
    @ExcelColumn("Agent ID")
    private String p2pAgentId;
    @ExcelColumn("Amount")
    private Double p2pCommissionAmount;
    @ExcelColumn("%")
    private Double p2pCommissionRate;
    @ExcelColumn("SM")
    private String smName;
    @ExcelColumn("Agent ID")
    private String smAgentId;
    @ExcelColumn("Amount")
    private Double smCommissionAmount;
    @ExcelColumn("%")
    private Double smCommissionRate;
    @ExcelColumn("AVP")
    private String avpName;
    @ExcelColumn("Agent ID")
    private String avpAgentId;
    @ExcelColumn("Amount")
    private Double avpCommissionAmount;
    @ExcelColumn("%")
    private Double avpCommissionRate;
    @ExcelColumn("VP/HOS")
    private String vpName;
    @ExcelColumn("Agent ID")
    private String vpAgentId;
    @ExcelColumn("Amount")
    private Double vpCommissionAmount;
    @ExcelColumn("%")
    private Double vpCommissionRate;
    @ExcelColumn("SVP")
    private String svp1Name;
    @ExcelColumn("Agent ID")
    private String svp1AgentId;
    @ExcelColumn("%")
    private Double svp1CommissionRate;
    @ExcelColumn("SVP")
    private String svp2Name;
    @ExcelColumn("Agent ID")
    private String svp2AgentId;
    @ExcelColumn("%")
    private Double svp2CommissionRate;
    @ExcelColumn("TOTAL")
    private Double totalCommissionRate;
    @ExcelColumn("Remark")
    private String remark;

    public static CommissionExcelVo agencyCommissionCalculationHistoryToCommissionExcelVo(AgencyCommissionCalculationHistory calculationHistory) {
        CommissionExcelVo commissionExcelVo = new CommissionExcelVo();
        commissionExcelVo.setReferenceNumber(calculationHistory.getReferenceNumber());
        Date dateOfSubmission = calculationHistory.getOrderSubmissionDate() == null ? DateUtil.convertLocalDateToDate(calculationHistory.getOrderAgreementDate()) : calculationHistory.getOrderSubmissionDate();
        commissionExcelVo.setDateOfSubmission(dateOfSubmission);
        LocalDate calculatedDate = calculationHistory.getCalculatedDate();
        LocalDate paymentDate = calculatedDate.withDayOfMonth(calculatedDate.lengthOfMonth());
        commissionExcelVo.setPayoutDate(DateUtil.convertLocalDateToDate(paymentDate));
        commissionExcelVo.setAgreementDate(calculationHistory.getOrderAgreementDate());
        commissionExcelVo.setClientName(calculationHistory.getClientName());
        commissionExcelVo.setAgreementFileName(calculationHistory.getOrderAgreementNumber());
        commissionExcelVo.setPurchasedAmount(calculationHistory.getPurchasedAmount());
        commissionExcelVo.setAgentName(calculationHistory.getAgencyName());
        commissionExcelVo.setAgentPosition("AGENCY");
        commissionExcelVo.setAgentCommissionAmount(calculationHistory.getCommissionAmount());
        commissionExcelVo.setAgentCommissionRate(calculationHistory.getCommissionRate());
        commissionExcelVo.setP2pName("");
        commissionExcelVo.setP2pCommissionAmount(0.0);
        commissionExcelVo.setP2pCommissionRate(0.0);
        commissionExcelVo.setSmName("");
        commissionExcelVo.setSmCommissionAmount(0.0);
        commissionExcelVo.setSmCommissionRate(0.0);
        commissionExcelVo.setAvpName("");
        commissionExcelVo.setAvpCommissionAmount(0.0);
        commissionExcelVo.setAvpCommissionRate(0.0);
        commissionExcelVo.setVpName("");
        commissionExcelVo.setVpCommissionAmount(0.0);
        commissionExcelVo.setVpCommissionRate(0.0);
        commissionExcelVo.setTotalCommissionRate(calculationHistory.getCommissionRate());
        return commissionExcelVo;
    }

    public static CommissionExcelVo agentCommissionCalculationHistoryToCommissionExcelVo(AgentCommissionCalculationHistory calculationHistory, String agencyId) {
        CommissionExcelVo commissionExcelVo = new CommissionExcelVo();
        commissionExcelVo.setReferenceNumber(calculationHistory.getReferenceNumber());
        Date dateOfSubmission = calculationHistory.getOrderSubmissionDate() == null ? DateUtil.convertLocalDateToDate(calculationHistory.getOrderAgreementDate()) : calculationHistory.getOrderSubmissionDate();
        commissionExcelVo.setDateOfSubmission(dateOfSubmission);
        LocalDate calculatedDate = calculationHistory.getCalculatedDate();
        LocalDate paymentDate = calculatedDate.withDayOfMonth(calculatedDate.lengthOfMonth());
        commissionExcelVo.setPayoutDate(DateUtil.convertLocalDateToDate(paymentDate));
        commissionExcelVo.setAgreementDate(calculationHistory.getOrderAgreementDate());
        commissionExcelVo.setClientName(calculationHistory.getClientName());
        commissionExcelVo.setAgreementFileName(calculationHistory.getOrderAgreementNumber());
        commissionExcelVo.setPurchasedAmount(calculationHistory.getPurchasedAmount());
        commissionExcelVo.setAgencyId(agencyId);
        commissionExcelVo.setAgentName(calculationHistory.getMgrName());
        commissionExcelVo.setMgrAgentId(calculationHistory.getMgrDigitalId());
        commissionExcelVo.setAgentPosition(calculationHistory.getMgrRole().toString());
        commissionExcelVo.setAgentCommissionAmount(calculationHistory.getMgrCommissionAmount());
        commissionExcelVo.setAgentCommissionRate(calculationHistory.getMgrCommissionPercentage());
        commissionExcelVo.setP2pName(calculationHistory.getP2pName());
        commissionExcelVo.setP2pAgentId(calculationHistory.getP2pDigitalId());
        commissionExcelVo.setP2pCommissionAmount(calculationHistory.getP2pCommissionAmount());
        commissionExcelVo.setP2pCommissionRate(calculationHistory.getP2pCommissionPercentage());
        commissionExcelVo.setSmName(calculationHistory.getSmName());
        commissionExcelVo.setSmAgentId(calculationHistory.getSmDigitalId());
        commissionExcelVo.setSmCommissionAmount(calculationHistory.getSmCommissionAmount());
        commissionExcelVo.setSmCommissionRate(calculationHistory.getSmCommissionPercentage());
        commissionExcelVo.setAvpName(calculationHistory.getAvpName());
        commissionExcelVo.setAvpAgentId(calculationHistory.getAvpDigitalId());
        commissionExcelVo.setAvpCommissionAmount(calculationHistory.getAvpCommissionAmount());
        commissionExcelVo.setAvpCommissionRate(calculationHistory.getAvpCommissionPercentage());
        commissionExcelVo.setVpName(calculationHistory.getVpName());
        commissionExcelVo.setVpAgentId(calculationHistory.getVpDigitalId());
        commissionExcelVo.setVpCommissionAmount(calculationHistory.getVpCommissionAmount());
        commissionExcelVo.setVpCommissionRate(calculationHistory.getVpCommissionPercentage());
        commissionExcelVo.setSvp1Name(calculationHistory.getSvpName());
        commissionExcelVo.setSvp1AgentId(calculationHistory.getSvpDigitalId());
        commissionExcelVo.setSvp2Name(calculationHistory.getSvpName());
        commissionExcelVo.setSvp2AgentId(calculationHistory.getSvpDigitalId());
        commissionExcelVo.setTotalCommissionRate(calculationHistory.getMgrCommissionPercentage() + calculationHistory.getP2pCommissionPercentage() + calculationHistory.getSmCommissionPercentage() + calculationHistory.getAvpCommissionPercentage() + calculationHistory.getVpCommissionPercentage());
        return commissionExcelVo;
    }
}
