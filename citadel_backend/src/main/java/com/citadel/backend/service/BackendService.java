package com.citadel.backend.service;

import com.citadel.backend.dao.Products.*;
import com.citadel.backend.entity.Products.*;
import com.citadel.backend.utils.*;
import com.citadel.backend.utils.Builder.DigitalIDBuilder;
import com.citadel.backend.utils.Builder.UploadBase64FileBuilder;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.vo.Agreement.AgreementRespVo;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Enum.*;
import com.citadel.backend.vo.Product.PhysicalTrustDeedReminderInterfaceVo;
import com.citadel.backend.vo.Product.PhysicalTrustDeedReminderVo;
import com.citadel.backend.vo.Product.req.CmsAdminPOStatusUpdateReqVo;
import jakarta.annotation.Resource;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import static com.citadel.backend.utils.ApiErrorKey.*;

@Service
public class BackendService extends BaseService {

    @Resource
    private ProductOrderDao productOrderDao;
    @Resource
    private ProductAgreementSchedulePivotDao productAgreementSchedulePivotDao;
    @Resource
    private DividendService dividendService;
    @Resource
    private ProductAgreementDateDao productAgreementDateDao;
    @Resource
    private CommissionService commissionService;
    @Resource
    private ProductDividendScheduleDao productDividendScheduleDao;
    @Resource
    private ProductService productService;
    @Resource
    private CommissionService.AgencyCommissionService agencyCommissionService;
    @Resource
    private CommissionService.AgentCommissionService agentCommissionService;
    @Resource
    private PdfService pdfService;
    @Resource
    private ProductAgreementDao productAgreementDao;
    @Resource
    private EmailService emailService;

    //-------------------------------CMS Backend API Calls Start------------------------------
    @Transactional
    public Object cmsAdminUpdateProductOrderStatus(String referenceNumber, CmsAdminPOStatusUpdateReqVo req) {
        try {
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(referenceNumber).orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));
            String adminRemark = null;
            if (StringUtil.isNotEmpty(req.getAdminRemark())) {
                adminRemark = req.getAdminRemark().strip();
            }

            Status reallocationRolloverStatus = Status.IN_REVIEW;

            if (CmsAdmin.AdminType.CHECKER.equals(req.getAdminType())) {
                if (CmsAdmin.Status.APPROVE_CHECKER.equals(req.getAdminStatus())) {
                    productOrder.setStatusChecker(CmsAdmin.CheckerStatus.APPROVE_CHECKER);
                    productOrder.setStatus(ProductOrder.ProductOrderStatus.IN_REVIEW);
                } else if (CmsAdmin.Status.REJECT_CHECKER.equals(req.getAdminStatus())) {
                    productOrder.setStatusChecker(CmsAdmin.CheckerStatus.REJECT_CHECKER);
                    productOrder.setStatus(ProductOrder.ProductOrderStatus.REJECTED);
                    if (StringUtil.isNotEmpty(adminRemark)) {
                        productOrder.setRemark(adminRemark);
                    }
                }
                productOrder.setCheckerUpdatedAt(new Date());
                productOrder.setRemarkChecker(adminRemark);
                productOrder.setCheckedBy(req.getAdminEmail().strip());
            }

            if (CmsAdmin.AdminType.FINANCE.equals(req.getAdminType())) {
                if (CmsAdmin.Status.APPROVE_FINANCE.equals(req.getAdminStatus())) {
                    List<ProductDividendSchedule> dividendScheduleList = productDividendScheduleDao.findAllByProductId(productOrder.getProduct().getId());
                    if (dividendScheduleList.isEmpty()) {
                        throw new GeneralException(DIVIDEND_SCHEDULE_NOT_FOUND);
                    }
                    productOrder.setPayoutFrequency(dividendScheduleList.get(0).getFrequencyOfPayout());
                    productOrder.setStructureType(dividendScheduleList.get(0).getStructureType());

                    // Admin Status
                    productOrder.setStatusFinance(CmsAdmin.FinanceStatus.APPROVE_FINANCE);
                    //If rollover/reallocation only set active if old product matured
                    if (productOrder.getAgreementDate() == null || LocalDate.now().isAfter(productOrder.getAgreementDate())) {
                        productOrder.setStatus(ProductOrder.ProductOrderStatus.ACTIVE);
                    } else {
                        productOrder.setStatus(ProductOrder.ProductOrderStatus.PENDING_ACTIVATION);
                    }

                    //Payment Details
                    productOrder.setPaymentStatus(Status.SUCCESS);

                    //Agreement Details
                    Long productTypeId = productOrder.getProduct().getProductType().getId();
                    //Rollover & Reallocation parent product order has not matured then need to pass in previous order end tenure date as request date
                    LocalDateTime approvalDateTime = productOrder.getAgreementDate() != null ? productOrder.getAgreementDate().atStartOfDay() : LocalDateTime.now();
                    LocalDateTime submissionDateTime = productOrder.getSubmissionDate() != null ? DateUtil.convertDateToLocalDateTime(productOrder.getSubmissionDate()) : LocalDateTime.now();
                    final LocalDate agreementDate = getProductAgreementDate(productTypeId, approvalDateTime, submissionDateTime, productOrder.getStructureType());
                    productOrder.setAgreementDate(agreementDate);

                    //Start Tenure
                    productOrder.setStartTenure(agreementDate);
                    //End tenure : AgreementDate : 01-01-2025, maturity period = 2years, end tenure = 31-12-2026 not 01-01-2027
                    productOrder.setEndTenure(productOrder.getStartTenure().plusMonths(productOrder.getInvestmentTenureMonth()).minusDays(1));

                    //Current period start and end dates
                    int payoutFrequency = DividendService.getPayoutFrequency(productOrder.getPayoutFrequency());
                    LocalDate periodStartingDate = LocalDate.now();
                    LocalDate periodEndingDate = LocalDate.now();
                    if (ProductDividendSchedule.StructureType.FIXED.equals(productOrder.getStructureType())) {
                        periodStartingDate = DividendService.calculateFixedPeriodStartingDate(productOrder.getAgreementDate(), payoutFrequency);
                        periodEndingDate = DividendService.calculateFixedPeriodEndingDate(periodStartingDate, payoutFrequency);
                    }
                    if (ProductDividendSchedule.StructureType.FLEXIBLE.equals(productOrder.getStructureType())) {
                        periodStartingDate = productOrder.getAgreementDate();
                        periodEndingDate = DividendService.calculateFlexiblePeriodEndingDate(periodStartingDate, payoutFrequency);
                    }
                    productOrder.setPeriodStartingDate(periodStartingDate);
                    productOrder.setPeriodEndingDate(periodEndingDate);
                    productOrder.setLastDividendCalculationDate(null);
                    productOrder.setRemark("Pending Approver Approval");


                    String agreementFileName = productOrder.getAgreementFileName();
                    if (StringUtil.isEmpty(agreementFileName)) {
                        UserType userType = UserType.CLIENT;
                        if (productOrder.getCorporateClient() != null) {
                            userType = UserType.CORPORATE_CLIENT;
                        }

                        Date submissionDate = productOrder.getSubmissionDate();
                        if (submissionDate == null) {
                            submissionDate = productOrder.getPaymentDate() == null ? new Date() : productOrder.getPaymentDate();
                        }

                        agreementFileName = DigitalIDUtil.createAgreementID(new DigitalIDBuilder()
                                .builderType(DigitalIDBuilder.BuilderType.PRODUCT_ORDER)
                                .name(productOrder.getProduct().getCode())
                                .userType(userType)
                                .date(submissionDate));
                        productOrder.setAgreementFileName(agreementFileName);
                    }
                    productOrder = productOrderDao.save(productOrder);

                    //Generate profit sharing schedule
                    dividendService.generateProfitSharingSchedule(productOrder);

                    // Generate PDF and store agreement file
                    byte[] pdfByte = pdfService.generateTrustProductAgreementPdf(UserType.CLIENT, productOrder, null, null, Boolean.TRUE);
                    productService.storeTrustFundAgreementFile(productOrder, pdfByte, false);
                    productService.storeUnsignedTrustFundAgreementFile(productOrder, pdfByte);
                } else if (CmsAdmin.Status.REJECT_FINANCE.equals(req.getAdminStatus())) {
                    // Admin Status
                    productOrder.setStatusFinance(CmsAdmin.FinanceStatus.REJECT_FINANCE);
                    productOrder.setStatus(ProductOrder.ProductOrderStatus.REJECTED);

                    //Payment Details
                    productOrder.setPaymentStatus(Status.FAILED);
                    if (StringUtil.isNotEmpty(adminRemark)) {
                        productOrder.setRemark(adminRemark);
                    }
                    reallocationRolloverStatus = Status.REJECTED;
                }
                productOrder.setFinanceUpdatedAt(new Date());
                productOrder.setRemarkFinance(adminRemark);
                productOrder.setFinancedBy(req.getAdminEmail().strip());
            }

            if (CmsAdmin.AdminType.APPROVER.equals(req.getAdminType())) {
                if (CmsAdmin.Status.APPROVE_APPROVER.equals(req.getAdminStatus())) {
                    //Prevent double approval of approved status
                    if (!(CmsAdmin.ApproverStatus.APPROVE_APPROVER.equals(productOrder.getStatusApprover()))) {
                        // Admin Status
                        productOrder.setStatus(ProductOrder.ProductOrderStatus.ACTIVE);
                        productOrder.setStatusApprover(CmsAdmin.ApproverStatus.APPROVE_APPROVER);

                        // Agreement Details
                        productOrder.setClientAgreementStatus(Status.PENDING);
                        productOrder.setWitnessAgreementStatus(Status.PENDING);
                        productOrder.setRemark("Pending Client Agreement Signature");

                        reallocationRolloverStatus = Status.APPROVED;

                        // Generate PDF and store agreement file
                        byte[] pdfByte = pdfService.generateTrustProductAgreementPdf(UserType.CLIENT, productOrder, null, null, Boolean.TRUE);
                        productService.storeTrustFundAgreementFile(productOrder, pdfByte, false);
                        productService.storeUnsignedTrustFundAgreementFile(productOrder, pdfByte);
                    }
                } else if (CmsAdmin.Status.REJECT_APPROVER.equals(req.getAdminStatus())) {
                    // Admin Status
                    productOrder.setStatusApprover(CmsAdmin.ApproverStatus.REJECT_APPROVER);
                    productOrder.setStatus(ProductOrder.ProductOrderStatus.REJECTED);
                    if (StringUtil.isNotEmpty(adminRemark)) {
                        productOrder.setRemark(adminRemark);
                    }

                    reallocationRolloverStatus = Status.REJECTED;
                }
                productOrder.setApproverUpdatedAt(new Date());
                productOrder.setRemarkApprover(adminRemark);
                productOrder.setApprovedBy(req.getAdminEmail().strip());
            }

            productOrder = productOrderDao.save(productOrder);
            productService.updateRolloverReallocationStatus(productOrder, reallocationRolloverStatus);

            if (ProductOrder.ProductOrderStatus.REJECTED.equals(productOrder.getStatus())) {
                //Notify client product order has been rejected
                emailService.sendProductOrderRejectedEmail(productOrder);
            }
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public LocalDate getProductAgreementDate(Long productTypeId, LocalDateTime approvalDateTime, LocalDateTime submissionDateTime, ProductDividendSchedule.StructureType structureType) {
        boolean fallback = false;
        LocalDate agreeementDate = null;

        LocalTime threePM = LocalTime.of(15, 0);
        LocalTime sixPM = LocalTime.of(18, 0);

        //Extract the time and date part from the submission LocalDateTime
        LocalTime submissionTime = submissionDateTime.toLocalTime();
        LocalDate submissionDate = submissionDateTime.toLocalDate();

        // Extract the time and date part from the approval LocalDateTime
        LocalTime approvalTime = approvalDateTime.toLocalTime();
        LocalDate approvalDate = approvalDateTime.toLocalDate();

        // Check if the submission time is after 3 PM
        if (submissionTime.isAfter(sixPM)) {
            // Add 1 day to the submission date
            submissionDate = submissionDate.plusDays(1);
        }

        // Check if the approval time is after 6 PM
        if (approvalTime.isAfter(threePM)) {
            // Add 1 day to approval date
            approvalDate = approvalDate.plusDays(1);
        }

        List<ProductAgreementSchedule> agreementScheduleList = productAgreementSchedulePivotDao.findSchedulesByProductTypeV2(productTypeId, submissionDate, approvalDate);
        if (agreementScheduleList.isEmpty()) {
            fallback = true;
        }

        if (!fallback) {
            // Find the first approvalDueDate after today
            LocalDate approvalDueDate = agreementScheduleList.get(0).getApprovalDueDate();
            Integer approvalDueDateOfMonth = approvalDueDate.getDayOfMonth();
            Integer dateOfMonth = productAgreementDateDao.findAgreementDateOfMonth(productTypeId, approvalDueDateOfMonth);
            if (dateOfMonth != null) {
                // Last day of month
                if (dateOfMonth == 99) {
                    agreeementDate = approvalDueDate.withDayOfMonth(approvalDueDate.lengthOfMonth());
                } else {
                    agreeementDate = approvalDueDate.withDayOfMonth(dateOfMonth);
                }
            } else if (ProductDividendSchedule.StructureType.FIXED.equals(structureType)) {
                //retry by adding 1 month and with day of 1 to the approvalDueDate -> used by fixed structure products.
                //product agreement date configured as 1st of the month
                //if the approval due date is 28th of the month, the agreement date query would return null because 28>1
                dateOfMonth = productAgreementDateDao.findAgreementDateOfMonth(productTypeId, 1);
                if (dateOfMonth != null) {
                    // Last day of month
                    if (dateOfMonth == 99) {
                        agreeementDate = approvalDueDate.withDayOfMonth(approvalDueDate.lengthOfMonth());
                    } else {
                        agreeementDate = approvalDueDate.plusMonths(1).withDayOfMonth(dateOfMonth);
                    }
                } else {
                    fallback = true;
                }
            } else {
                fallback = true;
            }
        }

        if (fallback) {
            // Calculate fallback date based on today's date
            if (ProductDividendSchedule.StructureType.FIXED.equals(structureType)) {
                agreeementDate = approvalDate.plusMonths(1).withDayOfMonth(1);
            } else {
                int dayOfMonth = approvalDate.getDayOfMonth();
                int lastDayOfMonth = approvalDate.lengthOfMonth();

                if (dayOfMonth <= 15) {
                    // Return 15th of the current month
                    agreeementDate = approvalDate.withDayOfMonth(15);
                } else {
                    // Return last day of the current month
                    agreeementDate = approvalDate.withDayOfMonth(lastDayOfMonth);
                }
            }
        }
        return agreeementDate;
    }

    //-------------------------------Dividend------------------------------
    public Object cmsGenerateDividendBankFile(Long id) {
        try {
            dividendService.generateDividendPayoutBankFile(id);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in cmsGenerateDividendBankFile", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object cmsUpdateDividendBankPaymentDetails(Long id) {
        try {
            dividendService.updateDividendBankPaymentDetails(id);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in cmsUpdateBankPaymentDetails", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object cmsUpdateDividendExcelDetails(Long id) {
        try {
            dividendService.updateDividendExcelDetails(id);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in cmsUpdateDividendExcelDetails", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-------------------------------Commission------------------------------
    public Object cmsGenerateCommissionBankFile(Long id) {
        try {
            commissionService.generateCommissionBankFile(id);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object cmsUpdateCommissionBankPaymentDetails(Long id) {
        try {
            commissionService.updateCommissionBankPaymentDetails(id);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object cmsUpdateCommissionExcelDetails(Long id) {
        try {
            commissionService.updateCommissionExcelDetails(id);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in cmsUpdateCommissionExcelDetails", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-------------------------------Rollover and Reallocation------------------------------
    public void cmsUpdateReallocationRollover(Long id) {
        productOrderDao.findById(id).ifPresent(productOrder -> productService.activateRolloverReallocation(productOrder));
    }

    //-------------------------------Redemption------------------------------
    public Object cmsGenerateRedemptionBankFile(Long id) {
        try {
            productService.generateRedemptionBankFile(id);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object cmsUpdateRedemptionBankPaymentDetails(Long id) {
        try {
            productService.updateRedemptionBankPaymentDetails(id);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-------------------------------Early Redemption------------------------------
    public Object cmsGenerateEarlyRedemptionBankFile(Long id) {
        try {
            productService.generateEarlyRedemptionBankFile(id);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object cmsUpdateEarlyRedemptionBankPaymentDetails(Long id) {
        try {
            productService.updateEarlyRedemptionBankPaymentDetails(id);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-------------------------------CMS Backend API Calls End------------------------------

    //-------------------------------Cron Fixed Dividend Calculation Start------------------------------
    public void cronProcessFixedQuarterlyDividendCalculation() {
        try {
            dividendService.processFixedDividendCalculation(LocalDate.now(), ProductDividendSchedule.FrequencyOfPayout.QUARTERLY);
        } catch (Exception ex) {
            log.error("Error in processFixedQuarterlyDividendCalculation", ex);
        }
    }

    public void cronProcessFixedMonthlyDividendCalculation() {
        try {
            dividendService.processFixedDividendCalculation(LocalDate.now(), ProductDividendSchedule.FrequencyOfPayout.MONTHLY);
        } catch (Exception ex) {
            log.error("Error in processFixedMonthlyDividendCalculation", ex);
        }
    }

    public void cronProcessFixedYearlyDividendCalculation() {
        try {
            dividendService.processFixedDividendCalculation(LocalDate.now(), ProductDividendSchedule.FrequencyOfPayout.ANNUALLY);
        } catch (Exception ex) {
            log.error("Error in processFixedYearlyDividendCalculation", ex);
        }
    }

    public void cronProcessFinalFixedDividend() {
        try {
            dividendService.processFinalFixedDividendCalculation(LocalDate.now());
        } catch (Exception ex) {
            log.error("Error in processFinalFixedDividend", ex);
        }
    }

    //-------------------------------Cron Fixed Dividend Calculation End------------------------------

    //-------------------------------Cron Flexible Dividend Calculation Start------------------------------
    public void cronProcessFlexibleQuarterlyDividendCalculation() {
        try {
            dividendService.processFlexibleDividendCalculation(LocalDate.now(), ProductDividendSchedule.FrequencyOfPayout.QUARTERLY);
        } catch (Exception ex) {
            log.error("Error in processFlexibleQuarterlyDividendCalculation", ex);
        }
    }

    public void cronProcessFlexibleMonthlyDividendCalculation() {
        try {
            dividendService.processFlexibleDividendCalculation(LocalDate.now(), ProductDividendSchedule.FrequencyOfPayout.MONTHLY);
        } catch (Exception ex) {
            log.error("Error in processFlexibleMonthlyDividendCalculation", ex);
        }
    }

    public void cronProcessFlexibleYearlyDividendCalculation() {
        try {
            dividendService.processFlexibleDividendCalculation(LocalDate.now(), ProductDividendSchedule.FrequencyOfPayout.ANNUALLY);
        } catch (Exception ex) {
            log.error("Error in processFlexibleYearlyDividendCalculation", ex);
        }
    }

    //-------------------------------Cron Flexible Dividend Calculation End------------------------------

    public void cronGenerateCommissionExcelFile() {
        try {
            log.info("------------Start generating commission excel file------------");
            commissionService.generateCommissionExcel(LocalDate.now());
            log.info("------------End generating commission excel file------------");
        } catch (Exception ex) {
            log.error("Error in {}", getFunctionName(), ex);
        }
    }

    //-------------------------------Cron Agent Commission Calculation Start------------------------------
    public void cronProcessAgentMonthlyCommissionCalculation() {
        try {
            agentCommissionService.processAgentMonthlyCommission(LocalDate.now());
        } catch (Exception ex) {
            log.info("Error in {}", getFunctionName(), ex);
        }
    }

    public void cronProcessAgentYearlyCommissionCalculation() {
        try {
            agentCommissionService.processAgentYearlyCommission(LocalDate.now());
        } catch (Exception ex) {
            log.info("Error in {}", getFunctionName(), ex);
        }
    }

    //-------------------------------Cron Agent Commission Calculation End------------------------------

    //-------------------------------Cron Agency Commission Calculation Start------------------------------
    public void cronProcessAgencyMonthlyCommissionCalculation() {
        try {
            agencyCommissionService.processAgencyMonthlyCommission(LocalDate.now());
        } catch (Exception ex) {
            log.info("Error in {}", getFunctionName(), ex);
        }
    }

    public void cronProcessAgencyYearlyCommissionCalculation() {
        try {
            agencyCommissionService.processAgencyYearlyCommission(LocalDate.now());
        } catch (Exception ex) {
            log.info("Error in {}", getFunctionName(), ex);
        }
    }

    //-------------------------------Cron Agency Commission Calculation End------------------------------
    public Object cmsGeneratePdfTemplate(Long id, String content) {
        try {
            if (id == null) {
                return new ErrorResp();
            }

            AgreementRespVo respVo = new AgreementRespVo();
            String htmlContent = content;

            if (htmlContent == null) {
                Optional<ProductAgreement> productAgreement = productAgreementDao.findById(id);
                if (productAgreement.isEmpty()) {
                    return new ErrorResp();
                }
                htmlContent = productAgreement.get().getDocumentEditor();
            }

            // Generate PDF
            PdfService pdfService = new PdfService();
            byte[] pdfBytes = pdfService.generatePdf(htmlContent);

            // Always use same file name to overwrite
            String fileName = "preview_" + id + ".pdf";
            String s3Key = S3_PRODUCT_AGREEMENT_DOCUMENT_PATH + fileName;

            // Upload with overwrite
            AwsS3Util.uploadByteArray(pdfBytes, s3Key, true);

            // Add cache-busting query param to force reload
            String signedUrl = AwsS3Util.getS3DownloadUrl(s3Key);

            respVo.setLink(signedUrl);
            respVo.setHtml(htmlContent);
            log.info("Generated pdf preview: {}", signedUrl);

            return respVo;

        } catch (Exception ex) {
            log.error("Error generating PDF preview", ex);
            return new ErrorResp();
        }
    }

    public Object cmsGenerateUnsignedProductAgreement(Long id) {
        try {
            if (id == null) {
                return getErrorObjectWithMsg("Product order ID is required.");
            }
            log.info("------------Start CMS generating unsigned product agreement------------");
            ProductOrder productOrder = productOrderDao.getReferenceById(id);
            if (StringUtil.isNotBlank(productOrder.getUnsignedAgreementKey())) {
                return getErrorObjectWithMsg("Unsigned agreement already exists for this product order.");
            }

            byte[] pdfByte = pdfService.generateTrustProductAgreementPdf(productOrder.getClient().getAppUser().getUserType(), productOrder, null, null, Boolean.TRUE);
            if (pdfByte == null || pdfByte.length == 0) {
                log.error("Invalid PDF byte array: {}", pdfByte == null ? "null" : "empty");
                return getErrorObjectWithMsg("Invalid PDF byte array");
            }

            String trustOrderAgreementBase64 = Base64.getEncoder().encodeToString(pdfByte);
            String unsignedAgreementFileName = productOrder.getAgreementFileName() + "_unsigned";
            String unsignedAgreementKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(trustOrderAgreementBase64)
                    .fileName(unsignedAgreementFileName)
                    .filePath(S3_PRODUCT_ORDER_PATH + productOrder.getOrderReferenceNumber()));
            productOrder.setUnsignedAgreementKey(unsignedAgreementKey);
            productOrderDao.save(productOrder);
            log.info("------------End CMS generating unsigned product agreement------------");

            AgreementRespVo respVo = new AgreementRespVo();
            respVo.setLink(AwsS3Util.getS3DownloadUrl(unsignedAgreementKey));
            return respVo;
        } catch (Exception ex) {
            log.error("Error in {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public void cronPhysicalTrustDeedReminder(LocalDate now) {
        try {
            if (now == null) {
                now = LocalDate.now();
            }
            log.info("------------Start cronPhysicalTrustDeedReminder for date: {}------------", now);
            LocalDate cutoffDate = DateUtil.subtractBusinessDays(now, 7);

            List<PhysicalTrustDeedReminderInterfaceVo> reminders = productOrderDao.findProductOrdersForPhysicalTrustDeedReminder(cutoffDate);
            if (reminders != null && !reminders.isEmpty()) {
                log.info("Found {} reminders for physical trust deed", reminders.size());
                boolean sent = emailService.sendPhysicalTrustDeedReminderEmail(reminders);
                if (sent) {
                    reminders.forEach(reminder -> productOrderDao.updatePhysicalSignedAgreementFilesReminderSentById(reminder.getId()));
                }
            }
            log.info("------------End cronPhysicalTrustDeedReminder for date: {}------------", now);
        } catch (Exception ex) {
            log.info("Error in {}", getFunctionName(), ex);
        }
    }

    public Object updateAgreementTemplatesToCMS() {
        try {
            log.info("------------Start updateAgreementTemplatesToCMS------------");

            List<ProductAgreement> agreementList = productAgreementDao.findAll();
            int uploadedCount = 0;

            for (ProductAgreement agreement : agreementList) {
                String agreementName = agreement.getName();
                if (StringUtil.isEmpty(agreementName)) {
                    log.warn("Agreement name is empty for agreement ID: {}", agreement.getId());
                    continue;
                }

                // Find matching template file based on agreement name (case insensitive)
                String templateFileName = findMatchingTemplateFile(agreementName);
                if (StringUtil.isEmpty(templateFileName)) {
                    log.warn("No matching template file found for agreement: {}", agreementName);
                    continue;
                }

                // Read template file content
                String templateContent = readTemplateFileContent(templateFileName);
                if (StringUtil.isEmpty(templateContent)) {
                    log.error("Failed to read template file: {}", templateFileName);
                    continue;
                }

                // Upload template to S3
                String s3Key = S3_PRODUCT_AGREEMENT_DOCUMENT_PATH + "templates/" + templateFileName;
                assert templateContent != null;
                byte[] templateBytes = templateContent.getBytes(StandardCharsets.UTF_8);
                AwsS3Util.uploadByteArray(templateBytes, s3Key, true);

                agreement.setUploadDocument(s3Key);
                agreement.setDocumentEditor(null);
                agreement.setOverwriteAgreementKey(null);
                productAgreementDao.save(agreement);

                uploadedCount++;
                log.info("Updated agreement '{}' with template '{}' and uploaded to S3", agreementName, templateFileName);
            }

            log.info("------------End updateAgreementTemplatesToCMS - Updated {} agreements------------", uploadedCount);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    private String findMatchingTemplateFile(String agreementName) {
        List<String> templateFiles = PdfService.AGREEMENT_FILE_LIST;

        // Try exact match first (case insensitive)
        for (String templateFile : templateFiles) {
            String templateNameWithoutExt = templateFile.replaceAll("\\.(html|ftl)$", "");
            if (templateNameWithoutExt.equalsIgnoreCase(agreementName)) {
                return templateFile;
            }
        }

        // Try partial match (case insensitive)
        for (String templateFile : templateFiles) {
            String templateNameWithoutExt = templateFile.replaceAll("\\.(html|ftl)$", "");
            if (templateNameWithoutExt.toLowerCase().contains(agreementName.toLowerCase()) ||
                    agreementName.toLowerCase().contains(templateNameWithoutExt.toLowerCase())) {
                return templateFile;
            }
        }

        // Try matching by removing common suffixes/prefixes
        String cleanedAgreementName = agreementName.replaceAll("(?i)(agreement|template|_agreement|_template)$", "");
        for (String templateFile : templateFiles) {
            String templateNameWithoutExt = templateFile.replaceAll("\\.(html|ftl)$", "");
            String cleanedTemplateName = templateNameWithoutExt.replaceAll("(?i)(agreement|template|_agreement|_template)$", "");
            if (cleanedTemplateName.equalsIgnoreCase(cleanedAgreementName)) {
                return templateFile;
            }
        }

        return null;
    }

    private String readTemplateFileContent(String templateFileName) {
        try {
            InputStream inputStream = getClass().getClassLoader().getResourceAsStream("templates/" + templateFileName);
            if (inputStream == null) {
                log.error("Template file not found in classpath: templates/{}", templateFileName);
                return null;
            }

            StringBuilder content = new StringBuilder();
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    content.append(line);
                }
            }
            return content.toString();
        } catch (Exception ex) {
            log.error("Error reading template file: {}", templateFileName, ex);
            return null;
        }
    }

    //-------------------------------Internal API------------------------------
    public Object regenerateProductOrderAgreements(Long productOrderId) {
        try {
            if (productOrderId == null) {
                return getErrorObjectWithMsg("Product order ID is required.");
            }

            log.info("------------Start regenerating product order agreements for ID: {}------------", productOrderId);

            Optional<ProductOrder> productOrderOpt = productOrderDao.findById(productOrderId);
            if (productOrderOpt.isEmpty()) {
                return getErrorObjectWithMsg("Product order not found with ID: " + productOrderId);
            }

            ProductOrder productOrder = productOrderOpt.get();

            // Regenerate signed and unsigned agreements
            productService.generateSignedAndUnsignedAgreements(productOrder);

            log.info("------------End regenerating product order agreements for ID: {}------------", productOrderId);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }
}
