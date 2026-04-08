package com.citadel.backend.service;

import com.citadel.backend.dao.*;
import com.citadel.backend.dao.Agent.AgentDao;
import com.citadel.backend.dao.Client.ClientDao;
import com.citadel.backend.dao.Client.IndividualBeneficiaryDao;
import com.citadel.backend.dao.Corporate.CorporateBeneficiaryDao;
import com.citadel.backend.dao.Corporate.CorporateClientDao;
import com.citadel.backend.dao.Products.*;
import com.citadel.backend.entity.*;
import com.citadel.backend.entity.Corporate.CorporateBeneficiaries;
import com.citadel.backend.entity.Corporate.CorporateClient;
import com.citadel.backend.entity.Products.*;
import com.citadel.backend.utils.*;
import com.citadel.backend.utils.Builder.DigitalIDBuilder;
import com.citadel.backend.utils.Builder.RandomCodeBuilder;
import com.citadel.backend.utils.Builder.UploadBase64FileBuilder;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.vo.AffinBankVo;
import com.citadel.backend.vo.Agreement.*;
import com.citadel.backend.vo.BankDetails.BankDetailsVo;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.CimbBankVo;
import com.citadel.backend.vo.Client.ClientPortfolioProductDetailsRespVo;
import com.citadel.backend.vo.Client.ClientPortfolioVo;
import com.citadel.backend.vo.Enum.*;
import com.citadel.backend.vo.Product.*;
import com.citadel.backend.vo.Product.EarlyRedemption.EarlyRedemptionPaymentRecordVo;
import com.citadel.backend.vo.Product.Reallocation.ReallocatableProductCodesRespVo;
import com.citadel.backend.vo.Product.Reallocation.ReallocateReqVo;
import com.citadel.backend.vo.Product.Redemption.RedemptionPaymentRecordVo;
import com.citadel.backend.vo.Product.req.*;
import com.citadel.backend.vo.Product.resp.ProductOrderPaymentReceiptVo;
import com.citadel.backend.vo.Product.resp.ProductOrderPaymentUploadRespVo;
import com.citadel.backend.vo.Product.resp.ProductPurchaseBeneficiariesRespVo;
import com.citadel.backend.vo.Product.resp.ProductOrderSummaryRespVo;
import com.citadel.backend.vo.SendGrid.Attachment;
import com.citadel.backend.vo.Transaction.TransactionRespVo;
import com.citadel.backend.vo.Transaction.TransactionVo;
import jakarta.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.stream.Collectors;

import static com.citadel.backend.utils.ApiErrorKey.*;
import static com.citadel.backend.vo.Enum.UserType.*;

@Service
public class ProductService extends BaseService {

    @Resource
    private ProductDao productDao;
    @Resource
    private ProductOrderDao productOrderDao;
    @Resource
    private ProductTargetReturnDao productTargetReturnDao;
    @Resource
    private ClientDao clientDao;
    @Resource
    private BankDetailsDao bankDetailsDao;
    @Resource
    private IndividualBeneficiaryDao individualBeneficiaryDao;
    @Resource
    private ProductBeneficiariesDao distributionBeneficiaryDao;
    @Resource
    private ProductDividendCalculationHistoryDao productDividendCalculationHistoryDao;
    @Resource
    private AgentDao agentDao;
    @Resource
    private ProductOrderPaymentReceiptDao productOrderPaymentReceiptDao;
    @Resource
    private PdfService pdfService;
    @Resource
    private CorporateClientDao corporateClientDao;
    @Resource
    private ValidatorService validatorService;
    @Resource
    private CorporateBeneficiaryDao corporateBeneficiaryDao;
    @Resource
    private ProductEarlyRedemptionHistoryDao productEarlyRedemptionHistoryDao;
    @Resource
    private EmailService emailService;
    @Resource
    private PushNotificationService pushNotificationService;
    @Resource
    private ProductRedemptionDao productRedemptionDao;
    @Resource
    private ProductReallocationDao productReallocationDao;
    @Resource
    private ProductRolloverHistoryDao productRolloverHistoryDao;
    @Resource
    private ProductEarlyRedemptionConfigurationDao productEarlyRedemptionConfigurationDao;
    @Resource
    private ProductReallocationConfigurationDao productReallocationConfigurationDao;
    @Resource
    private ExcelService excelService;
    @Resource
    private ProductBeneficiariesDao productBeneficiariesDao;
    @Resource
    private ClientTwoSignatureDao clientTwoSignatureDao;


    public Object getProductList() {
        try {
            // Fetch all products from the database
            List<Product> productList = productDao.findAllByIsPublishedIsTrue();

            // Convert each Product entity to ProductListVo using getProductListVo method
            List<ProductVo> productVoList = productList.stream().map(product -> {
                ProductVo productVo = new ProductVo();
                productVo.setId(product.getId());
                productVo.setName(product.getName());
                productVo.setProductDescription(product.getProductDescription());
                String productCatalogueUrl = product.getProductCatalogueUrl();
                if (StringUtil.isNotEmpty(productCatalogueUrl)) {
                    JSONArray productCatalogueUrlJson = new JSONArray(productCatalogueUrl);
                    if (!productCatalogueUrlJson.isEmpty()) {
                        productVo.setProductCatalogueUrl(AwsS3Util.getS3DownloadUrl(productCatalogueUrlJson.getJSONObject(0).getString("download_link")));
                    }
                }
                if (StringUtil.isNotEmpty(product.getImageOfProductUrl())) {
                    productVo.setImageOfProductUrl(AwsS3Util.getS3DownloadUrl(product.getImageOfProductUrl()));
                }

                // Calculate isSoldOut based on trancheSize and total purchasedAmount
                productVo.setIsSoldOut(product.getTrancheSize() <= 0.0);
                return productVo;
            }).toList();

            // Set the converted list in ProductListRespVo
            ProductListRespVo resp = new ProductListRespVo();
            resp.setProductList(productVoList);

            return resp;
        } catch (Exception ex) {
            // Return an error response if there is an exception
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object getProductById(Long id) {
        try {
            Product product = productDao.findByIdAndIsPublishedIsTrueAndStatusIsTrue(id).orElseThrow(() -> new GeneralException(INVALID_PRODUCT));

            ProductDetailsRespVo detailsVo = new ProductDetailsRespVo();
            detailsVo.setName(product.getName());
            detailsVo.setProductCode(product.getCode());
            detailsVo.setProductDescription(product.getProductDescription());
            detailsVo.setInvestmentTenureMonth(product.getInvestmentTenureMonth());
            detailsVo.setProductCatalogueUrl(product.getProductCatalogueUrl());
            detailsVo.setImageOfProductUrl(product.getImageOfProductUrl());
            detailsVo.setStatus(product.getStatus());
            detailsVo.setLivingTrustOptionEnabled(product.getEnableLivingTrust());

            Double availableTrancheSize = product.getTrancheSize();

            // Generate list of FundAmountVo
            List<FundAmountVo> fundAmounts = new ArrayList<>();
            Double currentAmount = product.getMinimumSubscriptionAmount();
            Double incremental = product.getIncremental();
            // Retrieve all ProductTargetReturn records for the given productId
            List<ProductTargetReturn> targetReturns = productTargetReturnDao.findByProductId(product.getId());

            while (currentAmount <= availableTrancheSize) {
                // Calculate dividend based on the target return table
                FundAmountVo fundAmountVo = getDividendsBasedOnFundAmounts(currentAmount, targetReturns);
                fundAmounts.add(fundAmountVo);

                // Update total subscription and increment current amount
                currentAmount += incremental;
            }

            detailsVo.setFundAmounts(fundAmounts);
            return detailsVo;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    // Helper method to calculate dividend based on target return table
    private FundAmountVo getDividendsBasedOnFundAmounts(Double amount, List<ProductTargetReturn> targetReturns) {
        FundAmountVo fundAmountVo = new FundAmountVo();
        for (ProductTargetReturn targetReturn : targetReturns) {
            boolean condition = isCondition(amount, targetReturn);
            if (condition) {
                fundAmountVo.setAmount(amount);
                fundAmountVo.setDividend(targetReturn.getTargetReturnPerAnnum());
                return fundAmountVo;
            }
        }
        return fundAmountVo;
    }

    private boolean isCondition(Double amount, ProductTargetReturn targetReturn) {
        ProductConditionType conditionType = targetReturn.getConditionType();
        Double thresholdAmount = targetReturn.getThresholdAmount();
        Double minimum = targetReturn.getMinimum();
        Double maximum = targetReturn.getMaximum();

        return switch (conditionType) {
            case BELOW -> amount <= thresholdAmount;
            case ABOVE -> amount >= thresholdAmount;
            case RANGE -> amount >= minimum && amount <= maximum;
        };
    }

    @Transactional
    public void updateProductTrancheSize(Long productId, Double purchasedAmount) {
        try {
            Product product = productDao.findProductForUpdate(productId);
            if (product.getTrancheSize() < purchasedAmount) {
                throw new GeneralException("Not enough tranche size for product ID: " + productId);
            }
            // Deduct purchased amount
            product.setTrancheSize(product.getTrancheSize() - purchasedAmount);
            productDao.save(product);
        } catch (Exception ex) {
            log.error("Error in updateProductTranchSize", ex);
            throw new GeneralException(ex.getMessage());
        }
    }

    public Object getProductBankDetails(String productCode) {
        try {
            return productDao.findProductBankDetailsByName(productCode);
        } catch (Exception ex) {
            log.error("Error in {} ", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------------Product Order Validation Start-----------------------------------
    //Product order validation one, validate available tranche size
    private void checkAvailableTrancheSize(double requestedAmount, double productTrancheSize) {
        if (productTrancheSize == 0.0) {
            throw new GeneralException(PRODUCT_SOLD_OUT);
        } else if (requestedAmount > productTrancheSize) {
            throw new GeneralException(AMOUNT_EXCEEDS_AVAILABLE_LIMIT);
        }
    }

    public Object productOrderValidationCheckpointOne(String apiKey, ProductPurchaseReqVo productPurchaseReqVo) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        try {
            ProductPurchaseProductDetailsVo productDetails = productPurchaseReqVo.getProductDetails();
            JSONArray validationErrors = ValidatorUtil.getAllNullFields(productDetails);
            if (!validationErrors.isEmpty()) {
                return getInvalidArgumentError(validationErrors);
            }
            if (appUserSession.getAppUser().getUserType().equals(CLIENT)) {
                //Client validation
                Client client = clientDao.findByAppUser(appUserSession.getAppUser()).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
            } else {
                //Agent validation
                Agent agent = agentDao.findByAppUserAndStatus(appUserSession.getAppUser(), Agent.AgentStatus.ACTIVE).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
            }
            //Product validation
            Product product = productDao.findByIdAndIsPublishedIsTrueAndStatusIsTrue(productDetails.getProductId()).orElseThrow(() -> new GeneralException(INVALID_PRODUCT));
            //TrancheSize validation
            checkAvailableTrancheSize(productDetails.getAmount(), product.getTrancheSize());
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //Product order validation two, validate beneficiaries and distribution percentage
    public Object productOrderBeneficiariesDistributionValidation(String apiKey, ProductPurchaseReqVo productPurchaseReqVo) {
        validateApiKey(apiKey);
        try {
            //Beneficiary validation
            List<ProductOrderBeneficiaryReqVo> beneficiaries = productPurchaseReqVo.getBeneficiaries();
            if (beneficiaries.isEmpty()) {
                return getErrorObjectWithMsg(MISSING_REQUIRED_DETAILS);
            }
            //Main beneficiary validation
            double totalMainDistributionPercentage = beneficiaries.stream()
                    .mapToDouble(ProductOrderBeneficiaryReqVo::getDistributionPercentage).sum();
            if (totalMainDistributionPercentage != 100.0) {
                return getErrorObjectWithMsg(INVALID_DISTRIBUTION_PERCENTAGE);
            }
            //Sub beneficiary validation
            if (beneficiaries.size() == 1) {
                ProductOrderBeneficiaryReqVo mainBeneficiary = beneficiaries.get(0);
                List<ProductOrderBeneficiaryReqVo> subBeneficiaries = mainBeneficiary.getSubBeneficiaries();
                if (subBeneficiaries != null && !subBeneficiaries.isEmpty()) {
                    double totalSubDistributionPercentage = subBeneficiaries.stream()
                            .mapToDouble(ProductOrderBeneficiaryReqVo::getDistributionPercentage).sum();
                    if (totalSubDistributionPercentage != 100.0) {
                        return getErrorObjectWithMsg(INVALID_DISTRIBUTION_PERCENTAGE);
                    }
                }
            }
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }
    //-----------------------------------Product Order Validation End-----------------------------------

    //-----------------------------------Product Order Submission Start-----------------------------------
    public static String createOrderReferenceNumber() throws Exception {
        return RandomCodeUtil.generateRandomCode(new RandomCodeBuilder()
                .prefix("ORD" + System.currentTimeMillis())
                .postfix(RandomCodeBuilder.NUMBERS)
                .postfixLength(3));
    }

    @Transactional
    public Object createProductOrder(String apiKey, ProductPurchaseReqVo productPurchaseReq, String referenceNumber) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            Client client;
            CorporateClient corporateClient = null;
            Agent agent;//Agent can never be null

            if (UserType.AGENT.equals(appUser.getUserType())) {
                //TODO if request by Agent check for secure tag
                agent = agentDao.findByAppUserAndStatus(appUser, Agent.AgentStatus.ACTIVE).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
                if (StringUtils.isNotEmpty(productPurchaseReq.getClientId()) && StringUtil.isEmpty(productPurchaseReq.getCorporateClientId())) {
                    client = clientDao.findByAgentAndClientId(agent, productPurchaseReq.getClientId()).orElseThrow(() -> new GeneralException(INVALID_CLIENT_ID));
                } else if (StringUtils.isNotEmpty(productPurchaseReq.getCorporateClientId()) && StringUtil.isEmpty(productPurchaseReq.getClientId())) {
                    corporateClient = corporateClientDao.findByCorporateClientIdAndAgentAndIsDeletedIsFalse(productPurchaseReq.getCorporateClientId(), agent).orElseThrow(() -> new GeneralException(CORPORATE_CLIENT_NOT_FOUND));
                    client = corporateClient.getClient();
                } else {
                    return getErrorObjectWithMsg(INVALID_REQUEST);
                }
            } else {
                client = clientDao.findByAppUser(appUser).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
                if (StringUtils.isNotEmpty(productPurchaseReq.getCorporateClientId())) {
                    corporateClient = corporateClientDao.findByClientAndCorporateClientIdAndIsDeletedIsFalse(client, productPurchaseReq.getCorporateClientId()).orElseThrow(() -> new GeneralException(CORPORATE_CLIENT_NOT_FOUND));
                }
                agent = client.getAgent();
                if (agent == null) {
                    return getErrorObjectWithMsg(AGENT_OF_CLIENT_NOT_FOUND);
                }
            }

            if (corporateClient != null) {
                Object corporateValidationResp = validatorService.corporateProductOrderValidation(corporateClient);
                if (corporateValidationResp instanceof ErrorResp) {
                    return corporateValidationResp;
                }
            }

            ProductOrder productOrder = null;
            if (StringUtil.isNotEmpty(referenceNumber)) {
                //Get existing product order details and set back in request
                productOrder = productOrderDao.findByOrderReferenceNumber(referenceNumber).orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));
                // Allow editing only when status is DRAFT or REJECTED
                if (!(ProductOrder.ProductOrderStatus.DRAFT.equals(productOrder.getStatus()) ||
                        ProductOrder.ProductOrderStatus.REJECTED.equals(productOrder.getStatus()) ||
                        ProductOrder.ProductOrderStatus.PENDING_PAYMENT.equals(productOrder.getStatus()))) {
                    return getErrorObjectWithMsg(ITEM_CANNOT_BE_EDITED);
                }

                ProductPurchaseProductDetailsVo productDetails = productPurchaseReq.getProductDetails();
                if (productDetails == null) {
                    productDetails = new ProductPurchaseProductDetailsVo();
                }
                if (productDetails.getProductId() == null) {
                    productDetails.setProductId(productOrder.getProduct().getId());
                }
                if (productDetails.getAmount() == null) {
                    productDetails.setAmount(productOrder.getPurchasedAmount());
                }
                if (productDetails.getDividend() == null) {
                    productDetails.setDividend(productOrder.getDividend());
                }
                if (productDetails.getInvestmentTenureMonth() == null) {
                    productDetails.setInvestmentTenureMonth(productOrder.getInvestmentTenureMonth());
                }
                productPurchaseReq.setProductDetails(productDetails);

                if (productPurchaseReq.getClientBankId() == null) {
                    productPurchaseReq.setClientBankId(productOrder.getBank() != null ? productOrder.getBank().getId() : null);
                }

                if (productPurchaseReq.getBeneficiaries() == null) {
                    List<FundBeneficiaryDetailsVo> productBeneficiaries = getProductBeneficiariesDetails(productOrder);
                    if (productBeneficiaries != null && !productBeneficiaries.isEmpty()) {
                        List<ProductOrderBeneficiaryReqVo> beneficiaries = getProductOrderBeneficiaryReqVos(productBeneficiaries);
                        productPurchaseReq.setBeneficiaries(beneficiaries);
                    }
                }

                if (productPurchaseReq.getPaymentMethod() == null) {
                    productPurchaseReq.setPaymentMethod(productOrder.getPaymentMethod());
                }
            }

            //Product order validation one, validate available tranche size
            Object checkpointOneResp = productOrderValidationCheckpointOne(apiKey, productPurchaseReq);
            if (checkpointOneResp instanceof ErrorResp) {
                return checkpointOneResp;
            }

            Product product = productDao.findById(productPurchaseReq.getProductDetails().getProductId()).orElseThrow(() -> new GeneralException(INVALID_PRODUCT));
            if (productOrder == null) {
                productOrder = new ProductOrder();
                productOrder.setOrderReferenceNumber(createOrderReferenceNumber());
                productOrder.setProductOrderType(ProductOrderType.NEW);
                if (corporateClient != null) {
                    productOrder.setCorporateClient(corporateClient);
                    productOrder.setClientName(corporateClient.getCorporateDetails().getEntityName());
                } else {
                    productOrder.setClient(client);
                    productOrder.setClientName(client.getUserDetail().getName());
                }
                productOrder.setEnableLivingTrust(productPurchaseReq.getLivingTrustOptionEnabled() != null && productPurchaseReq.getLivingTrustOptionEnabled());
                productOrder.setIsProrated(product.getIsProrated());
                productOrder.setAgent(agent);
                productOrder.setAgency(agent.getAgency());
                productOrder.setCreatedAt(new Date());
                productOrder.setCreatedBy(appUser);
            }
            productOrder.setProduct(product);
            productOrder.setPurchasedAmount(productPurchaseReq.getProductDetails().getAmount());
            productOrder.setDividend(productPurchaseReq.getProductDetails().getDividend());
            productOrder.setInvestmentTenureMonth(productPurchaseReq.getProductDetails().getInvestmentTenureMonth());
            productOrder.setStatus(ProductOrder.ProductOrderStatus.DRAFT);
            productOrder.setUpdatedAt(new Date());
            productOrder.setUpdatedBy(appUser);
            productOrder = productOrderDao.save(productOrder);

            //Bank details
            productOrder.setRemark("Pending Bank Details");
            if (productPurchaseReq.getClientBankId() != null) {
                BankDetails bank;
                if (corporateClient != null) {
                    bank = bankDetailsDao.findByIdAndCorporateClientAndIsDeletedFalse(productPurchaseReq.getClientBankId(), corporateClient).orElseThrow(() -> new GeneralException(BANK_DETAILS_NOT_FOUND));
                } else {
                    bank = bankDetailsDao.findByIdAndAppUserAndIsDeletedFalse(productPurchaseReq.getClientBankId(), client.getAppUser()).orElseThrow(() -> new GeneralException(BANK_DETAILS_NOT_FOUND));
                }
                productOrder.setBank(bank);
                productOrder.setUpdatedAt(new Date());
                productOrder.setUpdatedBy(appUser);
                productOrder.setStatus(ProductOrder.ProductOrderStatus.DRAFT);
                productOrder.setRemark(null);
                productOrder.setRemark("Pending Beneficiary Details");
                productOrder = productOrderDao.save(productOrder);
            }

            //Beneficiaries
            List<FundBeneficiaryDetailsVo> productBeneficiaries = null;
            if (productPurchaseReq.getBeneficiaries() != null && !productPurchaseReq.getBeneficiaries().isEmpty()) {
                Object checkpointTwoResp = productOrderBeneficiariesDistributionValidation(apiKey, productPurchaseReq);
                if (checkpointTwoResp instanceof ErrorResp) {
                    return checkpointTwoResp;
                }
                productBeneficiaries = saveProductOrderBeneficiary(productOrder, productPurchaseReq.getBeneficiaries());
                productOrder.setUpdatedAt(new Date());
                productOrder.setUpdatedBy(appUser);
                productOrder.setStatus(ProductOrder.ProductOrderStatus.DRAFT);
                productOrder.setRemark("Pending Payment");
                productOrder = productOrderDao.save(productOrder);
            }

            if (productOrder.getBank() != null && productBeneficiaries != null) {
                productOrder.setStatus(ProductOrder.ProductOrderStatus.PENDING_PAYMENT);
                productOrder.setPaymentStatus(Status.PENDING);
                //Reserve available tranch size
                updateProductTrancheSize(productOrder.getProduct().getId(), productOrder.getPurchasedAmount());
            }

            //Payment Method
            if (productPurchaseReq.getPaymentMethod() != null) {
                productOrder.setPaymentMethod(productPurchaseReq.getPaymentMethod());
                productOrder.setUpdatedAt(new Date());
                productOrder.setUpdatedBy(appUser);
                productOrder.setStatus(ProductOrder.ProductOrderStatus.PENDING_PAYMENT);
                productOrder.setRemark("Pending Payment");
                productOrder = productOrderDao.save(productOrder);
            }

            if (productOrder.getBank() != null && productBeneficiaries != null && productOrder.getPaymentMethod() != null) {
                Object checkpointTwoResp = productOrderBeneficiariesDistributionValidation(apiKey, productPurchaseReq);
                if (checkpointTwoResp instanceof ErrorResp) {
                    return checkpointTwoResp;
                }

                boolean sendReview = false;

                //Check for payment receipt upload
                if (PaymentMethod.MANUAL_TRANSFER.equals(productOrder.getPaymentMethod())) {
                    if (productOrderPaymentReceiptDao.existsByProductOrderAndUploadStatus(productOrder, ProductOrderPaymentReceipt.UploadStatus.UPLOADED)) {
                        sendReview = true;
                    }
                }

                if (sendReview) {
                    // Check if re-submit and send email to CBT
                    if (CmsAdmin.CheckerStatus.REJECT_CHECKER.equals(productOrder.getStatusChecker()) || CmsAdmin.FinanceStatus.REJECT_FINANCE.equals(productOrder.getStatusFinance()) || CmsAdmin.ApproverStatus.REJECT_APPROVER.equals(productOrder.getStatusApprover())) {
                        emailService.sendProductOrderInReviewEmail(productOrder);
                    }

                    productOrder.setRemark("In Review");
                    productOrder.setStatus(ProductOrder.ProductOrderStatus.IN_REVIEW);
                    productOrder.setSubmissionDate(new Date());
                    // Approver rejection flow if submit for review again after rejected by approver, but if finance already approved, dont change status
                    //FINANCE
                    if (!CmsAdmin.FinanceStatus.APPROVE_FINANCE.equals(productOrder.getStatusFinance())) {
                        productOrder.setStatusFinance(CmsAdmin.FinanceStatus.PENDING_FINANCE);
                    }
                    //CHECKER
                    if (!CmsAdmin.CheckerStatus.APPROVE_CHECKER.equals(productOrder.getStatusChecker())) {
                        productOrder.setStatusChecker(CmsAdmin.CheckerStatus.PENDING_CHECKER);
                    }
                    //APPROVER
                    // If rejected by approver and submit for review -> regenerate the agreement
                    if (productOrder.getStatusApprover() != null && !CmsAdmin.ApproverStatus.APPROVE_APPROVER.equals(productOrder.getStatusApprover()) && StringUtil.isNotEmpty(productOrder.getAgreementKey())) {
                        // Generate PDF and store agreement file
                        generateSignedAndUnsignedAgreements(productOrder);
                    }
                    productOrder.setStatusApprover(CmsAdmin.ApproverStatus.PENDING_APPROVER);
                }

                productOrder.setUpdatedAt(new Date());
                productOrder.setUpdatedBy(appUser);
                productOrder = productOrderDao.save(productOrder);
            }
            if (UserType.AGENT.equals(appUser.getUserType())) {
                // Notify client to make payment
                String title = "Pending Payment for " + product.getName();
                String message = "Your agent has placed a trust product " + product.getName() + " for you. Proceed to pay now.";

                AppUser notifyTo;
                if (productOrder.getCorporateClient() != null) {
                    notifyTo = productOrder.getCorporateClient().getClient().getAppUser();
                } else {
                    notifyTo = productOrder.getClient().getAppUser();
                }
                pushNotificationService.notifyAppUser(notifyTo, title, message, new Date(), null, null);
            }
            return getProductOrderSummary(productOrder);
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    private List<ProductOrderBeneficiaryReqVo> getProductOrderBeneficiaryReqVos(List<FundBeneficiaryDetailsVo> productBeneficiaries) {
        List<ProductOrderBeneficiaryReqVo> beneficiaries = new ArrayList<>();
        for (FundBeneficiaryDetailsVo mainBeneficiary : productBeneficiaries) {
            ProductOrderBeneficiaryReqVo mainBeneficiaryReq = new ProductOrderBeneficiaryReqVo();
            mainBeneficiaryReq.setBeneficiaryId(mainBeneficiary.getBeneficiaryId());
            mainBeneficiaryReq.setDistributionPercentage(mainBeneficiary.getDistributionPercentage());
            List<ProductOrderBeneficiaryReqVo> subBeneficiaries = getProductOrderSubBeneficiaryReqVos(mainBeneficiary);
            mainBeneficiaryReq.setSubBeneficiaries(subBeneficiaries);
            beneficiaries.add(mainBeneficiaryReq);
        }
        return beneficiaries;
    }

    private List<ProductOrderBeneficiaryReqVo> getProductOrderSubBeneficiaryReqVos(FundBeneficiaryDetailsVo mainBeneficiary) {
        List<ProductOrderBeneficiaryReqVo> subBeneficiaries = new ArrayList<>();
        if (mainBeneficiary.getSubBeneficiaries() != null && !mainBeneficiary.getSubBeneficiaries().isEmpty()) {
            for (FundBeneficiaryDetailsVo subBeneficiary : mainBeneficiary.getSubBeneficiaries()) {
                ProductOrderBeneficiaryReqVo subBeneficiaryReq = new ProductOrderBeneficiaryReqVo();
                subBeneficiaryReq.setBeneficiaryId(subBeneficiary.getBeneficiaryId());
                subBeneficiaryReq.setDistributionPercentage(subBeneficiary.getDistributionPercentage());
                subBeneficiaries.add(subBeneficiaryReq);
            }
        }
        return subBeneficiaries;
    }

    @Transactional
    public List<FundBeneficiaryDetailsVo> saveProductOrderBeneficiary(ProductOrder productOrder, List<ProductOrderBeneficiaryReqVo> beneficiaries) {
        //Delete any existing product beneficiaries related to this order before saving new ones
        List<ProductBeneficiaries> productBeneficiaries = distributionBeneficiaryDao.findByProductOrder(productOrder);
        if (!productBeneficiaries.isEmpty()) {
            distributionBeneficiaryDao.deleteAll(productBeneficiaries);
        }
        Client client = productOrder.getClient();
        List<FundBeneficiaryDetailsVo> mainProductBeneficiariesList = new ArrayList<>();
        // Create main beneficiaries
        for (ProductOrderBeneficiaryReqVo mainBeneficiaryInfo : beneficiaries) {
            ProductBeneficiaries mainBeneficiary = saveBeneficiary(productOrder, mainBeneficiaryInfo, null, null);
            FundBeneficiaryDetailsVo mainBeneficiaryVo = FundBeneficiaryDetailsVo.productOrderBeneficiaryToFundBeneficiaryDetailsVo(mainBeneficiary);
            if (mainBeneficiaryInfo.getSubBeneficiaries() != null && !mainBeneficiaryInfo.getSubBeneficiaries().isEmpty()) {
                // Create sub beneficiaries if present
                List<FundBeneficiaryDetailsVo> subProductBeneficiariesList = new ArrayList<>();
                for (ProductOrderBeneficiaryReqVo subBeneficiaryInfo : mainBeneficiaryInfo.getSubBeneficiaries()) {
                    ProductBeneficiaries subBeneficiary;
                    if (client != null) {
                        subBeneficiary = saveBeneficiary(productOrder, subBeneficiaryInfo, mainBeneficiary.getBeneficiary(), null);
                    } else {
                        subBeneficiary = saveBeneficiary(productOrder, subBeneficiaryInfo, null, mainBeneficiary.getCorporateBeneficiary());
                    }
                    FundBeneficiaryDetailsVo subBeneficiaryVo = FundBeneficiaryDetailsVo.productOrderBeneficiaryToFundBeneficiaryDetailsVo(subBeneficiary);
                    subProductBeneficiariesList.add(subBeneficiaryVo);
                }
                mainBeneficiaryVo.setSubBeneficiaries(subProductBeneficiariesList);
            }
            mainProductBeneficiariesList.add(mainBeneficiaryVo);
        }
        return mainProductBeneficiariesList;
    }

    @Transactional
    public ProductBeneficiaries saveBeneficiary(ProductOrder productOrder, ProductOrderBeneficiaryReqVo beneficiaryInfo, IndividualBeneficiary mainBeneficiary, CorporateBeneficiaries corporateMainBeneficiary) {

        ProductBeneficiaries productBeneficiary = new ProductBeneficiaries();
        productBeneficiary.setProductOrder(productOrder);

        if (productOrder.getClient() != null) {
            IndividualBeneficiary beneficiary = individualBeneficiaryDao.findById(beneficiaryInfo.getBeneficiaryId())
                    .orElseThrow(() -> new GeneralException(INDIVIDUAL_BENEFICIARY_NOT_FOUND));
            productBeneficiary.setBeneficiary(beneficiary);
        } else if (productOrder.getCorporateClient() != null) {
            CorporateBeneficiaries beneficiary = corporateBeneficiaryDao.findById(beneficiaryInfo.getBeneficiaryId())
                    .orElseThrow(() -> new GeneralException(CORPORATE_BENEFICIARY_NOT_FOUND));
            productBeneficiary.setCorporateBeneficiary(beneficiary);
        } else {
            throw new GeneralException(CLIENT_NOT_FOUND);
        }

        productBeneficiary.setPercentage(beneficiaryInfo.getDistributionPercentage());
        if (mainBeneficiary == null && corporateMainBeneficiary == null) {
            productBeneficiary.setType(MAIN_BENEFICIARY);
            productBeneficiary.setMainBeneficiary(null);
            productBeneficiary.setCorporateMainBeneficiary(null);
        } else if (mainBeneficiary != null && corporateMainBeneficiary == null) {
            productBeneficiary.setType(SUB_BENEFICIARY);
            productBeneficiary.setMainBeneficiary(mainBeneficiary);
            productBeneficiary.setCorporateMainBeneficiary(null);
        } else {
            productBeneficiary.setType(SUB_BENEFICIARY);
            productBeneficiary.setMainBeneficiary(null);
            productBeneficiary.setCorporateMainBeneficiary(corporateMainBeneficiary);
        }

        productBeneficiary.setCreatedAt(new Date());
        productBeneficiary.setUpdatedAt(new Date());
        distributionBeneficiaryDao.save(productBeneficiary);

        return productBeneficiary;
    }

    public List<FundBeneficiaryDetailsVo> getProductBeneficiariesDetails(ProductOrder productOrder) {
        List<FundBeneficiaryDetailsVo> mainProductBeneficiariesList = new ArrayList<>();

        // Fetch all product beneficiaries for the given product order
        List<ProductBeneficiaries> productBeneficiaries = distributionBeneficiaryDao.findByProductOrder(productOrder);
        if (productBeneficiaries.isEmpty()) {
            return mainProductBeneficiariesList; // If no beneficiaries, return empty list
        }

        // This map is used to store main beneficiaries and their sub-beneficiaries
        Map<Long, FundBeneficiaryDetailsVo> mainBeneficiariesMap = new HashMap<>();

        // Iterate over product beneficiaries
        for (ProductBeneficiaries productBeneficiary : productBeneficiaries) {
            // Check if this is a main beneficiary
            if (MAIN_BENEFICIARY.equals(productBeneficiary.getType())) {
                FundBeneficiaryDetailsVo fundBeneficiaryDetailsVo = new FundBeneficiaryDetailsVo();
                if (productOrder.getClient() != null) {
                    fundBeneficiaryDetailsVo.setBeneficiaryId(productBeneficiary.getBeneficiary().getId());
                    fundBeneficiaryDetailsVo.setBeneficiaryName(productBeneficiary.getBeneficiary().getFullName());
                    fundBeneficiaryDetailsVo.setRelationship(productBeneficiary.getBeneficiary().getRelationshipToSettlor());
                } else {
                    fundBeneficiaryDetailsVo.setBeneficiaryId(productBeneficiary.getCorporateBeneficiary().getId());
                    fundBeneficiaryDetailsVo.setBeneficiaryName(productBeneficiary.getCorporateBeneficiary().getFullName());
                    fundBeneficiaryDetailsVo.setRelationship(productBeneficiary.getCorporateBeneficiary().getRelationshipToSettlor());
                }
                fundBeneficiaryDetailsVo.setDistributionPercentage(productBeneficiary.getPercentage());

                // Initialize an empty list for sub-beneficiaries
                fundBeneficiaryDetailsVo.setSubBeneficiaries(new ArrayList<>());

                // Add the main beneficiary to the map
                if (productOrder.getClient() != null) {
                    mainBeneficiariesMap.put(productBeneficiary.getBeneficiary().getId(), fundBeneficiaryDetailsVo);
                } else {
                    mainBeneficiariesMap.put(productBeneficiary.getCorporateBeneficiary().getId(), fundBeneficiaryDetailsVo);
                }
            }
        }

        // Now add sub-beneficiaries to their respective main beneficiaries
        for (ProductBeneficiaries subBeneficiary : productBeneficiaries) {
            if (SUB_BENEFICIARY.equals(subBeneficiary.getType()) &&
                    (subBeneficiary.getMainBeneficiary() != null || subBeneficiary.getCorporateMainBeneficiary() != null)) {
                // Find the corresponding main beneficiary
                FundBeneficiaryDetailsVo mainBeneficiary;
                if (subBeneficiary.getMainBeneficiary() != null) {
                    mainBeneficiary = mainBeneficiariesMap.get(subBeneficiary.getMainBeneficiary().getId());
                } else {
                    mainBeneficiary = mainBeneficiariesMap.get(subBeneficiary.getCorporateMainBeneficiary().getId());
                }
                if (mainBeneficiary != null) {
                    FundBeneficiaryDetailsVo subBeneficiaryVo = new FundBeneficiaryDetailsVo();
                    if (subBeneficiary.getBeneficiary() != null) {
                        subBeneficiaryVo.setBeneficiaryId(subBeneficiary.getBeneficiary().getId());
                        subBeneficiaryVo.setBeneficiaryName(subBeneficiary.getBeneficiary().getFullName());
                        subBeneficiaryVo.setRelationship(subBeneficiary.getBeneficiary().getRelationshipToSettlor());
                    } else {
                        subBeneficiaryVo.setBeneficiaryId(subBeneficiary.getCorporateBeneficiary().getId());
                        subBeneficiaryVo.setBeneficiaryName(subBeneficiary.getCorporateBeneficiary().getFullName());
                        subBeneficiaryVo.setRelationship(subBeneficiary.getCorporateBeneficiary().getRelationshipToSettlor());
                    }

                    subBeneficiaryVo.setDistributionPercentage(subBeneficiary.getPercentage());

                    // Add the sub-beneficiary to the main beneficiary's subBeneficiaries list
                    mainBeneficiary.getSubBeneficiaries().add(subBeneficiaryVo);
                }
            }
        }

        // Now collect all main beneficiaries (and their sub-beneficiaries)
        mainProductBeneficiariesList.addAll(mainBeneficiariesMap.values());

        return mainProductBeneficiariesList;
    }

    public Object getProductBeneficiaries(String apiKey, String referenceNumber) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(referenceNumber).orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));
            ProductPurchaseBeneficiariesRespVo resp = new ProductPurchaseBeneficiariesRespVo();
            resp.setProductBeneficiaries(getProductBeneficiariesDetails(productOrder));
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    private ProductOrderSummaryRespVo getProductOrderSummary(ProductOrder productOrder) {
        ProductOrderSummaryRespVo resp = new ProductOrderSummaryRespVo();
        resp.setProductOrderStatus(productOrder.getStatus());
        resp.setProductId(productOrder.getProduct().getId());
        resp.setProductOrderReferenceNumber(productOrder.getOrderReferenceNumber());
        resp.setProductName(productOrder.getProduct().getName());
        resp.setPurchasedAmount(productOrder.getPurchasedAmount());
        resp.setDividend(productOrder.getDividend());
        resp.setInvestmentTenureMonth(productOrder.getInvestmentTenureMonth());
        resp.setBankDetails(productOrder.getBank() != null ? BankDetailsVo.bankDetailsToBankDetailsVo(productOrder.getBank()) : null);
        resp.setProductBeneficiaries(getProductBeneficiariesDetails(productOrder));
        resp.setPaymentDetails(ProductOrderPaymentDetailsBaseVo.productOrderToPaymentDetailsBaseVo(productOrder));
        return resp;
    }
    //-----------------------------------Product Order Submission End-----------------------------------

    //-----------------------------------Product Order Delete Start-----------------------------------
    public Object deleteProductOrder(String apiKey, String referenceNumber) {
        validateApiKey(apiKey);
        try {
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(referenceNumber).orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));
            if (!ProductOrder.ProductOrderStatus.DRAFT.equals(productOrder.getStatus())) {
                return getErrorObjectWithMsg(PRODUCT_ORDER_CANNOT_BE_DELETED);
            }
            // Find and delete product beneficiaries records
            List<ProductBeneficiaries> productBeneficiaries = distributionBeneficiaryDao.findByProductOrder(productOrder);
            if (!productBeneficiaries.isEmpty()) {
                distributionBeneficiaryDao.deleteAll(productBeneficiaries);
            }
            productOrderDao.delete(productOrder);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }
    //-----------------------------------Product Order Delete End-----------------------------------

    //-----------------------------------Product Order Payment Receipt Start-----------------------------------
    @Transactional
    public Object uploadPaymentReceipt(String apiKey, String referenceNumber, ProductOrderPaymentUploadReqVo uploadReq, boolean isDraft) {
        validateApiKey(apiKey);
        try {
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(referenceNumber).orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));
            List<ProductOrderPaymentReceiptVo> receiptVos = uploadReq.getReceipts();

            List<ProductOrderPaymentReceipt> existingReceipts = productOrderPaymentReceiptDao.findAllByProductOrder(productOrder);
            Map<Long, ProductOrderPaymentReceipt> existingReceiptMap = existingReceipts.stream()
                    .collect(Collectors.toMap(ProductOrderPaymentReceipt::getId, receipt -> receipt));

            List<Long> passedIds = receiptVos.stream().map(ProductOrderPaymentReceiptVo::getId).toList();
            // Create a copy of existingIds to avoid modifying the original list
            List<Long> idsToDelete = new ArrayList<>(existingReceiptMap.keySet());
            // Remove all IDs that are in passedIds
            idsToDelete.removeAll(passedIds);
            // Delete all remaining IDs
            idsToDelete.forEach(
                    id -> {
                        ProductOrderPaymentReceipt receipt = existingReceiptMap.get(id);
                        AwsS3Util.deleteFile(receipt.getPaymentReceiptKey());
                        productOrderPaymentReceiptDao.delete(receipt);
                    }
            );

            int count = existingReceiptMap.size();
            for (int i = 0; i < receiptVos.size(); i++) {
                ProductOrderPaymentReceiptVo receiptVo = receiptVos.get(i);
                ProductOrderPaymentReceipt paymentReceipt = existingReceiptMap.get(receiptVo.getId());
                // To create or update
                if (paymentReceipt == null) {
                    paymentReceipt = new ProductOrderPaymentReceipt();
                    paymentReceipt.setProductOrder(productOrder);
                    paymentReceipt.setCreatedAt(new Date());
                }
                String receiptFileBase64 = receiptVo.getFile();
                if (!receiptFileBase64.startsWith("http")) {
                    String fileName = StringUtil.isEmpty(receiptVo.getFileName())
                            ? "paymentReceiptFile_" + ((i + 1) + count)
                            : StringUtil.removeFileExtensionFromFileName(receiptVo.getFileName());
                    String paymentReceiptKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                            .base64String(receiptFileBase64)
                            .fileName(fileName)
                            .filePath(S3_PRODUCT_ORDER_PATH + referenceNumber));
                    paymentReceipt.setPaymentReceiptKey(paymentReceiptKey);
                }
                paymentReceipt.setUploadStatus(ProductOrderPaymentReceipt.UploadStatus.DRAFT);
                if (Boolean.FALSE.equals(isDraft)) {
                    paymentReceipt.setUploadStatus(ProductOrderPaymentReceipt.UploadStatus.UPLOADED);
                    productOrder.setRemark("In Review");
//                    productOrder.setStatus(ProductOrder.ProductOrderStatus.IN_REVIEW);
                    productOrder.setPaymentDate(new Date());
                    productOrder.setPaymentStatus(Status.IN_REVIEW);
                    //FINANCE
                    productOrder.setStatusFinance(CmsAdmin.FinanceStatus.PENDING_FINANCE);
                    //CHECKER
                    productOrder.setStatusChecker(CmsAdmin.CheckerStatus.PENDING_CHECKER);
                    //APPROVER
                    productOrder.setStatusApprover(CmsAdmin.ApproverStatus.PENDING_APPROVER);
                    productOrderDao.save(productOrder);
                }
                paymentReceipt.setUpdatedAt(new Date());
                productOrderPaymentReceiptDao.save(paymentReceipt);
            }
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public List<ProductOrderPaymentReceiptVo> getPaymentReceipts(String referenceNumber) {
        ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(referenceNumber).orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));
        List<ProductOrderPaymentReceipt> receiptList = productOrderPaymentReceiptDao.findAllByProductOrder(productOrder);

        List<ProductOrderPaymentReceiptVo> receiptVoList = new ArrayList<>();
        for (ProductOrderPaymentReceipt receipt : receiptList) {
            ProductOrderPaymentReceiptVo receiptVo = ProductOrderPaymentReceiptVo.fromEntity(receipt);
            receiptVoList.add(receiptVo);
        }

        return receiptVoList;
    }

    public Object getUploadedPaymentReceipts(String apiKey, String referenceNumber) {
        validateApiKey(apiKey);
        try {
            ProductOrderPaymentUploadRespVo resp = new ProductOrderPaymentUploadRespVo();
            resp.setPaymentReceipts(getPaymentReceipts(referenceNumber));
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }
    //-----------------------------------Product Order Payment Receipt End-----------------------------------

    //-----------------------------------Trust Fund Agreement Start-----------------------------------
    @Transactional
    public Object getTrustFundAgreement(String apiKey, String referenceNumber) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            AgreementRespVo resp = new AgreementRespVo();
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumberAndStatusAndStatusApprover(referenceNumber, ProductOrder.ProductOrderStatus.ACTIVE, CmsAdmin.ApproverStatus.APPROVE_APPROVER);
            // Agreement is only accessible if approved
            if (productOrder == null) {
                return resp;
            }
            // Agreement is only accessible for agent if approved and client has signed it
            if (UserType.AGENT.equals(appUser.getUserType()) && !Status.SUCCESS.equals(productOrder.getClientAgreementStatus())) {
                return resp;
            }

            if (UserType.CLIENT.equals(appUser.getUserType()) && Status.SUCCESS.equals(productOrder.getClientAgreementStatus())) {
                return getErrorObjectWithMsg(AGREEMENT_SIGNED);
            }
            if (UserType.AGENT.equals(appUser.getUserType()) && Status.SUCCESS.equals(productOrder.getWitnessAgreementStatus())) {
                return getErrorObjectWithMsg(AGREEMENT_SIGNED);
            }

            String template;
            if (productOrder.getCorporateClient() != null) {
                template = pdfService.prefillTrustProductAgreementCorporate(appUser.getUserType(), productOrder, null, null, null, Boolean.FALSE);
            } else {
                template = pdfService.prefillTrustProductAgreementIndividual(appUser.getUserType(), productOrder, null, null, null, Boolean.FALSE);
            }

            resp.setHtml(template);
            // Generate PDF and store to get URL
            byte[] pdfByte = pdfService.generateTrustProductAgreementPdf(appUser.getUserType(), productOrder, null, null, Boolean.FALSE);
            String agreementFileUrl = storeTrustFundAgreementFile(productOrder, pdfByte, true);

            // Set URL in response
            resp.setLink(agreementFileUrl);
            return resp;
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    private void verifyWitnessEligibility(UserType userType, ProductOrder productOrder, String witnessIdentityCardNumber) {
        if (UserType.AGENT.equals(userType)) {
            // Check Witness != Client
            String clientIdentityCardNumber = productOrder.getClientIdentityId();
            String formatClientIdentityCardNumber = clientIdentityCardNumber.replaceAll("-", "");
            String formatWitnessIdentityCardNumber = witnessIdentityCardNumber.replaceAll("-", "");
            if (formatWitnessIdentityCardNumber.equals(formatClientIdentityCardNumber)) {
                throw new GeneralException(INVALID_SIGNER);
            }

            // Check if Witness != Beneficiary
            List<ProductBeneficiaries> productBeneficiariesList = productBeneficiariesDao.findAllByProductOrder(productOrder);
            for (ProductBeneficiaries productBeneficiaries : productBeneficiariesList) {
                if (productBeneficiaries.getBeneficiary() != null) {
                    String formatBeneficiaryIdentityCardNumber = productBeneficiaries.getBeneficiary().getIdentityCardNumber().replaceAll("-", "");
                    if (formatBeneficiaryIdentityCardNumber.equals(formatWitnessIdentityCardNumber)) {
                        throw new GeneralException(INVALID_SIGNER);
                    }
                }
                if (productBeneficiaries.getCorporateBeneficiary() != null) {
                    String formatCorporateBeneficiaryIdentityCardNumber = productBeneficiaries.getCorporateBeneficiary().getIdentityCardNumber().replaceAll("-", "");
                    if (formatCorporateBeneficiaryIdentityCardNumber.equals(formatWitnessIdentityCardNumber)) {
                        throw new GeneralException(INVALID_SIGNER);
                    }
                }
            }
        }
    }

    public Object submitTrustFundAgreementPreVerification(String apiKey, String orderReferenceNumber, TrustFundAgreementReqVo trustFundAgreementReqVo) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            log.info("Trust Fund Agreement Pre-Verification Request: {}", trustFundAgreementReqVo);
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(orderReferenceNumber).orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));

            verifyWitnessEligibility(appUser.getUserType(), productOrder, trustFundAgreementReqVo.getIdentityCardNumber());
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    @Transactional
    public Object submitTrustFundAgreement(String apiKey, String orderReferenceNumber, TrustFundAgreementReqVo trustFundAgreementReqVo) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(orderReferenceNumber).orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));

            verifyWitnessEligibility(appUser.getUserType(), productOrder, trustFundAgreementReqVo.getIdentityCardNumber());

            String fileExtension = getFileTypeFromBase64(trustFundAgreementReqVo.getDigitalSignature());
            String signatureBase64 = "data:" + fileExtension + ";base64," + trustFundAgreementReqVo.getDigitalSignature();

            byte[] pdfByte = pdfService.generateTrustProductAgreementPdf(appUser.getUserType(), productOrder, signatureBase64, trustFundAgreementReqVo, Boolean.FALSE);

            // Store agreement file and get URL
            storeTrustFundAgreementFile(productOrder, pdfByte, false);

            if (UserType.CLIENT.equals(appUser.getUserType())) {
                String digitalSignatureBase64 = signatureBase64.substring(signatureBase64.indexOf(",") + 1);
                // Extract the actual Base64 content if it's a data URL
                String clientSignatureKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(digitalSignatureBase64)
                        .fileName("clientSignature")
                        .filePath(S3_PRODUCT_ORDER_PATH + productOrder.getOrderReferenceNumber()));
                productOrder.setClientSignatureKey(clientSignatureKey);
                productOrder.setClientSignatureDate(LocalDate.now());
                productOrder.setClientAgreementStatus(Status.SUCCESS);
                productOrder.setClientRole(trustFundAgreementReqVo.getRole());

                // Check if corporate client with Private/Public Limited entity requires second signee
                boolean requiresSecondSignee = productOrder.isCorporateClientWithSecondSigneeRequirement();

                if (requiresSecondSignee) {
                    productOrder.setClientTwoAgreementStatus(Status.PENDING);
                    productOrder.setRemark("Pending 2nd Signee");
                } else {
                    productOrder.setRemark("Pending Witness Signature");
                    //Send message to Agent for Witness Signature
                    String title = "Pending Witness Signature";
                    String message = "Need your signature! One of your clients has purchased a trust product.";
                    pushNotificationService.notifyAppUser(productOrder.getAgent().getAppUser(), title, message, new Date(), null, null);
                }
            }
            if (UserType.AGENT.equals(appUser.getUserType())) {
                productOrder.setWitnessSignatureDate(LocalDate.now());
                productOrder.setWitnessAgreementStatus(Status.SUCCESS);
                productOrder.setRemark(null);
            }
            productOrder = productOrderDao.save(productOrder);

            if (Status.SUCCESS.equals(productOrder.getWitnessAgreementStatus()) && Status.SUCCESS.equals(productOrder.getClientAgreementStatus())) {
                if (productOrder.requireSecondSigneeSignature() && Status.SUCCESS.equals(productOrder.getClientTwoAgreementStatus())) {
                    Attachment attachment = new Attachment(Base64.getEncoder().encodeToString(pdfByte), PDF_FILETYPE, productOrder.getAgreementFileName() + ".pdf");
                    emailService.sendTrustDeedAgreementEmail(productOrder.getClientName(), productOrder.getClientEmail(), attachment);
                }
            }
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    @Transactional
    public String storeTrustFundAgreementFile(ProductOrder productOrder, byte[] pdfByte, boolean returnUrl) {
        try {
            if (pdfByte == null || pdfByte.length == 0) {
                log.error("Invalid PDF byte array: {}", pdfByte == null ? "null" : "empty");
                throw new GeneralException("Invalid PDF byte array");
            }

            String agreementFileName = productOrder.getAgreementFileName();
            if (StringUtil.isEmpty(agreementFileName)) {
                UserType agreementUserType = (productOrder.getCorporateClient() != null) ? UserType.CORPORATE_CLIENT : UserType.CLIENT;

                agreementFileName = DigitalIDUtil.createAgreementID(new DigitalIDBuilder()
                        .builderType(DigitalIDBuilder.BuilderType.PRODUCT_ORDER)
                        .name(productOrder.getProduct().getCode())
                        .userType(agreementUserType)
                        .date(productOrder.getSubmissionDate()));
                productOrder.setAgreementFileName(agreementFileName);
                productOrder = productOrderDao.save(productOrder);
            }

            String trustOrderAgreementBase64 = Base64.getEncoder().encodeToString(pdfByte);
            String agreementKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(trustOrderAgreementBase64)
                    .fileName(agreementFileName)
                    .filePath(S3_PRODUCT_ORDER_PATH + productOrder.getOrderReferenceNumber()));

            productOrder.setAgreementKey(agreementKey);
            productOrderDao.save(productOrder);

            // If returnUrl is true, return the file URL; otherwise, return null
            return returnUrl ? AwsS3Util.getS3DownloadUrl(agreementKey) : null;
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
            throw new GeneralException("Error storing agreement file: " + ex.getMessage());
        }
    }

    @Async
    public void storeUnsignedTrustFundAgreementFile(ProductOrder productOrder, byte[] pdfByte) {
        try {
            if (pdfByte == null || pdfByte.length == 0) {
                log.error("Invalid PDF byte array: {}", pdfByte == null ? "null" : "empty");
                throw new GeneralException("Invalid PDF byte array");
            }

            String agreementFileName = productOrder.getAgreementFileName();
            if (StringUtil.isEmpty(agreementFileName)) {
                log.error("Agreement file name is empty for ProductOrder: {}", productOrder.getOrderReferenceNumber());
                throw new GeneralException("Agreement file name is empty");
            }

            String unsignedAgreementFileName = agreementFileName + "_unsigned";

            String trustOrderAgreementBase64 = Base64.getEncoder().encodeToString(pdfByte);
            String unsignedAgreementKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(trustOrderAgreementBase64)
                    .fileName(unsignedAgreementFileName)
                    .filePath(S3_PRODUCT_ORDER_PATH + productOrder.getOrderReferenceNumber()));

            productOrder.setUnsignedAgreementKey(unsignedAgreementKey);
            productOrderDao.save(productOrder);
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
            throw new GeneralException("Error storing agreement file: " + ex.getMessage());
        }
    }

    @Transactional
    public Object getSecondSigneeAgreementLink(String apiKey, String orderReferenceNumber) {
        validateApiKey(apiKey);
        try {
            AgreementRespVo resp = new AgreementRespVo();

            // Fetch ProductOrder with same validation as getTrustFundAgreement
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumberAndStatusAndStatusApprover(orderReferenceNumber, ProductOrder.ProductOrderStatus.ACTIVE, CmsAdmin.ApproverStatus.APPROVE_APPROVER);

            if (productOrder == null || !productOrder.requireSecondSigneeSignature()) {
                return resp;
            }

            // Check if ClientTwoSignature already exists for this ProductOrder
            Optional<ClientTwoSignature> existingSignature = clientTwoSignatureDao.findByProductOrder(productOrder);

            String uniqueIdentifier;
            if (existingSignature.isPresent()) {
                // Return existing identifier if not expired
                ClientTwoSignature signature = existingSignature.get();
                if (!signature.getExpiryAt().isAfter(LocalDateTime.now())) {
                    // Create new signature if expired
                    signature.setUniqueIdentifier(UUID.randomUUID().toString());
                    signature.setExpiryAt(LocalDateTime.now().plusHours(24));
                    signature = clientTwoSignatureDao.save(signature);
                }
                uniqueIdentifier = signature.getUniqueIdentifier();
            } else {
                // Create new ClientTwoSignature entity
                ClientTwoSignature newSignature = new ClientTwoSignature();
                newSignature.setProductOrder(productOrder);
                newSignature.setUniqueIdentifier(UUID.randomUUID().toString());
                newSignature.setExpiryAt(LocalDateTime.now().plusHours(24));
                newSignature = clientTwoSignatureDao.save(newSignature);
                uniqueIdentifier = newSignature.getUniqueIdentifier();
            }

            resp.setLink(SECONDSIGNEEWEBPAGELINK + uniqueIdentifier);
            return resp;

        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    @Transactional
    public Object getSecondSigneeAgreementHtml(String uniqueIdentifier) {
        try {
            SecondSigneeAgreementRespVo resp = new SecondSigneeAgreementRespVo();

            // Fetch ClientTwoSignature by unique identifier
            Optional<ClientTwoSignature> signatureOpt = clientTwoSignatureDao.findByUniqueIdentifier(uniqueIdentifier);

            if (signatureOpt.isEmpty()) {
                return getErrorObjectWithMsg("Invalid unique identifier");
            }

            ClientTwoSignature signature = signatureOpt.get();

            // Check if the signature link has expired
            if (signature.getExpiryAt().isBefore(LocalDateTime.now())) {
                return getErrorObjectWithMsg("Agreement link has expired");
            }

            ProductOrder productOrder = signature.getProductOrder();

            // Generate HTML template for corporate agreement
            String template = pdfService.prefillTrustProductAgreementCorporate(UserType.CORPORATE_CLIENT, productOrder, null, null, null, Boolean.FALSE);
            resp.setLink(AwsS3Util.getS3DownloadUrl(productOrder.getAgreementKey()));
            resp.setHtml(template);
            return resp;

        } catch (Exception ex) {
            log.error("Error in getSecondSigneeAgreementHtml: {}", ex.getMessage(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    @Transactional
    public Object submitSecondSigneeAgreement(ClientTwoSignatureReqVo request) {
        try {
            // Fetch ClientTwoSignature by unique identifier
            Optional<ClientTwoSignature> signatureOpt = clientTwoSignatureDao.findByUniqueIdentifier(request.getUniqueIdentifier());

            if (signatureOpt.isEmpty()) {
                return getErrorObjectWithMsg("Invalid unique identifier");
            }

            ClientTwoSignature signature = signatureOpt.get();

            // Check if the signature link has expired
            if (signature.getExpiryAt().isBefore(LocalDateTime.now())) {
                return getErrorObjectWithMsg("Agreement link has expired");
            }

            ProductOrder productOrder = signature.getProductOrder();

            // Validate that the ID number is not null and not equal to the client's ID number
            String requestIdNumber = request.getIdNumber();
            if (requestIdNumber == null || requestIdNumber.trim().isEmpty()) {
                return getErrorObjectWithMsg("ID Number is required");
            }

            // Get client's ID number for validation
            String clientIdNumber = productOrder.getCorporateClient().getClient().getUserDetail().getIdentityCardNumber();
            if (requestIdNumber.equals(clientIdNumber)) {
                return getErrorObjectWithMsg("Second signee ID number cannot be the same as the client's ID number");
            }

            // Extract the actual Base64 content if it's a data URL (similar to submitTrustFundAgreement)
            String signatureBase64 = request.getSignatureImage();
            String digitalSignatureBase64 = signatureBase64.contains(",") ?
                    signatureBase64.substring(signatureBase64.indexOf(",") + 1) : signatureBase64;

            // Upload signature to S3
            String clientTwoSignatureKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(digitalSignatureBase64)
                    .fileName("clientTwoSignature")
                    .filePath(S3_PRODUCT_ORDER_PATH + productOrder.getOrderReferenceNumber()));

            // Update ProductOrder with second signee details
            productOrder.setClientTwoSignatureKey(clientTwoSignatureKey);
            productOrder.setClientTwoSignatureDate(LocalDate.now());
            productOrder.setClientTwoSignatureName(request.getName());
            productOrder.setClientTwoSignatureIdNumber(request.getIdNumber());
            productOrder.setClientTwoRole(request.getRole());
            productOrder.setClientTwoAgreementStatus(Status.SUCCESS);

            // Update remark to indicate waiting for witness signature
            productOrder.setRemark("Pending Witness Signature");

            // Save the updated ProductOrder
            productOrderDao.save(productOrder);

            // Delete the unique identifier record to prevent accessing the 2nd signee signature url
            clientTwoSignatureDao.deleteByUniqueIdentifier(request.getUniqueIdentifier());

            // Send notification to agent for witness signature
            if (productOrder.getAgent() != null && productOrder.getAgent().getAppUser() != null) {
                String title = "Pending Witness Signature";
                String message = "Second signee has signed! Corporate client agreement is ready for witness signature.";
                pushNotificationService.notifyAppUser(productOrder.getAgent().getAppUser(), title, message, new Date(), null, null);
            }
            return new SecondSigneeAgreementRespVo();
        } catch (Exception ex) {
            log.error("Error in submitSecondSigneeAgreement: {}", ex.getMessage(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    @Async
    public void generateSignedAndUnsignedAgreements(ProductOrder productOrder) {
        // Generate PDF and store agreement file
        byte[] pdfByte = pdfService.generateTrustProductAgreementPdf(UserType.CLIENT, productOrder, null, null, Boolean.TRUE);
        storeTrustFundAgreementFile(productOrder, pdfByte, false);
        storeUnsignedTrustFundAgreementFile(productOrder, pdfByte);
    }

    //-----------------------------------Trust Fund Agreement End-----------------------------------

    public ClientPortfolioProductDetailsRespVo getClientPortfolioProductDetailsRespVo(ProductOrder productOrder) {
        ClientPortfolioProductDetailsRespVo resp = new ClientPortfolioProductDetailsRespVo();
        resp.setClientPortfolio(getClientPortfolioVoWithOptions(productOrder));
        resp.setBankDetails(BankDetailsVo.bankDetailsToBankDetailsVo(productOrder.getBank()));
        resp.setFundBeneficiaries(getProductBeneficiariesDetails(productOrder));
        ProductOrderPaymentDetailsVo paymentDetails = ProductOrderPaymentDetailsVo.productOrderToPaymentDetailsVo(productOrder);
        paymentDetails.setPaymentReceipts(getPaymentReceipts(productOrder.getOrderReferenceNumber()));
        resp.setPaymentDetails(paymentDetails);
        resp.setDocuments(ProductOrderDocumentsVo.productOrderToProductOrderDocumentsVo(productOrder));
        resp.setAgreementNumber(productOrder.getAgreementFileName());
        resp.setRolloverAllowed(checkIfProductOrderOptionsIsAllowed(ProductOrderOptions.ROLLOVER, productOrder));
        resp.setFullRedemptionAllowed(checkIfProductOrderOptionsIsAllowed(ProductOrderOptions.FULL_REDEMPTION, productOrder));
        resp.setReallocationAllowed(checkIfProductOrderOptionsIsAllowed(ProductOrderOptions.REALLOCATION, productOrder));
        resp.setEarlyRedemptionAllowed(checkIfProductOrderOptionsIsAllowed(ProductOrderOptions.EARLY_REDEMPTION, productOrder));

        // Check if displayShareAgreementButton should be shown for corporate clients
        if (productOrder.requireSecondSigneeSignature() && !Status.SUCCESS.equals(productOrder.getClientTwoAgreementStatus())) {
            resp.setDisplayShareAgreementButton(true);
        }

        return resp;
    }

    public ClientPortfolioVo getClientPortfolioVoWithOptions(ProductOrder productOrder) {
        ClientPortfolioVo clientPortfolioVo = ClientPortfolioVo.productOrderToClientPortfolioVo(productOrder);

        ProductEarlyRedemptionHistory earlyRedemptionHistory = productEarlyRedemptionHistoryDao.findMostRecentRecord(productOrder.getId());
        ProductRedemption fullRedemptionHistory = productRedemptionDao.findMostRecentRecord(productOrder.getId());
        ProductRolloverHistory rolloverHistory = productRolloverHistoryDao.findMostRecentRecord(productOrder.getId());
        ProductReallocation reallocationHistory = productReallocationDao.findMostRecentRecord(productOrder.getId());

        PortfolioProductOrderOptionsVo optionsVo = PortfolioProductOrderOptionsVo.getMostRecentOption(Arrays.asList(earlyRedemptionHistory, fullRedemptionHistory, rolloverHistory, reallocationHistory));
        clientPortfolioVo.setOptionsVo(optionsVo);

        if (optionsVo != null) {
            if (Status.PENDING.equals(optionsVo.getClientSignatureStatus())) {
                clientPortfolioVo.setStatus(ProductOrder.ProductOrderStatus.AGREEMENT);
                clientPortfolioVo.setRemark("Pending Client Signature");
            }
            if (Status.PENDING.equals(optionsVo.getWitnessSignatureStatus())) {
                clientPortfolioVo.setStatus(ProductOrder.ProductOrderStatus.AGREEMENT);
                clientPortfolioVo.setRemark("Pending Witness Signature");
            }
        }
        return clientPortfolioVo;
    }

    //-----------------------------------Product Order Early Redemption Start-----------------------------------
    //If return 0 , early redemption not allowed
    private double getEarlyRedemptionPenaltyPercentage(ProductOrder productOrder) {
        if (productOrder.getEndTenure() == null || productOrder.getAgreementDate() == null || productOrder.getProduct() == null) {
            return 0;
        }

        LocalDate today = LocalDate.now();

        //If today is after endTenure, the product has matured—early redemption is not allowed.
        if (today.isAfter(productOrder.getEndTenure())) {
            return 0;
        }

        //If the remaining period is 3 months or less, early redemption is not allowed.
        if (!productOrder.getEndTenure().isAfter(today.plusMonths(3))) {
            return 0;
        }

        //Check if early redemption is allowed or there is penalty
        List<ProductEarlyRedemptionConfiguration> configList = productEarlyRedemptionConfigurationDao.findAllByProduct(productOrder.getProduct());
        if (configList.isEmpty()) {
            return 0;
        }

        Map<Integer, ProductEarlyRedemptionConfiguration> configMap = configList.stream()
                .collect(Collectors.toMap(ProductEarlyRedemptionConfiguration::getPeriod, config -> config));

        Set<Integer> monthThresholds = new TreeSet<>(configMap.keySet());

        // Calculate the number of complete months between the agreement date and today
        long monthsDiff = ChronoUnit.MONTHS.between(productOrder.getAgreementDate(), today);

        ProductEarlyRedemptionConfiguration config = null;
        // Find the first threshold that is greater than the months difference
        boolean ruleFound = false;
        for (Integer threshold : monthThresholds) {
            if (monthsDiff < threshold) {
                config = configMap.get(threshold);
                ruleFound = true;
                break;
            }
        }
        if (!ruleFound) {
            //no penalty found -> block redemption
            return 0;
        }
        if (ProductEarlyRedemptionConfiguration.Condition.NOT_ALLOWED.equals(config.getCondition())) {
            return 0;
        }
        return config.getPenaltyPercentage();
    }

    @Transactional
    public Object createEarlyRedemption(String apiKey, ProductEarlyRedemptionReqVo earlyRedemptionReq, Boolean isRedemption) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(earlyRedemptionReq.getOrderReferenceNumber()).orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));
            if (!checkIfProductOrderOptionsIsAllowed(ProductOrderOptions.EARLY_REDEMPTION, productOrder)) {
                return getErrorObjectWithMsg(EARLY_REDEMPTION_NOT_ALLOWED);
            }

            //Check if early redemption is allowed
            double penaltyPercentage = getEarlyRedemptionPenaltyPercentage(productOrder);
            if (penaltyPercentage == 0) {
                return getErrorObjectWithMsg(EARLY_REDEMPTION_NOT_ALLOWED);
            }

            double requestAmount;
            RedemptionMethod withdrawalMethod;
            if (RedemptionMethod.PARTIAL_AMOUNT.equals(earlyRedemptionReq.getWithdrawalMethod())) {
                if (earlyRedemptionReq.getWithdrawalAmount() == null || earlyRedemptionReq.getWithdrawalAmount() <= 0 || earlyRedemptionReq.getWithdrawalAmount() > productOrder.getPurchasedAmount()) {
                    return getErrorObjectWithMsg(INVALID_AMOUNT);
                }
                requestAmount = earlyRedemptionReq.getWithdrawalAmount();
                if (requestAmount == productOrder.getPurchasedAmount()) {
                    withdrawalMethod = RedemptionMethod.ALL;
                } else {
                    withdrawalMethod = RedemptionMethod.PARTIAL_AMOUNT;
                }
            } else {
                withdrawalMethod = RedemptionMethod.ALL;
                requestAmount = productOrder.getPurchasedAmount();
            }

            double penaltyAmount = MathUtil.roundHalfUp(requestAmount * penaltyPercentage / 100);
            double redemptionAmount = MathUtil.roundHalfUp(requestAmount - penaltyAmount);

            ProductEarlyRedemptionRespVo resp = new ProductEarlyRedemptionRespVo();
            resp.setPenaltyPercentage(penaltyPercentage);
            resp.setPenaltyAmount(penaltyAmount);
            resp.setRedemptionAmount(redemptionAmount);

            if (!isRedemption) {
                return resp;
            }

            Agent agent = clientDao.findByAppUser(appUser)
                    .map(Client::getAgent)
                    .orElse(null);

            // Client proceed to redeem
            ProductEarlyRedemptionHistory history = new ProductEarlyRedemptionHistory();
            history.setRedemptionReferenceNumber(RandomCodeUtil.generateRandomCode(new RandomCodeBuilder()
                    .prefix("RED" + System.currentTimeMillis())
                    .postfix(RandomCodeBuilder.NUMBERS)
                    .postfixLength(3)));
            history.setWithdrawalMethod(withdrawalMethod);
            history.setProductOrder(productOrder);
            history.setOrderReferenceNumber(earlyRedemptionReq.getOrderReferenceNumber());
            history.setWithdrawalReason(earlyRedemptionReq.getWithdrawalReason());
            history.setAmount(requestAmount);
            history.setPenaltyAmount(penaltyAmount);
            history.setPenaltyPercentage(penaltyPercentage);
            history.setStatus(Status.PENDING);
            history.setClientSignatureStatus(Status.PENDING);
            history.setWitnessSignatureStatus(null);
            history.setStatusChecker(null);
            history.setStatusApprover(null);
            history.setCreatedAt(new Date());
            history.setUpdatedAt(new Date());
            history.setAgent(agent);
            String supportingDocumentKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(earlyRedemptionReq.getSupportingDocumentKey())
                    .fileName("supportingDocument")
                    .filePath(S3_PRODUCT_EARLY_REDEMPTION_PATH + history.getOrderReferenceNumber()));
            history.setSupportingDocumentKey(supportingDocumentKey);
            history = productEarlyRedemptionHistoryDao.save(history);

            resp.setRedemptionReferenceNumber(history.getRedemptionReferenceNumber());
            return resp;
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    @Transactional
    public String storeEarlyRedemptionAgreementFile(UserType userType, ProductEarlyRedemptionHistory earlyRedemptionHistory, String digitalSignature, byte[] pdfByte, boolean returnUrl) {
        try {
            if (pdfByte == null || pdfByte.length == 0) {
                log.error("Invalid PDF byte array: {}", pdfByte == null ? "null" : "empty");
                throw new GeneralException("Invalid PDF byte array");
            }

            ProductOrder productOrder = earlyRedemptionHistory.getProductOrder();
            LocalDate localDate = LocalDate.now();

            // Save client signature and signedDate if provided
            if (UserType.CLIENT.equals(userType) && digitalSignature != null) {
                // Extract the actual Base64 content if it's a data URL
                String base64Content = digitalSignature;
                if (digitalSignature.startsWith("data:")) {
                    base64Content = digitalSignature.substring(digitalSignature.indexOf(",") + 1);
                }

                String clientSignatureKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(base64Content)
                        .fileName("clientSignature")
                        .filePath(S3_PRODUCT_EARLY_REDEMPTION_PATH + earlyRedemptionHistory.getOrderReferenceNumber()));
                earlyRedemptionHistory.setClientSignatureKey(clientSignatureKey);
                earlyRedemptionHistory.setClientSignatureDate(localDate);
                earlyRedemptionHistory.setClientSignatureStatus(Status.SUCCESS);
                earlyRedemptionHistory.setWitnessSignatureStatus(Status.PENDING);
                earlyRedemptionHistory = productEarlyRedemptionHistoryDao.save(earlyRedemptionHistory);
            }

            String productEarlyRedemptionAgreementBase64 = Base64.getEncoder().encodeToString(pdfByte);
            String agreementKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(productEarlyRedemptionAgreementBase64)
                    .fileName(productOrder.getAgreementFileName() + "_" + earlyRedemptionHistory.getRedemptionReferenceNumber())
                    .filePath(S3_PRODUCT_EARLY_REDEMPTION_PATH + earlyRedemptionHistory.getOrderReferenceNumber()));

            earlyRedemptionHistory.setWithdrawalAgreementKey(agreementKey);
            earlyRedemptionHistory.setUpdatedAt(new Date());
            productEarlyRedemptionHistoryDao.save(earlyRedemptionHistory);

            // If returnUrl is true, return the file URL; otherwise, return null
            return returnUrl ? AwsS3Util.getS3DownloadUrl(agreementKey) : null;
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
            throw new GeneralException(ex.getMessage());
        }
    }

    @Transactional
    public Object getEarlyRedemptionAgreement(String apiKey, String redemptionReferenceNumber) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            AgreementRespVo resp = new AgreementRespVo();
            ProductEarlyRedemptionHistory earlyRedemptionHistory = productEarlyRedemptionHistoryDao.findByRedemptionReferenceNumber(redemptionReferenceNumber).orElseThrow(() -> new GeneralException(EARLY_REDEMPTION_NOT_FOUND));

            //Agent can only view agreement if client has signed it
            if (UserType.AGENT.equals(appUser.getUserType()) && !Status.SUCCESS.equals(earlyRedemptionHistory.getClientSignatureStatus())) {
                return resp;
            }

            if (UserType.CLIENT.equals(appUser.getUserType()) && Status.SUCCESS.equals(earlyRedemptionHistory.getClientSignatureStatus())) {
                return getErrorObjectWithMsg(AGREEMENT_SIGNED);
            }
            if (UserType.AGENT.equals(appUser.getUserType()) && Status.SUCCESS.equals(earlyRedemptionHistory.getWitnessSignatureStatus())) {
                return getErrorObjectWithMsg(AGREEMENT_SIGNED);
            }

            String template = pdfService.prefillWithdrawalAgreement(appUser.getUserType(), earlyRedemptionHistory, null, null);
            resp.setHtml(template);
            // Generate new agreement
            byte[] pdfByte = pdfService.generateWithdrawalAgreementPdf(appUser.getUserType(), earlyRedemptionHistory, null, null);
            String pdfUrl = storeEarlyRedemptionAgreementFile(appUser.getUserType(), earlyRedemptionHistory, null, pdfByte, true);
            resp.setLink(pdfUrl);

            return resp;
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    @Transactional
    public Object submitEarlyRedemptionAgreement(String apiKey, String redemptionReferenceNumber, WithdrawalAgreementReqVo req) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            ProductEarlyRedemptionHistory earlyRedemptionHistory = productEarlyRedemptionHistoryDao.findByRedemptionReferenceNumber(redemptionReferenceNumber).orElseThrow(() -> new GeneralException(EARLY_REDEMPTION_NOT_FOUND));

            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(earlyRedemptionHistory.getOrderReferenceNumber()).orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));
            String witnessName = " ";
            if (UserType.AGENT.equals(appUser.getUserType())) {
                //Check Witness != Clinet
                String witnessIdentityCardNumber = req.getIdentityCardNumber();
                String clientIdentityCardNumber = productOrder.getClientIdentityId();
                String formatClientIdentityCardNumber = clientIdentityCardNumber.replaceAll("-", "");
                String formatWitnessIdentityCardNumber = witnessIdentityCardNumber.replaceAll("-", "");
                if (formatWitnessIdentityCardNumber.equals(formatClientIdentityCardNumber)) {
                    throw new GeneralException(INVALID_SIGNER);
                }

                //Check if Witness != Beneficiary
                List<ProductBeneficiaries> productBeneficiariesList = productBeneficiariesDao.findAllByProductOrder(productOrder);
                for (ProductBeneficiaries productBeneficiaries : productBeneficiariesList) {
                    if (productBeneficiaries.getBeneficiary() != null) {
                        String formatBeneficiaryIdentityCardNumber = productBeneficiaries.getBeneficiary().getIdentityCardNumber().replaceAll("-", "");
                        if (formatBeneficiaryIdentityCardNumber.equals(formatWitnessIdentityCardNumber)) {
                            throw new GeneralException(INVALID_SIGNER);
                        }
                    }
                    if (productBeneficiaries.getCorporateBeneficiary() != null) {
                        String formatCorporateBeneficiaryIdentityCardNumber = productBeneficiaries.getCorporateBeneficiary().getIdentityCardNumber().replaceAll("-", "");
                        if (formatCorporateBeneficiaryIdentityCardNumber.equals(formatWitnessIdentityCardNumber)) {
                            throw new GeneralException(INVALID_SIGNER);
                        }
                    }
                }
                witnessName = StringUtil.isNotEmpty(req.getFullName()) ? req.getFullName() : productOrder.getAgent().getUserDetail().getName();
            }

            String fileExtension = getFileTypeFromBase64(req.getDigitalSignature());
            String signatureBase64 = "data:" + fileExtension + ";base64," + req.getDigitalSignature();

            byte[] pdfByte = pdfService.generateWithdrawalAgreementPdf(appUser.getUserType(), earlyRedemptionHistory, signatureBase64, witnessName);

            // Store agreement file
            storeEarlyRedemptionAgreementFile(appUser.getUserType(), earlyRedemptionHistory, req.getDigitalSignature(), pdfByte, false);

            if (UserType.CLIENT.equals(appUser.getUserType())) {
                //Send message to Agent for Witness Signature
                String title = "Pending Witness Signature";
                String message = "Need your signature! One of your clients has submitted a early redemption request.";
                pushNotificationService.notifyAppUser(earlyRedemptionHistory.getAgent().getAppUser(), title, message, new Date(), null, null);
            }
            if (UserType.AGENT.equals(appUser.getUserType())) {
                earlyRedemptionHistory.setWitnessSignatureStatus(Status.SUCCESS);
                earlyRedemptionHistory.setUpdatedAt(new Date());
                earlyRedemptionHistory.setStatus(Status.IN_REVIEW);
                earlyRedemptionHistory.setStatusChecker(CmsAdmin.CheckerStatus.PENDING_CHECKER);
                earlyRedemptionHistory.setStatusApprover(CmsAdmin.ApproverStatus.PENDING_APPROVER);
                earlyRedemptionHistory = productEarlyRedemptionHistoryDao.save(earlyRedemptionHistory);

                // Send email to admin
                emailService.sendWithdrawalRequestEmailToAdmin(earlyRedemptionHistory);
            }
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }
    //-----------------------------------Product Early Redemption End-----------------------------------

    //-----------------------------------Product Statement Of Account Start-----------------------------------
    public void generateStatementOfAccount(ProductOrder productOrder) {
        try {
            List<ProductDividendCalculationHistory> dividendCalculationHistories = productDividendCalculationHistoryDao.findAllByProductOrderOrderByIdAsc(productOrder);
            // Generate Statement Of Account
            byte[] pdfBytes = pdfService.generateStatementOfAccountPdf(productOrder, dividendCalculationHistories);
            // Upload to S3
            String productOrderStatementOfAccountBase64 = Base64.getEncoder().encodeToString(pdfBytes);
            String productOrderStatementOfAccountFileName = productOrder.getAgreementFileName() + "_profitStatementOfAccount";
            String productOrderStatementOfAccountKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(productOrderStatementOfAccountBase64)
                    .fileName(productOrderStatementOfAccountFileName)
                    .filePath(S3_DIVIDEND_STATEMENT_OF_ACCOUNT_DOCUMENT_PATH + productOrder.getOrderReferenceNumber()));
            productOrder.setSoaKey(productOrderStatementOfAccountKey);
            productOrder.setSoaDate(new Date());
            productOrder.setUpdatedAt(new Date());
            productOrderDao.save(productOrder);
        } catch (Exception ex) {
            log.error("Error in {}", getFunctionName(), ex);
        }
    }
    //-----------------------------------Product Statement Of Account End-----------------------------------

    //Full redemption or Reallocation or Rollover is allowed if the request date is within 3 months before or after the productOrder.endTenure
    public boolean checkIfProductOrderOptionsIsAllowed(ProductOrderOptions option, ProductOrder productOrder) {
        if (productOrder == null || productOrder.getEndTenure() == null) {
            return false;
        }

        LocalDate requestDate = LocalDate.now();
        LocalDate allowedDate = productOrder.getEndTenure().minusMonths(3);

        // Check if any redemption, rollover, or reallocation records exist
        boolean redemptionExists = productRedemptionDao.existsProductRedemptionByProductOrderAndStatusNot(productOrder, Status.REJECTED);
        boolean rolloverExists = productRolloverHistoryDao.existsProductRolloverHistoryByProductOrderAndStatusNot(productOrder, Status.REJECTED);
        boolean reallocationExists = productReallocationDao.existsProductReallocationByProductOrderAndStatusNot(productOrder, Status.REJECTED);
        boolean anyOptionExists = redemptionExists || rolloverExists || reallocationExists;

        return switch (option) {
            case EARLY_REDEMPTION -> {
                // If the penalty percentage is zero, not allowed
                if (getEarlyRedemptionPenaltyPercentage(productOrder) == 0) {
                    yield false;
                }
                if (productEarlyRedemptionHistoryDao.existsByOrderReferenceNumberAndWithdrawalMethodAndStatusIn(productOrder.getOrderReferenceNumber(), RedemptionMethod.ALL, List.of(Status.IN_REVIEW, Status.SUCCESS, Status.APPROVED))) {
                    yield false;
                }
                yield !productEarlyRedemptionHistoryDao.existsByOrderReferenceNumberAndStatus(productOrder.getOrderReferenceNumber(), Status.IN_REVIEW);
            }
            case ROLLOVER, FULL_REDEMPTION ->
                // For rollover and full redemption, no option is allowed if any record exists and only after allowedDate
                    !anyOptionExists && requestDate.isAfter(allowedDate);
            case REALLOCATION -> {
                // For reallocation, disallow if any option exists.
                // Also, reallocation must have a non-empty configuration list.
                List<String> reallocatableCodes = productReallocationConfigurationDao.findAllReallocatableProductCodeByProduct(productOrder.getProduct().getId());
                yield !anyOptionExists && !reallocatableCodes.isEmpty() && requestDate.isAfter(allowedDate);
            }
            default -> false;
        };
    }

    //--------------------------------Product Redemption Full or Partial---------------------------------
    public Object productOrderFullRedemption(String apiKey, String orderReferenceNumber) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(orderReferenceNumber).orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));
            if (!checkIfProductOrderOptionsIsAllowed(ProductOrderOptions.FULL_REDEMPTION, productOrder)) {
                return getErrorObjectWithMsg(FULL_REDEMPTION_NOT_ALLOWED);
            }

            //Only 1 redemption is allowed for each product order, full redemption or partial redemption(created by either rollover or reallocation process)
            ProductRedemption productRedemption = productRedemptionDao.findByProductOrderAndStatusNot(productOrder, Status.REJECTED);
            if (productRedemption != null) {
                return getErrorObjectWithMsg(REDEMPTION_EXIST);
            }
            productRedemption = new ProductRedemption();
            productRedemption.setProductOrder(productOrder);
            productRedemption.setAmount(productOrder.getPurchasedAmount());
            productRedemption.setFundStatus(productOrder.getStatus());
            productRedemption.setRedemptionType(ProductRedemption.RedemptionType.FULL);
            productRedemption.setStatus(Status.IN_REVIEW);
            productRedemption.setCreatedAt(new Date());
            productRedemption.setUpdatedAt(new Date());
            productRedemption.setCreatedBy(appUser);
            productRedemption.setStatusChecker(CmsAdmin.CheckerStatus.PENDING_CHECKER);
            productRedemption.setStatusApprover(CmsAdmin.ApproverStatus.PENDING_APPROVER);
            productRedemption = productRedemptionDao.save(productRedemption);

            emailService.sendRedemptionRequestEmailToAdmin(productRedemption);

            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    private void productOrderPartialRedemption(ProductOrder productOrder, Double amount) {
        try {
            ProductRedemption productRedemption = productRedemptionDao.findByProductOrderAndStatusNot(productOrder, Status.REJECTED);
            if (productRedemption != null) {
                throw new GeneralException(REDEMPTION_EXIST);
            }
            productRedemption = new ProductRedemption();
            productRedemption.setProductOrder(productOrder);
            productRedemption.setFundStatus(productOrder.getStatus());
            productRedemption.setRedemptionType(ProductRedemption.RedemptionType.PARTIAL);
            productRedemption.setAmount(amount);
            productRedemption.setStatus(Status.IN_REVIEW);
            productRedemption.setCreatedAt(new Date());
            productRedemption.setUpdatedAt(new Date());
            productRedemption.setStatusChecker(CmsAdmin.CheckerStatus.PENDING_CHECKER);
            productRedemption.setStatusApprover(CmsAdmin.ApproverStatus.PENDING_APPROVER);
            productRedemption = productRedemptionDao.save(productRedemption);

            emailService.sendRedemptionRequestEmailToAdmin(productRedemption);
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
            throw new GeneralException(ex.getMessage());
        }
    }

    //--------------------------------Product Rollover---------------------------------
    public Object getIncrementalAmountList(String apiKey, String orderReferenceNumber) {
        validateApiKey(apiKey);
        try {
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(orderReferenceNumber).orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));
            double currentAmount = productOrder.getProduct().getMinimumSubscriptionAmount() == null ? 10000.0 : productOrder.getProduct().getMinimumSubscriptionAmount();
            double incremental = productOrder.getProduct().getIncremental() == null ? 10000.0 : productOrder.getProduct().getIncremental();
            double purchasedAmount = productOrder.getPurchasedAmount();

            List<Double> doubleList = new ArrayList<>();
            while (currentAmount < purchasedAmount) {
                doubleList.add(currentAmount);
                currentAmount += incremental;
            }
            doubleList.add(purchasedAmount);

            IncrementalAmountListRespVo resp = new IncrementalAmountListRespVo();
            resp.setAmountList(doubleList);
            return resp;
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    @Transactional
    public Object createRolloverProductOrder(String apiKey, String orderReferenceNumber, RolloverReqVo req) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(orderReferenceNumber).orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));

            if (!checkIfProductOrderOptionsIsAllowed(ProductOrderOptions.ROLLOVER, productOrder)) {
                return getErrorObjectWithMsg(ROLLOVER_NOT_ALLOWED);
            }

            //Only 1 rollover is allowed for each product order
            ProductRolloverHistory productRolloverHistory = productRolloverHistoryDao.findByProductOrderAndStatusNot(productOrder, Status.REJECTED);
            if (productRolloverHistory != null) {
                return getErrorObjectWithMsg(ROLLOVER_EXISTS);
            }

            if (req.getRolloverAmount() == null || req.getRolloverAmount() <= 0 || req.getRolloverAmount() > productOrder.getPurchasedAmount()) {
                return getErrorObjectWithMsg(INVALID_AMOUNT);
            }

            checkAvailableTrancheSize(req.getRolloverAmount(), productOrder.getProduct().getTrancheSize());

            double remainingAmount = productOrder.getPurchasedAmount() - req.getRolloverAmount();
            if (remainingAmount > 0) {
                productOrderPartialRedemption(productOrder, remainingAmount);
            }

            productRolloverHistory = new ProductRolloverHistory();
            productRolloverHistory.setProductOrder(productOrder);
            productRolloverHistory.setAmount(req.getRolloverAmount());
            productRolloverHistory.setStatus(Status.IN_REVIEW);
            productRolloverHistory.setCreatedAt(new Date());
            productRolloverHistory.setUpdatedAt(new Date());
            productRolloverHistory.setCreatedBy(appUser);
            productRolloverHistoryDao.save(productRolloverHistory);

            createRolloverReallocationProductOrder(productRolloverHistory);

            emailService.sendRolloverRequestEmailToAdmin(productRolloverHistory);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //--------------------------------Product Reallocation---------------------------------
    public Object getReallocatableProductCodes(String apiKey, String orderReferenceNumber) {
        validateApiKey(apiKey);
        try {
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(orderReferenceNumber).orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));
            List<String> allProductCodes = productReallocationConfigurationDao.findAllReallocatableProductCodeByProduct(productOrder.getProduct().getId());

            ReallocatableProductCodesRespVo resp = new ReallocatableProductCodesRespVo();
            resp.setProductCodes(allProductCodes);
            return resp;
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    @Transactional
    public Object createReallocationProductOrder(String apiKey, String orderReferenceNumber, ReallocateReqVo req) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(orderReferenceNumber).orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));

            if (!checkIfProductOrderOptionsIsAllowed(ProductOrderOptions.REALLOCATION, productOrder)) {
                return getErrorObjectWithMsg(REALLOCATION_NOT_ALLOWED);
            }

            List<String> allProductCodes = productReallocationConfigurationDao.findAllReallocatableProductCodeByProduct(productOrder.getProduct().getId());
            if (!allProductCodes.contains(req.getProductCode())) {
                return getErrorObjectWithMsg(INVALID_PRODUCT);
            }
            Product reallocatingProduct = productDao.findByCode(req.getProductCode()).orElseThrow(() -> new GeneralException(INVALID_PRODUCT));

            ProductReallocation productReallocation = productReallocationDao.findByProductOrderAndStatusNot(productOrder, Status.REJECTED);
            if (productReallocation != null) {
                return getErrorObjectWithMsg(REALLOCATION_EXISTS);
            }

            if (req.getAmount() == null || req.getAmount() <= 0 || req.getAmount() > productOrder.getPurchasedAmount()) {
                return getErrorObjectWithMsg(INVALID_AMOUNT);
            }

            // Remaining of reallocation amount will proceed with partial redemption
            double remaining = productOrder.getPurchasedAmount() - req.getAmount();
            if (remaining > 0) {
                productOrderPartialRedemption(productOrder, remaining);
            }

            productReallocation = new ProductReallocation();
            productReallocation.setProductOrder(productOrder);
            productReallocation.setAmount(req.getAmount());
            productReallocation.setReallocateProduct(reallocatingProduct);
            productReallocation.setStatus(Status.IN_REVIEW);
            productReallocation.setCreatedAt(new Date());
            productReallocation.setUpdatedAt(new Date());
            productReallocation.setCreatedBy(appUser);
            productReallocation = productReallocationDao.save(productReallocation);

            createRolloverReallocationProductOrder(productReallocation);

            emailService.sendReallocationRequestEmailToAdmin(productReallocation);

            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //--------------------------------Product Reallocation Rollover Update---------------------------------
    @Transactional
    public void createRolloverReallocationProductOrder(RolloverReallocationInterface request) {
        try {
            ProductOrder productOrder = cloneProductOrder(request);
            //Set dividend
            List<ProductTargetReturn> targetReturns = productTargetReturnDao.findByProductId(productOrder.getProduct().getId());
            FundAmountVo fundAmountVo = getDividendsBasedOnFundAmounts(productOrder.getPurchasedAmount(), targetReturns);
            productOrder.setDividend(fundAmountVo.getDividend());

            if (request instanceof ProductRolloverHistory rolloverRequest) {
                rolloverRequest.setRolloverProductOrder(productOrder);
                productRolloverHistoryDao.save(rolloverRequest);
            }
            if (request instanceof ProductReallocation reallocationRequest) {
                reallocationRequest.setReallocateProductOrder(productOrder);
                productReallocationDao.save(reallocationRequest);
            }
            updateProductTrancheSize(productOrder.getProduct().getId(), productOrder.getPurchasedAmount());
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
            throw new GeneralException(ex.getMessage());
        }
    }

    public ProductOrder cloneProductOrder(RolloverReallocationInterface request) throws Exception {
        ProductOrder original = request.getProductOrder();
        Product product = request.getReallocateProduct() == null ? original.getProduct() : request.getReallocateProduct();

        ProductOrder clone = new ProductOrder();
        clone.setOrderReferenceNumber(createOrderReferenceNumber());
        clone.setPurchasedAmount(request.getAmount());
        clone.setProductOrderType(ProductOrderType.ROLLOVER);
        clone.setClient(original.getClient());
        clone.setCorporateClient(original.getCorporateClient());
        clone.setClientName(original.getClientName());
        clone.setAgent(original.getAgent());
        clone.setAgency(original.getAgency());
        clone.setProduct(product);
        clone.setBank(original.getBank());
        clone.setInvestmentTenureMonth(product.getInvestmentTenureMonth());
        clone.setStatus(ProductOrder.ProductOrderStatus.IN_REVIEW);
        clone.setCreatedAt(new Date());
        clone.setUpdatedAt(new Date());
        clone.setSubmissionDate(new Date());
        clone.setCreatedBy(request.getCreatedBy());
        clone.setUpdatedBy(request.getCreatedBy());
        clone.setPaymentMethod(original.getPaymentMethod());
        clone.setPaymentStatus(Status.SUCCESS);
        clone.setPaymentDate(new Date());
        clone.setAgreementDate(original.getEndTenure().isBefore(LocalDate.now()) ? null : original.getEndTenure());
        clone.setStatusFinance(CmsAdmin.FinanceStatus.PENDING_FINANCE);
        clone.setStatusChecker(CmsAdmin.CheckerStatus.PENDING_CHECKER);
        clone.setStatusApprover(CmsAdmin.ApproverStatus.PENDING_APPROVER);
        clone.setIsProrated(product.getIsProrated());
        clone.setAgreementFileName(sanitizeAgreementFileName(request));
        clone = productOrderDao.save(clone);

        List<ProductBeneficiaries> productBeneficiaries = distributionBeneficiaryDao.findByProductOrder(original);
        for (ProductBeneficiaries originalBeneficiary : productBeneficiaries) {
            ProductBeneficiaries cloneBeneficiary = new ProductBeneficiaries();
            cloneBeneficiary.setProductOrder(clone);
            cloneBeneficiary.setBeneficiary(originalBeneficiary.getBeneficiary());
            cloneBeneficiary.setMainBeneficiary(originalBeneficiary.getMainBeneficiary());
            cloneBeneficiary.setCorporateBeneficiary(originalBeneficiary.getCorporateBeneficiary());
            cloneBeneficiary.setCorporateMainBeneficiary(originalBeneficiary.getCorporateMainBeneficiary());
            cloneBeneficiary.setPercentage(originalBeneficiary.getPercentage());
            cloneBeneficiary.setType(originalBeneficiary.getType());
            cloneBeneficiary.setCreatedAt(new Date());
            cloneBeneficiary.setUpdatedAt(new Date());
            distributionBeneficiaryDao.save(cloneBeneficiary);
        }
        return clone;
    }

    private static String sanitizeAgreementFileName(RolloverReallocationInterface request) {
        String originalAgreementFileName = request.getProductOrder().getAgreementFileName();
        if (request instanceof ProductRolloverHistory) {
            if (originalAgreementFileName.contains("-REALLOCATE")) {
                int index = originalAgreementFileName.indexOf("-REALLOCATE");
                originalAgreementFileName = originalAgreementFileName.substring(0, index);
            }
            if (!originalAgreementFileName.endsWith("-ROLLOVER")) {
                originalAgreementFileName += "-ROLLOVER";
            }
            return originalAgreementFileName;
        }
        if (request instanceof ProductReallocation) {
            if (originalAgreementFileName.contains("-ROLLOVER")) {
                int index = originalAgreementFileName.indexOf("-ROLLOVER");
                originalAgreementFileName = originalAgreementFileName.substring(0, index);
            }
            if (originalAgreementFileName.contains("-REALLOCATE")) {
                int index = originalAgreementFileName.indexOf("-REALLOCATE");
                originalAgreementFileName = originalAgreementFileName.substring(0, index);
            }
            originalAgreementFileName = originalAgreementFileName + "-REALLOCATE" + "-" + request.getReallocateProduct().getCode();
        }
        return originalAgreementFileName;
    }

    public void updateRolloverReallocationStatus(ProductOrder productOrder, Status status) {
        //Check and update if rollover exist
        ProductRolloverHistory productRolloverHistory = productRolloverHistoryDao.findByProductOrderAndStatusInAndRolloverProductOrderIsNotNull(productOrder, List.of(Status.IN_REVIEW, Status.REJECTED));
        if (productRolloverHistory != null) {
            productRolloverHistory.setStatus(status);
            productRolloverHistory.setUpdatedAt(new Date());
            productRolloverHistoryDao.save(productRolloverHistory);
        }
        //Check and update if reallocation exist
        ProductReallocation productReallocation = productReallocationDao.findByProductOrderAndStatusIn(productOrder, List.of(Status.IN_REVIEW, Status.REJECTED));
        if (productReallocation != null) {
            productReallocation.setStatus(status);
            productReallocation.setUpdatedAt(new Date());
            productReallocationDao.save(productReallocation);
        }
    }

    @Transactional
    public void activateRolloverReallocation(ProductOrder productOrder) {
        //Check if rollover exist
        ProductRolloverHistory rolloverHistory = productRolloverHistoryDao.findProductRolloverPendingActivation(productOrder.getId(), Status.APPROVED, ProductOrder.ProductOrderStatus.PENDING_ACTIVATION, CmsAdmin.FinanceStatus.APPROVE_FINANCE);
        if (rolloverHistory != null) {
            ProductOrder rolloverProductOrder = rolloverHistory.getRolloverProductOrder();
            rolloverProductOrder.setStatus(ProductOrder.ProductOrderStatus.ACTIVE);
            rolloverProductOrder.setUpdatedAt(new Date());
            productOrderDao.save(rolloverProductOrder);

            ProductOrder oldProductOrder = rolloverHistory.getProductOrder();
            oldProductOrder.setStatus(ProductOrder.ProductOrderStatus.COMPLETED);
            oldProductOrder.setUpdatedAt(new Date());
            productOrderDao.save(oldProductOrder);

            rolloverHistory.setStatus(Status.SUCCESS);
            productRolloverHistoryDao.save(rolloverHistory);
        }
        ProductReallocation reallocation = productReallocationDao.findProductReallocationPendingActivation(productOrder.getId(), Status.APPROVED, ProductOrder.ProductOrderStatus.PENDING_ACTIVATION, CmsAdmin.FinanceStatus.APPROVE_FINANCE);
        if (reallocation != null) {
            ProductOrder reallocationProductOrder = reallocation.getReallocateProductOrder();
            reallocationProductOrder.setStatus(ProductOrder.ProductOrderStatus.ACTIVE);
            productOrderDao.save(reallocationProductOrder);

            ProductOrder oldProductOrder = reallocation.getProductOrder();
            oldProductOrder.setStatus(ProductOrder.ProductOrderStatus.COMPLETED);
            oldProductOrder.setUpdatedAt(new Date());
            productOrderDao.save(oldProductOrder);

            reallocation.setStatus(Status.SUCCESS);
            productReallocationDao.save(reallocation);
        }
    }

    //--------------------------------Product Redemption Bank File Generation---------------------------------
    public void generateRedemptionBankFile(Long id) {
        if (id == null) {
            log.error("Error in : {} id is null", getFunctionName());
            return;
        }
        String redisKey = "redemption_bank_file_" + id;
        if (RedisUtil.exists(redisKey)) {
            return;
        }
        RedisUtil.set(redisKey, "1", ONE_DAY);
        try {
            ProductRedemption productRedemption = productRedemptionDao.findByIdAndStatus(id, Status.APPROVED);
            if (productRedemption != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy/MM/dd");

                List<Attachment> attachments = new ArrayList<>();
                String s3filePath = S3_REDEMPTION_BANK_FILE_DOCUMENT_PATH + sdf2.format(new Date()) + "/";
                String bankFile = productDao.findProductBankById(productRedemption.getProductOrder().getProduct().getId()).orElseThrow(() -> new GeneralException(BANK_DETAILS_NOT_FOUND));

                if (Product.BankFile.CIMB.name().equals(bankFile)) {
                    log.info("****************** Generate CIMB Bank Redemption File for id : {} Start ******************", id);
                    String beneficiaryName = CIMBBankUtil.sanitizeBeneficiaryName(productRedemption.getProductOrder().getBank().getAccountHolderName());
                    String beneficiaryId = StringUtil.removeAllSpecialCharacters(productRedemption.getProductOrder().getClientIdentityId());
                    String bnmCode = CIMBBankUtil.getCIMBBnmCode(productRedemption.getProductOrder().getBank().getBankName());
                    String accountNumber = CIMBBankUtil.sanitizeAccountNumber(productRedemption.getProductOrder().getBank().getAccountNumber());
                    String productCode = productRedemption.getProductOrder().getProduct().getCode();
                    String agreementRunningNumber = productRedemption.getProductOrder().getAgreementFileName().substring(productRedemption.getProductOrder().getAgreementFileName().length() - 4);
                    String referenceNumber = productCode + " " + agreementRunningNumber + " REDEMPTION";
                    String beneficiaryEmailAddress = productRedemption.getProductOrder().getClientEmail();
                    String paymentDetailDate = sdf.format(DateUtil.convertLocalDateToDate(productRedemption.getRedemptionPaymentDate()));
                    String paymentDescription = productRedemption.getProductOrder().getAgreementFileName() + " - REDEMPTION";

                    String recipientReference = " ";
                    if (ProductRedemption.RedemptionType.FULL.equals(productRedemption.getRedemptionType())) {
                        recipientReference = CIMBBankUtil.getRecipientReference(CIMBBankUtil.RecipientReferenceType.FULL_REDEMPTION, null, null, null);
                    } else if (ProductRedemption.RedemptionType.PARTIAL.equals(productRedemption.getRedemptionType())) {
                        recipientReference = CIMBBankUtil.getRecipientReference(CIMBBankUtil.RecipientReferenceType.PARTIAL_REDEMPTION, null, null, null);
                    }

                    CimbBankVo cimbBankVo = new CimbBankVo();
                    cimbBankVo.setColABeneficiaryName(beneficiaryName);
                    cimbBankVo.setColBBeneficiaryId(beneficiaryId);
                    cimbBankVo.setColCBnmCode(bnmCode);
                    cimbBankVo.setColDAccountNumber(accountNumber);
                    cimbBankVo.setColEPaymentAmount(productRedemption.getAmount());
                    cimbBankVo.setColFReferenceNumber(referenceNumber);
                    cimbBankVo.setColGBeneficiaryEmailAddress(beneficiaryEmailAddress);
                    cimbBankVo.setColHPaymentReferenceNumber(referenceNumber);
                    cimbBankVo.setColIPaymentDescription(paymentDescription);
                    cimbBankVo.setColJPaymentDetailNumber(referenceNumber);
                    cimbBankVo.setColKPaymentDetailDate(paymentDetailDate);
                    cimbBankVo.setColLPaymentDescription(recipientReference);
                    cimbBankVo.setColMPaymentDetailAmount(productRedemption.getAmount());

                    List<CimbBankVo> cimbBankVoList = List.of(cimbBankVo);
                    //Generate Excel File
                    File cimbBankFileExcel = excelService.generateCIMBBankFileExcel(cimbBankVoList, CimbBankVo.TYPE.DIVIDEND);
                    //Upload to S3
                    s3filePath += cimbBankFileExcel.getName();
                    AwsS3Util.uploadFile(cimbBankFileExcel, s3filePath, false);
                    log.info("Redemption CIMB Bank File Path : {}", s3filePath);
                    //Update Product Redemption
                    productRedemption.setGeneratedBankFile(Boolean.TRUE);
                    productRedemption.setUpdatedAt(new Date());
                    productRedemptionDao.save(productRedemption);
                    //Attach Excel to email
                    byte[] attachmentContentBytes = Files.readAllBytes(cimbBankFileExcel.toPath());
                    String attachmentContent = Base64.getEncoder().encodeToString(attachmentContentBytes);
                    attachments.add(new Attachment(attachmentContent, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", cimbBankFileExcel.getName()));
                    log.info("****************** Generate CIMB Bank Redemption File for id : {} End ******************", id);
                }
                if (Product.BankFile.AFFIN.name().equals(bankFile)) {
                    log.info("****************** Generate AFFIN Bank Redemption File for id : {} Start ******************", id);
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("ddMMyyyy");
                    AffinBankVo record = new AffinBankVo();
                    //Row 1
                    record.setColCRowOnePaymentDate(productRedemption.getRedemptionPaymentDate().format(formatter));
                    String productCode = productRedemption.getProductOrder().getProduct().getCode();
                    String agreementRunningNumber = productRedemption.getProductOrder().getAgreementFileName().substring(productRedemption.getProductOrder().getAgreementFileName().length() - 4);
                    record.setColDRowOneCustomerRefNo(productCode + " " + agreementRunningNumber);
                    record.setColERowOnePaymentAmount(productRedemption.getAmount());
                    record.setColGRowOneBeneficiaryBankCode(AffinBankUtil.getAFFINBnmCode(productRedemption.getProductOrder().getBank().getBankName()));
                    record.setColBRowOnePaymentMode(StringUtil.isEmpty(record.getColGRowOneBeneficiaryBankCode()) ? AffinBankUtil.PaymentMode.AFF.name() : AffinBankUtil.PaymentMode.IBG.name());
                    record.setColHRowOneBeneficiaryAccNo(productRedemption.getProductOrder().getBank().getAccountNumber());
                    record.setColIRowOneBeneficiaryName(productRedemption.getProductOrder().getBank().getAccountHolderName());
                    record.setColJRowOneIDCheckingRequired("Y");
                    record.setColKRowOneBeneficiaryIdType(AffinBankUtil.getBeneficiaryIdType(productRedemption.getProductOrder().getClientIdentityType()));
                    record.setColLRowOneBeneficiaryIdNo(StringUtil.removeAllSpecialCharacters(productRedemption.getProductOrder().getClientIdentityId()));
                    String residentIndicator = AffinBankUtil.getResidentIndicator(productRedemption.getProductOrder().getClientResidentialStatus());
                    record.setColMRowOneResidentIndicator(residentIndicator);
                    record.setColNRowOneResidentCountry(residentIndicator.equalsIgnoreCase("N") ? productRedemption.getProductOrder().getClientCountryCode() : "");
                    String recipientReference = " ";
                    if (ProductRedemption.RedemptionType.FULL.equals(productRedemption.getRedemptionType())) {
                        recipientReference = AffinBankUtil.getRecipientReference(AffinBankUtil.RecipientReferenceType.FULL_REDEMPTION, null, null);
                    } else if (ProductRedemption.RedemptionType.PARTIAL.equals(productRedemption.getRedemptionType())) {
                        recipientReference = AffinBankUtil.getRecipientReference(AffinBankUtil.RecipientReferenceType.PARTIAL_REDEMPTION, null, null);
                    }
                    record.setColSRowOneRecipientReference(recipientReference);
                    //Row 2
                    record.setColBRowTwoPaymentAdviceAmount(String.format("%.2f", productRedemption.getAmount()));
                    record.setColCRowTwoPaymentAdviceDetail(recipientReference);
                    record.setColDRowTwoEmailAddress1(productRedemption.getProductOrder().getClientEmail());

                    List<AffinBankVo> affinBankVoList = List.of(record);
                    //Generate Excel File
                    File affinBankFileExcel = excelService.generateAFFINBankFileExcel(affinBankVoList);
                    //Upload to S3
                    s3filePath += affinBankFileExcel.getName();
                    AwsS3Util.uploadFile(affinBankFileExcel, s3filePath, false);
                    log.info("Redemption AFFIN Bank File Path : {}", s3filePath);
                    //Update Product Redemption
                    productRedemption.setGeneratedBankFile(Boolean.TRUE);
                    productRedemption.setUpdatedAt(new Date());
                    productRedemptionDao.save(productRedemption);
                    //Attach Excel to email
                    byte[] attachmentContentBytes = Files.readAllBytes(affinBankFileExcel.toPath());
                    String attachmentContent = Base64.getEncoder().encodeToString(attachmentContentBytes);
                    attachments.add(new Attachment(attachmentContent, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", affinBankFileExcel.getName()));
                    log.info("****************** Generate AFFIN Bank Redemption File for id : {} End ******************", id);
                }
                if (attachments.isEmpty()) {
                    return;
                }
                emailService.sendRedemptionPayoutBankFileGenerationEmail(productRedemption, attachments);
            }
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
        } finally {
            RedisUtil.del(redisKey);
        }
    }

    public void updateRedemptionBankPaymentDetails(Long id) {
        if (id == null) {
            log.error("Error in : {} id is null", getFunctionName());
            return;
        }
        String redisKey = "update_redemption_payout_" + id;
        if (RedisUtil.exists(redisKey)) {
            return;
        }
        RedisUtil.set(redisKey, "1", ONE_DAY);
        try {
            ProductRedemption productRedemption = productRedemptionDao.findByIdAndStatusAndBankResultCsvIsNotNull(id, Status.APPROVED);
            if (productRedemption == null) {
                return;
            }
            String s3Key = StringUtil.extractDownloadLinkFromCmsContent(productRedemption.getBankResultCsv());
            String fileNameWithoutExtension = id + "_update_redemption_payout_" + System.currentTimeMillis();
            RedemptionPaymentRecordVo record = excelService.parseExcelFileFromS3ToVoClass(s3Key, fileNameWithoutExtension, RedemptionPaymentRecordVo.class, ExcelService.ParseStrategy.COLUMN_NAME).get(0);
            if (record != null) {
                String agreementNumber = record.getAgreementNo().strip();
                if (productRedemption.getProductOrder().getAgreementFileName().equals(agreementNumber)) {
                    productRedemption.setPaymentStatus(StringUtil.getEnumFromString(Status.class, record.getPaymentStatus()));
                    productRedemption.setPaymentDate(DateUtil.convertStringToDate(record.getPaymentDate()));
                    productRedemption.setUpdatedBankResult(Boolean.TRUE);
                    productRedemption.setUpdatedAt(new Date());
                    if (Status.SUCCESS.equals(productRedemption.getPaymentStatus())) {
                        productRedemption.setStatus(Status.SUCCESS);
                        if (ProductRedemption.RedemptionType.FULL.equals(productRedemption.getRedemptionType())) {
                            productRedemption.getProductOrder().setStatus(ProductOrder.ProductOrderStatus.COMPLETED);
                        }
                    }
                    productRedemptionDao.save(productRedemption);
                }
            }
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
        } finally {
            RedisUtil.del(redisKey);
        }
    }

    //--------------------------------Product Early Redemption Bank File Generation---------------------------------
    public void generateEarlyRedemptionBankFile(Long id) {
        if (id == null) {
            log.error("Error in : {} id is null", getFunctionName());
            return;
        }
        String redisKey = "early_redemption_bank_file_" + id;
        if (RedisUtil.exists(redisKey)) {
            return;
        }
        RedisUtil.set(redisKey, "1", ONE_DAY);
        try {
            ProductEarlyRedemptionHistory earlyRedemptionHistory = productEarlyRedemptionHistoryDao.findByIdAndStatus(id, Status.APPROVED);
            if (earlyRedemptionHistory != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy/MM/dd");

                List<Attachment> attachments = new ArrayList<>();
                String s3filePath = S3_REDEMPTION_BANK_FILE_DOCUMENT_PATH + sdf2.format(new Date()) + "/";
                String bankFile = productDao.findProductBankById(earlyRedemptionHistory.getProductOrder().getProduct().getId()).orElseThrow(() -> new GeneralException(BANK_DETAILS_NOT_FOUND));

                if (Product.BankFile.CIMB.name().equals(bankFile)) {
                    log.info("****************** Generate CIMB Bank Early Redemption File for id : {} Start ******************", id);
                    String beneficiaryName = CIMBBankUtil.sanitizeBeneficiaryName(earlyRedemptionHistory.getProductOrder().getBank().getAccountHolderName());
                    String beneficiaryId = StringUtil.removeAllSpecialCharacters(earlyRedemptionHistory.getProductOrder().getClientIdentityId());
                    String bnmCode = CIMBBankUtil.getCIMBBnmCode(earlyRedemptionHistory.getProductOrder().getBank().getBankName());
                    String accountNumber = CIMBBankUtil.sanitizeAccountNumber(earlyRedemptionHistory.getProductOrder().getBank().getAccountNumber());
                    String productCode = earlyRedemptionHistory.getProductOrder().getProduct().getCode();
                    String agreementRunningNumber = earlyRedemptionHistory.getProductOrder().getAgreementFileName().substring(earlyRedemptionHistory.getProductOrder().getAgreementFileName().length() - 4);
                    String referenceNumber = productCode + " " + agreementRunningNumber + " REDEMPTION";
                    String beneficiaryEmailAddress = earlyRedemptionHistory.getProductOrder().getClientEmail();
                    String paymentDetailDate = sdf.format(DateUtil.convertLocalDateToDate(LocalDate.now()));
                    String paymentDescription = earlyRedemptionHistory.getProductOrder().getAgreementFileName() + " - REDEMPTION";
                    String recipientReference = CIMBBankUtil.getRecipientReference(CIMBBankUtil.RecipientReferenceType.EARLY_REDEMPTION, null, null, null);

                    CimbBankVo cimbBankVo = new CimbBankVo();
                    cimbBankVo.setColABeneficiaryName(beneficiaryName);
                    cimbBankVo.setColBBeneficiaryId(beneficiaryId);
                    cimbBankVo.setColCBnmCode(bnmCode);
                    cimbBankVo.setColDAccountNumber(accountNumber);
                    cimbBankVo.setColEPaymentAmount(earlyRedemptionHistory.getRedemptionPaymentAmount());
                    cimbBankVo.setColFReferenceNumber(referenceNumber);
                    cimbBankVo.setColGBeneficiaryEmailAddress(beneficiaryEmailAddress);
                    cimbBankVo.setColHPaymentReferenceNumber(referenceNumber);
                    cimbBankVo.setColIPaymentDescription(paymentDescription);
                    cimbBankVo.setColJPaymentDetailNumber(referenceNumber);
                    cimbBankVo.setColKPaymentDetailDate(paymentDetailDate);
                    cimbBankVo.setColLPaymentDescription(recipientReference);
                    cimbBankVo.setColMPaymentDetailAmount(earlyRedemptionHistory.getRedemptionPaymentAmount());

                    List<CimbBankVo> cimbBankVoList = List.of(cimbBankVo);
                    //Generate Excel File
                    File cimbBankFileExcel = excelService.generateCIMBBankFileExcel(cimbBankVoList, CimbBankVo.TYPE.DIVIDEND);
                    //Upload to S3
                    s3filePath += cimbBankFileExcel.getName();
                    AwsS3Util.uploadFile(cimbBankFileExcel, s3filePath, false);
                    log.info("Early Redemption CIMB Bank File Path : {}", s3filePath);
                    //Update Product Redemption
                    earlyRedemptionHistory.setGeneratedBankFile(Boolean.TRUE);
                    earlyRedemptionHistory.setUpdatedAt(new Date());
                    productEarlyRedemptionHistoryDao.save(earlyRedemptionHistory);
                    //Attach Excel to email
                    byte[] attachmentContentBytes = Files.readAllBytes(cimbBankFileExcel.toPath());
                    String attachmentContent = Base64.getEncoder().encodeToString(attachmentContentBytes);
                    attachments.add(new Attachment(attachmentContent, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", cimbBankFileExcel.getName()));
                    log.info("****************** Generate CIMB Bank Early Redemption File for id : {} End ******************", id);
                }
                if (Product.BankFile.AFFIN.name().equals(bankFile)) {
                    log.info("****************** Generate AFFIN Bank Early Redemption File for id : {} Start ******************", id);
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("ddMMyyyy");
                    AffinBankVo record = new AffinBankVo();
                    //Row 1
                    record.setColCRowOnePaymentDate(LocalDate.now().format(formatter));
                    String productCode = earlyRedemptionHistory.getProductOrder().getProduct().getCode();
                    String agreementRunningNumber = earlyRedemptionHistory.getProductOrder().getAgreementFileName().substring(earlyRedemptionHistory.getProductOrder().getAgreementFileName().length() - 4);
                    record.setColDRowOneCustomerRefNo(productCode + " " + agreementRunningNumber);
                    record.setColERowOnePaymentAmount(earlyRedemptionHistory.getRedemptionPaymentAmount());
                    record.setColGRowOneBeneficiaryBankCode(AffinBankUtil.getAFFINBnmCode(earlyRedemptionHistory.getProductOrder().getBank().getBankName()));
                    record.setColBRowOnePaymentMode(StringUtil.isEmpty(record.getColGRowOneBeneficiaryBankCode()) ? AffinBankUtil.PaymentMode.AFF.name() : AffinBankUtil.PaymentMode.IBG.name());
                    record.setColHRowOneBeneficiaryAccNo(earlyRedemptionHistory.getProductOrder().getBank().getAccountNumber());
                    record.setColIRowOneBeneficiaryName(earlyRedemptionHistory.getProductOrder().getBank().getAccountHolderName());
                    record.setColJRowOneIDCheckingRequired("Y");
                    record.setColKRowOneBeneficiaryIdType(AffinBankUtil.getBeneficiaryIdType(earlyRedemptionHistory.getProductOrder().getClientIdentityType()));
                    record.setColLRowOneBeneficiaryIdNo(StringUtil.removeAllSpecialCharacters(earlyRedemptionHistory.getProductOrder().getClientIdentityId()));
                    String residentIndicator = AffinBankUtil.getResidentIndicator(earlyRedemptionHistory.getProductOrder().getClientResidentialStatus());
                    record.setColMRowOneResidentIndicator(residentIndicator);
                    record.setColNRowOneResidentCountry(residentIndicator.equalsIgnoreCase("N") ? earlyRedemptionHistory.getProductOrder().getClientCountryCode() : "");
                    String recipientReference = AffinBankUtil.getRecipientReference(AffinBankUtil.RecipientReferenceType.EARLY_REDEMPTION, null, null);
                    record.setColSRowOneRecipientReference(recipientReference);
                    //Row 2
                    record.setColBRowTwoPaymentAdviceAmount(String.format("%.2f", earlyRedemptionHistory.getRedemptionPaymentAmount()));
                    record.setColCRowTwoPaymentAdviceDetail(recipientReference);
                    record.setColDRowTwoEmailAddress1(earlyRedemptionHistory.getProductOrder().getClientEmail());

                    List<AffinBankVo> affinBankVoList = List.of(record);
                    //Generate Excel File
                    File affinBankFileExcel = excelService.generateAFFINBankFileExcel(affinBankVoList);
                    //Upload to S3
                    s3filePath += affinBankFileExcel.getName();
                    AwsS3Util.uploadFile(affinBankFileExcel, s3filePath, false);
                    log.info("Early Redemption AFFIN Bank File Path : {}", s3filePath);
                    //Update Product Redemption
                    earlyRedemptionHistory.setGeneratedBankFile(Boolean.TRUE);
                    earlyRedemptionHistory.setUpdatedAt(new Date());
                    productEarlyRedemptionHistoryDao.save(earlyRedemptionHistory);
                    //Attach Excel to email
                    byte[] attachmentContentBytes = Files.readAllBytes(affinBankFileExcel.toPath());
                    String attachmentContent = Base64.getEncoder().encodeToString(attachmentContentBytes);
                    attachments.add(new Attachment(attachmentContent, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", affinBankFileExcel.getName()));
                    log.info("****************** Generate AFFIN Bank Early Redemption File for id : {} End ******************", id);
                }
                if (attachments.isEmpty()) {
                    return;
                }
                emailService.sendEarlyRedemptionPayoutBankFileGenerationEmail(earlyRedemptionHistory, attachments);
            }
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
        } finally {
            RedisUtil.del(redisKey);
        }
    }

    public void updateEarlyRedemptionBankPaymentDetails(Long id) {
        if (id == null) {
            log.error("Error in : {} id is null", getFunctionName());
            return;
        }
        String redisKey = "update_early_redemption_payout_" + id;
        if (RedisUtil.exists(redisKey)) {
            return;
        }
        RedisUtil.set(redisKey, "1", ONE_DAY);
        try {
            ProductEarlyRedemptionHistory earlyRedemptionHistory = productEarlyRedemptionHistoryDao.findByIdAndStatusAndBankResultCsvIsNotNull(id, Status.APPROVED);
            if (earlyRedemptionHistory == null) {
                return;
            }
            String s3Key = StringUtil.extractDownloadLinkFromCmsContent(earlyRedemptionHistory.getBankResultCsv());
            String fileNameWithoutExtension = id + "_update_early_redemption_payout_" + System.currentTimeMillis();
            EarlyRedemptionPaymentRecordVo record = excelService.parseExcelFileFromS3ToVoClass(s3Key, fileNameWithoutExtension, EarlyRedemptionPaymentRecordVo.class, ExcelService.ParseStrategy.COLUMN_NAME).get(0);
            if (record != null) {
                String referenceNumber = record.getReferenceNumber().strip();
                if (earlyRedemptionHistory.getReferenceNumber().equals(referenceNumber)) {
                    earlyRedemptionHistory.setPaymentStatus(StringUtil.getEnumFromString(Status.class, record.getPaymentStatus()));
                    earlyRedemptionHistory.setPaymentDate(DateUtil.convertStringToDate(record.getPaymentDate()));
                    earlyRedemptionHistory.setUpdatedBankResult(Boolean.TRUE);
                    earlyRedemptionHistory.setUpdatedAt(new Date());
                    if (Status.SUCCESS.equals(earlyRedemptionHistory.getPaymentStatus())) {
                        earlyRedemptionHistory.setStatus(Status.SUCCESS);
                        //Update product order purchased amount balance
                        ProductOrder productOrder = earlyRedemptionHistory.getProductOrder();
                        double balanceAfterDeduct = productOrder.getPurchasedAmount() - earlyRedemptionHistory.getAmount();
                        productOrder.setPurchasedAmount(balanceAfterDeduct);
                        if (balanceAfterDeduct == 0 || RedemptionMethod.ALL.equals(earlyRedemptionHistory.getWithdrawalMethod())) {
                            productOrder.setStatus(ProductOrder.ProductOrderStatus.WITHDRAWN);
                        }
                        productOrderDao.save(productOrder);
                    }
                    productEarlyRedemptionHistoryDao.save(earlyRedemptionHistory);
                }
            }
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
        } finally {
            RedisUtil.del(redisKey);
        }
    }

    public TransactionRespVo getProductTransaction(Client client, CorporateClient corporateClient) {
        // 1. Dividend Transaction
        List<TransactionVo> dividendTransactionList = getDividendTransactionList(client, corporateClient);

        // 2. Placement Transaction
        List<TransactionVo> placementTransactionList = getPlacementTransactionList(client, corporateClient);

        Set<Long> productOrderIdSet = placementTransactionList.stream().map(TransactionVo::getHistoryId).collect(Collectors.toSet());

        // 3. Redemption transaction
        List<TransactionVo> redemptionTransactionList = productRedemptionDao.findRedemptionTransactions(Status.SUCCESS, productOrderIdSet)
                .stream().map(TransactionVo::redemptionTransactionVo).toList();

        // 4. Withdrawal transaction
        List<TransactionVo> withdrawalTransactionList = productEarlyRedemptionHistoryDao.findEarlyRedemptionTransactions(Status.SUCCESS, productOrderIdSet)
                .stream().map(TransactionVo::earlyRedemptionTransactionVo).toList();

        // Combine the all lists
        List<TransactionVo> transactionList = new ArrayList<>();
        transactionList.addAll(dividendTransactionList);
        transactionList.addAll(placementTransactionList);
        transactionList.addAll(redemptionTransactionList);
        transactionList.addAll(withdrawalTransactionList);

        // Sort the combined list by transactionDate in descending order
        transactionList.sort(Comparator.comparing(TransactionVo::getTransactionDate,
                Comparator.nullsLast(Comparator.reverseOrder())));

        TransactionRespVo resp = new TransactionRespVo();
        resp.setTransactions(transactionList);
        return resp;
    }

    public List<TransactionVo> getDividendTransactionList(Client client, CorporateClient corporateClient) {
        try {
            List<Long> productOrderIdList = new ArrayList<>();
            if (client != null) {
                productOrderIdList = productOrderDao.findAllByClientForDividendHistory(client);
            }
            if (corporateClient != null) {
                productOrderIdList = productOrderDao.findAllByCorporateClientForDividendHistory(corporateClient);
            }
            List<ProductDividendCalculationHistory> dividendHistoryList = productDividendCalculationHistoryDao.findAllByProductOrderIdInAndPaymentStatus(productOrderIdList, Status.SUCCESS);

            return dividendHistoryList.stream()
                    .map(TransactionVo::dividendTransactionVo)
                    .sorted(Comparator.comparing(TransactionVo::getHistoryId).reversed())
                    .toList();
        } catch (Exception ex) {
            log.error("Error", ex);
            throw new GeneralException(ex.getMessage());
        }
    }

    public List<TransactionVo> getPlacementTransactionList(Client client, CorporateClient corporateClient) {
        List<TransactionVo> placementTransactionList = new ArrayList<>();
        if (client != null) {
            placementTransactionList = productOrderDao.findAllPlacementTransactionsByClient(client.getId(), Status.SUCCESS);
        }
        if (corporateClient != null) {
            placementTransactionList = productOrderDao.findAllByCorporateClientAndPaymentStatus(corporateClient.getId(), Status.SUCCESS);
        }
        return placementTransactionList.stream().map(TransactionVo::placementTransactionVo).toList();
    }
}