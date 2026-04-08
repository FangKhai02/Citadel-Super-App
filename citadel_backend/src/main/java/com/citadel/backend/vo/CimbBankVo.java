package com.citadel.backend.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class CimbBankVo {
    public enum TYPE {DIVIDEND, COMMISSION, REDEMPTION}

    private String colABeneficiaryName;
    private String colBBeneficiaryId;//Optional
    private String colCBnmCode;
    private String colDAccountNumber;
    private Double colEPaymentAmount;
    private String colFReferenceNumber;//Optional
    private String colGBeneficiaryEmailAddress;
    private String colHPaymentReferenceNumber;
    private String colIPaymentDescription;//Optional
    private String colJPaymentDetailNumber;
    private String colKPaymentDetailDate;
    private String colLPaymentDescription;
    private Double colMPaymentDetailAmount;

    public String getColABeneficiaryName() {
        return colABeneficiaryName;
    }

    public void setColABeneficiaryName(String colABeneficiaryName) {
        this.colABeneficiaryName = colABeneficiaryName;
    }

    public String getColBBeneficiaryId() {
        return colBBeneficiaryId;
    }

    public void setColBBeneficiaryId(String colBBeneficiaryId) {
        this.colBBeneficiaryId = colBBeneficiaryId;
    }

    public String getColCBnmCode() {
        return colCBnmCode;
    }

    public void setColCBnmCode(String colCBnmCode) {
        this.colCBnmCode = colCBnmCode;
    }

    public String getColDAccountNumber() {
        return colDAccountNumber;
    }

    public void setColDAccountNumber(String colDAccountNumber) {
        this.colDAccountNumber = colDAccountNumber;
    }

    public Double getColEPaymentAmount() {
        return colEPaymentAmount;
    }

    public void setColEPaymentAmount(Double colEPaymentAmount) {
        this.colEPaymentAmount = colEPaymentAmount;
    }

    public String getColFReferenceNumber() {
        return colFReferenceNumber;
    }

    public void setColFReferenceNumber(String colFReferenceNumber) {
        this.colFReferenceNumber = colFReferenceNumber;
    }

    public String getColGBeneficiaryEmailAddress() {
        return colGBeneficiaryEmailAddress;
    }

    public void setColGBeneficiaryEmailAddress(String colGBeneficiaryEmailAddress) {
        this.colGBeneficiaryEmailAddress = colGBeneficiaryEmailAddress;
    }

    public String getColHPaymentReferenceNumber() {
        return colHPaymentReferenceNumber;
    }

    public void setColHPaymentReferenceNumber(String colHPaymentReferenceNumber) {
        this.colHPaymentReferenceNumber = colHPaymentReferenceNumber;
    }

    public String getColIPaymentDescription() {
        return colIPaymentDescription;
    }

    public void setColIPaymentDescription(String colIPaymentDescription) {
        this.colIPaymentDescription = colIPaymentDescription;
    }

    public String getColJPaymentDetailNumber() {
        return colJPaymentDetailNumber;
    }

    public void setColJPaymentDetailNumber(String colJPaymentDetailNumber) {
        this.colJPaymentDetailNumber = colJPaymentDetailNumber;
    }

    public String getColKPaymentDetailDate() {
        return colKPaymentDetailDate;
    }

    public void setColKPaymentDetailDate(String colKPaymentDetailDate) {
        this.colKPaymentDetailDate = colKPaymentDetailDate;
    }

    public String getColLPaymentDescription() {
        return colLPaymentDescription;
    }

    public void setColLPaymentDescription(String colLPaymentDescription) {
        this.colLPaymentDescription = colLPaymentDescription;
    }

    public Double getColMPaymentDetailAmount() {
        return colMPaymentDetailAmount;
    }

    public void setColMPaymentDetailAmount(Double colMPaymentDetailAmount) {
        this.colMPaymentDetailAmount = colMPaymentDetailAmount;
    }

    // Methods to return row values as lists
    public List<String> getDividendRecordRow() {
        return List.of(
                colABeneficiaryName,
                colBBeneficiaryId,
                colCBnmCode,
                colDAccountNumber,
                String.format("%.2f", colEPaymentAmount),
                colFReferenceNumber,
                colGBeneficiaryEmailAddress,
                colHPaymentReferenceNumber,
                colIPaymentDescription,
                colJPaymentDetailNumber,
                colKPaymentDetailDate,
                colLPaymentDescription,
                String.format("%.2f", colMPaymentDetailAmount)
        );
    }

    public List<String> getCommissionRecordRow() {
        return List.of(
                colABeneficiaryName,
                colBBeneficiaryId,
                colCBnmCode,
                colDAccountNumber,
                String.format("%.2f", colEPaymentAmount),
                colFReferenceNumber,
                colIPaymentDescription
        );
    }
}
