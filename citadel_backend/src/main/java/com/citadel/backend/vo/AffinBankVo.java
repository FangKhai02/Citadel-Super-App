package com.citadel.backend.vo;

import com.citadel.backend.utils.AffinBankUtil;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class AffinBankVo {
    // Row 1 (Payment Record)
    private String colARowOneRecordTypePayment = AffinBankUtil.RecordTypePayment;
    private String colBRowOnePaymentMode = AffinBankUtil.PaymentMode.IBG.name();
    private String colCRowOnePaymentDate = "";
    private String colDRowOneCustomerRefNo = "";
    private Double colERowOnePaymentAmount = 0.0;
    private String colFRowOneDebitingAccountNo = AffinBankUtil.DEBITING_ACCOUNT_NO;
    private String colGRowOneBeneficiaryBankCode = "";
    private String colHRowOneBeneficiaryAccNo = "";
    private String colIRowOneBeneficiaryName = "";
    private String colJRowOneIDCheckingRequired = "";
    private String colKRowOneBeneficiaryIdType = "";
    private String colLRowOneBeneficiaryIdNo = "";
    private String colMRowOneResidentIndicator = "";
    private String colNRowOneResidentCountry = "";
    private String colORowOneJointName = "";
    private String colPRowOneJointNameIdChecking = "";
    private String colQRowOneJointNameIdType = "";
    private String colRRowOneJointNameIdNo = "";
    private String colSRowOneRecipientReference = "";
    private String colTRowOneCreditDescription = "";
    private String colURowOneRemitterBeneficiaryRelationship = AffinBankUtil.RemitterBeneficiaryRelationship.SAMEPARTY.getValue();
    private String colVRowOnePurposeOfTransfer = "";
    private String colWRowOnePurposeOfTransferCode = "";
    private String colXRowOneOthersPurposeOfTransfer = "";

    // Row 2 (Payment Advice)
    private String colARowTwoRecordTypePaymentAdvice = AffinBankUtil.RecordTypePaymentAdvice;
    private String colBRowTwoPaymentAdviceAmount = "";
    private String colCRowTwoPaymentAdviceDetail = "";
    private String colDRowTwoEmailAddress1 = "";

    // Methods to return row values as lists
    public List<String> getPaymentRecordRow() {
        return List.of(
                colARowOneRecordTypePayment,
                colBRowOnePaymentMode,
                colCRowOnePaymentDate,
                colDRowOneCustomerRefNo,
                String.format("%.2f", colERowOnePaymentAmount),
                colFRowOneDebitingAccountNo,
                colGRowOneBeneficiaryBankCode,
                colHRowOneBeneficiaryAccNo,
                colIRowOneBeneficiaryName,
                colJRowOneIDCheckingRequired,
                colKRowOneBeneficiaryIdType,
                colLRowOneBeneficiaryIdNo,
                colMRowOneResidentIndicator,
                colNRowOneResidentCountry,
                colORowOneJointName,
                colPRowOneJointNameIdChecking,
                colQRowOneJointNameIdType,
                colRRowOneJointNameIdNo,
                colSRowOneRecipientReference,
                colTRowOneCreditDescription,
                colURowOneRemitterBeneficiaryRelationship,
                colVRowOnePurposeOfTransfer,
                colWRowOnePurposeOfTransferCode,
                colXRowOneOthersPurposeOfTransfer
        );
    }

    public List<String> getPaymentAdviceRow() {
        // For columns 0 to 3, provide values; the rest can be empty if your template expects them.
        List<String> adviceRow = new ArrayList<>();
        adviceRow.add(colARowTwoRecordTypePaymentAdvice);
        adviceRow.add(colBRowTwoPaymentAdviceAmount);
        adviceRow.add(colCRowTwoPaymentAdviceDetail);
        adviceRow.add(colDRowTwoEmailAddress1);
        // Fill remaining columns with empty strings. Adjust totalColumns accordingly.
        int totalColumns = 24; // for example, if you expect 24 columns
        for (int i = 4; i < totalColumns; i++) {
            adviceRow.add("");
        }
        return adviceRow;
    }
}
