package com.citadel.backend.utils;

import com.citadel.backend.vo.Enum.IdentityDocumentType;
import com.citadel.backend.vo.Enum.ProductOrderType;
import com.citadel.backend.vo.Enum.ResidentialStatus;
import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

import java.util.HashMap;
import java.util.Map;

public class AffinBankUtil {

    public enum PaymentMode {
        //AFF - Affin 3rd Party Fund Transfer
        AFF,
        //IBG - Interbank GIRO
        IBG,
        //RTS - RENTAS
        RTS
    }

    public enum RecipientReferenceType {
        DIVIDEND, FULL_REDEMPTION, EARLY_REDEMPTION, COMMISSION, PARTIAL_REDEMPTION
    }

    @Getter
    public enum BeneficiaryIdType implements EnumWithValue {
        MYKAD("New IC Number"),
        PASSPORT("Police/Army/Passport"),
        MYPOLIS("Police/Army/Passport"),
        MYTENTERA("Police/Army/Passport");

        public final String value;

        BeneficiaryIdType(String value) {
            this.value = value;
        }
    }

    @Getter
    public enum RemitterBeneficiaryRelationship implements EnumWithValue {
        SAMEPARTY("01"),
        THRIDPARTY("02");

        public final String value;

        RemitterBeneficiaryRelationship(String value) {
            this.value = value;
        }
    }

    public static final String RecordTypePayment = "01";
    public static final String RecordTypePaymentAdvice = "02";
    public static final String RecordTypeSummaryRow = "99";

    public final static String PAYMENT_ADVICE_DETAIL = "CAPITAL REPAYMENT";
    public final static String DEBITING_ACCOUNT_NO = "106570010563";

    public static String getRecipientReference(RecipientReferenceType referenceType, ProductOrderType orderType, Integer counter) {
        return switch (referenceType) {
            case EARLY_REDEMPTION, PARTIAL_REDEMPTION -> "REFUND";
            case FULL_REDEMPTION -> "CAPITAL REPAYMENT";
            case COMMISSION -> "COMMISSION";
            case DIVIDEND -> switch (orderType) {
                case NEW -> "Q" + counter + " DIV PAYMENT";
                case ROLLOVER -> "ROLLOVER Q" + counter + " DIV PAYMENT";
                default -> "";
            };
            default -> "";
        };
    }

    public static String getBeneficiaryIdType(IdentityDocumentType type) {
        if (type == null) {
            return null;
        }
        if (type == IdentityDocumentType.MYKAD) {
            return BeneficiaryIdType.MYKAD.value;
        } else if (type == IdentityDocumentType.PASSPORT) {
            return BeneficiaryIdType.PASSPORT.value;
        } else if (type == IdentityDocumentType.MYPOLIS) {
            return BeneficiaryIdType.MYPOLIS.value;
        } else if (type == IdentityDocumentType.MYTENTERA) {
            return BeneficiaryIdType.MYTENTERA.value;
        } else {
            return null;
        }
    }

    public static String getResidentIndicator(ResidentialStatus status) {
        if (status == null) {
            return null;
        }
        if (status.equals(ResidentialStatus.RESIDENT) || status.equals(ResidentialStatus.CITIZEN)) {
            return "Y";
        } else {
            return "N";
        }
    }

    public static String getAFFINBnmCode(String bankName) {
        if (StringUtil.isEmpty(bankName)) {
            return "";
        }

        String normalizedName = bankName.toUpperCase()
                .replace("(MALAYSIA)", "")
                .replace("BANKING", "")
                .replace("INVESTMENT", "")
                .replace("CORPORATION", "")
                .replace("&", "")
                .replace("(M)", "")
                .replace(" BERHAD", "")
                .replace(" MALAYSIA", "")
                .replace(" BANK", "")
                .replaceAll("\\s+", "")
                .trim();

        Map<String, String> BANK_BNM_CODES = new HashMap<>();
        BANK_BNM_CODES.put("MAYBANK", "MBBEMYKL");
        BANK_BNM_CODES.put("MAYBANKISLAMIC", "MBISMYKL");
        BANK_BNM_CODES.put("CIMB", "CIBBMYKL");
        BANK_BNM_CODES.put("CIMBISLAMIC", "CTBBMYKL");
        BANK_BNM_CODES.put("BANKISLAM", "BIMBMYKL");
        BANK_BNM_CODES.put("BANKKERJASAMARAKYAT", "BKRMMYKL");
        BANK_BNM_CODES.put("RHB", "RHBBMYKL");
        BANK_BNM_CODES.put("RHBISLAMIC", "RHBAMYKL");
        BANK_BNM_CODES.put("HONGLEONG", "HLBBMYKL");
        BANK_BNM_CODES.put("HONGLEONGISLAMIC", "HLIBMYKL");
        BANK_BNM_CODES.put("PUBLIC", "PBBEMYKL");
        BANK_BNM_CODES.put("PUBLICISLAMIC", "PIBEMYK1");
        BANK_BNM_CODES.put("BANKSIMPANANNASIONAL", "BSNAMYK1");
        BANK_BNM_CODES.put("HSBC", "HBMBMYKL");
        BANK_BNM_CODES.put("AMBANK", "ARBKMYKL");
        BANK_BNM_CODES.put("ALRAJHI", "RJHIMYKL");
        BANK_BNM_CODES.put("BANKMUAMALAT", "BMMBMYKL");
        BANK_BNM_CODES.put("STANDARDCHARTERED", "SCBLMYKX");

        //If the bank is “Affin Bank Berhad“ OR “Affin Islamic Bank Berhad“ then hide the bank code
        BANK_BNM_CODES.put("AFFIN", "");
        BANK_BNM_CODES.put("AFFINISLAMIC", "");

        BANK_BNM_CODES.put("UNITEDOVERSEAS", "UOVBMYKL");
        BANK_BNM_CODES.put("OCBC", "OCBCMYKL");
        BANK_BNM_CODES.put("OCBCAL-AMIN", "OABBMYKL");
        BANK_BNM_CODES.put("ALLIANCE", "MFBBMYKL");
        BANK_BNM_CODES.put("MBSB", "AFBQMYKL");
        BANK_BNM_CODES.put("AGRO", "AGOBMYKL");
        BANK_BNM_CODES.put("BANKOFCHINA", "BKCHMYKL");
        BANK_BNM_CODES.put("GX", "GX Bank Berhad");

        return BANK_BNM_CODES.entrySet().stream()
                .filter(entry -> normalizedName.equals(entry.getKey()))
                .map(Map.Entry::getValue)
                .findFirst()
                .orElse("");
    }

    public static String[] getColumnHeaders() {
        return new String[]{
                "Record Type\n*01-Payment\n*02-Payment Advice",     // Column A
                "01 - Payment Mode\n02 - Payment Advice Amount",    // Column B
                "01 - Payment Date\n02 - Advice Detail",            // Column C
                "01 - Customer Ref No.\n02 - Email Address 1",      // Column D
                "01 - Payment Amount\n02 - Email Address 2",        // Column E
                "01 - Debiting Acc. No.\n02 - Email Address 3",     // Column F
                "01 - Beneficiary Bank Code\n02 - Email Address 4", // Column G
                "01 - Beneficiary Acc. No\n02 - Email Address 5",   // Column H
                "01 - Beneficiary Name\n02 - Email Address 6",      // Column I
                "01 - ID Checking Required",                        // Column J
                "01 - Beneficiary ID Type",                         // Column K
                "01 - Beneficiary ID No.",                          // Column L
                "01 - Resident Indicator",                          // Column M
                "01 - Resident Country",                            // Column N
                "01 - Joint Name",                                  // Column O
                "01 - ID Checking Required for - Joint Name",       // Column P
                "01 - Joint Name - ID Type",                        // Column Q
                "01 - Joint Name - ID No.",                         // Column R
                "01 - Recipient Reference",                         // Column S
                "01 - Credit Description/ Other Payment Details",   // Column T
                "01 - Remitter and Beneficiary Relationship",       // Column U
                "01 - Purpose of Transfer",                         // Column V
                "01 - Purpose of Transfer Code",                    // Column W
                "01 - Others Purpose of Transfer"                   // Column X
        };
    }
}
