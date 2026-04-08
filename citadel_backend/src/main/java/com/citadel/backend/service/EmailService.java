package com.citadel.backend.service;

import com.citadel.backend.dao.SettingDao;
import com.citadel.backend.entity.*;
import com.citadel.backend.entity.Corporate.CorporateClient;
import com.citadel.backend.entity.Products.*;
import com.citadel.backend.utils.AwsS3Util;
import com.citadel.backend.utils.BaseService;
import com.citadel.backend.utils.Builder.UploadBase64FileBuilder;
import com.citadel.backend.utils.MathUtil;
import com.citadel.backend.vo.Enum.NiuApplicationType;
import com.citadel.backend.vo.Enum.UserType;
import com.citadel.backend.vo.Product.PhysicalTrustDeedReminderInterfaceVo;
import com.citadel.backend.vo.SendGrid.Attachment;
import jakarta.annotation.Resource;
import jakarta.validation.constraints.NotNull;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class EmailService extends BaseService {
    private static final String ONBOARDING_AGREEMENT_EMAIL_SUBJECT = "Welcome to Citadel Super App - Let's Get Started!";

    @Resource
    private PdfService pdfService;
    @Resource
    private SettingDao settingDao;

    public String sendOnboardingAgreementEmail(@NotNull Object object, @NotNull String runningNumber) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM");
        String dateSdf = sdf.format(new Date()).replace("/", "-");
        String emailBody;
        List<Attachment> attachments = new ArrayList<>();
        StringBuilder sb = new StringBuilder();
        sb.append(dateSdf).append("_").append(runningNumber);

        UserDetail userDetail;
        UserType userType;
        String filePath;
        String userName;
        String digitalSignatureKey;
        String receiverEmail;

        //Client
        if (object instanceof Client client) {
            userType = UserType.CLIENT;
            userDetail = client.getUserDetail();
            sb.append("-I");
            filePath = S3_SIGN_UP_CLIENT_PATH + userDetail.getIdentityCardNumber();
            userName = userDetail.getName();
            digitalSignatureKey = userDetail.getDigitalSignatureKey();
            receiverEmail = userDetail.getEmail();

            emailBody = "Hi " + userDetail.getName() + ",<br/><br/>" +
                    "Welcome to Citadel Super App! \uD83C\uDF89 We’re excited to have you join our community as a client.<br/><br/>" +
                    "Please find the Onboarding Agreement attached.<br/>" +
                    "Let us know if you have any questions or feedback — we’re here to help!<br/><br/>" +
                    "Yours sincerely,<br/>" +
                    "Citadel Group";
        }
        //Agent
        else if (object instanceof Agent agent) {
            userType = UserType.AGENT;
            userDetail = agent.getUserDetail();
            sb.append("-A");
            filePath = S3_SIGN_UP_AGENT_PATH + userDetail.getIdentityCardNumber();
            userName = userDetail.getName();
            digitalSignatureKey = userDetail.getDigitalSignatureKey();
            receiverEmail = userDetail.getEmail();

            emailBody = "Hi " + userDetail.getName() + ",<br/><br/>" +
                    "Welcome to Citadel Super App! \uD83C\uDF89 We’re excited to have you join our community as an agent.<br/><br/>" +
                    "Please find the Onboarding Agreement attached.<br/>" +
                    "Let us know if you have any questions or feedback — we’re here to help!<br/><br/>" +
                    "Yours sincerely,<br/>" +
                    "Citadel Group";
        }
        //CorporateClient
        else if (object instanceof CorporateClient corporateClient) {
            userType = UserType.CORPORATE_CLIENT;
            sb.append("-C");
            filePath = S3_CORPORATE_PATH + corporateClient.getCorporateClientId();
            userName = corporateClient.getCorporateDetails().getContactName();
            digitalSignatureKey = corporateClient.getDigitalSignatureKey();
            receiverEmail = corporateClient.getCorporateDetails().getContactEmail();

            emailBody = "Hi " + userName + ",<br/><br/>" +
                    "Welcome to Citadel Super App! \uD83C\uDF89 We’re excited to have you join our community as a corporate.<br/><br/>" +
                    "Please find the Onboarding Agreement attached.<br/>" +
                    "Let us know if you have any questions or feedback — we’re here to help!<br/><br/>" +
                    "Yours sincerely,<br/>" +
                    "Citadel Group";
        } else {
            throw new Exception("Invalid object type");
        }

        //1. generate pdf
        byte[] pdfByte = pdfService.generateOnboardingAgreementPdf(userType, userName, digitalSignatureKey);

        //2. convert byte to base64
        String onboardingAgreementBase64 = Base64.getEncoder().encodeToString(pdfByte);

        //3. upload byte to aws s3
        String onboardingAgreementKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                .base64String(onboardingAgreementBase64)
                .fileName(sb.toString())
                .filePath(filePath));

        //4. put base64 to attachment
        Attachment attachment = new Attachment(onboardingAgreementBase64, PDF_FILETYPE, sb.append(".pdf").toString());
        attachments.add(attachment);

        //5. send email with attachment
        sendEmail("Citadel Group",
                receiverEmail.split(","),
                Optional.ofNullable(settingDao.findByKey(CITADEL_ADMIN_EMAIL_SETTING_KEY))
                        .map(Setting::getValue)
                        .orElse("zack@nexstream.com.my").split(","),
                ONBOARDING_AGREEMENT_EMAIL_SUBJECT,
                emailBody,
                attachments);

        return onboardingAgreementKey;
    }

    @Async
    public void sendUserDeleteRequestEmailToAdmin(Object object, String reason) {
        String userType = null;
        String name = null;
        String fullMobileNumber = null;
        String cmsUserProfileUrl = null;
        if (object instanceof Client client) {
            UserDetail userDetail = client.getUserDetail();
            userType = UserType.CLIENT.name().toLowerCase();
            name = userDetail.getName();
            fullMobileNumber = userDetail.getMobileCountryCode() + userDetail.getMobileNumber();
            cmsUserProfileUrl = "/client?key=client_id&filter=contains&s=" + client.getClientId();
        } else if (object instanceof Agent agent) {
            UserDetail userDetail = agent.getUserDetail();
            userType = UserType.AGENT.name().toLowerCase();
            name = userDetail.getName();
            fullMobileNumber = userDetail.getMobileCountryCode() + userDetail.getMobileNumber();
            cmsUserProfileUrl = "/agent?key=agent_id&filter=contains&s=" + agent.getAgentId();
        }
        String emailBody = "Hi, " + "<br/><br/>" +
                "You have a new delete account request by a " + userType + ".<br/><br/>" +
                "Name" + "<br/><br/>" +
                name + "<br/><br/>" +
                "Mobile Number" + "<br/><br/>" +
                fullMobileNumber + "<br/><br/>" +
                "Reason for Account Deletion" + "<br/><br/>" +
                reason + "<br/><br/>" +
                "Link to " + userType + "<br/><br/>" +
                CMS_HOST + cmsUserProfileUrl + "<br/><br/>";

        String emailSubject = "A " + userType + " request to delete account";

        sendEmail("Citadel Group",
                Optional.ofNullable(settingDao.findByKey(CITADEL_ADMIN_EMAIL_SETTING_KEY))
                        .map(Setting::getValue)
                        .orElse("zack@nexstream.com.my").split(","),
                null,
                emailSubject,
                emailBody,
                null);
    }

    @Async
    public void sendContactUsFormSubmissionEmailToAdmin(ContactUsFormSubmission contactUsFormSubmission) {
        String emailBody = "Hi, " + "<br/><br/>" +
                "You have a new contact us form submission.<br/><br/>" +
                "Name" + "<br/><br/>" +
                contactUsFormSubmission.getName() + "<br/><br/>" +
                "Mobile Number" + "<br/><br/>" +
                contactUsFormSubmission.getMobileCountryCode() + contactUsFormSubmission.getMobileNumber() + "<br/><br/>" +
                "Email" + "<br/><br/>" +
                contactUsFormSubmission.getEmail() + "<br/><br/>" +
                "Reason" + "<br/><br/>" +
                contactUsFormSubmission.getReason() + "<br/><br/>" +
                "Remark" + "<br/><br/>" +
                contactUsFormSubmission.getRemark() + "<br/><br/>" +
                "Submitted At" + "<br/><br/>" +
                contactUsFormSubmission.getCreatedAt() + "<br/><br/>";

        String emailSubject = "A new contact us form submission";

        sendEmail("Citadel Group",
                Optional.ofNullable(settingDao.findByKey(CITADEL_ADMIN_EMAIL_SETTING_KEY))
                        .map(Setting::getValue)
                        .orElse("zack@nexstream.com.my").split(","),
                null,
                emailSubject,
                emailBody,
                null);
    }

    // send withdrawal request email to admin
    @Async
    public void sendWithdrawalRequestEmailToAdmin(ProductEarlyRedemptionHistory productEarlyRedemptionHistory) {
        String cmsProductRedemptionUrl = CMS_HOST + "/product-early-redemption-history?key=redemption_reference_number&filter=contains&s=" + productEarlyRedemptionHistory.getReferenceNumber();

        String emailBody = "Hi Citadel Team, " + "<br/><br/>" +
                "You have a new Early Redemption Request.<br/><br/>" +
                "Click here to view: <a href=\"" + cmsProductRedemptionUrl + "\">Early Redemption Record</a><br/><br/>";

        String emailSubject = "New Early Redemption Request";

        sendEmail("Citadel Group",
                Optional.ofNullable(settingDao.findByKey(CITADEL_WITHDRAWAL_DIVIDEND_SETTING_KEY))
                        .map(Setting::getValue)
                        .orElse("zack@nexstream.com.my").split(","),
                null,
                emailSubject,
                emailBody,
                null);
    }

    @Async
    public void sendRedemptionRequestEmailToAdmin(ProductRedemption productRedemption) {
        String cmsProductRedemptionUrl = CMS_HOST + "/product-redemption?key=product_redemption_belongsto_product_order_relationship&filter=contains&s=" + productRedemption.getProductOrder().getAgreementFileName();

        String emailBody = "Hi Citadel Team, " + "<br/><br/>" +
                "You have a new Redemption Request.<br/><br/>" +
                "Click here to view: <a href=\"" + cmsProductRedemptionUrl + "\">Redemption Record</a><br/><br/>";

        String emailSubject = "New Redemption request";

        sendEmail("Citadel Group",
                Optional.ofNullable(settingDao.findByKey(CITADEL_WITHDRAWAL_DIVIDEND_SETTING_KEY))
                        .map(Setting::getValue)
                        .orElse("zack@nexstream.com.my").split(","),
                null,
                emailSubject,
                emailBody,
                null);
    }

    @Async
    public void sendRolloverRequestEmailToAdmin(ProductRolloverHistory productRollover) {
        String cmsProductRolloverUrl = CMS_HOST + "/product-order?key=order_reference_number&filter=contains&s=" + productRollover.getRolloverProductOrder().getOrderReferenceNumber();

        String emailBody = "Hi Citadel Team, " + "<br/><br/>" +
                "You have a new Rollover Request.<br/><br/>" +
                "Click here to view: <a href=\"" + cmsProductRolloverUrl + "\">Rollover Record</a><br/><br/>";

        String emailSubject = "New Rollover request";

        sendEmail("Citadel Group",
                Optional.ofNullable(settingDao.findByKey(CITADEL_WITHDRAWAL_DIVIDEND_SETTING_KEY))
                        .map(Setting::getValue)
                        .orElse("zack@nexstream.com.my").split(","),
                null,
                emailSubject,
                emailBody,
                null);
    }

    @Async
    public void sendReallocationRequestEmailToAdmin(ProductReallocation productReallocation) {
        String cmsProductReallocationUrl = CMS_HOST + "/product-order?key=order_reference_number&filter=contains&s=" + productReallocation.getReallocateProductOrder().getOrderReferenceNumber();

        String emailBody = "Hi Citadel Team, " + "<br/><br/>" +
                "You have a new Reallocation Request.<br/><br/>" +
                "Click here to view: <a href=\"" + cmsProductReallocationUrl + "\">Reallocation Record</a><br/><br/>";

        String emailSubject = "New Reallocation request";

        sendEmail("Citadel Group",
                Optional.ofNullable(settingDao.findByKey(CITADEL_WITHDRAWAL_DIVIDEND_SETTING_KEY))
                        .map(Setting::getValue)
                        .orElse("zack@nexstream.com.my").split(","),
                null,
                emailSubject,
                emailBody,
                null);
    }

    @Async
    public void sendNiuApplicationEmail(NiuApplication niuApplication, List<Attachment> attachments) {
        String emailSubject = "NIU Application";

        // For Citadel Admin
        StringBuilder adminEmailBody = new StringBuilder();
        adminEmailBody.append("You have received a NIU application from a client.").append("<br/><br/>")
                .append("Application Amount: RM").append(MathUtil.convertIntegerToString(niuApplication.getAmountRequested() * 100)).append("<br/><br/>")
                .append("Tenure: ").append(niuApplication.getTenure()).append(" months").append("<br/><br/>")
                .append("Apply: ").append(niuApplication.getApplicationType().getValue()).append("<br/><br/>");

        if (NiuApplicationType.PERSONAL.equals(niuApplication.getApplicationType())) {
            adminEmailBody.append("Full Name: ").append(niuApplication.getName()).append("<br/><br/>")
                    .append("ID Number: ").append(niuApplication.getDocumentNumber()).append("<br/><br/>");
        }
        if (NiuApplicationType.COMPANY.equals(niuApplication.getApplicationType())) {
            adminEmailBody.append("Company Name: ").append(niuApplication.getName()).append("<br/><br/>")
                    .append("Company Registration Number: ").append(niuApplication.getDocumentNumber()).append("<br/><br/>")
                    .append("Nature of Business: ").append(niuApplication.getNatureOfBusiness()).append("<br/><br/>");
        }
        adminEmailBody.append("Address: ").append(niuApplication.getFullAddress()).append("<br/><br/>")
                .append("Mobile Number: ").append(niuApplication.getFullMobileNumber()).append("<br/><br/>")
                .append("Email: ").append(niuApplication.getEmail()).append("<br/><br/>")
                .append("Nature of business: ").append(niuApplication.getNatureOfBusiness()).append("<br/><br/>")
                .append("Purpose of advance: ").append(niuApplication.getPurposeOfAdvances()).append("<br/><br/>");

        sendEmail("Citadel Group",
                Optional.ofNullable(settingDao.findByKey(CITADEL_ADMIN_EMAIL_SETTING_KEY))
                        .map(Setting::getValue)
                        .orElse("zack@nexstream.com.my").split(","),
                null,
                emailSubject,
                adminEmailBody.toString(),
                attachments);

        // For Applicant
        String applicantEmailBody = "We have successfully received your NIU application. One of our representative will contact you soon upon reviewing your details.";
        sendEmail("Citadel Group",
                niuApplication.getEmail().split(","),
                Optional.ofNullable(settingDao.findByKey(CITADEL_ADMIN_EMAIL_SETTING_KEY))
                        .map(Setting::getValue)
                        .orElse("zack@nexstream.com.my").split(","),
                emailSubject,
                applicantEmailBody,
                null);
    }

    @Async
    public void sendDividendPayoutBankFileGenerationEmail(ProductDividendHistory productDividendHistory, List<Attachment> attachments) {
        String emailSubject = "Dividend Payout Bank File Generation";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss a");

        // For Citadel Admin
        String adminEmailBody = "Bank file(s) for dividend payout has been generated." + "<br/><br/>" +
                "Dividend Excel Key: " + productDividendHistory.getDividendCsvKey() + "<br/><br/>" +
                "Generated At: " + sdf.format(new Date()) + "<br/><br/>";

        sendEmail("Citadel Group",
                Optional.ofNullable(settingDao.findByKey(CITADEL_WITHDRAWAL_DIVIDEND_SETTING_KEY))
                        .map(Setting::getValue)
                        .orElse("zack@nexstream.com.my").split(","),
                null,
                emailSubject,
                adminEmailBody,
                attachments);
    }

    @Async
    public void sendCommissionPayoutBankFileGenerationEmail(List<Attachment> attachments) {
        String emailSubject = "Commission Payout Bank File Generation";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss a");

        // For Citadel Admin
        String adminEmailBody = "Bank file(s) for commission payout has been generated." + "<br/><br/>" +
                "Generated At: " + sdf.format(new Date()) + "<br/><br/>";

        sendEmail("Citadel Group",
                Optional.ofNullable(settingDao.findByKey(CITADEL_COMMISSION_EMAIL_SETTING_KEY))
                        .map(Setting::getValue)
                        .orElse("zack@nexstream.com.my").split(","),
                null,
                emailSubject,
                adminEmailBody,
                attachments);
    }

    @Async
    public void sendTrustDeedAgreementEmail(String userName, String receiverEmail, Attachment attachment) {
        String emailSubject = "Your Trust Deed Agreement – Now Active!";
        List<Attachment> attachments = new ArrayList<>();
        attachments.add(attachment);

        String emailBody = "Hi " + userName + ",<br/><br/>" +
                "Please find the Trust Deed Agreement attached.<br/>" +
                "Let us know if you have any questions or feedback — we’re here to help!<br/><br/>" +
                "Yours sincerely,<br/>" +
                "Citadel Group";

        // Send email with attachment
        sendEmail("Citadel Group",
                receiverEmail.split(","),
                Optional.ofNullable(settingDao.findByKey(CITADEL_ADMIN_EMAIL_SETTING_KEY))
                        .map(Setting::getValue)
                        .orElse("zack@nexstream.com.my").split(","),
                emailSubject,
                emailBody,
                attachments);
    }

    @Async
    public void sendRedemptionPayoutBankFileGenerationEmail(ProductRedemption productRedemption, List<Attachment> attachments) {
        String emailSubject = "Redemption Payout Bank File Generation";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss a");

        // For Citadel Admin
        String adminEmailBody = "Bank file(s) for redemption payout has been generated." + "<br/><br/>" +
                "Order reference number : " + productRedemption.getProductOrder().getOrderReferenceNumber() + "<br/><br/>" +
                "Generated At: " + sdf.format(new Date()) + "<br/><br/>";

        sendEmail("Citadel Group",
                Optional.ofNullable(settingDao.findByKey(CITADEL_WITHDRAWAL_DIVIDEND_SETTING_KEY))
                        .map(Setting::getValue)
                        .orElse("zack@nexstream.com.my").split(","),
                null,
                emailSubject,
                adminEmailBody,
                attachments);
    }

    @Async
    public void sendEarlyRedemptionPayoutBankFileGenerationEmail(ProductEarlyRedemptionHistory productEarlyRedemptionHistory, List<Attachment> attachments) {
        String emailSubject = "Early Redemption Payout Bank File Generation";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss a");

        // For Citadel Admin
        String adminEmailBody = "Bank file(s) for early redemption payout has been generated." + "<br/><br/>" +
                "You have a new reallocation request.<br/><br/>" +
                "Redemption Reference Number" + "<br/><br/>" +
                productEarlyRedemptionHistory.getRedemptionReferenceNumber() + "<br/><br/>" +
                "Product Order Status" + "<br/><br/>" +
                productEarlyRedemptionHistory.getProductOrder().getStatus().name() + "<br/><br/>" +
                "Redemption Amount" + "<br/><br/>" +
                productEarlyRedemptionHistory.getAmount() + "<br/><br/>" +
                "Submitted At" + "<br/><br/>" +
                "Generated At: " + sdf.format(new Date()) + "<br/><br/>";

        sendEmail("Citadel Group",
                Optional.ofNullable(settingDao.findByKey(CITADEL_WITHDRAWAL_DIVIDEND_SETTING_KEY))
                        .map(Setting::getValue)
                        .orElse("zack@nexstream.com.my").split(","),
                null,
                emailSubject,
                adminEmailBody,
                attachments);
    }

    public boolean sendPhysicalTrustDeedReminderEmail(List<PhysicalTrustDeedReminderInterfaceVo> reminders) {

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < reminders.size(); i++) {
            PhysicalTrustDeedReminderInterfaceVo reminderVo = reminders.get(i);
            sb.append(i + 1).append(". ").append(reminderVo.getAgreementFileName()).append(" link:");
            String cmsProductOrderUrl = CMS_HOST + "/product-order/" + reminderVo.getId();
            sb.append("<a href=\"").append(cmsProductOrderUrl).append("\">Product Order</a><br/><br/>");
        }

        String emailBody = "Hi Citadel Team, " + "<br/><br/>" +
                "You have a reminder to upload " + reminders.size() + " Physical Trust Deed(s).<br/><br/>" +
                "Please find the list of reminders below:<br/><br/>" +
                sb;

        String emailSubject = "Physical Trust Deed Reminder";

        return sendEmail("Citadel Group",
                Optional.ofNullable(settingDao.findByKey(CITADEL_ADMIN_EMAIL_SETTING_KEY))
                        .map(Setting::getValue)
                        .orElse("zack@nexstream.com.my").split(","),
                null,
                emailSubject,
                emailBody,
                null);
    }

    @Async
    public void sendProductOrderInReviewEmail(ProductOrder productOrder) {
        try {
            String productName = productOrder.getProduct().getName();
            String productCode = productOrder.getProduct().getCode();
            String clientId = productOrder.getClientId();
            String orderReferenceNumber = productOrder.getOrderReferenceNumber();
            DecimalFormat decimalFormatter = new DecimalFormat("#,##0.00");
            String trustFundAmount = decimalFormatter.format(productOrder.getPurchasedAmount());
            String cmsLink = CMS_HOST + "/product-order/" + productOrder.getId();

            String emailBody = "Hi Citadel Team, " + "<br/><br/>" +
                    "Description: The following trust fund has been resubmitted by the user.<br/><br/>" +
                    "Order ID: " + orderReferenceNumber + ".<br/><br/>" +
                    "Client ID: " + clientId + ".<br/><br/>" +
                    "Product: " + productCode + ".<br/><br/>" +
                    "Fund Amount: RM" + trustFundAmount + ".<br/><br/>" +
                    "Click here to view: <a href=\"" + cmsLink + "\">Product Order Record</a><br/><br/>";

            String emailSubject = "Trust Fund " + productName + " has been resubmitted by " + clientId;

            sendEmail("Citadel Group",
                    Optional.ofNullable(settingDao.findByKey(CITADEL_CTB_GROUP_EMAIL_SETTING_KEY))
                            .map(Setting::getValue)
                            .orElse("zack@nexstream.com.my").split(","),
                    null,
                    emailSubject,
                    emailBody,
                    null);
        } catch (Exception e) {
            log.error("Error while sending product order IN-REVIEW email for product order : {}", productOrder.getOrderReferenceNumber(), e);
        }
    }

    @Async
    public void sendProductOrderRejectedEmail(ProductOrder productOrder) {
        try {
            String productName = productOrder.getProduct().getName();
            String productCode = productOrder.getProduct().getCode();
            DecimalFormat decimalFormatter = new DecimalFormat("#,##0.00");
            String trustFundAmount = decimalFormatter.format(productOrder.getPurchasedAmount());
            String reason = productOrder.getRemark();
            String[] clientEmail = new String[]{productOrder.getClientEmail()};

            String emailBody = "Hi, " + "<br/><br/>" +
                    "Description: Your trust fund " + productName + " has been rejected. Kindly update the details based on the reason below and resubmit the same order from the app.<br/><br/>" +
                    "Product: " + productCode + ".<br/><br/>" +
                    "Fund Amount: RM" + trustFundAmount + ".<br/><br/>" +
                    "Reason: " + reason + ".<br/><br/>";

            String emailSubject = "Trust Fund " + productName + " has been rejected.";

            sendEmail("Citadel Group",
                    clientEmail,
                    null,
                    emailSubject,
                    emailBody,
                    null);
        } catch (Exception e) {
            log.error("Error while sending product order REJECTED email for product order : {}", productOrder.getOrderReferenceNumber(), e);
        }

    }
}