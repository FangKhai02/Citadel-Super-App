package com.citadel.backend.service;

import com.citadel.backend.dao.*;
import com.citadel.backend.dao.Agent.AgentDao;
import com.citadel.backend.dao.Client.ClientDao;
import com.citadel.backend.dao.Corporate.*;
import com.citadel.backend.dao.Products.ProductEarlyRedemptionHistoryDao;
import com.citadel.backend.dao.Products.ProductOrderDao;
import com.citadel.backend.dao.Products.ProductRedemptionDao;
import com.citadel.backend.entity.*;
import com.citadel.backend.entity.Corporate.*;
import com.citadel.backend.entity.Products.ProductOrder;
import com.citadel.backend.utils.*;
import com.citadel.backend.utils.Builder.DigitalIDBuilder;
import com.citadel.backend.utils.Builder.RandomCodeBuilder;
import com.citadel.backend.utils.Builder.UploadBase64FileBuilder;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.vo.BankDetails.BankDetailsVo;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Client.ClientPortfolioRespVo;
import com.citadel.backend.vo.Client.ClientPortfolioVo;
import com.citadel.backend.vo.Corporate.*;
import com.citadel.backend.vo.Corporate.Bank.*;
import com.citadel.backend.vo.Corporate.Beneficiary.*;
import com.citadel.backend.vo.Corporate.Documents.CorporateDocumentsReqVo;
import com.citadel.backend.vo.Corporate.Documents.CorporateDocumentsRespVo;
import com.citadel.backend.vo.Corporate.Documents.CorporateDocumentsVo;
import com.citadel.backend.vo.Corporate.Guardian.*;
import com.citadel.backend.vo.Corporate.ShareHolder.*;
import com.citadel.backend.vo.DigitalIDResultVo;
import com.citadel.backend.vo.Enum.Status;
import com.citadel.backend.vo.Enum.UserType;
import com.citadel.backend.vo.SignUp.PepDeclarationVo;
import com.citadel.backend.vo.Transaction.TransactionRespVo;
import com.citadel.backend.vo.Transaction.TransactionVo;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

import static com.citadel.backend.utils.ApiErrorKey.*;
import static com.citadel.backend.utils.DigitalIDUtil.createDigitalID;

@Service
public class CorporateService extends BaseService {

    @Resource
    private ClientDao clientDao;
    @Resource
    private CorporateClientDao corporateClientDao;
    @Resource
    private ProductOrderDao productOrderDao;
    @Resource
    private ProductService productService;
    @Resource
    private DividendService dividendService;
    @Resource
    private CorporateDetailsDao corporateDetailsDao;
    @Resource
    private PepInfoDao pepInfoDao;
    @Resource
    private CorporateShareholderDao corporateShareholderDao;
    @Resource
    private CorporateBeneficiaryDao corporateBeneficiaryDao;
    @Resource
    private CorporateShareholdersPivotDao corporateShareholdersPivotDao;
    @Resource
    private CorporateGuardianDao corporateGuardianDao;
    @Resource
    private CorporateDocumentsDao corporateDocumentDao;
    @Resource
    private EmailService emailService;
    @Resource
    private ValidatorService validatorService;
    @Resource
    private BankDetailsDao bankDetailsDao;
    @Resource
    private ProductRedemptionDao productRedemptionDao;
    @Resource
    private ProductEarlyRedemptionHistoryDao productEarlyRedemptionHistoryDao;
    @Resource
    private AgentDao agentDao;

    private Client getClient(AppUser appUser, String clientId) {
        Client client;
        if (UserType.AGENT.equals(appUser.getUserType())) {
            Agent agent = agentDao.findByAppUserAndStatus(appUser, Agent.AgentStatus.ACTIVE).orElseThrow(() -> new GeneralException(AGENT_PROFILE_TERMINATED));
            client = clientDao.findByAgentAndClientId(agent, clientId).orElseThrow(() -> new GeneralException(CLIENT_NOT_FOUND));
        } else {
            client = clientDao.findByAppUser(appUser).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
        }
        return client;
    }

    @Transactional
    public Object corporateClientSignUp(String apiKey, String clientId, String referenceNumber, Boolean isDraft, CorporateClientSignUpReqVo corporateClientSignUpReq) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        String key = "sign-up/corporate-client/" + apiKey;
        if (RedisUtil.exists(key)) {
            return getErrorObjectWithMsg(DUPLICATE_REQUEST);
        }
        RedisUtil.set(key, "1");
        try {
            Client client = getClient(appUser, clientId);

            //Create or update corporate client
            CorporateClient corporateClient = null;
            // If reference number is provided, attempt to find an existing client
            if (StringUtil.isNotEmpty(referenceNumber)) {
                corporateClient = corporateClientDao.findByReferenceNumberAndIsDeletedFalse(referenceNumber);
            }

            //Internal verification of corporate details
            CorporateDetailsReqVo detailsReqVo = corporateClientSignUpReq.getCorporateDetails();
            Object validationResp = validatorService.corporateCompanyDetailsValidator(detailsReqVo);
            if (validationResp instanceof ErrorResp errorResp) {
                return errorResp;
            }

            if (corporateClient == null) {
                corporateClient = new CorporateClient();
                corporateClient.setCreatedAt(new Date());
                String corReferenceNumber = RandomCodeUtil.generateRandomCode(new RandomCodeBuilder()
                        .prefix("COR" + System.currentTimeMillis())
                        .postfix(RandomCodeBuilder.NUMBERS)
                        .postfixLength(3));
                corporateClient.setReferenceNumber(corReferenceNumber);
                corporateClient.setClient(client);
                corporateClient.setUserDetail(client.getUserDetail());
                DigitalIDResultVo digitalIDResult = createDigitalID(new DigitalIDBuilder()
                        .builderType(DigitalIDBuilder.BuilderType.CORPORATE_CLIENT)
                        .name(detailsReqVo.getEntityName())
                        .date(new Date(detailsReqVo.getDateIncorporate())));
                String corporateDigitalId = digitalIDResult.getDigitalID();
                corporateClient.setCorporateClientId(corporateDigitalId);
                corporateClient.setStatus(CorporateClient.CorporateClientStatus.DRAFT);
                corporateClient.setAgent(client.getAgent());
            }
            //Prevent update if corporate client is already approved or in review
            else if (!corporateClient.canUpdate()) {
                throw new GeneralException(CORPORATE_ACCOUNT_UPDATE_NOT_ALLOWED);
            }
            corporateClient.setStatus(CorporateClient.CorporateClientStatus.DRAFT);

            //Corporate details
            CorporateDetails corporateDetails = corporateClient.getCorporateDetails();
            if (corporateDetails == null) {
                corporateDetails = new CorporateDetails();
                corporateDetails.setCreatedAt(new Date());
            }

            boolean overrideDigitalID = false;
            String entityName = corporateDetails.getEntityName();
            Date dateIncorporation = corporateDetails.getDateIncorporation();
            if (StringUtils.isNotEmpty(entityName) && dateIncorporation != null) {
                if (!entityName.equals(detailsReqVo.getEntityName()) || dateIncorporation.getTime() != detailsReqVo.getDateIncorporate()) {
                    overrideDigitalID = true;
                }
            }

            // Set Corporate Details (Draft Mode)
            corporateDetails.setStatus(CorporateDetails.CorporateDetailsStatus.DRAFT);
            corporateDetails.setEntityName(detailsReqVo.getEntityName());
            corporateDetails.setEntityType(detailsReqVo.getEntityType());
            corporateDetails.setRegistrationNumber(detailsReqVo.getRegistrationNumber());
            corporateDetails.setDateIncorporation(new Date(detailsReqVo.getDateIncorporate()));
            corporateDetails.setPlaceIncorporation(detailsReqVo.getPlaceIncorporate());
            corporateDetails.setBusinessType(detailsReqVo.getBusinessType());
            corporateDetails.setRegisteredAddress(StringUtil.capitalizeEachWord(detailsReqVo.getRegisteredAddress()));
            corporateDetails.setCity(StringUtil.capitalizeEachWord(detailsReqVo.getCity()));
            corporateDetails.setPostcode(detailsReqVo.getPostcode());
            corporateDetails.setState(StringUtil.capitalizeEachWord(detailsReqVo.getState()));
            corporateDetails.setCountry(StringUtil.capitalizeEachWord(detailsReqVo.getCountry()));
            corporateDetails.setIsDifferentBusinessAddress(detailsReqVo.getCorporateAddressDetails().getIsDifferentRegisteredAddress());
            if (corporateDetails.getIsDifferentBusinessAddress()) {
                corporateDetails.setBusinessAddress(StringUtil.capitalizeEachWord(detailsReqVo.getCorporateAddressDetails().getBusinessAddress()));
                corporateDetails.setBusinessCity(StringUtil.capitalizeEachWord(detailsReqVo.getCorporateAddressDetails().getBusinessCity()));
                corporateDetails.setBusinessState(StringUtil.capitalizeEachWord(detailsReqVo.getCorporateAddressDetails().getBusinessState()));
                corporateDetails.setBusinessPostcode(detailsReqVo.getCorporateAddressDetails().getBusinessPostcode());
                corporateDetails.setBusinessCountry(StringUtil.capitalizeEachWord(detailsReqVo.getCorporateAddressDetails().getBusinessCountry()));
            } else {
                corporateDetails.setBusinessAddress(StringUtil.capitalizeEachWord(detailsReqVo.getRegisteredAddress()));
                corporateDetails.setBusinessCity(StringUtil.capitalizeEachWord(detailsReqVo.getCity()));
                corporateDetails.setBusinessState(StringUtil.capitalizeEachWord(detailsReqVo.getState()));
                corporateDetails.setBusinessPostcode(detailsReqVo.getPostcode());
                corporateDetails.setBusinessCountry(StringUtil.capitalizeEachWord(detailsReqVo.getCountry()));
            }

            // Corporate primary contact details
            corporateDetails.setContactName(detailsReqVo.getContactName());
            corporateDetails.setContactIsMyself(detailsReqVo.getContactIsMyself());
            corporateDetails.setContactDesignation(detailsReqVo.getContactDesignation());
            corporateDetails.setContactMobileCountryCode(detailsReqVo.getContactMobileCountryCode());
            corporateDetails.setContactMobileNumber(detailsReqVo.getContactMobileNumber());
            corporateDetails.setContactEmail(detailsReqVo.getContactEmail());

            //Save or update corporate details
            corporateDetails.setUpdatedAt(new Date());
            corporateDetails = corporateDetailsDao.save(corporateDetails);

            if (overrideDigitalID) {
                DigitalIDResultVo digitalIDResult = createDigitalID(new DigitalIDBuilder()
                        .builderType(DigitalIDBuilder.BuilderType.CORPORATE_CLIENT)
                        .name(corporateDetails.getEntityName())
                        .date(corporateDetails.getDateIncorporation()));
                String corporateDigitalId = digitalIDResult.getDigitalID();
                corporateClient.setCorporateClientId(corporateDigitalId);
            }

            // Wealth source
            corporateClient.setAnnualIncomeDeclaration(corporateClientSignUpReq.getAnnualIncomeDeclaration());
            corporateClient.setSourceOfIncome(corporateClientSignUpReq.getSourceOfIncome());

            // Digital Signature
            String digitalSignatureBase64 = corporateClientSignUpReq.getDigitalSignature();
            if (StringUtils.isNotEmpty(digitalSignatureBase64) && !digitalSignatureBase64.startsWith("http")) {
                String digitalSignatureKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(digitalSignatureBase64)
                        .fileName("digitalSignature")
                        .filePath(S3_CORPORATE_PATH + corporateClient.getReferenceNumber()));
                corporateClient.setDigitalSignatureKey(digitalSignatureKey);
            }

            //Save or update corporate client
            corporateClient.setUpdatedAt(new Date());
            corporateClient.setCorporateDetails(corporateDetails);
            corporateClient = corporateClientDao.save(corporateClient);

            // Determine if draft or not
            // 1. Valid Corporate details
            // 2. Valid ShareHolders
            // 3. Valid Wealth source
            // 4. Valid Company documents
            // 5. Valid Digital Signature

            //Corporate Details
            boolean isComplete = corporateClient.getCorporateDetails() != null;

            //Corporate Shareholders
            List<CorporateShareholder> mappedShareholders = getMappedShareHolders(corporateClient);
            Object shareHolderValidationResp = ValidatorUtil.shareholderCountAndShareholdingsValidator(mappedShareholders);
            if (shareHolderValidationResp instanceof ErrorResp) {
                isComplete = false;
            }

            //Wealth source
            if (StringUtil.isEmpty(corporateClient.getAnnualIncomeDeclaration()) || StringUtil.isEmpty(corporateClient.getSourceOfIncome())) {
                isComplete = false;
            }
            //Company documents
            List<CorporateDocumentsVo> corporateDocumentsVo = getCorporateDocumentsVo(corporateDetails);
            Object documentValidationResp = ValidatorUtil.corporateDocumentsValidator(corporateDocumentsVo);
            if (documentValidationResp instanceof ErrorResp) {
                isComplete = false;
            }
            //Digital Signature
            if (StringUtil.isEmpty(corporateClient.getDigitalSignatureKey())) {
                isComplete = false;
            }

            if (isComplete && Boolean.FALSE.equals(isDraft)) {
                corporateClient.setStatus(CorporateClient.CorporateClientStatus.IN_REVIEW);
                corporateDetails.setStatus(CorporateDetails.CorporateDetailsStatus.IN_REVIEW);

                String onboardingAgreementKey = emailService.sendOnboardingAgreementEmail(corporateClient, DigitalIDUtil.extractRunningNumber(corporateClient.getCorporateClientId()));
                corporateClient.setOnboardingAgreementKey(onboardingAgreementKey);
            }
            corporateDetails.setUpdatedAt(new Date());
            corporateDetailsDao.save(corporateDetails);

            corporateClient.setUpdatedAt(new Date());
            corporateClientDao.save(corporateClient);

            CorporateProfileRespVo resp = new CorporateProfileRespVo();
            resp.setCorporateClient(corporateClient.getCorporateClientVo());
            resp.setCorporateDetails(corporateClient.getCorporateDetailsVo());
            resp.setCorporateDocuments(corporateDocumentsVo);
            List<CorporateShareholderBaseVo> mappedShareholdersBaseVoList = mappedShareholders.stream()
                    .map(CorporateShareholderBaseVo::corporateShareholderToCorporateShareholderBaseVo)
                    .toList();
            resp.setBindedCorporateShareholders(mappedShareholdersBaseVoList);
            return resp;
        } catch (Exception ex) {
            log.error("Error during corporate client sign-up", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        } finally {
            RedisUtil.del(key);
        }
    }

    private List<CorporateDocumentsVo> getCorporateDocumentsVo(CorporateDetails corporateDetails) {
        List<CorporateDocuments> corporateDocuments = corporateDocumentDao.findAllByCorporateDetailsAndIsDeletedIsFalse(corporateDetails);
        return corporateDocuments.stream()
                .map(CorporateDocumentsVo::corporateDocumentsToCorporateDocumentsVo)
                .toList();
    }

    public Object getCorporateDocuments(String apiKey, String referenceNumber) {
        validateApiKey(apiKey);
        try {
            CorporateClient corporateClient = corporateClientDao.findByReferenceNumberAndIsDeletedFalse(referenceNumber);
            if (corporateClient == null) {
                throw new GeneralException(CORPORATE_CLIENT_NOT_FOUND);
            }
            CorporateDetails corporateDetails = corporateClient.getCorporateDetails();
            if (corporateDetails == null) {
                throw new GeneralException(CORPORATE_CLIENT_NOT_FOUND);
            }
            CorporateDocumentsRespVo resp = new CorporateDocumentsRespVo();
            resp.setCorporateDocuments(getCorporateDocumentsVo(corporateDetails));
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object saveOrUpdateCorporateDocuments(String apiKey, String referenceNumber, CorporateDocumentsReqVo req) {
        validateApiKey(apiKey);
        try {
            CorporateClient corporateClient = corporateClientDao.findByReferenceNumberAndIsDeletedFalse(referenceNumber);
            if (corporateClient == null) {
                throw new GeneralException(CORPORATE_CLIENT_NOT_FOUND);
            }

            //Prevent updating if approved or in review
            if (!corporateClient.canUpdate()) {
                throw new GeneralException(CORPORATE_ACCOUNT_UPDATE_NOT_ALLOWED);
            }

            CorporateDetails corporateDetails = corporateClient.getCorporateDetails();
            if (corporateDetails == null) {
                throw new GeneralException(CORPORATE_CLIENT_NOT_FOUND);
            }
            List<CorporateDocumentsVo> corporateDocuments = req.getCorporateDocuments();

            Object result = ValidatorUtil.corporateDocumentsValidator(corporateDocuments);
            if (result instanceof ErrorResp errorResp) {
                return errorResp;
            }

            List<CorporateDocuments> existingCorporateDocuments = corporateDocumentDao.findAllByCorporateDetailsAndIsDeletedIsFalse(corporateDetails);
            Map<Long, CorporateDocuments> existingDocumentsMap = existingCorporateDocuments.stream()
                    .collect(Collectors.toMap(CorporateDocuments::getId, document -> document));

            List<Long> passedIds = corporateDocuments.stream().map(CorporateDocumentsVo::getId).filter(Objects::nonNull).toList();
            // Create a copy of existingIds to avoid modifying the original list
            List<Long> idsToDelete = new ArrayList<>(existingDocumentsMap.keySet());
            // Remove all IDs that are in passedIds
            idsToDelete.removeAll(passedIds);
            // Delete all remaining IDs
            idsToDelete.forEach(
                    id -> {
                        CorporateDocuments document = existingDocumentsMap.get(id);
                        AwsS3Util.deleteFile(document.getCompanyDocumentKey());
                        document.setIsDeleted(true);
                        document.setUpdatedAt(new Date());
                        corporateDocumentDao.save(document);
                    }
            );

            int count = existingCorporateDocuments.size();
            for (int i = 0; i < corporateDocuments.size(); i++) {
                CorporateDocumentsVo corporateDocumentVo = corporateDocuments.get(i);

                CorporateDocuments corporateDocument = existingDocumentsMap.get(corporateDocumentVo.getId());
                // To create or update
                if (corporateDocument == null) {
                    corporateDocument = new CorporateDocuments();
                    corporateDocument.setCorporateDetails(corporateDetails);
                    corporateDocument.setCreatedAt(new Date());
                }
                // Set or update fileName
                String fileName = StringUtil.isEmpty(corporateDocumentVo.getFileName())
                        ? "companyDocument_" + ((i + 1) + count)
                        : StringUtil.removeFileExtensionFromFileName(corporateDocumentVo.getFileName());
                corporateDocument.setCompanyDocumentName(fileName);

                // Set or update file key to s3
                String companyDocumentBase64 = corporateDocumentVo.getFile();
                if (!companyDocumentBase64.startsWith("http")) {
                    AwsS3Util.deleteFile(corporateDocument.getCompanyDocumentKey());
                    String companyDocumentKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                            .base64String(companyDocumentBase64)
                            .fileName(fileName)
                            .filePath(S3_CORPORATE_PATH + corporateClient.getReferenceNumber()));
                    corporateDocument.setCompanyDocumentKey(companyDocumentKey);
                }
                corporateDocument.setIsDeleted(false);
                corporateDocument.setUpdatedAt(new Date());
                corporateDocumentDao.save(corporateDocument);
            }
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------------Corporate shareholders--------------------------------
    public Object createShareholder(String apiKey, String referenceNumber, CorporateShareholderReqVo corporateShareholderReqVo) {
        validateApiKey(apiKey);
        try {
            CorporateClient corporateClient = corporateClientDao.findByReferenceNumberAndIsDeletedFalse(referenceNumber);
            if (corporateClient == null) {
                throw new GeneralException(CORPORATE_CLIENT_NOT_FOUND);
            }

            CorporateShareholder corporateShareholder = new CorporateShareholder();
            corporateShareholder.setName(corporateShareholderReqVo.getName());
            corporateShareholder.setMobileCountryCode(corporateShareholderReqVo.getMobileCountryCode());
            corporateShareholder.setMobileNumber(corporateShareholderReqVo.getMobileNumber().strip());
            corporateShareholder.setEmail(corporateShareholderReqVo.getEmail().strip());
            corporateShareholder.setIdentityCardNumber(corporateShareholderReqVo.getIdentityCardNumber().strip());
            corporateShareholder.setAddress(StringUtil.capitalizeEachWord(corporateShareholderReqVo.getAddress()));
            corporateShareholder.setPostcode(corporateShareholderReqVo.getPostcode());
            corporateShareholder.setCity(StringUtil.capitalizeEachWord(corporateShareholderReqVo.getCity()));
            corporateShareholder.setState(StringUtil.capitalizeEachWord(corporateShareholderReqVo.getState()));
            corporateShareholder.setCountry(StringUtil.capitalizeEachWord(corporateShareholderReqVo.getCountry()));
            corporateShareholder.setPercentageOfShareholdings(corporateShareholderReqVo.getPercentageOfShareholdings());
            corporateShareholder.setIdentityDocumentType(corporateShareholderReqVo.getIdentityDocumentType());
            corporateShareholder.setStatus(CorporateShareholder.CorporateShareholderStatus.DRAFT);

            String shareholderIdentityCardFrontImageBase64 = corporateShareholderReqVo.getIdentityCardFrontImage();
            if (!shareholderIdentityCardFrontImageBase64.startsWith("http")) {
                String shareholderIdentityCardFrontImageKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(shareholderIdentityCardFrontImageBase64)
                        .fileName("identityCardFrontImage")
                        .filePath(S3_CORPORATE_PATH + corporateClient.getUserDetail().getIdentityCardNumber() + "/corporate-shareholder/" + corporateShareholder.getIdentityCardNumber()));
                corporateShareholder.setIdentityCardFrontImageKey(shareholderIdentityCardFrontImageKey);
            }

            String shareholderIdentityCardBackImageBase64 = corporateShareholderReqVo.getIdentityCardBackImage();
            if (StringUtil.isNotEmpty(shareholderIdentityCardBackImageBase64) && !shareholderIdentityCardFrontImageBase64.startsWith("http")) {
                String shareholderIdentityCardBackImageKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(shareholderIdentityCardBackImageBase64)
                        .fileName("identityCardBackImage")
                        .filePath(S3_CORPORATE_PATH + corporateClient.getUserDetail().getIdentityCardNumber() + "/corporate-shareholder/" + corporateShareholder.getIdentityCardNumber()));
                corporateShareholder.setIdentityCardBackImageKey(shareholderIdentityCardBackImageKey);
            }

            //Corporate shareholder pep info
            PepInfo shareholderPepInfo = new PepInfo();
            shareholderPepInfo.setPep(corporateShareholderReqVo.getPepDeclaration().getIsPep());
            if (corporateShareholderReqVo.getPepDeclaration().getIsPep()) {
                shareholderPepInfo.setPepType(corporateShareholderReqVo.getPepDeclaration().getPepDeclarationOptions().getRelationship());
                shareholderPepInfo.setPepImmediateFamilyName(corporateShareholderReqVo.getPepDeclaration().getPepDeclarationOptions().getName());
                shareholderPepInfo.setPepPosition(corporateShareholderReqVo.getPepDeclaration().getPepDeclarationOptions().getPosition());
                shareholderPepInfo.setPepOrganisation(corporateShareholderReqVo.getPepDeclaration().getPepDeclarationOptions().getOrganization());

                String pepSupportingDocumentBase64 = corporateShareholderReqVo.getPepDeclaration().getPepDeclarationOptions().getSupportingDocument();
                if (!pepSupportingDocumentBase64.startsWith("http")) {
                    String pepSupportingDocumentKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                            .base64String(pepSupportingDocumentBase64)
                            .fileName("pepSupportingDocument")
                            .filePath(S3_CORPORATE_PATH + corporateClient.getUserDetail().getIdentityCardNumber() + "/corporate-shareholder/" + corporateShareholder.getIdentityCardNumber()));
                    shareholderPepInfo.setPepSupportingDocumentsKey(pepSupportingDocumentKey);
                }
            }
            shareholderPepInfo.setCreatedAt(new Date());
            shareholderPepInfo.setUpdatedAt(new Date());
            pepInfoDao.save(shareholderPepInfo);
            corporateShareholder.setPepInfo(shareholderPepInfo);

            corporateShareholder.setCorporateClient(corporateClient);
            corporateShareholder.setIsDeleted(Boolean.FALSE);
            corporateShareholder.setCreatedAt(new Date());
            corporateShareholder.setUpdatedAt(new Date());
            corporateShareholder = corporateShareholderDao.save(corporateShareholder);

            CorporateShareHolderRespVo resp = new CorporateShareHolderRespVo();
            CorporateShareholderVo shareholderVo = CorporateShareholderVo.corporateShareholderToCorporateShareholderVo(corporateShareholder);
            resp.setCorporateShareholder(shareholderVo);

            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object editShareholder(String apiKey, String referenceNumber, CorporateShareholderEditReqVo corporateShareholderEditReq) {
        validateApiKey(apiKey);
        try {
            CorporateShareHolderRespVo resp = new CorporateShareHolderRespVo();

            CorporateClient corporateClient = corporateClientDao.findByReferenceNumberAndIsDeletedFalse(referenceNumber);
            if (corporateClient == null) {
                throw new GeneralException(CORPORATE_CLIENT_NOT_FOUND);
            }

            CorporateShareholder corporateShareholder = corporateShareholderDao.findByIdAndCorporateClientAndIsDeletedIsFalse(corporateShareholderEditReq.getCorporateShareholderId(), corporateClient)
                    .orElseThrow(() -> new GeneralException(SHAREHOLDER_NOT_FOUND));

            JSONArray validationErrors = new JSONArray();
            if (StringUtil.isNotEmpty(corporateShareholderEditReq.getMobileCountryCode()) && StringUtil.isNotEmpty(corporateShareholderEditReq.getMobileNumber())) {
                String mobileNumber = corporateShareholderEditReq.getMobileCountryCode() + corporateShareholderEditReq.getMobileNumber().strip();
                if (!ValidatorUtil.validMobileNumber(mobileNumber)) {
                    validationErrors.put(corporateShareholderEditReq.getClass().getSimpleName() + "." + "mobileNumber");
                }
            }

            if (StringUtil.isNotEmpty(corporateShareholderEditReq.getEmail())) {
                corporateShareholderEditReq.setEmail(corporateShareholderEditReq.getEmail().strip());
                if (!ValidatorUtil.validEmail(corporateShareholderEditReq.getEmail())) {
                    validationErrors.put(corporateShareholderEditReq.getClass().getSimpleName() + "." + "email");
                }
            }

            if (!validationErrors.isEmpty()) {
                return getInvalidArgumentError(validationErrors);
            }

            Optional.ofNullable(corporateShareholderEditReq.getName()).ifPresent(corporateShareholder::setName);
            Optional.ofNullable(corporateShareholderEditReq.getPercentageOfShareholdings()).ifPresent(corporateShareholder::setPercentageOfShareholdings);
            Optional.ofNullable(corporateShareholderEditReq.getMobileCountryCode()).ifPresent(corporateShareholder::setMobileCountryCode);
            Optional.ofNullable(corporateShareholderEditReq.getMobileNumber()).ifPresent(corporateShareholder::setMobileNumber);
            Optional.ofNullable(corporateShareholderEditReq.getEmail()).ifPresent(corporateShareholder::setEmail);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateShareholderEditReq.getAddress())).ifPresent(corporateShareholder::setAddress);
            Optional.ofNullable(corporateShareholderEditReq.getPostcode()).ifPresent(corporateShareholder::setPostcode);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateShareholderEditReq.getCity())).ifPresent(corporateShareholder::setCity);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateShareholderEditReq.getState())).ifPresent(corporateShareholder::setState);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateShareholderEditReq.getCountry())).ifPresent(corporateShareholder::setCountry);

            corporateShareholder.setUpdatedAt(new Date());
            corporateShareholder = corporateShareholderDao.save(corporateShareholder);

            // Validate shareholder count and shareholdings only if corporate client is not in draft mode and corporate shareholder is completed
            if (!CorporateClient.CorporateClientStatus.DRAFT.equals(corporateClient.getStatus()) && CorporateShareholder.CorporateShareholderStatus.COMPLETED.equals(corporateShareholder.getStatus())) {
                List<CorporateShareholder> mappedShareholders = getMappedShareHolders(corporateClient);
                Object validationResp = ValidatorUtil.shareholderCountAndShareholdingsValidator(mappedShareholders);
                if (validationResp instanceof ErrorResp errorResp) {
                    resp.setMessage(errorResp.getMessage());
                }
            }

            CorporateShareholderVo shareholderVo = CorporateShareholderVo.corporateShareholderToCorporateShareholderVo(corporateShareholder);
            resp.setCorporateShareholder(shareholderVo);
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object deleteShareholder(String apiKey, String referenceNumber, Long corporateShareholderId) {
        validateApiKey(apiKey);
        try {
            BaseResp resp = new BaseResp();

            CorporateClient corporateClient = corporateClientDao.findByReferenceNumberAndIsDeletedFalse(referenceNumber);
            if (corporateClient == null) {
                throw new GeneralException(CORPORATE_CLIENT_NOT_FOUND);
            }
            CorporateShareholder corporateShareholder = corporateShareholderDao.findByIdAndCorporateClientAndIsDeletedIsFalse(corporateShareholderId, corporateClient)
                    .orElseThrow(() -> new GeneralException(SHAREHOLDER_NOT_FOUND));

            List<CorporateShareholdersPivot> mappedShareholder = corporateShareholdersPivotDao.findByCorporateShareholderAndIsDeletedIsFalse(corporateShareholder);
            if (!mappedShareholder.isEmpty()) {
                mappedShareholder.forEach(corporateShareholdersPivot -> {
                    corporateShareholdersPivot.setIsDeleted(Boolean.TRUE);
                    corporateShareholdersPivot.setUpdatedAt(new Date());
                    corporateShareholdersPivotDao.save(corporateShareholdersPivot);
                });
            }

            corporateShareholder.setIsDeleted(Boolean.TRUE);
            corporateShareholder.setUpdatedAt(new Date());
            corporateShareholderDao.save(corporateShareholder);

            // Validate shareholder count and shareholdings only if corporate client is not in draft mode and corporate shareholder is completed
            if (!CorporateClient.CorporateClientStatus.DRAFT.equals(corporateClient.getStatus()) && CorporateShareholder.CorporateShareholderStatus.COMPLETED.equals(corporateShareholder.getStatus())) {
                List<CorporateShareholder> mappedShareholders = getMappedShareHolders(corporateClient);
                Object validationResp = ValidatorUtil.shareholderCountAndShareholdingsValidator(mappedShareholders);
                if (validationResp instanceof ErrorResp errorResp) {
                    resp.setMessage(errorResp.getMessage());
                }
            }

            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object viewShareholder(String apiKey, String referenceNumber, Long corporateShareholderId) {
        validateApiKey(apiKey);
        try {
            CorporateClient corporateClient = corporateClientDao.findByReferenceNumberAndIsDeletedFalse(referenceNumber);
            if (corporateClient == null) {
                throw new GeneralException(CORPORATE_CLIENT_NOT_FOUND);
            }
            CorporateShareholder corporateShareholder = corporateShareholderDao.findByIdAndCorporateClientAndIsDeletedIsFalse(corporateShareholderId, corporateClient)
                    .orElseThrow(() -> new GeneralException(SHAREHOLDER_NOT_FOUND));
            CorporateShareholderVo corporateShareholderVo = CorporateShareholderVo.corporateShareholderToCorporateShareholderVo(corporateShareholder);
            CorporateShareHolderRespVo corporateShareHolderRespVo = new CorporateShareHolderRespVo();
            corporateShareHolderRespVo.setCorporateShareholder(corporateShareholderVo);
            return corporateShareHolderRespVo;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public List<CorporateShareholder> getMappedShareHolders(CorporateClient corporateClient) {
        List<CorporateShareholdersPivot> corporateShareholdersPivotList = corporateShareholdersPivotDao.findAllByCorporateClientAndIsDeletedFalse(corporateClient);
        return corporateShareholdersPivotList.stream()
                .map(CorporateShareholdersPivot::getCorporateShareholder)
                .toList();
    }

    public Object viewCorporateShareholders(String apiKey, String referenceNumber) {
        validateApiKey(apiKey);
        try {
            CorporateClient corporateClient = corporateClientDao.findByReferenceNumberAndIsDeletedFalse(referenceNumber);
            if (corporateClient == null) {
                throw new GeneralException(CORPORATE_CLIENT_NOT_FOUND);
            }

            // Draft Shareholders
            List<CorporateShareholder> draftShareholderList = corporateShareholderDao.findAllByCorporateClientAndStatusAndIsDeletedIsFalse(corporateClient, CorporateShareholder.CorporateShareholderStatus.DRAFT);
            List<CorporateShareholderBaseVo> draftShareholderBaseList = draftShareholderList.stream()
                    .map(CorporateShareholderBaseVo::corporateShareholderToCorporateShareholderBaseVo).toList();

            // Mapped Shareholders
            List<CorporateShareholder> mappedShareHolderList = getMappedShareHolders(corporateClient);
            List<CorporateShareholderBaseVo> mappedShareholderBaseList = mappedShareHolderList.stream()
                    .map(CorporateShareholderBaseVo::corporateShareholderToCorporateShareholderBaseVo).toList();

            CorporateShareholdersRespVo resp = new CorporateShareholdersRespVo();
            resp.setDraftShareholders(draftShareholderBaseList);
            resp.setMappedShareholders(mappedShareholderBaseList);
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    @Transactional
    public Object addShareholder(String apiKey, String referenceNumber, CorporateShareholderAddReqVo corporateShareholderAddReqVo) {
        validateApiKey(apiKey);
        try {
            CorporateClient corporateClient = corporateClientDao.findByReferenceNumberAndIsDeletedFalse(referenceNumber);
            if (corporateClient == null) {
                throw new GeneralException(CORPORATE_CLIENT_NOT_FOUND);
            }

            Map<Long, CorporateShareHolderAddVo> reqShareHoldersMap = corporateShareholderAddReqVo.getShareHolders().stream().collect(Collectors.toMap(CorporateShareHolderAddVo::getId, shareHolder -> shareHolder));

            List<CorporateShareholder> totalShareholders = corporateShareholderDao.findAllByCorporateClientAndIsDeletedIsFalse(corporateClient);

            // Create a temporary list to validate without modifying the original entities
            List<CorporateShareholder> tempShareholders = totalShareholders.stream()
                    .filter(shareholder -> reqShareHoldersMap.containsKey(shareholder.getId()))
                    .map(shareholder -> {
                        CorporateShareHolderAddVo addVo = reqShareHoldersMap.get(shareholder.getId());
                        CorporateShareholder temp = new CorporateShareholder();
                        temp.setId(shareholder.getId());
                        temp.setPercentageOfShareholdings(addVo.getPercentageOfShareholdings() != null
                                ? addVo.getPercentageOfShareholdings()
                                : shareholder.getPercentageOfShareholdings());
                        return temp;
                    }).toList();

            Object validationResp = ValidatorUtil.shareholderCountAndShareholdingsValidator(tempShareholders);
            if (validationResp instanceof ErrorResp errorResp) {
                throw new GeneralException(errorResp.getMessage());
            }

            // List reqShareholders  map from totalShareholders
            List<CorporateShareholder> reqShareholders = totalShareholders.stream()
                    .filter(shareholder -> reqShareHoldersMap.containsKey(shareholder.getId()))
                    .peek(shareholder -> {
                        CorporateShareHolderAddVo addVo = reqShareHoldersMap.get(shareholder.getId());
                        if (addVo.getPercentageOfShareholdings() != null) {
                            shareholder.setPercentageOfShareholdings(addVo.getPercentageOfShareholdings());
                        }
                    }).toList();

            List<CorporateShareholdersPivot> mappedShareholdersPivot = corporateShareholdersPivotDao.findAllByCorporateClientAndIsDeletedFalse(corporateClient);
            Map<Long, CorporateShareholdersPivot> mappedShareholdersMap = mappedShareholdersPivot.stream()
                    .collect(Collectors.toMap(pivot -> pivot.getCorporateShareholder().getId(), pivot -> pivot));
            List<Long> idsToDelete = new ArrayList<>(mappedShareholdersMap.keySet());
            List<Long> reqShareHolderIds = new ArrayList<>(reqShareHoldersMap.keySet());
            idsToDelete.removeAll(reqShareHolderIds);

            if (!idsToDelete.isEmpty()) {
                idsToDelete.forEach(id -> {
                    CorporateShareholdersPivot corporateShareholdersPivot = mappedShareholdersMap.get(id);
                    corporateShareholdersPivot.setIsDeleted(true);
                    corporateShareholdersPivot.setUpdatedAt(new Date());
                    corporateShareholdersPivotDao.save(corporateShareholdersPivot);
                });
            }

            for (CorporateShareholder corporateShareholder : reqShareholders) {
                CorporateShareholdersPivot existingShareholder = mappedShareholdersMap.get(corporateShareholder.getId());
                if (existingShareholder != null) {
                    //Override with new shareholding percentage
                    corporateShareholder.setPercentageOfShareholdings(corporateShareholder.getPercentageOfShareholdings());
                    corporateShareholderDao.save(corporateShareholder);
                } else {
                    addShareholderToPivot(corporateClient, corporateShareholder);
                }
            }
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error ", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    private void addShareholderToPivot(CorporateClient corporateClient, CorporateShareholder corporateShareholder) {
        CorporateShareholdersPivot newPivot = new CorporateShareholdersPivot();
        newPivot.setCorporateClient(corporateClient);
        newPivot.setCorporateShareholder(corporateShareholder);
        newPivot.setIsDeleted(false);
        newPivot.setCreatedAt(new Date());
        newPivot.setUpdatedAt(new Date());
        corporateShareholder.setStatus(CorporateShareholder.CorporateShareholderStatus.COMPLETED);
        corporateShareholder.setUpdatedAt(new Date());
        corporateShareholderDao.save(corporateShareholder);
        corporateShareholdersPivotDao.save(newPivot);
    }

    public Object editShareholderPep(String apiKey, String referenceNumber, Long corporateShareholderId, PepDeclarationVo pepDeclarationVo) {
        validateApiKey(apiKey);
        try {
            CorporateClient corporateClient = corporateClientDao.findByReferenceNumberAndIsDeletedFalse(referenceNumber);

            CorporateShareholder corporateShareholder = corporateShareholderDao.findByIdAndCorporateClientAndIsDeletedIsFalse(corporateShareholderId, corporateClient)
                    .orElseThrow(() -> new GeneralException(SHAREHOLDER_NOT_FOUND));

            PepInfo pepInfo = pepInfoDao.findById(corporateShareholder.getPepInfo().getId())
                    .orElseThrow(() -> new GeneralException(PEP_NOT_FOUND));

            JSONArray jsonArray = ValidatorUtil.pepOptionsValidator(pepDeclarationVo);
            if (!jsonArray.isEmpty()) {
                return getInvalidArgumentError(jsonArray);
            }

            pepInfo.setPep(pepDeclarationVo.getIsPep());
            if (pepInfo.getPep()) {
                pepInfo.setPepType(pepDeclarationVo.getPepDeclarationOptions().getRelationship());
                pepInfo.setPepImmediateFamilyName(pepDeclarationVo.getPepDeclarationOptions().getName());
                pepInfo.setPepPosition(pepDeclarationVo.getPepDeclarationOptions().getPosition());
                pepInfo.setPepOrganisation(pepDeclarationVo.getPepDeclarationOptions().getOrganization());
                String supportingDocument = pepDeclarationVo.getPepDeclarationOptions().getSupportingDocument();
                if (StringUtil.isNotEmpty(supportingDocument) && !supportingDocument.startsWith("http")) {
                    String pepSupportingDocumentKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                            .base64String(supportingDocument)
                            .fileName("pepSupportingDocument")
                            .filePath(S3_CORPORATE_PATH + corporateClient.getUserDetail().getIdentityCardNumber() + "/corporate-shareholder/" + corporateShareholder.getIdentityCardNumber()));
                    pepInfo.setPepSupportingDocumentsKey(pepSupportingDocumentKey);
                }
            } else {
                pepInfo.setPepType(null);
                pepInfo.setPepImmediateFamilyName(null);
                pepInfo.setPepPosition(null);
                pepInfo.setPepOrganisation(null);
                pepInfo.setPepSupportingDocumentsKey(null);
            }
            pepInfo.setUpdatedAt(new Date());
            pepInfo = pepInfoDao.save(pepInfo);

            CorporateShareholderPepRespVo resp = new CorporateShareholderPepRespVo();
            resp.setPepDeclaration(PepDeclarationVo.getPepDeclarationVoFromPepInfo(pepInfo));
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------------Profile--------------------------------
    private CorporateClient getCorporateClient(AppUser appUser, String corporateClientId) {
        CorporateClient corporateClient = null;
        if (UserType.CLIENT.equals(appUser.getUserType())) {
            Client client = clientDao.findByAppUser(appUser).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
            corporateClient = corporateClientDao.findByClientAndIsDeletedFalse(client);
        } else if (StringUtil.isNotEmpty(corporateClientId) && UserType.AGENT.equals(appUser.getUserType())) {
            corporateClient = corporateClientDao.findByCorporateClientIdAndIsDeletedIsFalse(corporateClientId).orElseThrow(() -> new GeneralException(CORPORATE_CLIENT_NOT_FOUND));
        }
        return corporateClient;
    }

    public Object corporateProfileView(String apiKey, String corporateClientId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);
            CorporateProfileRespVo resp = new CorporateProfileRespVo();
            if (corporateClient != null) {
                resp.setCorporateClient(corporateClient.getCorporateClientVo());
                resp.setCorporateDetails(corporateClient.getCorporateDetailsVo());
                resp.setCorporateDocuments(getCorporateDocumentsVo(corporateClient.getCorporateDetails()));
                List<CorporateShareholder> mappedShareholders = getMappedShareHolders(corporateClient);
                List<CorporateShareholderBaseVo> mappedShareholdersBaseVoList = mappedShareholders.stream()
                        .map(CorporateShareholderBaseVo::corporateShareholderToCorporateShareholderBaseVo)
                        .toList();
                resp.setBindedCorporateShareholders(mappedShareholdersBaseVoList);
            }
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object corporateClientDetailsEdit(String apiKey, String corporateClientId, CorporateClientEditReqVo corporateClientEditReqVo) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);

            // Update wealth source details if not null
            Optional.ofNullable(corporateClientEditReqVo.getAnnualIncomeDeclaration())
                    .ifPresent(corporateClient::setAnnualIncomeDeclaration);
            Optional.ofNullable(corporateClientEditReqVo.getSourceOfIncome())
                    .ifPresent(corporateClient::setSourceOfIncome);

            corporateClient.setUpdatedAt(new Date());
            corporateClientDao.save(corporateClient);

            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object corporateDetailsEdit(String apiKey, String corporateClientId, CorporateDetailsReqVo corporateDetailsEditReqVo) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);
            CorporateDetails corporateDetails = corporateClient.getCorporateDetails();

            Optional.ofNullable(corporateDetailsEditReqVo.getEntityName()).ifPresent(corporateDetails::setEntityName);
            Optional.ofNullable(corporateDetailsEditReqVo.getEntityType()).ifPresent(corporateDetails::setEntityType);
            Optional.ofNullable(corporateDetailsEditReqVo.getRegistrationNumber()).ifPresent(corporateDetails::setRegistrationNumber);
            if (corporateDetailsEditReqVo.getDateIncorporate() != null) {
                corporateDetails.setDateIncorporation(new Date(corporateDetailsEditReqVo.getDateIncorporate()));
            }
            Optional.ofNullable(corporateDetailsEditReqVo.getPlaceIncorporate()).ifPresent(corporateDetails::setPlaceIncorporation);
            Optional.ofNullable(corporateDetailsEditReqVo.getBusinessType()).ifPresent(corporateDetails::setBusinessType);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateDetailsEditReqVo.getRegisteredAddress())).ifPresent(corporateDetails::setRegisteredAddress);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateDetailsEditReqVo.getCity())).ifPresent(corporateDetails::setCity);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateDetailsEditReqVo.getState())).ifPresent(corporateDetails::setState);
            Optional.ofNullable(corporateDetailsEditReqVo.getPostcode()).ifPresent(corporateDetails::setPostcode);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateDetailsEditReqVo.getCountry())).ifPresent(corporateDetails::setCountry);
            Optional.ofNullable(corporateDetailsEditReqVo.getContactName()).ifPresent(corporateDetails::setContactName);
            Optional.ofNullable(corporateDetailsEditReqVo.getContactIsMyself()).ifPresent(corporateDetails::setContactIsMyself);
            Optional.ofNullable(corporateDetailsEditReqVo.getContactDesignation()).ifPresent(corporateDetails::setContactDesignation);
            Optional.ofNullable(corporateDetailsEditReqVo.getContactMobileCountryCode()).ifPresent(corporateDetails::setContactMobileCountryCode);
            Optional.ofNullable(corporateDetailsEditReqVo.getContactMobileNumber()).ifPresent(corporateDetails::setContactMobileNumber);
            Optional.ofNullable(corporateDetailsEditReqVo.getContactEmail()).ifPresent(corporateDetails::setContactEmail);

            if (corporateDetailsEditReqVo.getCorporateAddressDetails() != null) {
                CorporateAddressDetailsVo addressDetailsVo = corporateDetailsEditReqVo.getCorporateAddressDetails();

                Boolean isDifferentAddress = addressDetailsVo.getIsDifferentRegisteredAddress();
                if (Boolean.TRUE.equals(isDifferentAddress)) {
                    corporateDetails.setIsDifferentBusinessAddress(Boolean.TRUE);
                    Optional.ofNullable(StringUtil.capitalizeEachWord(addressDetailsVo.getBusinessAddress())).ifPresent(corporateDetails::setBusinessAddress);
                    Optional.ofNullable(addressDetailsVo.getBusinessPostcode()).ifPresent(corporateDetails::setBusinessPostcode);
                    Optional.ofNullable(StringUtil.capitalizeEachWord(addressDetailsVo.getBusinessCity())).ifPresent(corporateDetails::setBusinessCity);
                    Optional.ofNullable(StringUtil.capitalizeEachWord(addressDetailsVo.getBusinessState())).ifPresent(corporateDetails::setBusinessState);
                    Optional.ofNullable(StringUtil.capitalizeEachWord(addressDetailsVo.getBusinessCountry())).ifPresent(corporateDetails::setBusinessCountry);
                } else {
                    corporateDetails.setIsDifferentBusinessAddress(Boolean.FALSE);
                    corporateDetails.setBusinessAddress(StringUtil.capitalizeEachWord(corporateDetails.getRegisteredAddress()));
                    corporateDetails.setBusinessPostcode(corporateDetails.getPostcode());
                    corporateDetails.setBusinessCity(StringUtil.capitalizeEachWord(corporateDetails.getCity()));
                    corporateDetails.setBusinessState(StringUtil.capitalizeEachWord(corporateDetails.getState()));
                    corporateDetails.setBusinessCountry(StringUtil.capitalizeEachWord(corporateDetails.getCountry()));
                }
            }

            corporateDetails.setUpdatedAt(new Date());
            corporateDetailsDao.save(corporateDetails);

            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object corporateClientProfileImageUpdate(String apiKey, String corporateClientId, CorporateProfileImageAddEditReqVo corporateProfileImageAddEditReqVo) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);

            String profilePictureImageBase64 = corporateProfileImageAddEditReqVo.getProfilePicture();
            if ((StringUtil.isNotEmpty(profilePictureImageBase64))) {
                if (!profilePictureImageBase64.startsWith("http")) {
                    String profilePictureImageKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                            .base64String(profilePictureImageBase64)
                            .fileName("profilePictureImage")
                            .filePath(S3_CORPORATE_PATH + corporateClient.getCorporateClientId()));
                    corporateClient.setProfilePictureImageKey(profilePictureImageKey);
                }
            } else {
                AwsS3Util.deleteFile(corporateClient.getProfilePictureImageKey());
                corporateClient.setProfilePictureImageKey(null);
            }

            corporateClient.setUpdatedAt(new Date());
            corporateClientDao.save(corporateClient);

            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------------Beneficiary--------------------------------
    public Object createCorporateBeneficiary(String apiKey, String corporateClientId, CorporateBeneficiaryCreationReqVo corporateBeneficiaryDetailsReq) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);

            int count = corporateBeneficiaryDao.findByCorporateClientAndIsDeletedFalse(corporateClient).size();
            if (count > 10) {
                return getErrorObjectWithMsg(CORPORATE_BENEFICIARY_LIMIT_EXCEEDED);
            }

            boolean exist = corporateBeneficiaryDao.existsByCorporateClientAndIdentityCardNumberAndIsDeletedFalse(corporateClient, corporateBeneficiaryDetailsReq.getIdentityCardNumber());
            if (exist) {
                return getErrorObjectWithMsg("api.beneficiary.exist");
            }

            JSONArray validationErrors = new JSONArray();
            String mobileNumber = corporateBeneficiaryDetailsReq.getMobileCountryCode() + corporateBeneficiaryDetailsReq.getMobileNumber();
            if (!ValidatorUtil.validMobileNumber(mobileNumber)) {
                validationErrors.put(corporateBeneficiaryDetailsReq.getClass().getSimpleName() + "." + "mobileNumber");
            }
            if (corporateBeneficiaryDetailsReq.getEmail() != null && !ValidatorUtil.validEmail(corporateBeneficiaryDetailsReq.getEmail())) {
                validationErrors.put(corporateBeneficiaryDetailsReq.getClass().getSimpleName() + "." + "email");
            }
            if (!validationErrors.isEmpty()) {
                return getInvalidArgumentError(validationErrors);
            }

            CorporateBeneficiaries corporateBeneficiary = new CorporateBeneficiaries();
            corporateBeneficiary.setRelationshipToSettlor(corporateBeneficiaryDetailsReq.getRelationshipToSettlor());
            corporateBeneficiary.setFullName(corporateBeneficiaryDetailsReq.getFullName());
            corporateBeneficiary.setIdentityCardNumber(corporateBeneficiaryDetailsReq.getIdentityCardNumber());
            corporateBeneficiary.setDob(new Date(corporateBeneficiaryDetailsReq.getDob()));
            corporateBeneficiary.setGender(corporateBeneficiaryDetailsReq.getGender());
            corporateBeneficiary.setNationality(corporateBeneficiaryDetailsReq.getNationality());
            corporateBeneficiary.setAddress(StringUtil.capitalizeEachWord(corporateBeneficiaryDetailsReq.getAddress()));
            corporateBeneficiary.setPostcode(corporateBeneficiaryDetailsReq.getPostcode());
            corporateBeneficiary.setCity(StringUtil.capitalizeEachWord(corporateBeneficiaryDetailsReq.getCity()));
            corporateBeneficiary.setState(StringUtil.capitalizeEachWord(corporateBeneficiaryDetailsReq.getState()));
            corporateBeneficiary.setCountry(StringUtil.capitalizeEachWord(corporateBeneficiaryDetailsReq.getCountry()));
            corporateBeneficiary.setResidentialStatus(corporateBeneficiaryDetailsReq.getResidentialStatus());
            corporateBeneficiary.setMaritalStatus(corporateBeneficiaryDetailsReq.getMaritalStatus());
            corporateBeneficiary.setMobileCountryCode(corporateBeneficiaryDetailsReq.getMobileCountryCode());
            corporateBeneficiary.setMobileNumber(corporateBeneficiaryDetailsReq.getMobileNumber());
            if (corporateBeneficiaryDetailsReq.getEmail() != null) {
                corporateBeneficiary.setEmail(corporateBeneficiaryDetailsReq.getEmail());
            }
            corporateBeneficiary.setIdentityDocumentType(corporateBeneficiaryDetailsReq.getDocumentType());

            String identityCardFrontImageBase64 = corporateBeneficiaryDetailsReq.getIdentityCardFrontImage();
            if (!identityCardFrontImageBase64.startsWith("http")) {
                String identityCardFrontImageKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(identityCardFrontImageBase64)
                        .fileName("identityCardFrontImage")
                        .filePath(S3_CORPORATE_PATH + corporateClient.getCorporateClientId() + "/corporate-beneficiary/" + corporateBeneficiary.getIdentityCardNumber()));
                corporateBeneficiary.setIdentityCardFrontImageKey(identityCardFrontImageKey);
            }

            String identityCardBackImageBase64 = corporateBeneficiaryDetailsReq.getIdentityCardBackImage();
            if (StringUtil.isNotEmpty(identityCardBackImageBase64) && !identityCardFrontImageBase64.startsWith("http")) {
                String identityCardBackImageKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(identityCardBackImageBase64)
                        .fileName("identityCardBackImage")
                        .filePath(S3_CORPORATE_PATH + corporateClient.getCorporateClientId() + "/corporate-beneficiary/" + corporateBeneficiary.getIdentityCardNumber()));
                corporateBeneficiary.setIdentityCardBackImageKey(identityCardBackImageKey);
            }

            corporateBeneficiary.setCorporateClient(corporateClient);
            corporateBeneficiary.setIsDeleted(Boolean.FALSE);
            corporateBeneficiary.setCreatedAt(new Date());
            corporateBeneficiary.setUpdatedAt(new Date());
            corporateBeneficiaryDao.save(corporateBeneficiary);

            Long corporateBeneficiaryId = corporateBeneficiary.getId();
            Date dob = corporateBeneficiary.getDob();

            CorporateBeneficiaryCreateRespVo resp = new CorporateBeneficiaryCreateRespVo();
            resp.setIsUnderAge(DateUtil.isUnder18(dob));
            resp.setCorporateGuardianBaseVo(new CorporateGuardianBaseVo());
            resp.setCorporateBeneficiaryId(corporateBeneficiaryId);

            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object updateCorporateBeneficiary(String apiKey, String corporateClientId, Long corporateBeneficiaryId, CorporateBeneficiaryUpdateReqVo corporateBeneficiaryUpdateReq) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);

            CorporateBeneficiaries corporateBeneficiaries = corporateBeneficiaryDao.findByIdAndCorporateClientAndIsDeletedFalse(corporateBeneficiaryId, corporateClient);
            if (corporateBeneficiaries == null) {
                throw new GeneralException(CORPORATE_BENEFICIARY_NOT_FOUND);
            }

            JSONArray validationErrors = new JSONArray();
            if (StringUtil.isNotEmpty(corporateBeneficiaryUpdateReq.getMobileCountryCode()) && StringUtil.isNotEmpty(corporateBeneficiaryUpdateReq.getMobileNumber())) {
                String mobileNumber = corporateBeneficiaryUpdateReq.getMobileCountryCode() + corporateBeneficiaryUpdateReq.getMobileNumber();
                if (!ValidatorUtil.validMobileNumber(mobileNumber)) {
                    validationErrors.put(corporateBeneficiaryUpdateReq.getClass().getSimpleName() + "." + "mobileNumber");
                }
            }

            if (StringUtil.isNotEmpty(corporateBeneficiaryUpdateReq.getEmail())) {
                if (!ValidatorUtil.validEmail(corporateBeneficiaryUpdateReq.getEmail())) {
                    validationErrors.put(corporateBeneficiaryUpdateReq.getClass().getSimpleName() + "." + "email");
                }
            }

            if (!validationErrors.isEmpty()) {
                return getInvalidArgumentError(validationErrors);
            }

            Optional.ofNullable(corporateBeneficiaryUpdateReq.getRelationshipToSettlor()).ifPresent(corporateBeneficiaries::setRelationshipToSettlor);
            Optional.ofNullable(corporateBeneficiaryUpdateReq.getRelationshipToGuardian()).ifPresent(corporateBeneficiaries::setRelationshipToGuardian);
            Optional.ofNullable(corporateBeneficiaryUpdateReq.getFullName()).ifPresent(corporateBeneficiaries::setFullName);
            Optional.ofNullable(corporateBeneficiaryUpdateReq.getGender()).ifPresent(corporateBeneficiaries::setGender);
            Optional.ofNullable(corporateBeneficiaryUpdateReq.getNationality()).ifPresent(corporateBeneficiaries::setNationality);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateBeneficiaryUpdateReq.getAddress())).ifPresent(corporateBeneficiaries::setAddress);
            Optional.ofNullable(corporateBeneficiaryUpdateReq.getPostcode()).ifPresent(corporateBeneficiaries::setPostcode);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateBeneficiaryUpdateReq.getCity())).ifPresent(corporateBeneficiaries::setCity);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateBeneficiaryUpdateReq.getState())).ifPresent(corporateBeneficiaries::setState);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateBeneficiaryUpdateReq.getCountry())).ifPresent(corporateBeneficiaries::setCountry);
            Optional.ofNullable(corporateBeneficiaryUpdateReq.getResidentialStatus()).ifPresent(corporateBeneficiaries::setResidentialStatus);
            Optional.ofNullable(corporateBeneficiaryUpdateReq.getMaritalStatus()).ifPresent(corporateBeneficiaries::setMaritalStatus);
            Optional.ofNullable(corporateBeneficiaryUpdateReq.getMobileCountryCode()).ifPresent(corporateBeneficiaries::setMobileCountryCode);
            Optional.ofNullable(corporateBeneficiaryUpdateReq.getMobileNumber()).ifPresent(corporateBeneficiaries::setMobileNumber);
            Optional.ofNullable(corporateBeneficiaryUpdateReq.getEmail()).ifPresent(corporateBeneficiaries::setEmail);

            corporateBeneficiaries.setUpdatedAt(new Date());
            corporateBeneficiaryDao.save(corporateBeneficiaries);

            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object deleteCorporateBeneficiary(String apiKey, String corporateClientId, Long corporateBeneficiaryId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);

            CorporateBeneficiaries corporateBeneficiaries = corporateBeneficiaryDao.findByIdAndCorporateClientAndIsDeletedFalse(corporateBeneficiaryId, corporateClient);
            if (corporateBeneficiaries == null) {
                throw new GeneralException(CORPORATE_BENEFICIARY_NOT_FOUND);
            }

            corporateBeneficiaries.setIsDeleted(Boolean.TRUE);
            corporateBeneficiaries.setUpdatedAt(new Date());
            corporateBeneficiaryDao.save(corporateBeneficiaries);

            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object viewCorporateBeneficiaries(String apiKey, String corporateClientId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);

            List<CorporateBeneficiaries> corporateBeneficiaries = corporateBeneficiaryDao.findByCorporateClientAndIsDeletedFalse(corporateClient);
            List<CorporateBeneficiaryBaseVo> corporateBeneficiaryBaseVoList = corporateBeneficiaries.stream()
                    .map(CorporateBeneficiaryVo::corporateBeneficiaryToCorporateBeneficiaryBaseVo).toList();

            CorporateBeneficiariesRespVo resp = new CorporateBeneficiariesRespVo();
            resp.setCorporateBeneficiaries(corporateBeneficiaryBaseVoList);

            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object viewCorporateBeneficiaryById(String apiKey, String corporateClientId, Long corporateBeneficiaryId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);

            CorporateBeneficiaries corporateBeneficiaries = corporateBeneficiaryDao.findByIdAndCorporateClientAndIsDeletedFalse(corporateBeneficiaryId, corporateClient);
            if (corporateBeneficiaries == null) {
                throw new GeneralException(CORPORATE_BENEFICIARY_NOT_FOUND);
            }

            CorporateBeneficiaryRespVo resp = new CorporateBeneficiaryRespVo();
            CorporateBeneficiaryVo corporateBeneficiaryVo = CorporateBeneficiaryVo.corporateBeneficiaryToCorporateBeneficiaryViewVo(corporateBeneficiaries);
            CorporateGuardianVo corporateGuardianVo = CorporateGuardianVo.getCorporateGuardianDetailsToCorporateGuardianVo(corporateBeneficiaries.getCorporateGuardian());
            corporateBeneficiaryVo.setCorporateGuardianVo(corporateGuardianVo);

            resp.setCorporateBeneficiary(corporateBeneficiaryVo);

            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------------Portfolio-----------------------------------
    public Object getCorporateClientPortfolio(String apiKey, String corporateClientId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);
            List<ClientPortfolioVo> portfolio = getCorporateClientPortfolio(corporateClient);
            ClientPortfolioRespVo resp = new ClientPortfolioRespVo();
            resp.setPortfolio(portfolio);
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public List<ClientPortfolioVo> getCorporateClientPortfolio(CorporateClient corporateClient) {
        List<ProductOrder> corporateClientPurchasedProducts = productOrderDao.findAllByCorporateClient(corporateClient);
        return corporateClientPurchasedProducts.stream()
                .map(productOrder -> productService.getClientPortfolioVoWithOptions(productOrder))
                .sorted(Comparator.comparing(ClientPortfolioVo::getProductPurchaseDate).reversed())
                .toList();
    }

    public Object getCorporateClientPortfolioProductDetails(String apiKey, String orderReferenceNumber, String corporateClientId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumberAndCorporateClient(orderReferenceNumber, corporateClient)
                    .orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));

            return productService.getClientPortfolioProductDetailsRespVo(productOrder);
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------------Transactions-----------------------------------
    // Includes ProductOrder(PaymentSuccess only), DividendPayment
    public Object getCorporateClientTransactions(String apiKey, String corporateClientId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);
            return productService.getProductTransaction(null, corporateClient);
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------------Bank details--------------------------------
    public Object createBankDetails(String apiKey, String corporateClientId, CorporateBankDetailsReqVo corporateBankDetailsReqVo) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);

            if (bankDetailsDao.findAllByCorporateClientAndIsDeletedIsFalse(corporateClient).size() > 2) {
                return getErrorObjectWithMsg(CORPORATE_BANK_DETAILS_LIMIT_EXCEEDED);
            }

            boolean exist = bankDetailsDao.existsByAccountNumberAndCorporateClientAndIsDeletedIsFalse(corporateBankDetailsReqVo.getAccountNumber().strip(), corporateClient);
            if (exist) {
                return getErrorObjectWithMsg(BANK_ACCOUNT_EXISTS);
            }

            JSONArray jsonArray = ValidatorUtil.getAllNullFields(corporateBankDetailsReqVo);
            if (!validBase64FileExtension(corporateBankDetailsReqVo.getBankAccountProofFile())) {
                jsonArray.put(corporateBankDetailsReqVo.getClass().getSimpleName() + "." + "bankAccountProofFile");
            }

            if (!jsonArray.isEmpty()) {
                return getInvalidArgumentError(jsonArray);
            }


            BankDetails bankDetails = new BankDetails();
            bankDetails.setCorporateClient(corporateClient);
            bankDetails.setBankName(corporateBankDetailsReqVo.getBankName());
            bankDetails.setAccountNumber(corporateBankDetailsReqVo.getAccountNumber().strip());
            bankDetails.setAccountHolderName(corporateBankDetailsReqVo.getAccountHolderName().strip());

            String bankAccountProofFileBase64 = corporateBankDetailsReqVo.getBankAccountProofFile();
            if (!bankAccountProofFileBase64.startsWith("http")) {
                String fileName = bankDetails.getBankName() + "_" + bankDetails.getAccountNumber() + "_bankAccountProofFile";
                String bankAccountProofKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(bankAccountProofFileBase64)
                        .fileName(fileName)
                        .filePath(S3_CORPORATE_PATH + corporateClient.getCorporateClientId() + "/corporate-bankdetails"));
                bankDetails.setBankAccountProofKey(bankAccountProofKey);
            }

            //Address and SwiftCode optional
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateBankDetailsReqVo.getBankAddress())).ifPresent(bankDetails::setBankAddress);
            Optional.ofNullable(corporateBankDetailsReqVo.getPostcode()).ifPresent(bankDetails::setPostcode);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateBankDetailsReqVo.getCity())).ifPresent(bankDetails::setCity);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateBankDetailsReqVo.getState())).ifPresent(bankDetails::setState);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateBankDetailsReqVo.getCountry())).ifPresent(bankDetails::setCountry);
            Optional.ofNullable(corporateBankDetailsReqVo.getSwiftCode()).map(String::strip).ifPresent(bankDetails::setSwiftCode);
            bankDetails.setIsDeleted(false);
            bankDetails.setCreatedAt(new Date());
            bankDetails.setUpdatedAt(new Date());

            bankDetailsDao.save(bankDetails);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object updateBankDetails(String apiKey, String corporateClientId, CorporateBankDetailsEditReqVo corporateBankDetailsEditReqVo) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);

            Long corporateBankId = corporateBankDetailsEditReqVo.getCorporateBankDetailsId();
            BankDetails bankDetails = bankDetailsDao.findByIdAndCorporateClientAndIsDeletedFalse(corporateBankId, corporateClient).orElseThrow(() -> new GeneralException(BANK_DETAILS_NOT_FOUND));

            JSONArray jsonArray = new JSONArray();
            String bankAccountProofFile = corporateBankDetailsEditReqVo.getBankAccountProofFile();
            if (StringUtil.isNotEmpty(bankAccountProofFile) && !bankAccountProofFile.startsWith("http")) {
                if (!validBase64FileExtension(bankAccountProofFile)) {
                    jsonArray.put(corporateBankDetailsEditReqVo.getClass().getSimpleName() + "." + "bankAccountProofFile");
                }
            }

            if (!jsonArray.isEmpty()) {
                return getInvalidArgumentError(jsonArray);
            }

            Optional.ofNullable(corporateBankDetailsEditReqVo.getBankName()).ifPresent(bankDetails::setBankName);
            Optional.ofNullable(corporateBankDetailsEditReqVo.getAccountNumber()).map(String::strip).ifPresent(bankDetails::setAccountNumber);
            Optional.ofNullable(corporateBankDetailsEditReqVo.getAccountHolderName()).map(String::strip).ifPresent(bankDetails::setAccountHolderName);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateBankDetailsEditReqVo.getBankAddress())).ifPresent(bankDetails::setBankAddress);
            Optional.ofNullable(corporateBankDetailsEditReqVo.getPostcode()).ifPresent(bankDetails::setPostcode);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateBankDetailsEditReqVo.getCity())).ifPresent(bankDetails::setCity);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateBankDetailsEditReqVo.getState())).ifPresent(bankDetails::setState);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateBankDetailsEditReqVo.getCountry())).ifPresent(bankDetails::setCountry);
            Optional.ofNullable(corporateBankDetailsEditReqVo.getSwiftCode()).map(String::strip).ifPresent(bankDetails::setSwiftCode);

            if (StringUtil.isNotEmpty(bankAccountProofFile) && !bankAccountProofFile.startsWith("http")) {
                String fileName = bankDetails.getBankName() + "_" + bankDetails.getAccountNumber() + "_bankAccountProofFile";
                String bankAccountProofKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(bankAccountProofFile)
                        .fileName(fileName)
                        .filePath(S3_CORPORATE_PATH + corporateClient.getCorporateClientId() + "/corporate-bankdetails"));
                bankDetails.setBankAccountProofKey(bankAccountProofKey);
            }

            bankDetails.setUpdatedAt(new Date());
            bankDetailsDao.save(bankDetails);

            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object bankDetailsDelete(String apiKey, String corporateClientId, Long corporateBankId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);

            BankDetails bankDetails = bankDetailsDao.findByIdAndCorporateClientAndIsDeletedFalse(corporateBankId, corporateClient).orElseThrow(() -> new GeneralException(BANK_DETAILS_NOT_FOUND));
            bankDetails.setIsDeleted(Boolean.TRUE);
            bankDetails.setUpdatedAt(new Date());
            bankDetailsDao.save(bankDetails);

            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object viewCorporateBankDetailsById(String apiKey, String corporateClientId, Long corporateBankId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);

            BankDetails bankDetails = bankDetailsDao.findByIdAndCorporateClientAndIsDeletedFalse(corporateBankId, corporateClient).orElseThrow(() -> new GeneralException(BANK_DETAILS_NOT_FOUND));

            CorporateBankDetailsRespVo corporateBankDetailsRespVo = new CorporateBankDetailsRespVo();
            corporateBankDetailsRespVo.setCorporateBankDetailsVo(BankDetailsVo.bankDetailsToBankDetailsVo(bankDetails));
            return corporateBankDetailsRespVo;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object getCorporateBankDetails(String apiKey, String corporateClientId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);

            List<BankDetails> bankDetailsList = bankDetailsDao.findAllByCorporateClientAndIsDeletedIsFalse(corporateClient);
            List<BankDetailsVo> bankDetailsVoList = bankDetailsList.stream()
                    .map(BankDetailsVo::bankDetailsToBankDetailsVo).toList();

            CorporateBankDetailsListRespVo resp = new CorporateBankDetailsListRespVo();
            resp.setCorporateBankDetails(bankDetailsVoList);
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------------Guardian--------------------------------
    public Object createCorporateGuardian(String apiKey, String corporateClientId, CorporateGuardianCreationReqVo corporateGuardianReq) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);
            CorporateBeneficiaries corporateBeneficiary = corporateBeneficiaryDao.findByIdAndCorporateClientAndIsDeletedFalse(corporateGuardianReq.getCorporateBeneficiaryId(), corporateClient);
            if (corporateBeneficiary == null) {
                throw new GeneralException(CORPORATE_BENEFICIARY_NOT_FOUND);
            }

            CorporateGuardian corporateGuardian = corporateBeneficiary.getCorporateGuardian();
            if (corporateGuardian != null) {
                return getErrorObjectWithMsg(GUARDIAN_EXIST);
            }

            JSONArray validationErrors = new JSONArray();

            String mobileNumber = corporateGuardianReq.getMobileCountryCode() + corporateGuardianReq.getMobileNumber();
            if (!ValidatorUtil.validMobileNumber(mobileNumber)) {
                validationErrors.put(corporateGuardianReq.getClass().getSimpleName() + "." + "mobileNumber");
            }

            if (corporateGuardianReq.getEmail() != null && !ValidatorUtil.validEmail(corporateGuardianReq.getEmail())) {
                validationErrors.put(corporateGuardianReq.getClass().getSimpleName() + "." + "email");
            }

            if (!validationErrors.isEmpty()) {
                return getInvalidArgumentError(validationErrors);
            }

            CorporateGuardian guardian = new CorporateGuardian();
            guardian.setCorporateClient(corporateClient);
            guardian.setFullName(corporateGuardianReq.getFullName());
            guardian.setIdentityCardNumber(corporateGuardianReq.getIdentityCardNumber());
            guardian.setDob(new Date(corporateGuardianReq.getDob()));
            guardian.setGender(corporateGuardianReq.getGender());
            guardian.setNationality(corporateGuardianReq.getNationality());
            guardian.setAddress(StringUtil.capitalizeEachWord(corporateGuardianReq.getAddress()));
            guardian.setPostcode(corporateGuardianReq.getPostcode());
            guardian.setCity(StringUtil.capitalizeEachWord(corporateGuardianReq.getCity()));
            guardian.setState(StringUtil.capitalizeEachWord(corporateGuardianReq.getState()));
            guardian.setCountry(StringUtil.capitalizeEachWord(corporateGuardianReq.getCountry()));
            guardian.setResidentialStatus(corporateGuardianReq.getResidentialStatus());
            guardian.setMaritalStatus(corporateGuardianReq.getMaritalStatus());
            guardian.setMobileCountryCode(corporateGuardianReq.getMobileCountryCode());
            guardian.setMobileNumber(corporateGuardianReq.getMobileNumber());
            if (corporateGuardianReq.getEmail() != null)
                guardian.setEmail(corporateGuardianReq.getEmail());
            guardian.setIsDeleted(false);
            guardian.setIdentityDocumentType(corporateGuardianReq.getIdentityDocumentType());

            String identityCardFrontImageBase64 = corporateGuardianReq.getIdentityCardFrontImage();
            if (StringUtil.isNotEmpty(identityCardFrontImageBase64) && !identityCardFrontImageBase64.startsWith("http")) {
                String identityCardFrontImageKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(identityCardFrontImageBase64)
                        .fileName("identityCardFrontImage")
                        .filePath(S3_CORPORATE_PATH + corporateClient.getCorporateClientId() + "/corporate-guardian/" + guardian.getIdentityCardNumber()));
                guardian.setIdentityCardFrontImageKey(identityCardFrontImageKey);
            }

            String identityCardBackImageBase64 = corporateGuardianReq.getIdentityCardBackImage();
            if (StringUtil.isNotEmpty(identityCardBackImageBase64) && !identityCardBackImageBase64.startsWith("http")) {
                String identityCardBackImageKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(identityCardBackImageBase64)
                        .fileName("identityCardBackImage")
                        .filePath(S3_CORPORATE_PATH + corporateClient.getCorporateClientId() + "/corporate-guardian/" + guardian.getIdentityCardNumber()));
                guardian.setIdentityCardBackImageKey(identityCardBackImageKey);
            }

            guardian.setCreatedAt(new Date());
            guardian.setUpdatedAt(new Date());
            guardian = corporateGuardianDao.save(guardian);

            corporateBeneficiary.setCorporateGuardian(guardian);
            corporateBeneficiary.setRelationshipToGuardian(corporateGuardianReq.getRelationshipToGuardian());
            corporateBeneficiaryDao.save(corporateBeneficiary);

            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object updateCorporateGuardian(String apiKey, String corporateClientId, Long corporateGuardianId, CorporateGuardianUpdateReqVo corporateGuardianUpdateReq) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);

            CorporateGuardian corporateGuardian = corporateGuardianDao.findByIdAndCorporateClientAndIsDeletedFalse(corporateGuardianId, corporateClient);
            if (corporateGuardian == null) {
                throw new GeneralException(CORPORATE_GUARDIAN_NOT_FOUND);
            }

            JSONArray validationErrors = new JSONArray();
            if (StringUtil.isNotEmpty(corporateGuardianUpdateReq.getMobileCountryCode()) && StringUtil.isNotEmpty(corporateGuardianUpdateReq.getMobileNumber())) {
                String mobileNumber = corporateGuardianUpdateReq.getMobileCountryCode() + corporateGuardianUpdateReq.getMobileNumber();
                if (!ValidatorUtil.validMobileNumber(mobileNumber)) {
                    validationErrors.put(corporateGuardianUpdateReq.getClass().getSimpleName() + "." + "mobileNumber");
                }
            }

            if (StringUtil.isNotEmpty(corporateGuardianUpdateReq.getEmail())) {
                if (!ValidatorUtil.validEmail(corporateGuardianUpdateReq.getEmail())) {
                    validationErrors.put(corporateGuardianUpdateReq.getClass().getSimpleName() + "." + "email");
                }
            }

            if (!validationErrors.isEmpty()) {
                return getInvalidArgumentError(validationErrors);
            }
            Optional.ofNullable(corporateGuardianUpdateReq.getFullName()).ifPresent(corporateGuardian::setFullName);
            Optional.ofNullable(corporateGuardianUpdateReq.getGender()).ifPresent(corporateGuardian::setGender);
            Optional.ofNullable(corporateGuardianUpdateReq.getNationality()).ifPresent(corporateGuardian::setNationality);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateGuardianUpdateReq.getAddress())).ifPresent(corporateGuardian::setAddress);
            Optional.ofNullable(corporateGuardianUpdateReq.getPostcode()).ifPresent(corporateGuardian::setPostcode);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateGuardianUpdateReq.getCity())).ifPresent(corporateGuardian::setCity);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateGuardianUpdateReq.getState())).ifPresent(corporateGuardian::setState);
            Optional.ofNullable(StringUtil.capitalizeEachWord(corporateGuardianUpdateReq.getCountry())).ifPresent(corporateGuardian::setCountry);
            Optional.ofNullable(corporateGuardianUpdateReq.getResidentialStatus()).ifPresent(corporateGuardian::setResidentialStatus);
            Optional.ofNullable(corporateGuardianUpdateReq.getMaritalStatus()).ifPresent(corporateGuardian::setMaritalStatus);
            Optional.ofNullable(corporateGuardianUpdateReq.getMobileCountryCode()).ifPresent(corporateGuardian::setMobileCountryCode);
            Optional.ofNullable(corporateGuardianUpdateReq.getMobileNumber()).ifPresent(corporateGuardian::setMobileNumber);
            Optional.ofNullable(corporateGuardianUpdateReq.getEmail()).ifPresent(corporateGuardian::setEmail);

            corporateGuardian.setUpdatedAt(new Date());
            corporateGuardianDao.save(corporateGuardian);

            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object deleteCorporateGuardian(String apiKey, String corporateClientId, Long corporateGuardianId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);

            CorporateGuardian corporateGuardian = corporateGuardianDao.findByIdAndCorporateClientAndIsDeletedFalse(corporateGuardianId, corporateClient);
            if (corporateGuardian == null) {
                throw new GeneralException(CORPORATE_GUARDIAN_NOT_FOUND);
            }

            Optional<CorporateBeneficiaries> corporateBeneficiary = corporateBeneficiaryDao.findByCorporateGuardianIdAndCorporateClientAndIsDeletedFalse(corporateGuardianId, corporateClient);

            if (corporateBeneficiary.isPresent()) {
                CorporateBeneficiaries beneficiary = corporateBeneficiary.get();
                beneficiary.setCorporateGuardian(null);
                beneficiary.setRelationshipToGuardian(null);
                beneficiary.setUpdatedAt(new Date());
                corporateBeneficiaryDao.save(beneficiary);
            }

            corporateGuardian.setIsDeleted(Boolean.TRUE);
            corporateGuardian.setUpdatedAt(new Date());
            corporateGuardianDao.save(corporateGuardian);

            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object viewCorporateGuardians(String apiKey, String corporateClientId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);

            List<CorporateGuardian> corporateGuardians = corporateGuardianDao.findAllByCorporateClientAndIsDeletedIsFalse(corporateClient);
            List<CorporateGuardianBaseVo> corporateGuardianBaseVoList = corporateGuardians.stream()
                    .map(CorporateGuardianBaseVo::corporateGuardiansBaseToCorporateBankDetailsVo).toList();

            CorporateGuardiansRespVo resp = new CorporateGuardiansRespVo();
            resp.setCorporateGuardians(corporateGuardianBaseVoList);

            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object viewByIdCorporateGuardians(String apiKey, String corporateClientId, Long corporateGuardianId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            CorporateClient corporateClient = getCorporateClient(appUser, corporateClientId);

            CorporateGuardian corporateGuardian = corporateGuardianDao.findByIdAndCorporateClientAndIsDeletedFalse(corporateGuardianId, corporateClient);
            if (corporateGuardian == null) {
                throw new GeneralException(CORPORATE_GUARDIAN_NOT_FOUND);
            }

            CorporateGuardianVo corporateGuardianVo = CorporateGuardianVo.getCorporateGuardianDetailsToCorporateGuardianVo(corporateGuardian);
            CorporateGuardianRespVo corporateGuardianRespVo = new CorporateGuardianRespVo();
            corporateGuardianRespVo.setCorporateGuardian(corporateGuardianVo);

            return corporateGuardianRespVo;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }
}
