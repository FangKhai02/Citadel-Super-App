package com.citadel.backend.vo.Transaction;

import com.citadel.backend.entity.Products.*;
import com.citadel.backend.utils.DateToMillisecondsSerializer;
import com.citadel.backend.vo.Enum.ProductOrderType;
import com.citadel.backend.vo.Enum.Status;
import com.citadel.backend.vo.QuarterVo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
public class TransactionVo {
    public enum TransactionType {
        DIVIDEND, PLACEMENT, WITHDRAWAL, ROLLOVER, REDEMPTION, REALLOCATION
    }

    @JsonIgnore
    private Long historyId;
    private TransactionType transactionType;
    private String transactionTitle;
    private String productName;
    private String agreementNumber;
    @JsonSerialize(using = DateToMillisecondsSerializer.class)
    private Date transactionDate;
    private Double amount;
    private String bankName;
    private String transactionId;
    private Status status;
    private Double trusteeFee = 0.0;

    public TransactionVo(Long historyId, String productName, String agreementNumber, Date transactionDate, Double amount, String bankName, String transactionId) {
        this.historyId = historyId;
        this.productName = productName;
        this.agreementNumber = agreementNumber;
        this.transactionDate = transactionDate;
        this.amount = amount;
        this.bankName = bankName;
        this.transactionId = transactionId;
    }

    public static String getTransactionTitle(@NotNull TransactionType transactionType, ProductOrderType orderType, LocalDate periodStartingDate, LocalDate periodEndingDate) {
        String title = "";
        if (TransactionType.PLACEMENT.equals(transactionType)) {
            title = "Placement";
        }
        if (TransactionType.WITHDRAWAL.equals(transactionType)) {
            title = "Withdrawal";
        }
        if (TransactionType.DIVIDEND.equals(transactionType) && ProductOrderType.NEW.equals(orderType)) {
            QuarterVo quarter = QuarterVo.addQuarter(periodStartingDate, periodEndingDate);
            title = "Q" + quarter.getQuarterNumber() + " Profit Sharing Earned";
        }
        if (TransactionType.DIVIDEND.equals(transactionType) && ProductOrderType.ROLLOVER.equals(orderType)) {
            QuarterVo quarter = QuarterVo.addQuarter(periodStartingDate, periodEndingDate);
            title = "ROLLOVER Q" + quarter.getQuarterNumber() + " Profit Sharing Earned";
        }
        if (TransactionType.REDEMPTION.equals(transactionType)) {
            title = "Redemption";
        }
        if (TransactionType.REALLOCATION.equals(transactionType)) {
            title = "Reallocation";
        }
        return title;
    }

    public static TransactionVo dividendTransactionVo(ProductDividendCalculationHistory history) {
        TransactionVo transactionVo = new TransactionVo();
        if (history != null) {
            ProductOrder productOrder = history.getProductOrder();
            transactionVo.setHistoryId(history.getId());
            transactionVo.setTransactionType(TransactionType.DIVIDEND);
            transactionVo.setTransactionTitle("Q" + history.getDividendQuarter() + " Profit Sharing Earned");
            transactionVo.setProductName(productOrder.getProduct().getCode());
            transactionVo.setAgreementNumber(history.getProductOrder().getAgreementFileName());
            transactionVo.setTransactionDate(history.getPaymentDate());
            transactionVo.setAmount(history.getDividendAmount());
            transactionVo.setTrusteeFee(history.getTrusteeFeeAmount());
            transactionVo.setBankName(productOrder.getBank().getBankName());
            transactionVo.setTransactionId(history.getReferenceNumber());
            transactionVo.setStatus(Status.SUCCESS);
        }
        return transactionVo;
    }

    public static TransactionVo placementTransactionVo(TransactionVo productOrder) {
        TransactionVo transactionVo = new TransactionVo();
        if (productOrder != null) {
            transactionVo.setHistoryId(productOrder.getHistoryId());
            transactionVo.setTransactionType(TransactionType.PLACEMENT);
            transactionVo.setTransactionTitle(getTransactionTitle(TransactionType.PLACEMENT, null, null, null));
            transactionVo.setProductName(productOrder.getProductName());
            transactionVo.setAgreementNumber(productOrder.getAgreementNumber());
            transactionVo.setTransactionDate(productOrder.getTransactionDate());
            transactionVo.setAmount(productOrder.getAmount());
            transactionVo.setBankName(productOrder.getBankName());
            transactionVo.setTransactionId(productOrder.getAgreementNumber());
            transactionVo.setStatus(Status.SUCCESS);
        }
        return transactionVo;
    }

    public static TransactionVo redemptionTransactionVo(TransactionVo redemptionDetails) {
        TransactionVo transactionVo = new TransactionVo();
        if (redemptionDetails != null) {
            transactionVo.setTransactionType(TransactionType.REDEMPTION);
            transactionVo.setTransactionTitle(getTransactionTitle(TransactionType.REDEMPTION, null, null, null));
            transactionVo.setProductName(redemptionDetails.getProductName());
            transactionVo.setAgreementNumber(redemptionDetails.getAgreementNumber());
            transactionVo.setTransactionDate(redemptionDetails.getTransactionDate());
            transactionVo.setAmount(redemptionDetails.getAmount());
            transactionVo.setBankName(redemptionDetails.getBankName());
            transactionVo.setTransactionId(redemptionDetails.getAgreementNumber());
            transactionVo.setStatus(Status.SUCCESS);
        }
        return transactionVo;
    }

    //TransactionVo withdrawalTransactionVo(WithdrawalDetails withdrawalDetails)
    public static TransactionVo earlyRedemptionTransactionVo(TransactionVo productWithdrawalHistory) {
        TransactionVo transactionVo = new TransactionVo();
        if (productWithdrawalHistory != null) {
            transactionVo.setTransactionType(TransactionType.WITHDRAWAL);
            transactionVo.setTransactionTitle(getTransactionTitle(TransactionType.WITHDRAWAL, null, null, null));
            transactionVo.setProductName(productWithdrawalHistory.getProductName());
            transactionVo.setAgreementNumber(productWithdrawalHistory.getAgreementNumber());
            transactionVo.setTransactionDate(productWithdrawalHistory.getTransactionDate());
            transactionVo.setAmount(productWithdrawalHistory.getAmount());
            transactionVo.setBankName(productWithdrawalHistory.getBankName());
            transactionVo.setTransactionId(productWithdrawalHistory.getAgreementNumber());
            transactionVo.setStatus(Status.SUCCESS);
        }
        return transactionVo;
    }

    //TransactionVo reallocationTransactionVo(ReallocateReqVo reallocateReqVo)
    public static TransactionVo reallocateTransactionVo(ProductReallocation productReallocation) {
        TransactionVo transactionVo = new TransactionVo();
        if (productReallocation != null) {
            transactionVo.setTransactionType(TransactionType.REALLOCATION);
            transactionVo.setTransactionTitle(getTransactionTitle(TransactionType.REALLOCATION, null, null, null));
            transactionVo.setProductName(productReallocation.getProductOrder().getProduct().getCode());
            transactionVo.setAgreementNumber(productReallocation.getProductOrder().getAgreementFileName());
            transactionVo.setTransactionDate(productReallocation.getProductOrder().getPaymentDate());
            transactionVo.setAmount(productReallocation.getProductOrder().getPurchasedAmount());
            transactionVo.setBankName(productReallocation.getProductOrder().getBank().getBankName());
            transactionVo.setTransactionId(productReallocation.getProductOrder().getAgreementFileName());
            transactionVo.setStatus(Status.SUCCESS);
        }
        return transactionVo;
    }

    //TransactionVo rolloverTransactionVo(RolloverDetails rolloverDetails)
    public static TransactionVo rolloverTransactionVo(ProductRolloverHistory productRolloverHistory) {
        TransactionVo transactionVo = new TransactionVo();
        if (productRolloverHistory != null) {
            transactionVo.setTransactionType(TransactionType.ROLLOVER);
            transactionVo.setTransactionTitle(getTransactionTitle(TransactionType.ROLLOVER, null, null, null));
            transactionVo.setProductName(productRolloverHistory.getProductOrder().getProduct().getCode());
            transactionVo.setAgreementNumber(productRolloverHistory.getProductOrder().getAgreementFileName());
            transactionVo.setTransactionDate(productRolloverHistory.getProductOrder().getPaymentDate());
            transactionVo.setAmount(productRolloverHistory.getProductOrder().getPurchasedAmount());
            transactionVo.setBankName(productRolloverHistory.getProductOrder().getBank().getBankName());
            transactionVo.setTransactionId(productRolloverHistory.getProductOrder().getAgreementFileName());
            transactionVo.setStatus(Status.SUCCESS);
        }
        return transactionVo;
    }
}
