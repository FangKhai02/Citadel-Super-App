package com.citadel.backend.service;

import com.citadel.backend.dao.Products.*;
import com.citadel.backend.dao.SettingDao;
import com.citadel.backend.entity.BankDetails;
import com.citadel.backend.entity.Client;
import com.citadel.backend.entity.Corporate.CorporateBeneficiaries;
import com.citadel.backend.entity.Corporate.CorporateClient;
import com.citadel.backend.entity.IndividualBeneficiary;
import com.citadel.backend.entity.Products.*;
import com.citadel.backend.entity.Setting;
import com.citadel.backend.utils.*;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.vo.Agreement.TrustFundAgreementReqVo;
import com.citadel.backend.vo.Enum.ProductOrderType;
import com.citadel.backend.vo.Enum.Status;
import com.citadel.backend.vo.Enum.UserType;
import com.citadel.backend.vo.Agreement.OnboardingAgreementReqVo;
import com.citadel.backend.vo.Agreement.AgreementRespVo;
import com.openhtmltopdf.pdfboxout.PdfRendererBuilder;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import jakarta.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.text.StringEscapeUtils;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import com.citadel.backend.utils.Builder.UploadBase64FileBuilder;

import java.io.*;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.Base64;

@Service
public class PdfService extends BaseService {
    @Resource
    private Configuration freeMakerConfiguration;

    @Resource
    private SettingDao settingDao;

    @Resource
    private ProductOrderPaymentReceiptDao productOrderPaymentReceiptDao;

    @Resource
    private ProductBeneficiariesDao productBeneficiariesDao;

    @Resource
    private ProductAgreementPivotDao productAgreementPivotDao;

    @Resource
    private ProductAgreementDao productAgreementDao;

    @Resource
    private ProductReallocationDao productReallocationDao;

    public static final List<String> AGREEMENT_FILE_LIST = Arrays.asList(
            "CGOT2-TD-DOT-LATEST-INDIVIDUAL.html",
            "CGOT-TD-DOT-LATEST-CORPORATE.html",
            "CGOT-TD-DOT-LATEST-INDIVIDUAL.html",
            "CHT5-TD-DOT-LATEST-CORPORATE.html",
            "CHT5-TD-DOT-LATEST-INDIVIDUAL.html",
            "COBRT-TD-DOT-LATEST-CORPORATE.html",
            "COBRT-TD-DOT-LATEST-INDIVIDUAL.html",
            "ICGT2-ROLLOVER-TD-DOT-LATEST-INDIVIDUAL.html",
            "ICGT4-ROLLOVER-TD-DOT-LATEST-INDIVIDUAL.html",
            "ICHFT-ROLLOVER-TD-DOT-LATEST-CORPORATE.html",
            "ICHFT-ROLLOVER-TD-DOT-LATEST-INDIVIDUAL.html",
            "ICHT2-ROLLOVER-TD-DOT-LATEST-INDIVIDUAL.html",
            "ICHT3-REALLOCATE-TD-DOT-LATEST-INDIVIDUAL.html",
            "ICHT3-TD-DOT-LATEST-CORPORATE.html",
            "ICHT3-TD-DOT-LATEST-INDIVIDUAL.html",
            "ICHT5-TD-DOT-LATEST-CORPORATE.html",
            "ICHT5-TD-DOT-LATEST-INDIVIDUAL.html",
            "ICOBRT-TD-DOT-LATEST-CORPORATE.html",
            "ICOBRT-TD-DOT-LATEST-INDIVIDUAL.html",
            "CCREL-TD-DOT-LATEST-CORPORATE_PROMO.html",
            "CCREL-TD-DOT-LATEST-INDIVIDUAL_PROMO.html",
            "trust_product_agreement.html"
            );

    private static final String CEO_SIGNATURE_IMAGE_KEY = "admin.ceo.signature.image";
    private static final String CEO_NAME_KEY = "admin.ceo.name";
    private static final String CEO_NRIC_KEY = "admin.ceo.nric";
    private static final String DIRECTOR_SIGNATURE_IMAGE_KEY = "admin.director.signature.image";
    private static final String DIRECTOR_NAME_KEY = "admin.director.name";
    private static final String DIRECTOR_NRIC_KEY = "admin.director.nric";
    private static final String DIRECTOR_SIGNATURE_IMAGE_KEY_2 = "admin.director.signature.image.2";
    private static final String DIRECTOR_NAME_KEY_2 = "admin.director.name.2";
    private static final String DIRECTOR_NRIC_KEY_2 = "admin.director.nric.2";

    //----------------------------Common Functions----------------------------
    public String renderTemplate(String templateName, HashMap<String, Object> hashMap) throws Exception {
        Template template = freeMakerConfiguration.getTemplate(templateName);
        return FreeMarkerTemplateUtils.processTemplateIntoString(template, hashMap);
    }

    public String renderHtmlTemplateFromString(String htmlContent, Map<String, Object> model) throws IOException, TemplateException {
        Template temp = new Template("templateFromS3", new StringReader(htmlContent), freeMakerConfiguration);
        return FreeMarkerTemplateUtils.processTemplateIntoString(temp, model);
    }

    public byte[] generatePdf(String renderedTemplate) {
        try (ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
            renderedTemplate = StringUtil.sanitizeFullHtml(renderedTemplate);
            PdfRendererBuilder builder = new PdfRendererBuilder();
            builder.useFastMode();
            builder.withHtmlContent(renderedTemplate, null);
            builder.toStream(outputStream);
            builder.run();
            return outputStream.toByteArray();
        } catch (Exception e) {
            throw new RuntimeException("Failed to generate PDF", e);
        }
    }

    //Set agreement date format
    public static String getFormattedDateWithOrdinal(Date date) {
        if (date == null) {
            return null;
        }
        SimpleDateFormat dayFormat = new SimpleDateFormat("d");
        String day = dayFormat.format(date);

        // Determine the ordinal suffix and convert to superscript
        int dayInt = Integer.parseInt(day);
        String suffix;
        if (dayInt >= 11 && dayInt <= 13) {
            suffix = "<sup>th</sup>";  // Special case for 11th, 12th, 13th (superscript th)
        } else {
            switch (dayInt % 10) {
                case 1:
                    suffix = "<sup>st</sup>";
                    break;  // Superscript for "st"
                case 2:
                    suffix = "<sup>nd</sup>";
                    break;  // Superscript for "nd"
                case 3:
                    suffix = "<sup>rd</sup>";
                    break;  // Superscript for "rd"
                default:
                    suffix = "<sup>th</sup>";
                    break;  // Superscript for "th"
            }
        }

        // Use SimpleDateFormat to get Month and Year
        SimpleDateFormat sdfMonthYear = new SimpleDateFormat("MMMM yyyy");
        String monthYear = sdfMonthYear.format(date).toUpperCase(); // Convert to uppercase

        return day + suffix + " " + monthYear;
    }

    //----------------------------Onboarding Agreement----------------------------
    public AgreementRespVo getPrefilledOnboardingAgreement(UserType userType, OnboardingAgreementReqVo req) {
        try {
            AgreementRespVo resp = new AgreementRespVo();
            String template = prefillOnboardingTemplateV2(userType, StringUtil.capitalizeEachWord(req.getName()), null);
            resp.setHtml(template);

            // 1. Generate PDF
            byte[] pdfByte = generateOnboardingAgreementPdf(userType, StringUtil.capitalizeEachWord(req.getName()), null);

            // 2. Convert byte to base64
            String onboardingAgreementBase64 = Base64.getEncoder().encodeToString(pdfByte);

            String filePath = "temp";
            if (UserType.CLIENT.equals(userType)) {
                filePath = StringUtil.isNotEmpty(req.getIdentityCardNumber())
                        ? S3_SIGN_UP_CLIENT_PATH + req.getIdentityCardNumber()
                        : S3_SIGN_UP_CLIENT_PATH + filePath;
            } else if (UserType.AGENT.equals(userType)) {
                filePath = StringUtil.isNotEmpty(req.getIdentityCardNumber())
                        ? S3_SIGN_UP_AGENT_PATH + req.getIdentityCardNumber()
                        : S3_SIGN_UP_AGENT_PATH + filePath;
            } else if (UserType.CORPORATE_CLIENT.equals(userType)) {
                filePath = StringUtil.isNotEmpty(req.getCorporateClientId())
                        ? S3_CORPORATE_PATH + req.getCorporateClientId()
                        : S3_CORPORATE_PATH + filePath;
            }

            String fileName = "onboarding_agreement_temporary";

            // 4. Upload to S3
            String onboardingAgreementKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(onboardingAgreementBase64)
                    .fileName(fileName)
                    .filePath(filePath));

            // 5. Get and set the download URL
            String pdfUrl = AwsS3Util.getS3DownloadUrl(onboardingAgreementKey);
            resp.setLink(pdfUrl);

            return resp;
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
            throw new GeneralException(ex.getMessage());
        }
    }

    public String prefillOnboardingTemplateV2(UserType userType, String name, String digitalSignatureKey) {
        try {
            //Citadel Admin Name
            String citadelAdminName = Optional.ofNullable(settingDao.findByKey(CITADEL_ADMIN_NAME_SETTING_KEY))
                    .map(Setting::getValue)
                    .orElse("Citadel Group");

            //Contact email format
            String citadelAdminEmail = Optional.ofNullable(settingDao.findByKey(CITADEL_ADMIN_EMAIL_SETTING_KEY))
                    .map(Setting::getValue)
                    .orElse("enquiry@citadelgroup.com.my");

            //ServiceAmount
            String serviceAmount = "1000.00";

            //signatureImage
            String signatureImage = null;
            if (StringUtil.isNotEmpty(digitalSignatureKey)) {
                signatureImage = AwsS3Util.downloadFileToBase64(digitalSignatureKey);
            }
            //Username
            String userName = name;
            //SignedDate
            String signedDate = getFormattedDateWithOrdinal(new Date());

            HashMap<String, Object> hashMap = new HashMap<>();
            hashMap.put("citadelAdminName", citadelAdminName);
            hashMap.put("citadelCorporateEmail", citadelAdminEmail);
            hashMap.put("serviceAmount", serviceAmount);
            hashMap.put("signatureImage", signatureImage);
            hashMap.put("userName", userName);
            hashMap.put("signedDate", signedDate);

            String templateName = "client_onboarding_agreement_V2.html";
            if (userType.equals(UserType.CLIENT)) {
                templateName = "client_onboarding_agreement_V2.html";

                //Agreement Updated Date
                Date agreementUpdatedAt = Optional.ofNullable(settingDao.findByKey(CLIENT_ONBOARDING_AGREEMENT_SETTING_KEY))
                        .map(Setting::getUpdatedAt)
                        .orElse(new Date());
                String agreementUpdatedDate = getFormattedDateWithOrdinal(agreementUpdatedAt);

                hashMap.put("agreementUpdatedDate", agreementUpdatedDate);
            }
            if (userType.equals(UserType.AGENT)) {
                templateName = "client_onboarding_agreement_V2.html";

                //Agreement Updated Date
                Date agreementUpdatedAt = Optional.ofNullable(settingDao.findByKey(CLIENT_ONBOARDING_AGREEMENT_SETTING_KEY))
                        .map(Setting::getUpdatedAt)
                        .orElse(new Date());
                String agreementUpdatedDate = getFormattedDateWithOrdinal(agreementUpdatedAt);

                hashMap.put("agreementUpdatedDate", agreementUpdatedDate);
            }
            if (userType.equals(UserType.CORPORATE_CLIENT)) {
                templateName = "client_onboarding_agreement_V2.html";

                //Agreement Updated Date
                Date agreementUpdatedAt = Optional.ofNullable(settingDao.findByKey(CLIENT_ONBOARDING_AGREEMENT_SETTING_KEY))
                        .map(Setting::getUpdatedAt)
                        .orElse(new Date());
                String agreementUpdatedDate = getFormattedDateWithOrdinal(agreementUpdatedAt);

                hashMap.put("agreementUpdatedDate", agreementUpdatedDate);
            }
            return renderTemplate(templateName, hashMap);
        } catch (Exception ex) {
            log.error("Error prefilling onboarding agreement template", ex);
            throw new GeneralException(ex.getMessage());
        }
    }

    public byte[] generateOnboardingAgreementPdf(UserType userType, String name, String digitalSignatureKey) {
        try {
            String renderedTemplate = prefillOnboardingTemplateV2(userType, name, digitalSignatureKey);
            return generatePdf(renderedTemplate);
        } catch (Exception ex) {
            log.error("Error generating onboarding agreement pdf", ex);
            throw new GeneralException(ex.getMessage());
        }
    }

    //----------------------------Trust Product Agreement----------------------------
    public byte[] generateTrustProductAgreementPdf(UserType userType, ProductOrder productOrder, String digitalSignature, TrustFundAgreementReqVo trustFundAgreementReqVo, Boolean withoutSignatures) {
        try {
            String renderedTemplate;
            String witnessName = null, witnessIdentityCardNumber = null;
            if (trustFundAgreementReqVo != null && !UserType.CLIENT.equals(userType)) {
                if (trustFundAgreementReqVo.getFullName() != null && trustFundAgreementReqVo.getIdentityCardNumber() != null) {
                    witnessName = trustFundAgreementReqVo.getFullName();
                    witnessIdentityCardNumber = trustFundAgreementReqVo.getIdentityCardNumber();
                }
            }
            if (productOrder.getCorporateClient() != null) {
                renderedTemplate = prefillTrustProductAgreementCorporate(userType, productOrder, digitalSignature, witnessName, witnessIdentityCardNumber, withoutSignatures);
            } else {
                renderedTemplate = prefillTrustProductAgreementIndividual(userType, productOrder, digitalSignature, witnessName, witnessIdentityCardNumber, withoutSignatures);
            }
            return generatePdf(renderedTemplate);
        } catch (Exception ex) {
            log.error("Error generating trust product agreement pdf", ex);
            throw new GeneralException(ex.getMessage());
        }
    }

    public String getTrustProductAgreementFileName(ProductOrder productOrder, ProductAgreement.ClientType clientType) {
        String agreementTemplateName = productAgreementPivotDao.findProductAgreementTemplateName(productOrder.getProduct().getId(), clientType);

        if (StringUtil.isEmpty(agreementTemplateName)) {
            String productCode = productOrder.getProduct().getCode().toUpperCase();
            String userTypeSuffix = clientType.name();

            // Search in AGREEMENT_FILE_LIST for any file that starts with productCode and ends with the correct suffix
            agreementTemplateName = AGREEMENT_FILE_LIST.stream()
                    .filter(agreementFile -> agreementFile.toUpperCase().startsWith(productCode)
                            && agreementFile.toUpperCase().contains(userTypeSuffix))
                    .findFirst()
                    .orElse("trust_product_agreement.html");
        }
        if (!agreementTemplateName.endsWith(".html")) {
            agreementTemplateName += ".html";
        }
        if (!AGREEMENT_FILE_LIST.contains(agreementTemplateName)) {
            agreementTemplateName = "trust_product_agreement.html";
        }
        return agreementTemplateName;
    }

    //1st execution of this function is by Client, then only by Agent
    public String prefillTrustProductAgreementIndividual(UserType userType, ProductOrder productOrder, String digitalSignature, String witnessName, String witnessIdentityCardNumber, Boolean withoutSignatures) {
        try {
            String agreementTemplateName = getTrustProductAgreementFileName(productOrder, ProductAgreement.ClientType.INDIVIDUAL);

            HashMap<String, Object> hashMap = new HashMap<>();
            String agentName = StringUtil.isEmpty(witnessName) ? " " : witnessName;
            String agentIdentityId = StringUtil.isEmpty(witnessIdentityCardNumber) ? " " : witnessIdentityCardNumber;

            //Client Details
            String clientName = null;
            String clientId = null;
            if (productOrder.getClient() != null) {
                Client client = productOrder.getClient();
                //Agreement Date
                LocalDate now = LocalDate.now();
                if (productOrder.getAgreementDate() != null) {
                    now = productOrder.getAgreementDate();
                }
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMMM, yyyy");
                String agreementSignedDate = now.format(formatter);
                DateTimeFormatter monthYearFormatter = DateTimeFormatter.ofPattern("MMMM yyyy");
                String agreementDateMonthYear = now.format(monthYearFormatter);

                //Client ID
                clientId = client.getClientId();
                //Client Name
                clientName = StringUtil.capitalizeEachWord(client.getUserDetail().getName());
                //Client IdentityId
                String clientIdentityId = client.getUserDetail().getIdentityCardNumber();
                //Client Address
                String clientAddress = client.getUserDetail().getFullAddress();
                //Trust Fund Amount
                DecimalFormat decimalFormatter = new DecimalFormat("#,##0.00");
                String trustFundAmount = decimalFormatter.format(productOrder.getPurchasedAmount());

                //Principal Beneficiary
                String principalBeneficiaryName = clientName;
                String principalBeneficiaryIdentityId = clientIdentityId;
                String principalBeneficiaryAddress = clientAddress;
                //Principal Beneficiary Bank Details
                BankDetails bankDetails = productOrder.getBank();
                String principalBeneficiaryBankName = bankDetails.getBankName();
                String principalBeneficiaryBankAccountHolderName = bankDetails.getAccountHolderName();
                String principalBeneficiaryBankAccountNumber = StringUtil.capitalizeEachWord(bankDetails.getAccountNumber());
                String principalBeneficiaryBankAddress = StringUtil.isNotEmpty(bankDetails.getFullBankAddress()) ? bankDetails.getFullBankAddress() : "N/A";
                String principalBeneficiaryBankSwiftCode = StringUtil.isNotEmpty(bankDetails.getSwiftCode()) ? bankDetails.getSwiftCode() : "N/A";

                //Beneficiaries
                List<ProductBeneficiaries> productBeneficiariesList = productBeneficiariesDao.findByProductOrder(productOrder);
                if (productBeneficiariesList.size() < 5) {
                    int toAdd = 5 - productBeneficiariesList.size();
                    for (int i = 0; i < toAdd; i++) {
                        productBeneficiariesList.add(null);
                    }
                }

                //Beneficiary 1
                ProductBeneficiaries beneficiary1 = productBeneficiariesList.get(0);
                String beneficiaryOneName = " ";
                String beneficiaryOneIdentityId = " ";
                String beneficiaryOneAddress = " ";
                String beneficiaryOneDistribution = " ";
                String beneficiaryOneRelation = " ";
                String beneficiaryOnePhoneNumber = " ";
                String beneficiaryOneEmail = " ";
                if (beneficiary1 != null) {
                    IndividualBeneficiary beneficiary = beneficiary1.getBeneficiary();
                    beneficiaryOneName = StringUtil.isNotEmpty(beneficiary.getFullName()) ? beneficiary.getFullName() : " ";
                    beneficiaryOneIdentityId = StringUtil.isNotEmpty(beneficiary.getIdentityCardNumber()) ? beneficiary.getIdentityCardNumber() : " ";
                    beneficiaryOneAddress = StringUtil.isNotEmpty(beneficiary.getFullAddress()) ? beneficiary.getFullAddress() : " ";
                    beneficiaryOneDistribution = beneficiary1.getPercentage() != null ? beneficiary1.getPercentage().toString() : " ";
                    beneficiaryOneRelation = beneficiary1.getMainBeneficiary() != null ? "Substitute Beneficiary" : (beneficiary.getRelationshipToSettlor() != null ? beneficiary.getRelationshipToSettlor().getValue() : " ");
                    beneficiaryOnePhoneNumber = StringUtil.isNotEmpty(beneficiary.getFullMobileNumber()) ? beneficiary.getFullMobileNumber() : " ";
                    beneficiaryOneEmail = StringUtil.isNotEmpty(beneficiary.getEmail()) ? beneficiary.getEmail() : " ";
                }

                //Beneficiary 2
                ProductBeneficiaries beneficiary2 = productBeneficiariesList.get(1);
                String beneficiaryTwoName = " ";
                String beneficiaryTwoIdentityId = " ";
                String beneficiaryTwoAddress = " ";
                String beneficiaryTwoDistribution = " ";
                String beneficiaryTwoRelation = " ";
                String beneficiaryTwoPhoneNumber = " ";
                String beneficiaryTwoEmail = " ";
                if (beneficiary2 != null) {
                    IndividualBeneficiary beneficiary = beneficiary2.getBeneficiary();
                    beneficiaryTwoName = StringUtil.isNotEmpty(beneficiary.getFullName()) ? beneficiary.getFullName() : " ";
                    beneficiaryTwoIdentityId = StringUtil.isNotEmpty(beneficiary.getIdentityCardNumber()) ? beneficiary.getIdentityCardNumber() : " ";
                    beneficiaryTwoAddress = StringUtil.isNotEmpty(beneficiary.getFullAddress()) ? beneficiary.getFullAddress() : " ";
                    beneficiaryTwoDistribution = beneficiary2.getPercentage() != null ? beneficiary2.getPercentage().toString() : " ";
                    beneficiaryTwoRelation = beneficiary2.getMainBeneficiary() != null ? "Substitute Beneficiary" : (beneficiary.getRelationshipToSettlor() != null ? beneficiary.getRelationshipToSettlor().getValue() : " ");
                    beneficiaryTwoPhoneNumber = StringUtil.isNotEmpty(beneficiary.getFullMobileNumber()) ? beneficiary.getFullMobileNumber() : " ";
                    beneficiaryTwoEmail = StringUtil.isNotEmpty(beneficiary.getEmail()) ? beneficiary.getEmail() : " ";
                }

                //Beneficiary 3
                ProductBeneficiaries beneficiary3 = productBeneficiariesList.get(2);
                String beneficiaryThreeName = " ";
                String beneficiaryThreeIdentityId = " ";
                String beneficiaryThreeAddress = " ";
                String beneficiaryThreeDistribution = " ";
                String beneficiaryThreeRelation = " ";
                String beneficiaryThreePhoneNumber = " ";
                String beneficiaryThreeEmail = " ";
                if (beneficiary3 != null) {
                    IndividualBeneficiary beneficiary = beneficiary3.getBeneficiary();
                    beneficiaryThreeName = StringUtil.isNotEmpty(beneficiary.getFullName()) ? beneficiary.getFullName() : " ";
                    beneficiaryThreeIdentityId = StringUtil.isNotEmpty(beneficiary.getIdentityCardNumber()) ? beneficiary.getIdentityCardNumber() : " ";
                    beneficiaryThreeAddress = StringUtil.isNotEmpty(beneficiary.getFullAddress()) ? beneficiary.getFullAddress() : " ";
                    beneficiaryThreeDistribution = beneficiary3.getPercentage() != null ? beneficiary3.getPercentage().toString() : " ";
                    beneficiaryThreeRelation = beneficiary3.getMainBeneficiary() != null ? "Substitute Beneficiary" : (beneficiary.getRelationshipToSettlor() != null ? beneficiary.getRelationshipToSettlor().getValue() : " ");
                    beneficiaryThreePhoneNumber = StringUtil.isNotEmpty(beneficiary.getFullMobileNumber()) ? beneficiary.getFullMobileNumber() : " ";
                    beneficiaryThreeEmail = StringUtil.isNotEmpty(beneficiary.getEmail()) ? beneficiary.getEmail() : " ";
                }

                //Beneficiary 4
                ProductBeneficiaries beneficiary4 = productBeneficiariesList.get(3);
                String beneficiaryFourName = " ";
                String beneficiaryFourIdentityId = " ";
                String beneficiaryFourAddress = " ";
                String beneficiaryFourDistribution = " ";
                String beneficiaryFourRelation = " ";
                String beneficiaryFourPhoneNumber = " ";
                String beneficiaryFourEmail = " ";
                if (beneficiary4 != null) {
                    IndividualBeneficiary beneficiary = beneficiary4.getBeneficiary();
                    beneficiaryFourName = StringUtil.isNotEmpty(beneficiary.getFullName()) ? beneficiary.getFullName() : " ";
                    beneficiaryFourIdentityId = StringUtil.isNotEmpty(beneficiary.getIdentityCardNumber()) ? beneficiary.getIdentityCardNumber() : " ";
                    beneficiaryFourAddress = StringUtil.isNotEmpty(beneficiary.getFullAddress()) ? beneficiary.getFullAddress() : " ";
                    beneficiaryFourDistribution = beneficiary4.getPercentage() != null ? beneficiary4.getPercentage().toString() : " ";
                    beneficiaryFourRelation = beneficiary4.getMainBeneficiary() != null ? "Substitute Beneficiary" : (beneficiary.getRelationshipToSettlor() != null ? beneficiary.getRelationshipToSettlor().getValue() : " ");
                    beneficiaryFourPhoneNumber = StringUtil.isNotEmpty(beneficiary.getFullMobileNumber()) ? beneficiary.getFullMobileNumber() : " ";
                    beneficiaryFourEmail = StringUtil.isNotEmpty(beneficiary.getEmail()) ? beneficiary.getEmail() : " ";
                }

                //Beneficiary 5
                ProductBeneficiaries beneficiary5 = productBeneficiariesList.get(4);
                String beneficiaryFiveName = " ";
                String beneficiaryFiveIdentityId = " ";
                String beneficiaryFiveAddress = " ";
                String beneficiaryFiveDistribution = " ";
                String beneficiaryFiveRelation = " ";
                String beneficiaryFivePhoneNumber = " ";
                String beneficiaryFiveEmail = " ";
                if (beneficiary5 != null) {
                    IndividualBeneficiary beneficiary = beneficiary5.getBeneficiary();
                    beneficiaryFiveName = StringUtil.isNotEmpty(beneficiary.getFullName()) ? beneficiary.getFullName() : " ";
                    beneficiaryFiveIdentityId = StringUtil.isNotEmpty(beneficiary.getIdentityCardNumber()) ? beneficiary.getIdentityCardNumber() : " ";
                    beneficiaryFiveAddress = StringUtil.isNotEmpty(beneficiary.getFullAddress()) ? beneficiary.getFullAddress() : " ";
                    beneficiaryFiveDistribution = beneficiary5.getPercentage() != null ? beneficiary5.getPercentage().toString() : " ";
                    beneficiaryFiveRelation = beneficiary5.getMainBeneficiary() != null ? "Substitute Beneficiary" : (beneficiary.getRelationshipToSettlor() != null ? beneficiary.getRelationshipToSettlor().getValue() : " ");
                    beneficiaryFivePhoneNumber = StringUtil.isNotEmpty(beneficiary.getFullMobileNumber()) ? beneficiary.getFullMobileNumber() : " ";
                    beneficiaryFiveEmail = StringUtil.isNotEmpty(beneficiary.getEmail()) ? beneficiary.getEmail() : " ";
                }

                //Agreement File Name
                String agreementFileName = StringUtil.isNotEmpty(productOrder.getAgreementFileName()) ? productOrder.getAgreementFileName() : " ";

                //Client Details
                String clientPhoneNumber = StringUtil.isNotEmpty(client.getUserDetail().getFullMobileNumber()) ? client.getUserDetail().getFullMobileNumber() : " ";
                String clientEmail = StringUtil.isNotEmpty(client.getUserDetail().getEmail()) ? client.getUserDetail().getEmail() : " ";
                String clientPIC = StringUtil.capitalizeEachWord(client.getAgent().getUserDetail().getName());

                //CEO Details
                //CEO Signature Image
                String ceoSignatureImage = null;
                String ceoSignatureImageKey = Optional.ofNullable(settingDao.findByKey(CEO_SIGNATURE_IMAGE_KEY))
                        .map(Setting::getValue)
                        .orElse(null);
                if (StringUtil.isNotEmpty(ceoSignatureImageKey)) {
                    ceoSignatureImageKey = StringUtil.extractDownloadLinkFromCmsContent(ceoSignatureImageKey);
                    ceoSignatureImage = AwsS3Util.getS3DownloadUrl(ceoSignatureImageKey);
                }
                //CEO Name
                String ceoName = Optional.ofNullable(settingDao.findByKey(CEO_NAME_KEY))
                        .map(Setting::getValue)
                        .orElse(" ");
                //CEO NRIC
                String ceoIdentityId = Optional.ofNullable(settingDao.findByKey(CEO_NRIC_KEY))
                        .map(Setting::getValue)
                        .orElse(" ");

                //Director Details 1
                //Director Signature Image
                String directorSignatureImage = null;
                String directorSignatureImageKey = Optional.ofNullable(settingDao.findByKey(DIRECTOR_SIGNATURE_IMAGE_KEY))
                        .map(Setting::getValue)
                        .orElse(null);
                if (StringUtil.isNotEmpty(directorSignatureImageKey)) {
                    directorSignatureImageKey = StringUtil.extractDownloadLinkFromCmsContent(directorSignatureImageKey);
                    directorSignatureImage = AwsS3Util.getS3DownloadUrl(directorSignatureImageKey);
                }
                //Director Name
                String directorName = Optional.ofNullable(settingDao.findByKey(DIRECTOR_NAME_KEY))
                        .map(Setting::getValue)
                        .orElse(" ");
                //Director NRIC
                String directorIdentityId = Optional.ofNullable(settingDao.findByKey(DIRECTOR_NRIC_KEY))
                        .map(Setting::getValue)
                        .orElse(" ");

                //Director Details 2
                //Director Signature Image
                String directorSignatureImage2 = null;
                String directorSignatureImageKey2 = Optional.ofNullable(settingDao.findByKey(DIRECTOR_SIGNATURE_IMAGE_KEY_2))
                        .map(Setting::getValue)
                        .orElse(null);
                if (StringUtil.isNotEmpty(directorSignatureImageKey2)) {
                    directorSignatureImageKey2 = StringUtil.extractDownloadLinkFromCmsContent(directorSignatureImageKey2);
                    directorSignatureImage2 = AwsS3Util.getS3DownloadUrl(directorSignatureImageKey2);
                }
                //Director Name
                String directorName2 = Optional.ofNullable(settingDao.findByKey(DIRECTOR_NAME_KEY_2))
                        .map(Setting::getValue)
                        .orElse(" ");
                //Director NRIC
                String directorIdentityId2 = Optional.ofNullable(settingDao.findByKey(DIRECTOR_NRIC_KEY_2))
                        .map(Setting::getValue)
                        .orElse(" ");

                hashMap.put("productCode", productOrder.getProduct().getCode().toUpperCase());
                hashMap.put("agreementDateMonthYear", agreementDateMonthYear);
                hashMap.put("agreementSignedDate", agreementSignedDate); //1
                hashMap.put("clientIdentityId", clientIdentityId); //3
                hashMap.put("clientAddress", clientAddress); //4
                hashMap.put("trustFundAmount", trustFundAmount); //5

                hashMap.put("principalBeneficiaryName", principalBeneficiaryName); //6
                hashMap.put("principalBeneficiaryIdentityId", principalBeneficiaryIdentityId); //7
                hashMap.put("principalBeneficiaryAddress", principalBeneficiaryAddress); //8
                hashMap.put("principalBeneficiaryBankName", principalBeneficiaryBankName); //9
                hashMap.put("principalBeneficiaryBankAccountHolderName", principalBeneficiaryBankAccountHolderName); //10
                hashMap.put("principalBeneficiaryBankAccountNumber", principalBeneficiaryBankAccountNumber); //11
                hashMap.put("principalBeneficiaryBankAddress", principalBeneficiaryBankAddress); //12
                hashMap.put("principalBeneficiaryBankSwiftCode", principalBeneficiaryBankSwiftCode); //13

                hashMap.put("beneficiaryOneName", StringUtil.capitalizeEachWord(beneficiaryOneName)); //14,66
                hashMap.put("beneficiaryOneIdentityId", beneficiaryOneIdentityId); //15,68
                hashMap.put("beneficiaryOneAddress", beneficiaryOneAddress); //16,69
                hashMap.put("beneficiaryOneDistribution", beneficiaryOneDistribution); //17
                hashMap.put("beneficiaryOneRelation", beneficiaryOneRelation); //67
                hashMap.put("beneficiaryOnePhoneNumber", beneficiaryOnePhoneNumber); //70
                hashMap.put("beneficiaryOneEmail", beneficiaryOneEmail); //71

                hashMap.put("beneficiaryTwoName", StringUtil.capitalizeEachWord(beneficiaryTwoName)); //18,72
                hashMap.put("beneficiaryTwoIdentityId", beneficiaryTwoIdentityId); //19,74
                hashMap.put("beneficiaryTwoAddress", beneficiaryTwoAddress); //20,75
                hashMap.put("beneficiaryTwoDistribution", beneficiaryTwoDistribution); //21
                hashMap.put("beneficiaryTwoRelation", beneficiaryTwoRelation); //73
                hashMap.put("beneficiaryTwoPhoneNumber", beneficiaryTwoPhoneNumber); //76
                hashMap.put("beneficiaryTwoEmail", beneficiaryTwoEmail); //77

                hashMap.put("beneficiaryThreeName", StringUtil.capitalizeEachWord(beneficiaryThreeName)); //22,78
                hashMap.put("beneficiaryThreeIdentityId", beneficiaryThreeIdentityId); //23,80
                hashMap.put("beneficiaryThreeAddress", beneficiaryThreeAddress); //24,81
                hashMap.put("beneficiaryThreeDistribution", beneficiaryThreeDistribution); //25
                hashMap.put("beneficiaryThreeRelation", beneficiaryThreeRelation); //79
                hashMap.put("beneficiaryThreePhoneNumber", beneficiaryThreePhoneNumber); //82
                hashMap.put("beneficiaryThreeEmail", beneficiaryThreeEmail); //83

                hashMap.put("beneficiaryFourName", StringUtil.capitalizeEachWord(beneficiaryFourName)); //26,84
                hashMap.put("beneficiaryFourIdentityId", beneficiaryFourIdentityId); //27,86
                hashMap.put("beneficiaryFourAddress", beneficiaryFourAddress); //28,87
                hashMap.put("beneficiaryFourDistribution", beneficiaryFourDistribution); //29
                hashMap.put("beneficiaryFourRelation", beneficiaryFourRelation); //85
                hashMap.put("beneficiaryFourPhoneNumber", beneficiaryFourPhoneNumber); //88
                hashMap.put("beneficiaryFourEmail", beneficiaryFourEmail); //89

                hashMap.put("beneficiaryFiveName", StringUtil.capitalizeEachWord(beneficiaryFiveName)); //30,90
                hashMap.put("beneficiaryFiveIdentityId", beneficiaryFiveIdentityId); //31,92
                hashMap.put("beneficiaryFiveAddress", beneficiaryFiveAddress); //32,93
                hashMap.put("beneficiaryFiveDistribution", beneficiaryFiveDistribution); //33
                hashMap.put("beneficiaryFiveRelation", beneficiaryFiveRelation); //91
                hashMap.put("beneficiaryFivePhoneNumber", beneficiaryFivePhoneNumber); //94
                hashMap.put("beneficiaryFiveEmail", beneficiaryFiveEmail); //95

                hashMap.put("agentIdentityId", agentIdentityId); //39,52
                hashMap.put("agreementFileName", agreementFileName); //59

                hashMap.put("clientPhoneNumber", clientPhoneNumber); //63
                hashMap.put("clientEmail", clientEmail); //64
                hashMap.put("clientPIC", clientPIC); //65

                hashMap.put("ceoSignatureImage", ceoSignatureImage); //40,53
                hashMap.put("ceoName", StringUtil.capitalizeEachWord(ceoName)); //41,54
                hashMap.put("ceoIdentityId", ceoIdentityId); //42,55

                hashMap.put("directorSignatureImage", directorSignatureImage); //43,56
                hashMap.put("directorName", StringUtil.capitalizeEachWord(directorName)); //44,57
                hashMap.put("directorIdentityId", directorIdentityId); //45,58

                hashMap.put("directorSignatureImage2", directorSignatureImage2); //43,56
                hashMap.put("directorName2", StringUtil.capitalizeEachWord(directorName2)); //44,57
                hashMap.put("directorIdentityId2", directorIdentityId2); //45,58

                hashMap.put("enableLivingTrust", productOrder.getEnableLivingTrust());

                List<ProductBeneficiaries> subBeneficaryList = productBeneficiariesDao.findAllByProductOrderAndMainBeneficiaryIsNotNull(productOrder);
                subBeneficaryList.forEach(productBeneficiary -> {
                    hashMap.put("substituteBeneficiaryOneName", productBeneficiary.getBeneficiary().getFullName());
                    hashMap.put("substituteBeneficiaryOneIdentityId", productBeneficiary.getBeneficiary().getIdentityCardNumber());
                    hashMap.put("substituteBeneficiaryOneAddress", productBeneficiary.getBeneficiary().getFullAddress());
                    hashMap.put("substituteBeneficiaryOneDistribution", productBeneficiary.getPercentage() != null ? productBeneficiary.getPercentage().toString() : " ");
                    hashMap.put("substituteBeneficiaryOneRelation", "Substitute Beneficiary");
                    hashMap.put("substituteBeneficiaryOnePhoneNumber", StringUtil.isNotEmpty(productBeneficiary.getBeneficiary().getFullMobileNumber()) ? productBeneficiary.getBeneficiary().getFullMobileNumber() : " ");
                    hashMap.put("substituteBeneficiaryOneEmail", StringUtil.isNotEmpty(productBeneficiary.getBeneficiary().getEmail()) ? productBeneficiary.getBeneficiary().getEmail() : " ");
                });

            }

            String clientSignatureImage = productOrder.getClientSignatureKey() != null ? AwsS3Util.downloadFileToBase64(productOrder.getClientSignatureKey()) : digitalSignature;

            //Agent Details
            String agentDigitalSignature = null;
            if (UserType.AGENT.equals(userType)) {
                agentDigitalSignature = digitalSignature;
            }

            // For unsigned agreements
            if (withoutSignatures) {
                clientSignatureImage = null;
                agentDigitalSignature = null;
            }

            hashMap.put("clientId", clientId);
            hashMap.put("clientName", clientName); //2,25,48,60
            hashMap.put("clientSignatureImage", clientSignatureImage); //34,47
            hashMap.put("agentName", agentName); //38,51
            hashMap.put("agentIdentityId", agentIdentityId); //39,52
            hashMap.put("agentSignatureImage", agentDigitalSignature); //39,52

            return generateTemplate(agreementTemplateName, hashMap);
        } catch (Exception ex) {
            log.error("Error", ex);
            throw new GeneralException(ex.getMessage());
        }
    }

    public String prefillTrustProductAgreementCorporate(UserType userType, ProductOrder productOrder, String digitalSignature, String witnessName, String witnessIdentityCardNumber, Boolean withoutSignatures) {
        try {
            String agreementTemplateName = getTrustProductAgreementFileName(productOrder, ProductAgreement.ClientType.CORPORATE);

            HashMap<String, Object> hashMap = new HashMap<>();
            String agentName = StringUtil.isEmpty(witnessName) ? " " : witnessName;
            String agentIdentityId = StringUtil.isEmpty(witnessIdentityCardNumber) ? " " : witnessIdentityCardNumber;

            //Corporate Details
            String companyName = null;
            String companyRegistrationNumber = null;
            String companyAddress = null;
            String companyEmail = null;
            String companyPhoneNumber = null;

            CorporateClient corporateClient = productOrder.getCorporateClient();
            //Agreement Date
            LocalDate now = LocalDate.now();
            if (productOrder.getAgreementDate() != null) {
                now = productOrder.getAgreementDate();
            }
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMMM, yyyy");
            String agreementSignedDate = now.format(formatter);
            DateTimeFormatter monthYearFormatter = DateTimeFormatter.ofPattern("MMMM yyyy");
            String agreementDateMonthYear = now.format(monthYearFormatter);

            // Director Details
            String clientName = StringUtil.capitalizeEachWord(corporateClient.getClient().getUserDetail().getName());
            String clientId = corporateClient.getClient().getClientId();
            Client client = corporateClient.getClient();
            String clientIdentityId = corporateClient.getClient().getUserDetail().getIdentityCardNumber();

            // Corporate Details
            // Corporate ID
            // Corporate Name
            companyName = StringUtil.capitalizeEachWord(corporateClient.getCorporateDetails().getEntityName());
            // Corporate Registration Number
            companyRegistrationNumber = corporateClient.getCorporateDetails().getRegistrationNumber();
            // Corporate Address
            companyAddress = corporateClient.getCorporateDetails().getFullAddress();
            //Trust Fund Amount
            DecimalFormat decimalFormatter = new DecimalFormat("#,##0.00");
            String trustFundAmount = decimalFormatter.format(productOrder.getPurchasedAmount());
            companyEmail = corporateClient.getCorporateDetails().getContactEmail();
            companyPhoneNumber = corporateClient.getCorporateDetails().getPhoneNumber();

            //Principal beneficiary
            String principalBeneficiaryCompanyName = companyName;
            String principalBeneficiaryCompanyRegistrationNumber = companyRegistrationNumber;
            String principalBeneficiaryCompanyAddress = companyAddress;

            //Principal Beneficiary Bank Details
            BankDetails bankDetails = productOrder.getBank();
            String principalBeneficiaryCompanyBankName = bankDetails.getBankName();
            String principalBeneficiaryCompanyBankAccountHolderName = bankDetails.getAccountHolderName();
            String principalBeneficiaryCompanyBankAccountNumber = bankDetails.getAccountNumber();
            String principalBeneficiaryCompanyBankAddress = StringUtil.isNotEmpty(bankDetails.getFullBankAddress()) ? bankDetails.getFullBankAddress() : "N/A";
            String principalBeneficiaryCompanyBankSwiftCode = StringUtil.isNotEmpty(bankDetails.getSwiftCode()) ? bankDetails.getSwiftCode() : "N/A";

            //Beneficiaries
            List<ProductBeneficiaries> productBeneficiariesList = productBeneficiariesDao.findByProductOrder(productOrder);
            if (productBeneficiariesList.size() < 5) {
                int toAdd = 5 - productBeneficiariesList.size();
                for (int i = 0; i < toAdd; i++) {
                    productBeneficiariesList.add(null);
                }
            }

            //Beneficiary 1
            ProductBeneficiaries beneficiary1 = productBeneficiariesList.get(0);
            String beneficiaryOneName = " ";
            String beneficiaryOneIdentityId = " ";
            String beneficiaryOneAddress = " ";
            String beneficiaryOneDistribution = " ";
            //String beneficiaryOneRelation = " ";
            String beneficiaryOnePhoneNumber = " ";
            String beneficiaryOneEmail = " ";
            if (beneficiary1 != null) {
                CorporateBeneficiaries beneficiary = beneficiary1.getCorporateBeneficiary();
                beneficiaryOneName = StringUtil.isNotEmpty(beneficiary.getFullName()) ? beneficiary.getFullName() : " ";
                beneficiaryOneIdentityId = StringUtil.isNotEmpty(beneficiary.getIdentityCardNumber()) ? beneficiary.getIdentityCardNumber() : " ";
                beneficiaryOneAddress = StringUtil.isNotEmpty(beneficiary.getFullAddress()) ? beneficiary.getFullAddress() : " ";
                beneficiaryOneDistribution = beneficiary1.getPercentage() != null ? beneficiary1.getPercentage().toString() : " ";
                //beneficiaryOneRelation = beneficiary.getRelationshipToSettlor() != null ? beneficiary.getRelationshipToSettlor().getValue() : " ";
                beneficiaryOnePhoneNumber = StringUtil.isNotEmpty(beneficiary.getFullMobileNumber()) ? beneficiary.getFullMobileNumber() : " ";
                beneficiaryOneEmail = StringUtil.isNotEmpty(beneficiary.getEmail()) ? beneficiary.getEmail() : " ";
            }

            //Beneficiary 2
            ProductBeneficiaries beneficiary2 = productBeneficiariesList.get(1);
            String beneficiaryTwoName = " ";
            String beneficiaryTwoIdentityId = " ";
            String beneficiaryTwoAddress = " ";
            String beneficiaryTwoDistribution = " ";
            //String beneficiaryTwoRelation = " ";
            String beneficiaryTwoPhoneNumber = " ";
            String beneficiaryTwoEmail = " ";
            if (beneficiary2 != null) {
                CorporateBeneficiaries beneficiary = beneficiary2.getCorporateBeneficiary();
                beneficiaryTwoName = StringUtil.isNotEmpty(beneficiary.getFullName()) ? beneficiary.getFullName() : " ";
                beneficiaryTwoIdentityId = StringUtil.isNotEmpty(beneficiary.getIdentityCardNumber()) ? beneficiary.getIdentityCardNumber() : " ";
                beneficiaryTwoAddress = StringUtil.isNotEmpty(beneficiary.getFullAddress()) ? beneficiary.getFullAddress() : " ";
                beneficiaryTwoDistribution = beneficiary2.getPercentage() != null ? beneficiary2.getPercentage().toString() : " ";
                //beneficiaryTwoRelation = beneficiary.getRelationshipToSettlor() != null ? beneficiary.getRelationshipToSettlor().getValue() : " ";
                beneficiaryTwoPhoneNumber = StringUtil.isNotEmpty(beneficiary.getFullMobileNumber()) ? beneficiary.getFullMobileNumber() : " ";
                beneficiaryTwoEmail = StringUtil.isNotEmpty(beneficiary.getEmail()) ? beneficiary.getEmail() : " ";
            }

            //Beneficiary 3
            ProductBeneficiaries beneficiary3 = productBeneficiariesList.get(2);
            String beneficiaryThreeName = " ";
            String beneficiaryThreeIdentityId = " ";
            String beneficiaryThreeAddress = " ";
            String beneficiaryThreeDistribution = " ";
            //String beneficiaryThreeRelation = " ";
            String beneficiaryThreePhoneNumber = " ";
            String beneficiaryThreeEmail = " ";
            if (beneficiary3 != null) {
                CorporateBeneficiaries beneficiary = beneficiary3.getCorporateBeneficiary();
                beneficiaryThreeName = StringUtil.isNotEmpty(beneficiary.getFullName()) ? beneficiary.getFullName() : " ";
                beneficiaryThreeIdentityId = StringUtil.isNotEmpty(beneficiary.getIdentityCardNumber()) ? beneficiary.getIdentityCardNumber() : " ";
                beneficiaryThreeAddress = StringUtil.isNotEmpty(beneficiary.getFullAddress()) ? beneficiary.getFullAddress() : " ";
                beneficiaryThreeDistribution = beneficiary3.getPercentage() != null ? beneficiary3.getPercentage().toString() : " ";
                //beneficiaryThreeRelation = beneficiary.getRelationshipToSettlor() != null ? beneficiary.getRelationshipToSettlor().getValue() : " ";
                beneficiaryThreePhoneNumber = StringUtil.isNotEmpty(beneficiary.getFullMobileNumber()) ? beneficiary.getFullMobileNumber() : " ";
                beneficiaryThreeEmail = StringUtil.isNotEmpty(beneficiary.getEmail()) ? beneficiary.getEmail() : " ";
            }

            //Beneficiary 4
            ProductBeneficiaries beneficiary4 = productBeneficiariesList.get(3);
            String beneficiaryFourName = " ";
            String beneficiaryFourIdentityId = " ";
            String beneficiaryFourAddress = " ";
            String beneficiaryFourDistribution = " ";
            //String beneficiaryFourRelation = " ";
            String beneficiaryFourPhoneNumber = " ";
            String beneficiaryFourEmail = " ";
            if (beneficiary4 != null) {
                CorporateBeneficiaries beneficiary = beneficiary4.getCorporateBeneficiary();
                beneficiaryFourName = StringUtil.isNotEmpty(beneficiary.getFullName()) ? beneficiary.getFullName() : " ";
                beneficiaryFourIdentityId = StringUtil.isNotEmpty(beneficiary.getIdentityCardNumber()) ? beneficiary.getIdentityCardNumber() : " ";
                beneficiaryFourAddress = StringUtil.isNotEmpty(beneficiary.getFullAddress()) ? beneficiary.getFullAddress() : " ";
                beneficiaryFourDistribution = beneficiary4.getPercentage() != null ? beneficiary4.getPercentage().toString() : " ";
                //beneficiaryFourRelation = beneficiary.getRelationshipToSettlor() != null ? beneficiary.getRelationshipToSettlor().getValue() : " ";
                beneficiaryFourPhoneNumber = StringUtil.isNotEmpty(beneficiary.getFullMobileNumber()) ? beneficiary.getFullMobileNumber() : " ";
                beneficiaryFourEmail = StringUtil.isNotEmpty(beneficiary.getEmail()) ? beneficiary.getEmail() : " ";
            }

            //Beneficiary 5
            ProductBeneficiaries beneficiary5 = productBeneficiariesList.get(4);
            String beneficiaryFiveName = " ";
            String beneficiaryFiveIdentityId = " ";
            String beneficiaryFiveAddress = " ";
            String beneficiaryFiveDistribution = " ";
            //String beneficiaryFiveRelation = " ";
            String beneficiaryFivePhoneNumber = " ";
            String beneficiaryFiveEmail = " ";
            if (beneficiary5 != null) {
                CorporateBeneficiaries beneficiary = beneficiary5.getCorporateBeneficiary();
                beneficiaryFiveName = StringUtil.isNotEmpty(beneficiary.getFullName()) ? beneficiary.getFullName() : " ";
                beneficiaryFiveIdentityId = StringUtil.isNotEmpty(beneficiary.getIdentityCardNumber()) ? beneficiary.getIdentityCardNumber() : " ";
                beneficiaryFiveAddress = StringUtil.isNotEmpty(beneficiary.getFullAddress()) ? beneficiary.getFullAddress() : " ";
                beneficiaryFiveDistribution = beneficiary5.getPercentage() != null ? beneficiary5.getPercentage().toString() : " ";
                //beneficiaryFiveRelation = beneficiary.getRelationshipToSettlor() != null ? beneficiary.getRelationshipToSettlor().getValue() : " ";
                beneficiaryFivePhoneNumber = StringUtil.isNotEmpty(beneficiary.getFullMobileNumber()) ? beneficiary.getFullMobileNumber() : " ";
                beneficiaryFiveEmail = StringUtil.isNotEmpty(beneficiary.getEmail()) ? beneficiary.getEmail() : " ";
            }

            //Agreement File Name
            String agreementFileName = StringUtil.isNotEmpty(productOrder.getAgreementFileName()) ? productOrder.getAgreementFileName() : " ";

            //Client Details
            String clientPhoneNumber = StringUtil.isNotEmpty(client.getUserDetail().getFullMobileNumber()) ? client.getUserDetail().getFullMobileNumber() : " ";
            String clientEmail = StringUtil.isNotEmpty(client.getUserDetail().getEmail()) ? client.getUserDetail().getEmail() : " ";
            String clientPIC = StringUtil.capitalizeEachWord(client.getAgent().getUserDetail().getName());

            //Client 2 Details
            boolean requireSecondSignee = false;
            String client2SignatureImage = " ";
            String client2Name = " ";
            String client2IdentityId = " ";
            if (productOrder.isCorporateClientWithSecondSigneeRequirement()) {
                requireSecondSignee = true;
                client2SignatureImage = AwsS3Util.getS3DownloadUrl(productOrder.getClientTwoSignatureKey());
                client2Name = productOrder.getClientTwoSignatureName();
                client2IdentityId = productOrder.getClientTwoSignatureIdNumber();
            }
            hashMap.put("requireSecondSignee", requireSecondSignee);
            hashMap.put("client2SignatureImage", client2SignatureImage);
            hashMap.put("client2Name", client2Name);
            hashMap.put("client2IdentityId", client2IdentityId);

            //CEO Details
            //CEO Signature Image
            String ceoSignatureImage = null;
            String ceoSignatureImageKey = Optional.ofNullable(settingDao.findByKey(CEO_SIGNATURE_IMAGE_KEY))
                    .map(Setting::getValue)
                    .orElse(null);
            if (StringUtil.isNotEmpty(ceoSignatureImageKey)) {
                ceoSignatureImageKey = StringUtil.extractDownloadLinkFromCmsContent(ceoSignatureImageKey);
                ceoSignatureImage = AwsS3Util.getS3DownloadUrl(ceoSignatureImageKey);
            }
            //CEO Name
            String ceoName = Optional.ofNullable(settingDao.findByKey(CEO_NAME_KEY))
                    .map(Setting::getValue)
                    .orElse(" ");
            //CEO NRIC
            String ceoIdentityId = Optional.ofNullable(settingDao.findByKey(CEO_NRIC_KEY))
                    .map(Setting::getValue)
                    .orElse(" ");

            //Director Details
            //Director Signature Image
            String directorSignatureImage = null;
            String directorSignatureImageKey = Optional.ofNullable(settingDao.findByKey(DIRECTOR_SIGNATURE_IMAGE_KEY))
                    .map(Setting::getValue)
                    .orElse(null);
            if (StringUtil.isNotEmpty(directorSignatureImageKey)) {
                directorSignatureImageKey = StringUtil.extractDownloadLinkFromCmsContent(directorSignatureImageKey);
                directorSignatureImage = AwsS3Util.getS3DownloadUrl(directorSignatureImageKey);
            }
            //Director Name
            String directorName = Optional.ofNullable(settingDao.findByKey(DIRECTOR_NAME_KEY))
                    .map(Setting::getValue)
                    .orElse(" ");
            //Director NRIC
            String directorIdentityId = Optional.ofNullable(settingDao.findByKey(DIRECTOR_NRIC_KEY))
                    .map(Setting::getValue)
                    .orElse(" ");

            hashMap.put("productCode", productOrder.getProduct().getCode().toUpperCase());
            hashMap.put("agreementDateMonthYear", agreementDateMonthYear);
            hashMap.put("agreementSignedDate", agreementSignedDate); //1
            hashMap.put("companyName", companyName);//2
            hashMap.put("companyRegistrationNumber", companyRegistrationNumber); //3
            hashMap.put("companyAddress", companyAddress); //4
            hashMap.put("trustFundAmount", trustFundAmount); //5
            hashMap.put("companyEmail", companyEmail);
            hashMap.put("companyPhoneNumber", companyPhoneNumber);

            hashMap.put("principalBeneficiaryCompanyName", principalBeneficiaryCompanyName); //6
            hashMap.put("principalBeneficiaryCompanyRegistrationNumber", principalBeneficiaryCompanyRegistrationNumber); //7
            hashMap.put("principalBeneficiaryCompanyAddress", principalBeneficiaryCompanyAddress); //8
            hashMap.put("principalBeneficiaryCompanyBankName", principalBeneficiaryCompanyBankName); //9
            hashMap.put("principalBeneficiaryCompanyBankAccountHolderName", principalBeneficiaryCompanyBankAccountHolderName); //10
            hashMap.put("principalBeneficiaryCompanyBankAccountNumber", principalBeneficiaryCompanyBankAccountNumber); //11
            hashMap.put("principalBeneficiaryCompanyBankAddress", principalBeneficiaryCompanyBankAddress); //12
            hashMap.put("principalBeneficiaryCompanyBankSwiftCode", principalBeneficiaryCompanyBankSwiftCode); //13

            hashMap.put("beneficiaryOneName", StringUtil.capitalizeEachWord(beneficiaryOneName)); //14,66
            hashMap.put("beneficiaryOneIdentityId", beneficiaryOneIdentityId); //15,68
            hashMap.put("beneficiaryOneAddress", beneficiaryOneAddress); //16,69
            hashMap.put("beneficiaryOneDistribution", beneficiaryOneDistribution); //17
            //hashMap.put("beneficiaryOneRelation", beneficiaryOneRelation); //67
            hashMap.put("beneficiaryOnePhoneNumber", beneficiaryOnePhoneNumber); //70
            hashMap.put("beneficiaryOneEmail", beneficiaryOneEmail); //71

            hashMap.put("beneficiaryTwoName", StringUtil.capitalizeEachWord(beneficiaryTwoName)); //18,72
            hashMap.put("beneficiaryTwoIdentityId", beneficiaryTwoIdentityId); //19,74
            hashMap.put("beneficiaryTwoAddress", beneficiaryTwoAddress); //20,75
            hashMap.put("beneficiaryTwoDistribution", beneficiaryTwoDistribution); //21
            //hashMap.put("beneficiaryTwoRelation", beneficiaryTwoRelation); //73
            hashMap.put("beneficiaryTwoPhoneNumber", beneficiaryTwoPhoneNumber); //76
            hashMap.put("beneficiaryTwoEmail", beneficiaryTwoEmail); //77

            hashMap.put("beneficiaryThreeName", StringUtil.capitalizeEachWord(beneficiaryThreeName)); //22,78
            hashMap.put("beneficiaryThreeIdentityId", beneficiaryThreeIdentityId); //23,80
            hashMap.put("beneficiaryThreeAddress", beneficiaryThreeAddress); //24,81
            hashMap.put("beneficiaryThreeDistribution", beneficiaryThreeDistribution); //25
            //hashMap.put("beneficiaryThreeRelation", beneficiaryThreeRelation); //79
            hashMap.put("beneficiaryThreePhoneNumber", beneficiaryThreePhoneNumber); //82
            hashMap.put("beneficiaryThreeEmail", beneficiaryThreeEmail); //83

            hashMap.put("beneficiaryFourName", StringUtil.capitalizeEachWord(beneficiaryFourName)); //26,84
            hashMap.put("beneficiaryFourIdentityId", beneficiaryFourIdentityId); //27,86
            hashMap.put("beneficiaryFourAddress", beneficiaryFourAddress); //28,87
            hashMap.put("beneficiaryFourDistribution", beneficiaryFourDistribution); //29
            //hashMap.put("beneficiaryFourRelation", beneficiaryFourRelation); //85
            hashMap.put("beneficiaryFourPhoneNumber", beneficiaryFourPhoneNumber); //88
            hashMap.put("beneficiaryFourEmail", beneficiaryFourEmail); //89

            hashMap.put("beneficiaryFiveName", StringUtil.capitalizeEachWord(beneficiaryFiveName)); //30,90
            hashMap.put("beneficiaryFiveIdentityId", beneficiaryFiveIdentityId); //31,92
            hashMap.put("beneficiaryFiveAddress", beneficiaryFiveAddress); //32,93
            hashMap.put("beneficiaryFiveDistribution", beneficiaryFiveDistribution); //33
            //hashMap.put("beneficiaryFiveRelation", beneficiaryFiveRelation); //91
            hashMap.put("beneficiaryFivePhoneNumber", beneficiaryFivePhoneNumber); //94
            hashMap.put("beneficiaryFiveEmail", beneficiaryFiveEmail); //95

            hashMap.put("agentIdentityId", agentIdentityId); //39,52
            hashMap.put("agreementFileName", agreementFileName); //59

            hashMap.put("clientPhoneNumber", clientPhoneNumber); //63
            hashMap.put("clientEmail", clientEmail); //64
            hashMap.put("clientPIC", clientPIC); //65

            hashMap.put("ceoSignatureImage", ceoSignatureImage); //40,53
            hashMap.put("ceoName", StringUtil.capitalizeEachWord(ceoName)); //41,54
            hashMap.put("ceoIdentityId", ceoIdentityId); //42,55

            hashMap.put("directorSignatureImage", directorSignatureImage); //43,56
            hashMap.put("directorName", StringUtil.capitalizeEachWord(directorName)); //44,57
            hashMap.put("directorIdentityId", directorIdentityId); //45,58

            String clientSignatureImage = productOrder.getClientSignatureKey() != null ? AwsS3Util.downloadFileToBase64(productOrder.getClientSignatureKey()) : digitalSignature;

            String companyStampImage = corporateClient.getCompanyStampKey() != null ? AwsS3Util.downloadFileToBase64(corporateClient.getCompanyStampKey()) : null;

            //Agent Details
            String agentDigitalSignature = null;
            if (UserType.AGENT.equals(userType)) {
                agentDigitalSignature = digitalSignature;
            }

            // For unsigned agreements
            if (withoutSignatures) {
                clientSignatureImage = null;
                agentDigitalSignature = null;
            }

            hashMap.put("clientId", clientId);
            hashMap.put("clientName", clientName); //2,25,48,60
            hashMap.put("clientIdentityId", clientIdentityId);
            hashMap.put("clientSignatureImage", clientSignatureImage); //34,47
            hashMap.put("companyStamp", companyStampImage);
            hashMap.put("agentName", agentName); //38,51
            hashMap.put("agentIdentityId", agentIdentityId);
            hashMap.put("agentSignatureImage", agentDigitalSignature); //39,52

            return generateTemplate(agreementTemplateName, hashMap);
        } catch (Exception ex) {
            log.error("Error", ex);
            throw new GeneralException(ex.getMessage());
        }
    }

    private String generateTemplate(String agreementTemplateName, HashMap<String, Object> hashMap) throws Exception {
        String overwriteAgreementKey = productAgreementDao.findOverrideAgreementKey(agreementTemplateName);
        if (StringUtil.isNotEmpty(overwriteAgreementKey)) {
            String s3Key = StringUtil.extractDownloadLinkFromCmsContent(overwriteAgreementKey);
            if (StringUtil.isNotEmpty(s3Key)) {
                String htmlTemplateContent = AwsS3Util.downloadHtmlContentAsString(s3Key);
                htmlTemplateContent = StringEscapeUtils.unescapeHtml4(htmlTemplateContent);
                htmlTemplateContent = htmlTemplateContent.replace("<!--#if-->", "</#if>");
                htmlTemplateContent = htmlTemplateContent.replaceAll(
                        "src\\s*=\\s*\"http[^\\\"]*\\$\\{(.*?)\\}\"",
                        "src=\"\\${$1}\""
                );
                return renderHtmlTemplateFromString(htmlTemplateContent, hashMap);
            }
        }
        return renderTemplate(agreementTemplateName, hashMap);
    }

    //----------------------------Withdrawal Agreement----------------------------
    public String prefillWithdrawalAgreement(UserType userType, ProductEarlyRedemptionHistory earlyRedemptionHistory, String digitalSignature, String witnessName) {
        try {
            //Template
            String templateName = "withdrawal_agreement.html";

            ProductOrder productOrder = earlyRedemptionHistory.getProductOrder();

            //Client Details
            String clientName = productOrder.getClientName();
            String clientDigitalSignature = earlyRedemptionHistory.getClientSignatureKey() != null ? AwsS3Util.downloadFileToBase64(earlyRedemptionHistory.getClientSignatureKey()) : digitalSignature;
            LocalDate clientSignatureDate = earlyRedemptionHistory.getClientSignatureDate() != null ? earlyRedemptionHistory.getClientSignatureDate() : LocalDate.now();

            //Client SignedDate
            String formattedClientSignatureDate = getFormattedDateWithOrdinal(DateUtil.convertLocalDateToDate(clientSignatureDate));

            //Agent Details

            String agentName = " ";
            String agentDigitalSignature = null;
            LocalDate agentSignatureDate = null;
            if (UserType.AGENT.equals(userType)) {
                agentDigitalSignature = digitalSignature;
                agentSignatureDate = LocalDate.now();
                if (StringUtils.isNotEmpty(witnessName)) {
                    agentName = StringUtil.capitalizeEachWord(witnessName);
                }
            }
            //Agent SignedDate
            String formattedAgentSignatureDate = getFormattedDateWithOrdinal(DateUtil.convertLocalDateToDate(agentSignatureDate));

            HashMap<String, Object> hashMap = new HashMap<>();
            hashMap.put("clientName", clientName);
            hashMap.put("clientSignedDate", formattedClientSignatureDate);
            hashMap.put("clientSignatureImage", clientDigitalSignature);
            hashMap.put("agentName", agentName);
            hashMap.put("agentSignedDate", formattedAgentSignatureDate);
            hashMap.put("agentSignatureImage", agentDigitalSignature);

            return renderTemplate(templateName, hashMap);
        } catch (Exception ex) {
            log.error("Error", ex);
            throw new GeneralException(ex.getMessage());
        }
    }

    public byte[] generateWithdrawalAgreementPdf(UserType userType, ProductEarlyRedemptionHistory earlyRedemptionHistory, String digitalSignatureKey, String witnessName) {
        try {
            String renderedTemplate = prefillWithdrawalAgreement(userType, earlyRedemptionHistory, digitalSignatureKey, witnessName);
            return generatePdf(renderedTemplate);
        } catch (Exception ex) {
            log.error("Error generating withdrawal agreement pdf", ex);
            throw new GeneralException(ex.getMessage());
        }
    }

    //----------------------------Statement of Account----------------------------
    public String prefillStatementOfAccount(ProductOrder productOrder, List<ProductDividendCalculationHistory> dividendCalculationHistories) throws Exception {
        String templateName = "statement_of_account.html";
        HashMap<String, Object> hashMap = new HashMap<>();
        // Dummy records list
        List<Map<String, String>> records = new ArrayList<>();

        String client_name, customer_address;

        if (productOrder.getClient() != null) {
            client_name = productOrder.getClient().getUserDetail().getName();
            customer_address = productOrder.getClient().getUserDetail().getFullAddress();

        } else if (productOrder.getCorporateClient() != null) {
            client_name = productOrder.getCorporateClient().getCorporateDetails().getEntityName();
            customer_address = productOrder.getCorporateClient().getCorporateDetails().getFullAddress();
        } else {
            client_name = "John Doe";
            customer_address = "123, Jalan ABC, 12345 Kuala Lumpur";
        }

        hashMap.put("client_name", client_name);
        hashMap.put("customer_address", customer_address);
        Date statementDate = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
        hashMap.put("statement_date", sdf.format(statementDate));
        hashMap.put("reference_no", productOrder.getAgreementFileName() != null ? productOrder.getAgreementFileName() : "-");
        DateTimeFormatter formatterDate = DateTimeFormatter.ofPattern("MMM yy"); // Formats as "Jan 25"
        DecimalFormat formatter = new DecimalFormat("#,##0.00");
        double homeBalance = 0;

        records.add(Map.of(
                "date", "",
                "journal_type", "",
                "ref_no", "BALANCE B/F",
                "description", "",
                "home_dr", "",
                "home_cr", "",
                "home_balance", homeBalance == 0 ? "-" : formatter.format(homeBalance)
        ));

        homeBalance += productOrder.getPurchasedAmount();
        String date = productOrder.getCreatedAt().toString();
        String[] dateArray = date.split(" ");
        String[] dateArray2 = dateArray[0].split("-");
        String formattedDate = dateArray2[2] + "-" + dateArray2[1] + "-" + dateArray2[0];
        String refNo = "OR-" + dateArray2[0] + dateArray2[1];

        records.add(Map.of(
                "date", formattedDate,
                "journal_type", "BANK",
                "ref_no", productOrder.getOrderReferenceNumber(),
                "description", productOrder.getAgreementFileName() != null ? productOrder.getAgreementFileName() : "-",
                "home_dr", "",
                "home_cr", formatter.format(productOrder.getPurchasedAmount()),
                "home_balance", homeBalance == 0 ? "-" : formatter.format(homeBalance)
        ));

        int i = 1;
        for (ProductDividendCalculationHistory dividendCalculationHistory : dividendCalculationHistories) {
            homeBalance += dividendCalculationHistory.getDividendAmount();
            String dividendDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(dividendCalculationHistory.getCreatedAt());
            String[] dividendDateArray = dividendDate.split(" ");
            String[] dividendDateArray2 = dividendDateArray[0].split("-");
            String formattedDateDividend = dividendDateArray2[2] + "-" + dividendDateArray2[1] + "-" + dividendDateArray2[0];

            String formattedPeriodStart = dividendCalculationHistory.getPeriodStartingDate().format(formatterDate);
            String formattedPeriodEnd = dividendCalculationHistory.getPeriodEndingDate().format(formatterDate);
            LocalDate dateBatch = dividendCalculationHistory.getPeriodStartingDate();
            String batch;
//            if date dateBatch >= 15. Batch 2, else batch 1
            if (dateBatch.getDayOfMonth() >= 15) {
                batch = "2";
            } else {
                batch = "1";
            }


            records.add(Map.of(
                    "date", formattedDateDividend,
                    "journal_type", "GENERAL",
                    "ref_no", dividendCalculationHistory.getReferenceNumber(),
                    "description", "Batch " + batch + " (" + formattedPeriodStart + ") - Q" + i + " Profit Sharing (" + formattedPeriodEnd + ")",
                    "home_dr", "",
                    "home_cr", formatter.format(dividendCalculationHistory.getDividendAmount()),
                    "home_balance", homeBalance == 0 ? "-" : formatter.format(homeBalance)
            ));
            if (Status.SUCCESS.equals(dividendCalculationHistory.getPaymentStatus())) {
                homeBalance -= dividendCalculationHistory.getDividendAmount();
                records.add(Map.of(
                        "date", formattedDateDividend,
                        "journal_type", "BANK",
                        "ref_no", dividendCalculationHistory.getReferenceNumber(),
                        "description", "Q" + i + " Profit Sharing Paid",
                        "home_dr", formatter.format(dividendCalculationHistory.getDividendAmount()),
                        "home_cr", "",
                        "home_balance", homeBalance == 0 ? "-" : formatter.format(homeBalance)
                ));
            }
            i++;
        }

        // add sum of home_dr and home_cr
        double total_home_dr = 0.0;
        double total_home_cr = 0.0;

        for (Map<String, String> record : records) {
            if (!record.get("home_dr").isEmpty()) {
                total_home_dr += Double.parseDouble(record.get("home_dr").replace(",", ""));
            }
            if (!record.get("home_cr").isEmpty()) {
                total_home_cr += Double.parseDouble(record.get("home_cr").replace(",", ""));
            }
        }

        hashMap.put("total_home_dr", formatter.format(total_home_dr));
        hashMap.put("total_home_cr", formatter.format(total_home_cr));

// Add records to the hashmap
        hashMap.put("records", records);

        hashMap.put("amount_due", homeBalance == 0 ? "-" : formatter.format(homeBalance));

        //Generate PDF and save to local for testing
        return renderTemplate(templateName, hashMap);
    }

    public byte[] generateStatementOfAccountPdf(ProductOrder productOrder, List<ProductDividendCalculationHistory> dividendCalculationHistories) {
        try {
            String renderedTemplate = prefillStatementOfAccount(productOrder, dividendCalculationHistories);
            return generatePdf(renderedTemplate);
        } catch (Exception ex) {
            log.error("Error generating statement of account pdf", ex);
            throw new GeneralException(ex.getMessage());
        }
    }
}
