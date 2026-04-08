package com.citadel.backend.service;

import com.citadel.backend.dao.Products.ProductDividendScheduleDao;
import com.citadel.backend.entity.Products.ProductDividendCalculationHistory;
import com.citadel.backend.utils.*;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.vo.BankPaymentRecordVo;
import com.citadel.backend.vo.Enum.ProductOrderType;
import com.opencsv.bean.CsvToBean;
import com.opencsv.bean.CsvToBeanBuilder;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.Reader;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;

@Service
public class CSVService extends BaseService {

    @Resource
    private ProductDividendScheduleDao productDividendScheduleDao;
    private final SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    private final SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy/MM/dd");

    //Read CSV file
    public List<BankPaymentRecordVo> parseCSVFromS3(String s3Key, String fileNameWithoutExtension) throws Exception {

        String csvFilePath = AwsS3Util.downloadFile(s3Key, fileNameWithoutExtension);
        if (StringUtil.isEmpty(csvFilePath)) {
            throw new GeneralException("Failed to download file from S3. Returned null path.");
        }

        log.info("Local file downloaded at: {}", csvFilePath);

        // 2) Parse the CSV using OpenCSV
        try (Reader reader = new FileReader(csvFilePath)) {
            // Customize the builder as needed (separator, skip lines, etc.)
            CsvToBean<BankPaymentRecordVo> csvToBean = new CsvToBeanBuilder<BankPaymentRecordVo>(reader)
                    .withType(BankPaymentRecordVo.class)
                    .withIgnoreLeadingWhiteSpace(true)
                    .withSkipLines(0) // 0 = Read header row, 1 = Skip header row
                    .build();

            // 3) Convert all parsed lines into a List of PaymentRecord objects
            List<BankPaymentRecordVo> bankPaymentRecords = csvToBean.parse();

            log.info("Successfully parsed {} records from CSV.", bankPaymentRecords.size());
            return bankPaymentRecords;
        }
    }

    public File generateDividendCsv(List<ProductDividendCalculationHistory> productDividendCalculationHistoryList, String fileNameWithoutExt) throws Exception {
        String fileName = StringUtil.isNotEmpty(fileNameWithoutExt) ? fileNameWithoutExt : "dividend-csv-" + System.currentTimeMillis();
        String csvFilePath = getTempDir() + fileName + ".csv";
        FileWriter writer = new FileWriter(csvFilePath);

        CSVUtils.writeLine(writer,
                Arrays.asList(
                        "Reference Number",
                        "Closing Date",
                        "Client name",
                        "Digital ID",
                        "Agreement No",
                        "Fund Amount",
                        "Dividend",
                        "Percentage",
                        "Bank Name",
                        "Bank Account Number",
                        "Bank Account Name"
                ),
                ',',
                '"'
        );
        for (ProductDividendCalculationHistory productDividendCalculationHistory : productDividendCalculationHistoryList) {
            try {
                CSVUtils.writeLine(writer,
                        Arrays.asList(
                                productDividendCalculationHistory.getReferenceNumber(),
                                sdf.format(DateUtil.convertLocalDateToDate(productDividendCalculationHistory.getPeriodEndingDate())),
                                productDividendCalculationHistory.getProductOrder().getClient().getUserDetail().getName(),
                                productDividendCalculationHistory.getProductOrder().getClient().getClientId(),
                                productDividendCalculationHistory.getProductOrder().getAgreementFileName(),
                                String.format("%,.0f", productDividendCalculationHistory.getProductOrder().getPurchasedAmount()),
                                String.format("%,.0f", productDividendCalculationHistory.getDividendAmount()),
                                String.format("%.2f", (productDividendCalculationHistory.getProductOrder().getDividend())),
                                productDividendCalculationHistory.getProductOrder().getBank().getBankName(),
                                productDividendCalculationHistory.getProductOrder().getBank().getAccountNumber(),
                                productDividendCalculationHistory.getProductOrder().getBank().getAccountHolderName()
                        ), ',', '"'
                );
            } catch (Exception ex) {
                log.error("Error in generateDividendCsv", ex);
            }
        }
        writer.flush();
        writer.close();

        return new File(csvFilePath);
    }

    //----------------------CIMB Dividend Bank File CSV-------------------------
    public File generateCIMBDividendBankFileCsv(List<ProductDividendCalculationHistory> productDividendCalculationHistoryList) throws Exception {
        if (productDividendCalculationHistoryList == null || productDividendCalculationHistoryList.isEmpty()) {
            return new File("");
        }
        String csvFilePath = getTempDir() + "cimb-bank-file-csv-" + System.currentTimeMillis() + ".csv";
        FileWriter writer = new FileWriter(csvFilePath);


        CSVUtils.writeLine(writer,
                Arrays.asList("Beneficiary Name",//Length : 40 (Char without '-' or '/')
                        "Beneficiary ID",//Length: 20 (Char without '-' or '/'), optional
                        "BNM Code",//Length: 2 (Num Only)
                        "Account Number",//Length: 16 (Num only)
                        "Payment Amount",//Length: 11(Num only)
                        "Reference Number",//Length : 30 (Char without '-' or '/'), optional
                        "Beneficiary Email Address",//Length: 70 (Char)
                        "Payment Reference Number",//Length: 5 (Char)
                        "Payment Description",//Length: 20 (Char), optional
                        "Payment Detail Number",//Length: 30 (Char)
                        "Payment Detail Date",//Length: 10 (Date Format, DD/MM/YYYY)
                        "Payment Description",//Length: 500 (Char)
                        "Payment Detail Amount"//Length: 11 (Num Only)
                ),
                ',',
                '"'
        );

        for (ProductDividendCalculationHistory productDividendCalculationHistory : productDividendCalculationHistoryList) {
            try {
                String beneficiaryName = productDividendCalculationHistory.getProductOrder().getBank().getAccountHolderName()
                        .replace("-", " ")
                        .replace("/", "");
                if (beneficiaryName.length() > 40) {
                    beneficiaryName = beneficiaryName.substring(0, 40);
                }
                String beneficiaryId = StringUtil.removeAllSpecialCharacters(productDividendCalculationHistory.getProductOrder().getClientIdentityId());
                String bnmCode = CIMBBankUtil.getCIMBBnmCode(productDividendCalculationHistory.getProductOrder().getBank().getBankName());
                String accountNumber = productDividendCalculationHistory.getProductOrder().getBank().getAccountNumber();
                if (accountNumber.length() > 16) {
                    accountNumber = accountNumber.substring(0, 16);
                }
                String paymentAmount = String.format("%.0f", productDividendCalculationHistory.getDividendAmount());
                String referenceNumber = productDividendCalculationHistory.getReferenceNumber();
                String beneficiaryEmailAddress = productDividendCalculationHistory.getProductOrder().getClient().getAppUser().getEmailAddress();
                String paymentDetailNumber = productDividendCalculationHistory.getReferenceNumber();
                String paymentReferenceNumber = paymentDetailNumber.substring(paymentDetailNumber.length() - 5);
                String paymentDetailDate = sdf.format(DateUtil.convertLocalDateToDate(productDividendCalculationHistory.getPeriodEndingDate()));
                String paymentDescription = productDividendCalculationHistory.getProductOrder().getProduct().getName() + " - Dividend";
                String paymentDetailAmount = String.format("%.0f", productDividendCalculationHistory.getDividendAmount());

                CSVUtils.writeLine(writer,
                        Arrays.asList(
                                beneficiaryName,
                                beneficiaryId,//optional
                                bnmCode,
                                accountNumber,
                                paymentAmount,
                                referenceNumber,//optional
                                beneficiaryEmailAddress,
                                paymentReferenceNumber,
                                "",//optional
                                paymentDetailNumber,
                                paymentDetailDate,
                                paymentDescription,
                                paymentDetailAmount
                        ), ',', '"'
                );
            } catch (Exception ex) {
                log.error("Error in generateCIMBDividendBankFileCsv", ex);
            }
        }
        writer.flush();
        writer.close();

        return new File(csvFilePath);
    }

    //----------------------AFFIN Dividend Bank File CSV-------------------------
    public File generateAFFINDividendBankFileCsv(List<ProductDividendCalculationHistory> productDividendCalculationHistoryList) throws Exception {
        if (productDividendCalculationHistoryList == null || productDividendCalculationHistoryList.isEmpty()) {
            return new File("");
        }
        String csvFilePath = getTempDir() + "affin-bank-file-csv-" + System.currentTimeMillis() + ".csv";
        FileWriter writer = new FileWriter(csvFilePath);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("ddMMyyyy");

        // CSV Column Header
        CSVUtils.writeLine(writer, Arrays.asList(
                "Record Type",//Column A
                "01 - Payment Mode\n02 - Payment Advice Amount",//Column B
                "01 - Payment Date\n02 - Advice Detail",//Column C
                "01 - Customer Ref No.\n02 - Email Address 1",//Column D
                "01 - Payment Amount\n02 - Email Address 2",//Column E
                "01 - Debiting Acc. No.\n02 - Email Address 3",//Column F
                "01 - Beneficiary Bank Code\n02 - Email Address 4",//Column G
                "01 - Beneficiary Acc. No\n02 - Email Address 5",//Column H
                "01 - Beneficiary Name\n02 - Email Address 6",//Column I
                "01 - ID Checking Required",//Column J
                "01 - Beneficiary ID Type",//Column K
                "01 - Beneficiary ID No.",//Column L
                "01 - Resident Indicator",//Column M
                "01 - Resident Country",//Column N
                "01 - Joint Name",//Column O
                "01 - ID Checking Required for - Joint Name",//Column P
                "01 - Joint Name - ID Type",//Column Q
                "01 - Joint Name - ID No.",//Column R
                "01 - Recipient Reference",//Column S
                "01 - Credit Description/ Other Payment Details",//Column T
                "01 - Remitter and Beneficiary Relationship",//Column U
                "01 - Purpose of Transfer",//Column V
                "01 - Purpose of Transfer Code",//Column W
                "01 - Others Purpose of Transfer"//Column X
        ), ',', '"');


        Integer sumOfRecords = 0;
        Double sumOfAmounts = 0.0;
        // CSV Column Data
        for (ProductDividendCalculationHistory productDividendCalculationHistory : productDividendCalculationHistoryList) {
            try {
                Integer paymentDayOfMonth = productDividendScheduleDao.findPaymentDayOfMonth(productDividendCalculationHistory.getProductOrder().getProduct().getId(), productDividendCalculationHistory.getProductOrder().getAgreementDate().getDayOfMonth());
                LocalDate paymentDate = productDividendCalculationHistory.getPeriodEndingDate();
                paymentDate = paymentDate.plusMonths(1);
                if (paymentDayOfMonth != 99) {
                    paymentDate = paymentDate.withDayOfMonth(paymentDayOfMonth);
                } else {
                    paymentDate = paymentDate.withDayOfMonth(paymentDate.lengthOfMonth());
                }
                ProductOrderType productOrderType = productDividendCalculationHistory.getProductOrder().getProductOrderType();
                //Row 1
                String recordTypePayment = AffinBankUtil.RecordTypePayment;//A
                String ibgPaymentMode = AffinBankUtil.PaymentMode.IBG.name();//B
                String paymentDateStr = paymentDate.format(formatter);//C
                String customerRefNo = productDividendCalculationHistory.getProductOrder().getProduct().getName() + "_" + productDividendCalculationHistory.getProductOrder().getAgreementFileName().substring(productDividendCalculationHistory.getProductOrder().getAgreementFileName().length() - 4);//D, Format of reference no: Product Name_4 last digit Agreement No ex: ICHT3_0123
                String paymentAmount = String.format("%.2f", productDividendCalculationHistory.getDividendAmount());//E
                String debitingAccountNo = AffinBankUtil.DEBITING_ACCOUNT_NO;//F
                String beneficiaryBankCode = AffinBankUtil.getAFFINBnmCode(productDividendCalculationHistory.getProductOrder().getBank().getBankName());//G
                String beneficiaryAccountNo = productDividendCalculationHistory.getProductOrder().getBank().getAccountNumber();//H
                String beneficiaryName = productDividendCalculationHistory.getProductOrder().getBank().getAccountHolderName();//I
                String idChecking = "Y";//J
                String beneficiaryIdType = AffinBankUtil.getBeneficiaryIdType(productDividendCalculationHistory.getProductOrder().getClientIdentityType());//K
                String beneficiaryIdNo = StringUtil.removeAllSpecialCharacters(productDividendCalculationHistory.getProductOrder().getClientIdentityId());//L
                String residentIndicator = AffinBankUtil.getResidentIndicator(productDividendCalculationHistory.getProductOrder().getClientResidentialStatus());//M
                String residentCountry = residentIndicator.equalsIgnoreCase("N") ? productDividendCalculationHistory.getProductOrder().getClientCountryCode() : "";//N
                String jointName = "";//O, optional
                String idCheckingRequiredForJointName = "";//P, optional
                String jointNameIdType = "";//Q, optional
                String jointNameIdNo = "";//R, optional
                String recipientReference = AffinBankUtil.getRecipientReference(AffinBankUtil.RecipientReferenceType.DIVIDEND,productOrderType, productDividendCalculationHistory.getProductOrder().getDividendCounter());//S
                String creditDescriptionOtherPaymentDetails = "";//T, optional
                String remitterBeneficiaryRelationship = AffinBankUtil.RemitterBeneficiaryRelationship.SAMEPARTY.getValue();//U
                String purposeOfTransfer = "";//V, optional
                String purposeOfTransferCode = "";//W, optional
                String othersPurposeOfTransfer = "";//X, optional
                //Row 2
                String recordTypePaymentAdvice = AffinBankUtil.RecordTypePaymentAdvice;//A 02
                String paymentAdviceAmount = String.format("%.2f", productDividendCalculationHistory.getDividendAmount());//B
                String paymentAdviceDetail = AffinBankUtil.PAYMENT_ADVICE_DETAIL;//C
                String emailAddress1 = productDividendCalculationHistory.getProductOrder().getClientEmail();//D
                String emailAddress2 = "";//E
                String emailAddress3 = "";//F
                String emailAddress4 = "";//G
                String emailAddress5 = "";//H
                String emailAddress6 = "";//I
                String emptyRowJ = "";//J
                String emptyRowK = "";//K
                String emptyRowL = "";//L
                String emptyRowM = "";//M
                String emptyRowN = "";//N
                String emptyRowO = "";//O
                String emptyRowP = "";//P
                String emptyRowQ = "";//Q
                String emptyRowR = "";//R
                String emptyRowS = "";//S
                String emptyRowT = "";//T
                String emptyRowU = "";//U
                String emptyRowV = "";//V
                String emptyRowW = "";//W
                String emptyRowX = "";//X

                //Write Row 1
                CSVUtils.writeLine(writer, Arrays.asList(
                        recordTypePayment,
                        ibgPaymentMode,
                        paymentDateStr,
                        customerRefNo,
                        paymentAmount,
                        debitingAccountNo,
                        beneficiaryBankCode,
                        beneficiaryAccountNo,
                        beneficiaryName,
                        idChecking,
                        beneficiaryIdType,
                        beneficiaryIdNo,
                        residentIndicator,
                        residentCountry,
                        jointName,
                        idCheckingRequiredForJointName,
                        jointNameIdType,
                        jointNameIdNo,
                        recipientReference,
                        creditDescriptionOtherPaymentDetails,
                        remitterBeneficiaryRelationship,
                        purposeOfTransfer,
                        purposeOfTransferCode,
                        othersPurposeOfTransfer
                ), ',', '"');

                //Write Row 2
                CSVUtils.writeLine(writer, Arrays.asList(
                        recordTypePaymentAdvice,
                        paymentAdviceAmount,
                        paymentAdviceDetail,
                        emailAddress1,
                        emailAddress2,
                        emailAddress3,
                        emailAddress4,
                        emailAddress5,
                        emailAddress6,
                        emptyRowJ,
                        emptyRowK,
                        emptyRowL,
                        emptyRowM,
                        emptyRowN,
                        emptyRowO,
                        emptyRowP,
                        emptyRowQ,
                        emptyRowR,
                        emptyRowS,
                        emptyRowT,
                        emptyRowU,
                        emptyRowV,
                        emptyRowW,
                        emptyRowX
                ), ',', '"');

                sumOfRecords++;
                sumOfAmounts += productDividendCalculationHistory.getDividendAmount();
            } catch (Exception ex) {
                log.error("Error in generateAFFINDividendBankFileCsv", ex);
            }
        }

        // CSV Summary Row
        CSVUtils.writeLine(writer, Arrays.asList(
                        AffinBankUtil.RecordTypeSummaryRow,
                        sumOfRecords.toString(),
                        String.format("%.2f", sumOfAmounts),
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        ""
                ), ',', '"');
        writer.flush();
        writer.close();

        return new File(csvFilePath);
    }
}
