package com.citadel.backend.utils;

import com.citadel.backend.vo.Enum.ProductOrderType;
import com.citadel.backend.vo.QuarterVo;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

public class CIMBBankUtil {

    public enum RecipientReferenceType {
        DIVIDEND, FULL_REDEMPTION, EARLY_REDEMPTION, COMMISSION, PARTIAL_REDEMPTION
    }

    //References:
    //https://support.qne.com.my/support/solutions/articles/81000406162-what-is-bank-bnm-code-in-payroll-system-
    //https://docs.google.com/spreadsheets/d/148fNiMnUyQlMT6Wd5qJNt5vMwkX3HnNU/edit?gid=901793487#gid=901793487
    public static String getCIMBBnmCode(String bankName) {
        if (StringUtil.isEmpty(bankName)) {
            return "";
        }

        // Normalize bank name by removing common suffixes and converting to uppercase
        String normalizedName = bankName.toUpperCase()
                .replace(" BERHAD", "")
                .replace(" (M)", "")
                .replace(" MALAYSIA", "")
                .replace(" ISLAMIC", "")
                .replace(" BANK", "")
                .trim();

        Map<String, String> BANK_BNM_CODES = new HashMap<>();
        // Initialize bank BNM codes
        BANK_BNM_CODES.put("MAYBANK", "27");
        BANK_BNM_CODES.put("CIMB", "35");
        BANK_BNM_CODES.put("BANK ISLAM", "45");
        BANK_BNM_CODES.put("BANK KERJASAMA RAKYAT", "02");
        BANK_BNM_CODES.put("RHB", "18");
        BANK_BNM_CODES.put("HONG LEONG", "24");
        BANK_BNM_CODES.put("PUBLIC", "33");
        BANK_BNM_CODES.put("BANK SIMPANAN NASIONAL", "10");
        BANK_BNM_CODES.put("HSBC", "22");
        BANK_BNM_CODES.put("AMBANK", "08");
        BANK_BNM_CODES.put("AL RAJHI", "53");
        BANK_BNM_CODES.put("BANK MUAMALAT", "41");
        BANK_BNM_CODES.put("STANDARD CHARTERED", "14");
        BANK_BNM_CODES.put("AFFIN", "32");
        BANK_BNM_CODES.put("UNITED OVERSEAS", "26");
        BANK_BNM_CODES.put("OCBC", "29");
        BANK_BNM_CODES.put("ALLIANCE", "12");
        BANK_BNM_CODES.put("MBSB", "75");
        BANK_BNM_CODES.put("AGRO", "49");
        BANK_BNM_CODES.put("BANK OF CHINA", "42");
        BANK_BNM_CODES.put("GX", "GX Bank Berhad");

        // Find matching bank code
        return BANK_BNM_CODES.entrySet().stream()
                .filter(entry -> normalizedName.contains(entry.getKey()))
                .map(Map.Entry::getValue)
                .findFirst()
                .orElse("");
    }

    public static String getRecipientReference(RecipientReferenceType referenceType, ProductOrderType orderType, LocalDate periodStartingDate, LocalDate periodEndingDate) {
        return switch (referenceType) {
            case EARLY_REDEMPTION, PARTIAL_REDEMPTION -> "REFUND";
            case FULL_REDEMPTION -> "CAPITAL REPAYMENT";
            case COMMISSION -> "CWP COMM ";
            case DIVIDEND -> {
                QuarterVo quarter = QuarterVo.addQuarter(periodStartingDate, periodEndingDate);
                yield switch (orderType) {
                    case NEW -> "Q" + quarter.getQuarterNumber() + " DIV PAYMENT";
                    case ROLLOVER -> "ROLLOVER Q" + quarter.getQuarterNumber() + " DIV PAYMENT";
                    default -> ""; // Handle unexpected order types if needed
                };
            }
        };
    }

    public static String sanitizeBeneficiaryName(String beneficiaryName) {
        if (StringUtil.isEmpty(beneficiaryName)) {
            return "";
        }
        beneficiaryName = beneficiaryName.replace("-", " ").replace("/", "");
        if (beneficiaryName.length() > 40) {
            beneficiaryName = beneficiaryName.substring(0, 40);
        }
        return beneficiaryName;
    }

    public static String sanitizeAccountNumber(String accountNumber) {
        if (StringUtil.isEmpty(accountNumber)) {
            return "";
        }
        accountNumber = accountNumber.replace("-", "").replace(" ", "");
        if (accountNumber.length() > 16) {
            accountNumber = accountNumber.substring(0, 16);
        }
        return accountNumber;
    }
}
