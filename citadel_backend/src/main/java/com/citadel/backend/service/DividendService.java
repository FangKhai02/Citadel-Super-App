package com.citadel.backend.service;

import com.citadel.backend.dao.Products.ProductDividendCalculationHistoryDao;
import com.citadel.backend.dao.Products.ProductDividendScheduleDao;
import com.citadel.backend.dao.Products.ProductDividendHistoryDao;
import com.citadel.backend.dao.Products.ProductDividendHistoryPivotDao;
import com.citadel.backend.dao.Products.ProductOrderDao;
import com.citadel.backend.entity.Products.*;
import com.citadel.backend.utils.*;
import com.citadel.backend.utils.Builder.RandomCodeBuilder;
import com.citadel.backend.utils.Builder.UploadBase64FileBuilder;
import com.citadel.backend.vo.*;
import com.citadel.backend.vo.Enum.CmsAdmin;
import com.citadel.backend.vo.Enum.ProductOrderType;
import com.citadel.backend.vo.Enum.Status;
import com.citadel.backend.vo.SendGrid.Attachment;
import com.citadel.backend.vo.Transaction.TransactionVo;
import jakarta.annotation.Resource;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.beans.Transient;
import java.io.File;
import java.nio.file.Files;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.*;

@Service
public class DividendService extends BaseService {
    @Resource
    private ProductOrderDao productOrderDao;
    @Resource
    private ProductDividendCalculationHistoryDao productDividendCalculationHistoryDao;
    @Resource
    private ProductDividendScheduleDao productDividendScheduleDao;
    @Resource
    private PdfService pdfService;
    @Resource
    private ProductDividendHistoryDao productDividendHistoryDao;
    @Resource
    private ProductDividendHistoryPivotDao productDividendHistoryPivotDao;
    @Resource
    private EmailService emailService;
    @Resource
    private ExcelService excelService;
    @Resource
    private ProductService productService;

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy/MM/dd");

    //Common sub-functions
    private static double calculateProratedFactorByDays(Boolean isProrated, LocalDate agreementDate, LocalDate periodStartingDate, LocalDate periodEndingDate, LocalDate endTenure) {
        /* Formula */
        /* Not prorated = proratedFactor = 1 */
        /* If prorated, proratedFactor = holdingDays / daysInPeriod */
        /* effectiveStartDate = max(periodStartingDate,agreementDate) */
        /* holdingDays = max(0,periodEndingDate-effectiveStartDate) */
        /* daysInPeriod = periodEndingDate-periodStartingDate */
        double proratedFactor = 1.0; // Default for non-prorated calculations
        if (isProrated) {
            LocalDate effectiveStartDate = agreementDate.isAfter(periodStartingDate) ? agreementDate : periodStartingDate;
            //periodEndingDate−max(periodStartingDate,agreementDate)
            //long holdingDays = ChronoUnit.DAYS.between(effectiveStartDate, periodEndingDate.plusDays(1));
            //holdingDays = Math.max(holdingDays, 0);
            long holdingDays;
            if (endTenure != null) {
                holdingDays = Math.max(0, ChronoUnit.DAYS.between(effectiveStartDate, endTenure.plusDays(1)));
            } else {
                holdingDays = Math.max(0, ChronoUnit.DAYS.between(effectiveStartDate, periodEndingDate.plusDays(1)));
            }
            long daysInPeriod = ChronoUnit.DAYS.between(periodStartingDate, periodEndingDate.plusDays(1));
            proratedFactor = (double) holdingDays / (double) daysInPeriod;
        }
        return proratedFactor;
    }

    public static double calculateProratedFactorByMonths(Boolean isProrated, LocalDate agreementDate, LocalDate periodStartingDate, LocalDate periodEndingDate, LocalDate endTenure) {

        double proratedFactor = 1.0; // Default for non-prorated calculations

        if (isProrated) {
            // Effective start date is the later of the period start or the agreement date
            LocalDate effectiveStartDate = agreementDate.isAfter(periodStartingDate) ? agreementDate : periodStartingDate;

            // Calculate holding months using endTenure if provided, otherwise use periodEndingDate
            long holdingMonths;
            if (endTenure != null) {
                holdingMonths = Math.max(0, ChronoUnit.MONTHS.between(effectiveStartDate, endTenure.plusDays(1)));
            } else {
                holdingMonths = Math.max(0, ChronoUnit.MONTHS.between(effectiveStartDate, periodEndingDate.plusDays(1)));
            }

            // Total months in the period (quarterly period: e.g., Jan 1 to Mar 31, adjusted by +1 day gives 3 months)
            long monthsInPeriod = ChronoUnit.MONTHS.between(periodStartingDate, periodEndingDate.plusDays(1));

            proratedFactor = (double) holdingMonths / (double) monthsInPeriod;
        }

        return proratedFactor;
    }

    public static LocalDate calculateFixedPeriodStartingDate(LocalDate today, int payoutFrequency) {
        int periodNumber = getPeriodNumber(today, payoutFrequency);
        /* Calculate the starting date of the period based on periodNumber and payoutFrequency */
        // Calculate the number of months in each period
        int monthsPerPeriod = 12 / payoutFrequency;

        // Calculate the start month of the period
        int startMonth = ((periodNumber - 1) * monthsPerPeriod) + 1;

        // Return the start of the period
        return today.withMonth(startMonth).withDayOfMonth(1);
    }

    public static LocalDate calculateFixedPeriodEndingDate(LocalDate startOfPeriod, int payoutFrequency) {
        // Calculate the number of months in each period
        int monthsPerPeriod = 12 / payoutFrequency;

        // Add the months and subtract one day to get the last day of the period
        return startOfPeriod.plusMonths(monthsPerPeriod).minusDays(1);
    }

    public static int getPayoutFrequency(ProductDividendSchedule.FrequencyOfPayout payoutFrequency) {
        return switch (payoutFrequency) {
            case ANNUALLY -> 1;
            case QUARTERLY -> 4;
            case MONTHLY -> 12;
        };
    }

    private static int getPeriodNumber(LocalDate today, int payoutFrequency) {
        /* Calculate the period number based on the current date and the payout frequency */
        /* If payoutFrequency = 12, monthly payment, returns value 1-12 (the current month) */
        /* If payoutFrequency = 4, quarterly payment, returns value 1-4 (the current quarter) */
        /* If payoutFrequency = 1, annual payment, returns value 1 */

        // Calculate the number of months per period
        int monthsPerPeriod = 12 / payoutFrequency;

        // Calculate the period number
        return (today.getMonthValue() - 1) / monthsPerPeriod + 1;
    }

    public void saveProductDividendCalculationHistory(ProductOrder productOrder, Double dividendPayoutAmount, Double trusteeFeeAmount, List<ProductDividendCalculationHistory> dividendHistoryList) throws Exception {

        final int dividendCounter = productOrder.getDividendCounter() + 1;
        ProductDividendCalculationHistory history = new ProductDividendCalculationHistory();
        String referenceNumber = RandomCodeUtil.generateRandomCode(new RandomCodeBuilder()
                .prefix("DIV" + System.currentTimeMillis())
                .postfix(RandomCodeBuilder.NUMBERS)
                .postfixLength(3));
        history.setReferenceNumber(referenceNumber);
        history.setProductOrder(productOrder);
        history.setDividendAmount(dividendPayoutAmount);
        history.setTrusteeFeeAmount(trusteeFeeAmount);
        history.setPeriodStartingDate(productOrder.getPeriodStartingDate());
        history.setPeriodEndingDate(productOrder.getPeriodEndingDate());
        history.setClosingDate(productOrder.getPeriodEndingDate());
        if (ProductDividendSchedule.StructureType.FLEXIBLE.equals(productOrder.getStructureType())) {
            LocalDate periodEndingDate = productOrder.getPeriodEndingDate();
            if (periodEndingDate.getDayOfMonth() > 17) {
                // If period ending date is after the 17th, set closing date as the end of the month
                history.setClosingDate(periodEndingDate.withDayOfMonth(periodEndingDate.lengthOfMonth()));
            }
        }
        history.setPaymentStatus(Status.PENDING);
        history.setCreatedAt(new Date());
        history.setUpdatedAt(new Date());
        history.setDividendQuarter(dividendCounter);
        history = productDividendCalculationHistoryDao.save(history);

        productOrder.setDividendCounter(dividendCounter);
        productOrderDao.save(productOrder);

        dividendHistoryList.add(history);
    }

    public static double[] calculateDividendAmount(ProductOrder productOrder, Boolean isFinalDividend) {
        /* Formula : Dividend = fundAmount x periodicRate x proratedFactor */
        final double fundAmount = productOrder.getPurchasedAmount();
        final double annualRate = productOrder.getDividend();
        final boolean isProrated = productOrder.getIsProrated();
        final LocalDate agreementDate = productOrder.getAgreementDate();
        final LocalDate maturityDate = productOrder.getEndTenure();

        // Calculate the start and end dates for the current period
        int payoutFrequency = getPayoutFrequency(productOrder.getPayoutFrequency());
        LocalDate periodStartingDate = productOrder.getPeriodStartingDate();
        LocalDate periodEndingDate = productOrder.getPeriodEndingDate();

        //Fail safe is periodStartingDate and periodEndingDate are null
        if (periodStartingDate == null || periodEndingDate == null) {
            periodStartingDate = calculateFixedPeriodStartingDate(agreementDate, payoutFrequency);
            periodEndingDate = calculateFixedPeriodEndingDate(periodStartingDate, payoutFrequency);
        }

        // Calculate prorated factor
        double proratedFactor;
        if (isFinalDividend) {
            proratedFactor = calculateProratedFactorByMonths(isProrated, agreementDate, periodStartingDate, periodEndingDate, productOrder.getEndTenure());
        } else {
            // Validate against maturity date
            if (periodEndingDate.isAfter(maturityDate)) {
                return new double[]{0.0, 0.0};
            }
            proratedFactor = calculateProratedFactorByMonths(isProrated, agreementDate, periodStartingDate, periodEndingDate, null);
        }

        //periodicRate = dividend rate per period
        double periodicRate = annualRate / payoutFrequency;

        // Calculate the dividend
        double dividendPayoutAmount = fundAmount * (periodicRate / 100.00) * proratedFactor;
        dividendPayoutAmount = MathUtil.roundHalfUp(dividendPayoutAmount);

        // Calculate trustee fee
        double trusteeFeeAmount = 0.0;
        //First trustee fee
        if (productOrder.getDividendCounter() == 0 && ((productOrder.getProduct().getTrusteeFeeFirstDividend() != null && productOrder.getProduct().getTrusteeFeeFirstDividend() > 0))) {
            double trusteeFeePercentage = productOrder.getProduct().getTrusteeFeeFirstDividend() / 100.00;
            trusteeFeeAmount = MathUtil.roundHalfUp((productOrder.getPurchasedAmount() * trusteeFeePercentage));
        }
        //Last trustee fee
        if (productOrder.getProduct().getTrusteeFeeLastDividend() != null && productOrder.getProduct().getTrusteeFeeLastDividend() > 0) {
            double trusteeFeePercentage = productOrder.getProduct().getTrusteeFeeLastDividend() / 100.00;
            if (ProductDividendSchedule.StructureType.FIXED.equals(productOrder.getStructureType())) {
                if (periodEndingDate.isAfter(maturityDate) || periodEndingDate.isEqual(maturityDate)) {
                    trusteeFeeAmount = MathUtil.roundHalfUp((productOrder.getPurchasedAmount() * trusteeFeePercentage));
                }
            } else {
                // Determine if counter is last
                int lastCounter = productOrder.getInvestmentTenureMonth() / (12 / payoutFrequency);
                if (lastCounter == (productOrder.getDividendCounter() + 1)) {
                    trusteeFeeAmount = MathUtil.roundHalfUp((productOrder.getPurchasedAmount() * trusteeFeePercentage));
                }
            }
        }
        dividendPayoutAmount = MathUtil.roundHalfUp(dividendPayoutAmount - trusteeFeeAmount);
        return new double[]{dividendPayoutAmount, trusteeFeeAmount};
    }

    public void processProductOrderMaturity(ProductOrder productOrder) {
        productOrder.setStatus(ProductOrder.ProductOrderStatus.MATURED);
        // Generate statement of account
        productService.generateStatementOfAccount(productOrder);
        // Activate redeem/rollover/reallocation request
        productService.activateRolloverReallocation(productOrder);
    }

    //----------------------------------Fixed Dividend Calculation Start----------------------------------
    public Object processFixedDividendCalculation(LocalDate today, ProductDividendSchedule.FrequencyOfPayout frequencyOfPayout) {
        try {
            //TODO migrate param LocalDate today internally
            List<ProductOrder> productOrderList = productOrderDao.findAllProductOrdersForDividendCalculation(ProductOrder.ProductOrderStatus.ACTIVE, frequencyOfPayout, ProductDividendSchedule.StructureType.FIXED, today);
            if (productOrderList.isEmpty()) {
                return new BaseResp();
            }
            //TODO JSONARRAY is for testing only, need to remove
            JSONArray jsonArray = new JSONArray();
            List<ProductDividendCalculationHistory> dividendHistoryList = new ArrayList<>();
            //Process each product order
            for (ProductOrder productOrder : productOrderList) {
                JSONObject jsonObject = processFixedDividendCalculationByProductOrder(today, productOrder, dividendHistoryList);
                jsonArray.put(jsonObject);
            }

            int payoutOfFrequency = getPayoutFrequency(frequencyOfPayout);
            LocalDate periodStartingDate = calculateFixedPeriodStartingDate(today.minusDays(1), payoutOfFrequency);
            LocalDate periodEndingDate = calculateFixedPeriodEndingDate(periodStartingDate, payoutOfFrequency);
            String fileNameWithoutExt = frequencyOfPayout.name().toLowerCase() + "_fixed_dividend_" + periodStartingDate + "_" + periodEndingDate;

            generateDividendExcel(dividendHistoryList, fileNameWithoutExt);

            BaseResp resp = new BaseResp();
            resp.setMessage(jsonArray.toString().replace("\\", ""));
            return resp;
        } catch (Exception ex) {
            log.error("Error in processFixedDividendCalculation", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public JSONObject processFixedDividendCalculationByProductOrder(LocalDate today, ProductOrder productOrder, List<ProductDividendCalculationHistory> dividendHistoryList) {
        JSONObject jsonObject = new JSONObject();
        String key = "dividend_" + productOrder.getOrderReferenceNumber();
        if (!RedisUtil.exists(key)) {
            RedisUtil.set(key, "1", ONE_DAY);
            try {
                jsonObject.put("case", productOrder.getOrderReferenceNumber());
                //Calculate Dividend Amount
                double[] calculateDividendAmountResult = calculateDividendAmount(productOrder, false);
                double dividendPayoutAmount = calculateDividendAmountResult[0];
                //Save Dividend Calculation History
                saveProductDividendCalculationHistory(productOrder, dividendPayoutAmount, calculateDividendAmountResult[1], dividendHistoryList);
                //Update Calculation Date
                productOrder.setLastDividendCalculationDate(DateUtil.convertLocalDateToDate(today));

                int payoutFrequency = getPayoutFrequency(productOrder.getPayoutFrequency());
                LocalDate newPeriodStartingDate = productOrder.getPeriodEndingDate().plusDays(1);
                LocalDate newPeriodEndingDate = calculateFixedPeriodEndingDate(newPeriodStartingDate, payoutFrequency);

                // Validate against maturity date
                if (newPeriodStartingDate.isAfter(productOrder.getEndTenure()) || productOrder.getEndTenure().isEqual(productOrder.getPeriodEndingDate())) {
                    processProductOrderMaturity(productOrder);
                } else {
                    //Set new Period Start and end Days
                    productOrder.setPeriodStartingDate(newPeriodStartingDate);
                    productOrder.setPeriodEndingDate(newPeriodEndingDate);
                }
                productOrder.setUpdatedAt(new Date());
                productOrderDao.save(productOrder);
                jsonObject.put("dividendPayoutAmount", dividendPayoutAmount);
                System.out.println("Dividend payout amount for product : " + productOrder.getOrderReferenceNumber() + " is " + dividendPayoutAmount);
            } catch (Exception ex) {
                log.error("Error in processFixedDividendCalculation for : {}", productOrder.getOrderReferenceNumber(), ex);
            } finally {
                RedisUtil.del(key);
            }
        }
        return jsonObject;
    }

    public Object processFinalFixedDividendCalculation(LocalDate today) {
        try {
            List<ProductOrder> productOrderList = productOrderDao.findAllProductOrdersForMaturityCalculation(ProductOrder.ProductOrderStatus.ACTIVE, today);
            if (productOrderList.isEmpty()) {
                return new BaseResp();
            }
            //TODO JSONARRAY is for testing only, need to remove
            JSONArray jsonArray = new JSONArray();
            List<ProductDividendCalculationHistory> dividendHistoryList = new ArrayList<>();
            for (ProductOrder productOrder : productOrderList) {
                JSONObject jsonObject = processFinalFixedDividendCalculationByProductOrder(today, productOrder, dividendHistoryList);
                jsonArray.put(jsonObject);
            }

            String fileNameWithoutExt = "maturity" + "_fixed_dividend_" + today.minusDays(1);
            generateDividendExcel(dividendHistoryList, fileNameWithoutExt);

            BaseResp resp = new BaseResp();
            resp.setMessage(jsonArray.toString().replace("\\", ""));
            return resp;
        } catch (Exception ex) {
            log.error("Error in processMaturityDividendCalculation", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public JSONObject processFinalFixedDividendCalculationByProductOrder(LocalDate today, ProductOrder productOrder, List<ProductDividendCalculationHistory> dividendHistoryList) {
        JSONObject jsonObject = new JSONObject();
        String key = "maturity_dividend_" + productOrder.getOrderReferenceNumber();
        if (!RedisUtil.exists(key)) {
            RedisUtil.set(key, "1");
            try {
                jsonObject.put("case", productOrder.getOrderReferenceNumber());
                //Calculate Dividend Amount
                double[] calculateDividendAmountResult = calculateDividendAmount(productOrder, true);
                double dividendPayoutAmount = calculateDividendAmountResult[0];
                //Save Dividend Calculation History
                saveProductDividendCalculationHistory(productOrder, dividendPayoutAmount, calculateDividendAmountResult[1], dividendHistoryList);
                //Update Calculation Date
                productOrder.setLastDividendCalculationDate(DateUtil.convertLocalDateToDate(today));

                processProductOrderMaturity(productOrder);
                jsonObject.put("dividendPayoutAmount", dividendPayoutAmount);
                System.out.println("Dividend payout amount for product : " + productOrder.getOrderReferenceNumber() + " is " + dividendPayoutAmount);
            } catch (Exception ex) {
                log.error("Error in processMaturityDividendCalculation for : {}", productOrder.getOrderReferenceNumber(), ex);
            } finally {
                RedisUtil.del(key);
            }
        }
        return jsonObject;
    }

    //----------------------------------Fixed Dividend Calculation End----------------------------------

    //----------------------------------Flexible Dividend Calculation Start----------------------------------
    public static LocalDate calculateFlexiblePeriodStartingDate(LocalDate today, int payoutFrequency) {
        int monthsToDeduct = 12 / payoutFrequency;
        return today.minusMonths(monthsToDeduct).plusDays(1);
    }

    public static LocalDate calculateFlexiblePeriodEndingDate(LocalDate periodStartingDate, int payoutFrequency) {
        int monthsToAdd = 12 / payoutFrequency;
        return periodStartingDate.plusMonths(monthsToAdd).minusDays(1);
    }

    public Object processFlexibleDividendCalculation(LocalDate today, ProductDividendSchedule.FrequencyOfPayout frequencyOfPayout) {
        try {
            today = today.plusDays(10);
            List<ProductOrder> productOrderList = productOrderDao.findAllProductOrdersForDividendCalculation(ProductOrder.ProductOrderStatus.ACTIVE, frequencyOfPayout, ProductDividendSchedule.StructureType.FLEXIBLE, today);
            if (productOrderList.isEmpty()) {
                return new BaseResp();
            }
            //TODO JSONARRAY is for testing only, need to remove
            JSONArray jsonArray = new JSONArray();
            List<ProductDividendCalculationHistory> dividendHistoryList = new ArrayList<>();
            for (ProductOrder productOrder : productOrderList) {
                JSONObject jsonObject = processFlexibleDividendCalculationByProductOrder(today, productOrder, dividendHistoryList);
                jsonArray.put(jsonObject);
            }

            int payoutFrequency = getPayoutFrequency(frequencyOfPayout);
            LocalDate periodStartingDate = calculateFlexiblePeriodStartingDate(today.minusDays(1), payoutFrequency);
            LocalDate periodEndingDate = calculateFlexiblePeriodEndingDate(periodStartingDate, payoutFrequency);
            String fileNameWithoutExt = frequencyOfPayout.name().toLowerCase() + "_flexible_dividend_" + periodStartingDate + "_" + periodEndingDate;
            generateDividendExcel(dividendHistoryList, fileNameWithoutExt);

            BaseResp resp = new BaseResp();
            resp.setMessage(jsonArray.toString().replace("\\", ""));
            return resp;
        } catch (Exception ex) {
            log.error("Error in processFlexibleDividendCalculation", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public JSONObject processFlexibleDividendCalculationByProductOrder(LocalDate today, ProductOrder productOrder, List<ProductDividendCalculationHistory> dividendHistoryList) {
        JSONObject jsonObject = new JSONObject();
        String key = "dividend_" + productOrder.getOrderReferenceNumber();
        if (!RedisUtil.exists(key)) {
            RedisUtil.set(key, "1", ONE_DAY);
            try {
                jsonObject.put("case", productOrder.getOrderReferenceNumber());
                //Calculate Dividend Amount
                double[] calculateDividendAmountResult = calculateDividendAmount(productOrder, false);
                double dividendPayoutAmount = calculateDividendAmountResult[0];

                //Save Dividend Calculation History
                saveProductDividendCalculationHistory(productOrder, dividendPayoutAmount, calculateDividendAmountResult[1], dividendHistoryList);
                //Update Product Order
                //TODO just for testing using LocalDate today, need to change to new Date()
                productOrder.setLastDividendCalculationDate(DateUtil.convertLocalDateToDate(today.minusDays(10)));
                //Set new Period Start and end Days
                int payoutFrequency = getPayoutFrequency(productOrder.getPayoutFrequency());
                productOrder.setPeriodStartingDate(productOrder.getPeriodEndingDate().plusDays(1));
                productOrder.setPeriodEndingDate(calculateFlexiblePeriodEndingDate(productOrder.getPeriodStartingDate(), payoutFrequency));
                productOrder.setUpdatedAt(new Date());
                productOrder = productOrderDao.save(productOrder);
                //Set status to matured if period ending date is after end tenure
                if (productOrder.getPeriodEndingDate().isAfter(productOrder.getEndTenure())) {
                    processProductOrderMaturity(productOrder);
                }
                jsonObject.put("dividendPayoutAmount", dividendPayoutAmount);
                System.out.println("Dividend payout amount for product : " + productOrder.getOrderReferenceNumber() + " is " + dividendPayoutAmount);
            } catch (Exception ex) {
                log.error("Error in processFixedDividendCalculation for : {}", productOrder.getOrderReferenceNumber(), ex);
            } finally {
                RedisUtil.del(key);
            }
        }
        return jsonObject;
    }

    //----------------------------------Flexible Dividend Calculation End----------------------------------

    //----------------------------------Get Paid Dividend History----------------------------------
    public List<TransactionVo> getDividendTransactionList(List<Long> productOrderIdList) {
        if (productOrderIdList == null || productOrderIdList.isEmpty()) {
            return new ArrayList<>();
        }
        List<ProductDividendCalculationHistory> dividendHistoryList = productDividendCalculationHistoryDao.findAllByProductOrderIdInAndPaymentStatus(productOrderIdList, Status.SUCCESS);

        return dividendHistoryList.stream()
                .map(TransactionVo::dividendTransactionVo)
                .sorted(Comparator.comparing(TransactionVo::getHistoryId).reversed())
                .toList();
    }

    //----------------------------------Excel Generation Start----------------------------------
    public void generateDividendExcel(List<ProductDividendCalculationHistory> productDividendCalculationHistoryList, String fileNameWithoutExt) throws Exception {
        File dividendExcelFile = excelService.generateDividendExcel(productDividendCalculationHistoryList, fileNameWithoutExt);

        String s3filePath = S3_DIVIDEND_EXCEL_DOCUMENT_PATH + sdf2.format(new Date()) + "/" + dividendExcelFile.getName();
        AwsS3Util.uploadFile(dividendExcelFile, s3filePath, false);

        ProductDividendHistory productDividendHistory = new ProductDividendHistory();
        productDividendHistory.setCsvFileName(dividendExcelFile.getName());
        productDividendHistory.setDividendCsvKey(s3filePath);
        productDividendHistory.setCreatedAt(new Date());
        productDividendHistory.setStatusChecker(CmsAdmin.CheckerStatus.PENDING_CHECKER);
        productDividendHistory.setStatusApprover(CmsAdmin.ApproverStatus.PENDING_APPROVER);
        productDividendHistory.setGeneratedBankFile(Boolean.FALSE);
        productDividendHistoryDao.save(productDividendHistory);

        productDividendCalculationHistoryList.forEach(productDividendCalculationHistory -> {
            ProductDividendHistoryPivot pivot = new ProductDividendHistoryPivot();
            pivot.setProductDividendHistory(productDividendHistory);
            pivot.setProductDividendCalculationHistory(productDividendCalculationHistory);
            pivot.setCreatedAt(new Date());
            productDividendHistoryPivotDao.save(pivot);
        });
    }

    public LocalDate getDividendPaymentDate(Long productId, LocalDate agreementDate, LocalDate periodEndingDate) {
        Integer paymentDayOfMonth = productDividendScheduleDao.findPaymentDayOfMonth(productId, agreementDate.getDayOfMonth());
        if (paymentDayOfMonth == null) {
            paymentDayOfMonth = 15;
        }

        LocalDate paymentDate = periodEndingDate;
        paymentDate = paymentDate.plusMonths(1);
        if (paymentDayOfMonth != 99) {
            paymentDate = paymentDate.withDayOfMonth(paymentDayOfMonth);
        } else {
            paymentDate = paymentDate.withDayOfMonth(paymentDate.lengthOfMonth());
        }
        return paymentDate;
    }

    public void generateDividendPayoutBankFile(Long id) {
        if (id == null) {
            log.error("Error in generateDividendPayoutBankFile : id is null");
            return;
        }
        String redisKey = "dividend_bank_file_" + id;
        if (RedisUtil.exists(redisKey)) {
            return;
        }
        RedisUtil.set(redisKey, "1", ONE_DAY);
        try {
            ProductDividendHistory productDividendHistory = productDividendHistoryDao.findProductDividendHistoryByIdAndStatusCheckerAndStatusApproverAndGeneratedBankFileIsFalse(id, CmsAdmin.CheckerStatus.APPROVE_CHECKER, CmsAdmin.ApproverStatus.APPROVE_APPROVER);
            if (productDividendHistory == null) {
                return;
            }

            String s3filePath = S3_DIVIDEND_BANK_FILE_DOCUMENT_PATH + sdf2.format(new Date()) + "/";
            List<Attachment> attachments = new ArrayList<>();

            List<ProductDividendCalculationHistory> cimbBankDividendCalculationHistoryList = productDividendHistoryPivotDao.getProductDividendCalculationHistoriesByProductDividendHistoryAndBankName(productDividendHistory, Product.BankFile.CIMB.name());
            if (cimbBankDividendCalculationHistoryList != null && !cimbBankDividendCalculationHistoryList.isEmpty()) {
                try {
                    log.info("****************** Generate CIMB Bank Dividend File for id : {} Start ******************", id);
                    List<CimbBankVo> cimbBankVoList = new ArrayList<>();
                    for (ProductDividendCalculationHistory history : cimbBankDividendCalculationHistoryList) {
                        String beneficiaryName = CIMBBankUtil.sanitizeBeneficiaryName(history.getProductOrder().getBank().getAccountHolderName());
                        String beneficiaryId = StringUtil.removeAllSpecialCharacters(history.getProductOrder().getClientIdentityId());
                        String bnmCode = CIMBBankUtil.getCIMBBnmCode(history.getProductOrder().getBank().getBankName());
                        String accountNumber = CIMBBankUtil.sanitizeAccountNumber(history.getProductOrder().getBank().getAccountNumber());
                        String productCode = history.getProductOrder().getProduct().getCode();
                        String agreementRunningNumber = history.getProductOrder().getAgreementFileName().substring(history.getProductOrder().getAgreementFileName().length() - 4);
                        String referenceNumber = productCode + " " + agreementRunningNumber;
                        String beneficiaryEmailAddress = history.getProductOrder().getClientEmail();
                        String paymentDetailNumber = history.getReferenceNumber();
                        String paymentReferenceNumber = paymentDetailNumber.substring(paymentDetailNumber.length() - 5);
                        LocalDate paymentDate = getDividendPaymentDate(history.getProductOrder().getProduct().getId(), history.getProductOrder().getAgreementDate(), history.getPeriodEndingDate());
                        String paymentDetailDate = sdf.format(DateUtil.convertLocalDateToDate(paymentDate));
                        String paymentDescription = history.getProductOrder().getProduct().getName() + " - Dividend";
                        ProductOrderType productOrderType = history.getProductOrder().getProductOrderType();

                        CimbBankVo cimbBankVo = new CimbBankVo();
                        cimbBankVo.setColABeneficiaryName(beneficiaryName);
                        cimbBankVo.setColBBeneficiaryId(beneficiaryId);
                        cimbBankVo.setColCBnmCode(bnmCode);
                        cimbBankVo.setColDAccountNumber(accountNumber);
                        cimbBankVo.setColEPaymentAmount(history.getDividendAmount());
                        cimbBankVo.setColFReferenceNumber(referenceNumber);
                        cimbBankVo.setColGBeneficiaryEmailAddress(beneficiaryEmailAddress);
                        cimbBankVo.setColHPaymentReferenceNumber(referenceNumber);
                        cimbBankVo.setColIPaymentDescription(paymentDescription);
                        cimbBankVo.setColJPaymentDetailNumber(referenceNumber);
                        cimbBankVo.setColKPaymentDetailDate(paymentDetailDate);
                        cimbBankVo.setColLPaymentDescription(CIMBBankUtil.getRecipientReference(CIMBBankUtil.RecipientReferenceType.DIVIDEND, productOrderType, history.getPeriodStartingDate(), history.getPeriodEndingDate()));
                        cimbBankVo.setColMPaymentDetailAmount(history.getDividendAmount());
                        cimbBankVoList.add(cimbBankVo);
                    }
                    //Generate Excel File
                    File cimbBankFileExcel = excelService.generateCIMBBankFileExcel(cimbBankVoList, CimbBankVo.TYPE.DIVIDEND);
                    //Upload to S3
                    s3filePath += cimbBankFileExcel.getName();
                    AwsS3Util.uploadFile(cimbBankFileExcel, s3filePath, false);
                    log.info("Dividend CIMB Bank File Path : {}", s3filePath);
                    //Update ProductDividendHistory
                    productDividendHistory.setGeneratedBankFile(Boolean.TRUE);
                    productDividendHistory.setUpdatedAt(new Date());
                    productDividendHistoryDao.save(productDividendHistory);
                    //Attach Excel to email
                    byte[] attachmentContentBytes = Files.readAllBytes(cimbBankFileExcel.toPath());
                    String attachmentContent = Base64.getEncoder().encodeToString(attachmentContentBytes);
                    attachments.add(new Attachment(attachmentContent, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", cimbBankFileExcel.getName()));
                    log.info("****************** Generate CIMB Bank Dividend File for id : {} End ******************", id);
                } catch (Exception ex) {
                    log.error("Error in generateDividendPayoutBankFile for CIMB Bank", ex);
                }
            }

            List<ProductDividendCalculationHistory> affinBankDividendCalculationHistoryList = productDividendHistoryPivotDao.getProductDividendCalculationHistoriesByProductDividendHistoryAndBankName(productDividendHistory, Product.BankFile.AFFIN.name());
            if (affinBankDividendCalculationHistoryList != null && !affinBankDividendCalculationHistoryList.isEmpty()) {
                try {
                    log.info("****************** Generate AFFIN Bank File Dividend for id : {} Start ******************", id);
                    //Generate Excel File
                    List<AffinBankVo> affinBankVoList = new ArrayList<>();
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("ddMMyyyy");
                    for (ProductDividendCalculationHistory history : affinBankDividendCalculationHistoryList) {
                        Integer paymentDayOfMonth = productDividendScheduleDao.findPaymentDayOfMonth(history.getProductOrder().getProduct().getId(), history.getProductOrder().getAgreementDate().getDayOfMonth());
                        if (paymentDayOfMonth == null) {
                            paymentDayOfMonth = 15;
                        }

                        LocalDate paymentDate = history.getPeriodEndingDate();
                        paymentDate = paymentDate.plusMonths(1);
                        if (paymentDayOfMonth != 99) {
                            paymentDate = paymentDate.withDayOfMonth(paymentDayOfMonth);
                        } else {
                            paymentDate = paymentDate.withDayOfMonth(paymentDate.lengthOfMonth());
                        }
                        ProductOrderType productOrderType = history.getProductOrder().getProductOrderType();

                        AffinBankVo record = new AffinBankVo();
                        //Row 1
                        record.setColCRowOnePaymentDate(paymentDate.format(formatter));
                        String productCode = history.getProductOrder().getProduct().getCode();
                        String agreementRunningNumber = history.getProductOrder().getAgreementFileName().substring(history.getProductOrder().getAgreementFileName().length() - 4);
                        record.setColDRowOneCustomerRefNo(productCode + " " + agreementRunningNumber);
                        record.setColERowOnePaymentAmount(history.getDividendAmount());
                        record.setColGRowOneBeneficiaryBankCode(AffinBankUtil.getAFFINBnmCode(history.getProductOrder().getBank().getBankName()));
                        record.setColBRowOnePaymentMode(StringUtil.isEmpty(record.getColGRowOneBeneficiaryBankCode()) ? AffinBankUtil.PaymentMode.AFF.name() : AffinBankUtil.PaymentMode.IBG.name());
                        record.setColHRowOneBeneficiaryAccNo(history.getProductOrder().getBank().getAccountNumber());
                        record.setColIRowOneBeneficiaryName(history.getProductOrder().getBank().getAccountHolderName());
                        record.setColJRowOneIDCheckingRequired("Y");
                        record.setColKRowOneBeneficiaryIdType(AffinBankUtil.getBeneficiaryIdType(history.getProductOrder().getClientIdentityType()));
                        record.setColLRowOneBeneficiaryIdNo(StringUtil.removeAllSpecialCharacters(history.getProductOrder().getClientIdentityId()));
                        String residentIndicator = AffinBankUtil.getResidentIndicator(history.getProductOrder().getClientResidentialStatus());
                        record.setColMRowOneResidentIndicator(residentIndicator);
                        record.setColNRowOneResidentCountry(residentIndicator.equalsIgnoreCase("N") ? history.getProductOrder().getClientCountryCode() : "");
                        record.setColSRowOneRecipientReference(AffinBankUtil.getRecipientReference(AffinBankUtil.RecipientReferenceType.DIVIDEND, productOrderType, history.getDividendQuarter()));
                        //Row 2
                        record.setColBRowTwoPaymentAdviceAmount(String.format("%.2f", history.getDividendAmount()));
                        record.setColCRowTwoPaymentAdviceDetail(AffinBankUtil.getRecipientReference(AffinBankUtil.RecipientReferenceType.DIVIDEND, productOrderType, history.getDividendQuarter()));
                        record.setColDRowTwoEmailAddress1(history.getProductOrder().getClientEmail());
                        affinBankVoList.add(record);
                    }
                    File affinBankFileExcel = excelService.generateAFFINBankFileExcel(affinBankVoList);
                    //Upload to S3
                    s3filePath += affinBankFileExcel.getName();
                    AwsS3Util.uploadFile(affinBankFileExcel, s3filePath, false);
                    log.info("Affin Bank File Path : {}", s3filePath);
                    //Attach Excel to email
                    byte[] attachmentContentBytes = Files.readAllBytes(affinBankFileExcel.toPath());
                    String attachmentContent = Base64.getEncoder().encodeToString(attachmentContentBytes);
                    attachments.add(new Attachment(attachmentContent, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", affinBankFileExcel.getName()));
                    //Update ProductDividendHistory
                    productDividendHistory.setGeneratedBankFile(Boolean.TRUE);
                    productDividendHistory.setUpdatedAt(new Date());
                    productDividendHistoryDao.save(productDividendHistory);
                    log.info("****************** Generate AFFIN Bank File Dividend for id : {} End ******************", id);
                } catch (Exception ex) {
                    log.error("Error in generateDividendPayoutBankFile for Affin Bank", ex);
                }
            }

            if (attachments.isEmpty()) {
                return;
            }
            emailService.sendDividendPayoutBankFileGenerationEmail(productDividendHistory, attachments);
        } catch (Exception ex) {
            log.error("Error in generateDividendPayoutBankFile", ex);
        } finally {
            RedisUtil.del(redisKey);
        }
    }

    public void updateDividendBankPaymentDetails(Long id) {
        if (id == null) {
            log.error("Error in updateProductDividendHistoryStatus : id is null");
        }
        String redisKey = "update_dividend_payout_" + id;
        if (RedisUtil.exists(redisKey)) {
            return;
        }
        RedisUtil.set(redisKey, "1", ONE_DAY);
        try {
            ProductDividendHistory productDividendHistory = productDividendHistoryDao.findProductDividendHistoryByIdAndStatusCheckerAndStatusApproverAndGeneratedBankFileIsTrue(id, CmsAdmin.CheckerStatus.APPROVE_CHECKER, CmsAdmin.ApproverStatus.APPROVE_APPROVER);
            if (productDividendHistory == null || StringUtil.isEmpty(productDividendHistory.getBankResultCsv())) {
                return;
            }
            String s3Key = StringUtil.extractDownloadLinkFromCmsContent(productDividendHistory.getBankResultCsv());
            String fileNameWithoutExtension = id + "_update_dividend_payout_" + System.currentTimeMillis();
            List<BankPaymentRecordVo> records = excelService.parseExcelFileFromS3ToVoClass(s3Key, fileNameWithoutExtension, BankPaymentRecordVo.class, ExcelService.ParseStrategy.COLUMN_NAME);

            for (BankPaymentRecordVo record : records) {
                String referenceNumber = record.getReferenceNumber().strip();
                ProductDividendCalculationHistory dividendCalculationHistory = productDividendCalculationHistoryDao.findByReferenceNumber(referenceNumber);
                if (dividendCalculationHistory != null) {
                    dividendCalculationHistory.setPaymentStatus(StringUtil.getEnumFromString(Status.class, record.getPaymentStatus()));
                    if (StringUtil.isNotEmpty(record.getPaymentDate())) {
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d/M/yyyy");
                        LocalDate paymentDate = LocalDate.parse(record.getPaymentDate(), formatter);
                        dividendCalculationHistory.setPaymentDate(DateUtil.convertLocalDateToDate(paymentDate));
                    }
                    dividendCalculationHistory.setUpdatedAt(new Date());
                    productDividendCalculationHistoryDao.save(dividendCalculationHistory);
                }
            }
            productDividendHistory.setUpdatedBankResult(Boolean.TRUE);
            productDividendHistory.setUpdatedAt(new Date());
            productDividendHistoryDao.save(productDividendHistory);
        } catch (Exception ex) {
            log.error("Error in updateDividendBankPaymentDetails", ex);
        } finally {
            RedisUtil.del(redisKey);
        }
    }

    public void updateDividendExcelDetails(Long id) {
        if (id == null) {
            log.error("Error in updateDividendExcelDetails : id is null");
            return;
        }
        String redisKey = "update_dividend_excel_" + id;
        if (RedisUtil.exists(redisKey)) {
            return;
        }
        RedisUtil.set(redisKey, "1", ONE_DAY);
        try {
            ProductDividendHistory productDividendHistory = productDividendHistoryDao.getReferenceById(id);
            if (StringUtil.isEmpty(productDividendHistory.getDividendCsvKey()) || StringUtil.isEmpty(productDividendHistory.getUpdatedDividendCsvKey())) {
                return;
            }
            String fileNameWithoutExtension = id + "update_dividend_excel_" + System.currentTimeMillis();
            List<DividendExcelRecordUpdateVo> records = excelService.parseExcelFileFromS3ToVoClass(productDividendHistory.getUpdatedDividendCsvKey(), fileNameWithoutExtension, DividendExcelRecordUpdateVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            List<ProductDividendCalculationHistory> ProductDividendCalculationHistoryList = new ArrayList<>();
            for (DividendExcelRecordUpdateVo record : records) {
                String referenceNumber = record.getReferenceNumber().strip();
                ProductDividendCalculationHistory dividendCalculationHistory = productDividendCalculationHistoryDao.findByReferenceNumber(referenceNumber);
                if (dividendCalculationHistory != null) {
                    dividendCalculationHistory.setDividendAmount(Double.valueOf(record.getDividend().replace(",", "")));
                    if (StringUtil.isNotEmpty(record.getTrusteeFee())) {
                        dividendCalculationHistory.setTrusteeFeeAmount(Double.valueOf(record.getTrusteeFee().replace(",", "")));
                    }
                    dividendCalculationHistory.setUpdatedAt(new Date());
                    productDividendCalculationHistoryDao.save(dividendCalculationHistory);
                    ProductDividendCalculationHistoryList.add(dividendCalculationHistory);
                }
            }
            File dividendExcelFile = excelService.generateDividendExcel(ProductDividendCalculationHistoryList, productDividendHistory.getCsvFileName());
            String s3filePath = S3_DIVIDEND_EXCEL_DOCUMENT_PATH + sdf2.format(new Date()) + "/" + dividendExcelFile.getName().replaceFirst("[.][^.]+$", "");
            ;
            AwsS3Util.uploadFile(dividendExcelFile, s3filePath, false);
            productDividendHistory.setDividendCsvKey(s3filePath);
            productDividendHistory.setStatusChecker(CmsAdmin.CheckerStatus.PENDING_CHECKER);
            productDividendHistory.setStatusApprover(CmsAdmin.ApproverStatus.PENDING_APPROVER);
            productDividendHistory.setGeneratedBankFile(Boolean.FALSE);

            productDividendHistory.setUpdatedAt(new Date());
            productDividendHistoryDao.save(productDividendHistory);
        } catch (Exception ex) {
            log.error("Error in updateDividendExcelDetails", ex);
        } finally {
            RedisUtil.del(redisKey);
        }
    }

    //----------------------------------Excel Generation End----------------------------------

    //----------------------------------Profit Sharing Dividend Schedule Generation Start----------------------------------
    @Async
    public void generateProfitSharingSchedule(ProductOrder productOrder) {
        try {
            if (ProductDividendSchedule.StructureType.FIXED.equals(productOrder.getStructureType())) {
                generateFixedProfitSharingSchedule(productOrder);
            } else if (ProductDividendSchedule.StructureType.FLEXIBLE.equals(productOrder.getStructureType())) {
                generateFlexibleProfitSharingSchedule(productOrder);
            }
        } catch (Exception ex) {
            log.error("Error in generateProfitSharingSchedule", ex);
        }
    }

    @Transient
    private void generateFixedProfitSharingSchedule(ProductOrder productOrder) {
        try {
            HashMap<String, Object> hashMap = new HashMap<>();

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MMM-yyyy");
            LocalDate agreementDate = productOrder.getAgreementDate();
            LocalDate endTenure = productOrder.getEndTenure();

            String clientName = productOrder.getClientName();
            String clientIdentityId = productOrder.getClientIdentityId();
            DecimalFormat decimalFormatter = new DecimalFormat("#,##0.00");
            String trustFundAmount = decimalFormatter.format(productOrder.getPurchasedAmount());
            String agreementDateString = agreementDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
            String footerNote = StringUtil.sanitizeHtml(productOrder.getProduct().getProfitSharingFooterNote());
            LocalDate capitalRepaymentDate = endTenure.plusMonths(1);
            capitalRepaymentDate = capitalRepaymentDate.withDayOfMonth(capitalRepaymentDate.lengthOfMonth());
            final String capitalRepaymentDateString = capitalRepaymentDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
            footerNote = StringUtil.isNotEmpty(footerNote) ? StringUtil.sanitizeHtml(footerNote) : " ";

            hashMap.put("clientName", clientName);
            hashMap.put("clientIdentityId", clientIdentityId);
            hashMap.put("trustFundAmount", trustFundAmount);
            hashMap.put("agreementDate", agreementDateString);
            hashMap.put("capitalRepaymentDate", capitalRepaymentDateString);
            hashMap.put("footerNote", footerNote);

            int payoutFrequency = getPayoutFrequency(productOrder.getPayoutFrequency());
            LocalDate firstPeriodStartingDate = calculateFixedPeriodStartingDate(agreementDate, payoutFrequency);
            LocalDate firstPeriodEndingDate = calculateFixedPeriodEndingDate(firstPeriodStartingDate, payoutFrequency);
            LocalDate lastPeriodStartingDate = calculateFixedPeriodStartingDate(productOrder.getEndTenure(), payoutFrequency);
            LocalDate lastPeriodEndingDate = calculateFixedPeriodEndingDate(lastPeriodStartingDate, payoutFrequency);

            List<QuarterVo> quarterVoList = new ArrayList<>();

            // Start with the first quarter
            LocalDate currentStart = firstPeriodStartingDate;
            LocalDate currentEnd = firstPeriodEndingDate;

            // Get a list of quarters between the first and last period
            while (!currentStart.isAfter(lastPeriodStartingDate)) {
                quarterVoList.add(QuarterVo.addQuarter(currentStart, currentEnd));
                // Calculate the next quarter's period:
                // New start is current end plus 1 day.
                currentStart = currentEnd.plusDays(1);
                // New end is calculated by adding the period's length in months and subtracting 1 day.
                currentEnd = currentStart.plusMonths(12 / payoutFrequency).minusDays(1);
                if (currentStart.isAfter(lastPeriodEndingDate)) {
                    break;
                }
            }

            Integer paymentDayOfMonth = productDividendScheduleDao.findPaymentDayOfMonth(productOrder.getProduct().getId(), agreementDate.getDayOfMonth());
            if (paymentDayOfMonth == null) {
                paymentDayOfMonth = 15;
            }

            hashMap.put("totalTenure", productOrder.getInvestmentTenureMonth() / 12);

            double totalDividendAmount = 0.0;
            List<Map<String, String>> rows = new ArrayList<>();

            final LocalDate periodStartingDateBeforeLoop = productOrder.getPeriodStartingDate();
            final LocalDate periodEndingDateBeforeLoop = productOrder.getPeriodEndingDate();

            for (int i = 0; i < quarterVoList.size(); i++) {
                //Schedule
                int counter = i + 1;

                QuarterVo qp = quarterVoList.get(i);
                productOrder.setPeriodStartingDate(qp.getStartDate());
                productOrder.setPeriodEndingDate(qp.getEndDate());
                double[] calculateDividendAmountResult = calculateDividendAmount(productOrder, counter == quarterVoList.size());
                double dividendAmount = calculateDividendAmountResult[0];
                totalDividendAmount += dividendAmount;

                //Update dividend counter after loop
                productOrder.setDividendCounter(productOrder.getDividendCounter() + 1);

                Map<String, String> row = new HashMap<>();

                //Entitlement Date
                String entitlementDate = qp.getEndDate().format(formatter);

                String schedule = DateUtil.returnDayWithOrdinal(counter) + " Payment";
                if (counter == 1 || counter == quarterVoList.size()) {
                    //If agreement date falls on the starting day of the 1st quarter, then no prorated for first payment
                    LocalDate firstQuarterDateStartingDate = quarterVoList.get(0).getStartDate();
                    if (!agreementDate.isEqual(firstQuarterDateStartingDate)) {
                        schedule = DateUtil.returnDayWithOrdinal(counter) + " Payment (Pro-rated)";
                    }
                }

                //Payment Date
                LocalDate paymentDate = qp.getEndDate();

                paymentDate = paymentDate.plusMonths(1);
                if (paymentDayOfMonth != 99) {
                    paymentDate = paymentDate.withDayOfMonth(paymentDayOfMonth);
                } else {
                    paymentDate = paymentDate.withDayOfMonth(paymentDate.lengthOfMonth());
                }

                //If maturity date is after last period starting date and before last period ending date
                if (productOrder.getEndTenure().isAfter(quarterVoList.get(i).getStartDate()) && productOrder.getEndTenure().isBefore(quarterVoList.get(i).getEndDate())) {
                    Map<String, String> maturityRow = new HashMap<>();
                    String maturityEntitlementDate = productOrder.getEndTenure().format(formatter);

                    maturityRow.put("entitlementDate", maturityEntitlementDate);
                    maturityRow.put("schedule", "Trust fund amount at maturity");
                    maturityRow.put("paymentDate", capitalRepaymentDate.format(formatter));
                    rows.add(maturityRow);
                }

                row.put("entitlementDate", entitlementDate);
                row.put("schedule", schedule);
                row.put("paymentDate", paymentDate.format(formatter));
                rows.add(row);

                //If maturity date equals to last period ending date
                if (productOrder.getEndTenure().isEqual(productOrder.getPeriodEndingDate())) {
                    Map<String, String> finalRow = new HashMap<>();
                    finalRow.put("entitlementDate", entitlementDate);
                    finalRow.put("schedule", "Trust fund amount at maturity");
                    finalRow.put("paymentDate", capitalRepaymentDate.format(formatter));
                    rows.add(finalRow);
                }
            }

            productOrder.setPeriodStartingDate(periodStartingDateBeforeLoop);
            productOrder.setPeriodEndingDate(periodEndingDateBeforeLoop);
            productOrder.setDividendCounter(0);

            String totalExpectedProfitSharing = decimalFormatter.format(totalDividendAmount);
            hashMap.put("totalExpectedProfitSharing", totalExpectedProfitSharing);
            hashMap.put("rows", rows);

            String templateName = "FIXED-PROFIT-SHARING-SCHEDULE.html";
            String renderedTemplate = pdfService.renderTemplate(templateName, hashMap);
            byte[] pdfByte = pdfService.generatePdf(renderedTemplate);

            String profitSharingScheduleBase64 = Base64.getEncoder().encodeToString(pdfByte);
            String profitSharingScheduleFileName = productOrder.getAgreementFileName() + "_profitSharingSchedule";
            String profitSharingScheduleKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(profitSharingScheduleBase64)
                    .fileName(profitSharingScheduleFileName)
                    .filePath(S3_PRODUCT_ORDER_PATH + productOrder.getOrderReferenceNumber()));
            productOrder.setProfitSharingScheduleKey(profitSharingScheduleKey);
            productOrderDao.save(productOrder);
        } catch (Exception ex) {
            log.error("Error in generateFixedProfitSharingSchedule", ex);
        }
    }

    @Transient
    private void generateFlexibleProfitSharingSchedule(ProductOrder productOrder) {
        try {
            HashMap<String, Object> hashMap = new HashMap<>();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MMM-yyyy");
            LocalDate agreementDate = productOrder.getAgreementDate();
            LocalDate endTenure = productOrder.getEndTenure();

            String clientName = productOrder.getClientName();
            String clientIdentityId = productOrder.getClientIdentityId();
            String agreementDateString = agreementDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
            DecimalFormat decimalFormatter = new DecimalFormat("#,##0.00");
            String trustFundAmount = decimalFormatter.format(productOrder.getPurchasedAmount());
            String footerNote = StringUtil.sanitizeHtml(productOrder.getProduct().getProfitSharingFooterNote());
            footerNote = StringUtil.isNotEmpty(footerNote) ? StringUtil.sanitizeHtml(footerNote) : " ";

            hashMap.put("clientName", clientName);
            hashMap.put("clientIdentityId", clientIdentityId);
            hashMap.put("agreementDate", agreementDateString);
            hashMap.put("trustFundAmount", trustFundAmount);
            hashMap.put("footerNote", footerNote);

            hashMap.put("totalTenure", productOrder.getInvestmentTenureMonth() / 12);

            int payoutFrequency = getPayoutFrequency(productOrder.getPayoutFrequency());
            LocalDate firstPeriodStartingDate = agreementDate;
            LocalDate firstPeriodEndingDate = calculateFlexiblePeriodEndingDate(firstPeriodStartingDate, payoutFrequency);
            LocalDate lastPeriodStartingDate = calculateFlexiblePeriodStartingDate(endTenure, payoutFrequency);
            LocalDate lastPeriodEndingDate = calculateFlexiblePeriodEndingDate(lastPeriodStartingDate, payoutFrequency);

            LocalDate currentStart = firstPeriodStartingDate;
            LocalDate currentEnd = firstPeriodEndingDate;

            List<QuarterVo> quarterVoList = new ArrayList<>();
            while (!currentStart.isAfter(lastPeriodStartingDate)) {
                quarterVoList.add(QuarterVo.addQuarter(currentStart, currentEnd));
                // Calculate the next quarter's period:
                currentStart = currentEnd.plusDays(1);
                // New end is calculated by adding the period's length in months and subtracting 1 day.
                currentEnd = calculateFlexiblePeriodEndingDate(currentStart, payoutFrequency);
                if (currentStart.isAfter(lastPeriodEndingDate)) {
                    break;
                }
            }

            double totalDividendAmount = 0.0;
            double quarterlyDividendAmount = 0.0;
            List<Map<String, String>> rows = new ArrayList<>();

            final LocalDate periodStartingDateBeforeLoop = productOrder.getPeriodStartingDate();
            final LocalDate periodEndingDateBeforeLoop = productOrder.getPeriodEndingDate();

            for (int i = 0; i < quarterVoList.size(); i++) {
                int lastIndex = quarterVoList.size() - 1;
                QuarterVo qp = quarterVoList.get(i);
                productOrder.setPeriodStartingDate(qp.getStartDate());
                productOrder.setPeriodEndingDate(qp.getEndDate());
                double[] calculateDividendAmountResult = calculateDividendAmount(productOrder, i == lastIndex);
                double dividendAmount = calculateDividendAmountResult[0];
                quarterlyDividendAmount = dividendAmount;
                totalDividendAmount += dividendAmount;

                //Update dividend counter after loop
                productOrder.setDividendCounter(productOrder.getDividendCounter() + 1);

                Map<String, String> row = new HashMap<>();

                //Schedule
                String schedule = DateUtil.returnDayWithOrdinal(i + 1) + " Payment";
                //Payment Date - For Flexible always end of month
                Integer paymentDayOfMonth = productDividendScheduleDao.findPaymentDayOfMonth(productOrder.getProduct().getId(), agreementDate.getDayOfMonth());
                LocalDate paymentDate = qp.getEndDate().plusDays(1);
                if (paymentDayOfMonth == 99) {
                    paymentDate = DateUtil.getLastDayOfMonth(qp.getEndDate());
                }

                row.put("schedule", schedule);
                row.put("paymentDate", paymentDate.format(formatter));
                rows.add(row);

                //If this is the final dividend
                if (i == lastIndex) {
                    Map<String, String> finalRow = new HashMap<>();
                    finalRow.put("schedule", "Capital Repayment");
                    finalRow.put("paymentDate", paymentDate.format(formatter) + "*");
                    rows.add(finalRow);
                }
            }

            productOrder.setPeriodStartingDate(periodStartingDateBeforeLoop);
            productOrder.setPeriodEndingDate(periodEndingDateBeforeLoop);
            productOrder.setDividendCounter(0);

            //Format the dividend amounts
            String quarterlyExpectedProfitSharing = decimalFormatter.format(quarterlyDividendAmount);
            String totalExpectedProfitSharing = decimalFormatter.format(totalDividendAmount);
            hashMap.put("quarterlyExpectedProfitSharing", quarterlyExpectedProfitSharing);
            hashMap.put("totalExpectedProfitSharing", totalExpectedProfitSharing);
            hashMap.put("rows", rows);

            String templateName = "FLEXIBLE-PROFIT-SHARING-SCHEDULE.html";
            String renderedTemplate = pdfService.renderTemplate(templateName, hashMap);
            byte[] pdfByte = pdfService.generatePdf(renderedTemplate);

            String profitSharingScheduleBase64 = Base64.getEncoder().encodeToString(pdfByte);
            String profitSharingScheduleFileName = productOrder.getAgreementFileName() + "_profitSharingSchedule";
            String profitSharingScheduleKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(profitSharingScheduleBase64)
                    .fileName(profitSharingScheduleFileName)
                    .filePath(S3_PRODUCT_ORDER_PATH + productOrder.getOrderReferenceNumber()));
            productOrder.setProfitSharingScheduleKey(profitSharingScheduleKey);
            productOrderDao.save(productOrder);
        } catch (Exception ex) {
            log.error("Error in generateFlexibleProfitSharingSchedule", ex);
        }
    }

    //----------------------------------Profit Sharing Dividend Schedule Generation End----------------------------------
}
