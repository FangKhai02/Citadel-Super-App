package com.citadel.backend.service;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.citadel.backend.dao.*;
import com.citadel.backend.dao.Agent.AgentDao;
import com.citadel.backend.dao.AppUser.AppUserDao;
import com.citadel.backend.dao.Client.ClientDao;
import com.citadel.backend.entity.*;
import com.citadel.backend.utils.*;
import com.citadel.backend.utils.Builder.UploadBase64FileBuilder;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.vo.*;
import com.citadel.backend.vo.Agency.AgencyListRespVo;
import com.citadel.backend.vo.Agency.AgencyVo;
import com.citadel.backend.vo.Constants.ConstantVo;
import com.citadel.backend.vo.Constants.GetConstantsRespVo;
import com.citadel.backend.vo.Constants.KeyValueMapVo;
import com.citadel.backend.vo.Enum.*;
import com.citadel.backend.vo.FaceID.FaceCompareReqVo;
import com.citadel.backend.vo.FaceID.FaceCompareRespVo;
import com.citadel.backend.vo.FaceID.ImageValidateReqVo;
import com.citadel.backend.vo.FaceID.ImageValidateRespVo;
import com.citadel.backend.vo.Interface.EnumWithValue;
import com.citadel.backend.vo.Login.LoginRespVo;
import com.citadel.backend.vo.Setting.SettingsItemVo;
import com.citadel.backend.vo.Setting.SettingsRespVo;
import jakarta.annotation.Resource;
import org.json.JSONArray;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;

import static com.citadel.backend.utils.ApiErrorKey.*;
import static com.citadel.backend.utils.ValidatorUtil.contactUsFormSubmitValidator;

@Service
public class AppService extends BaseService {

    private static final String REDIS_KEY_ACCOUNT_DELETE = "citadel/user/delete/";
    @Resource
    AgencyDao agencyDao;

    @Resource
    SettingDao settingDao;

    @Resource
    ContactUsFormSubmissionDao contactUsFormSubmissionDao;

    @Resource
    ClientDao clientDao;
    @Resource
    private EmailService emailService;
    @Resource
    private AgentDao agentDao;
    @Resource
    private AppUserDao appUsersDao;
    @Resource
    FaceIdImageValidateDao faceIdImageValidateDao;
    @Resource
    MaintenanceWindowDao maintenanceWindowDao;
    @Resource
    private FaceNetService faceNetService;

    public Object getAgencyList() {
        try {
            List<Agency> agencyList = agencyDao.findAllByStatusIsTrue();
            List<AgencyVo> agencyVoList = agencyList.stream()
                    .map(agency -> agency.agencyToAgencyVo(agency)).toList();

            AgencyListRespVo resp = new AgencyListRespVo();
            resp.setAgencyList(agencyVoList);
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object getSettings() {
        try {
            SettingsRespVo resp = new SettingsRespVo();
            List<SettingsItemVo> items = new ArrayList<>();

            List<Setting> settingsList = settingDao.findByGroup("App");
            for (Setting setting : settingsList) {
                items.add(new SettingsItemVo(setting.getKey(), setting.getValue(), setting.getDisplayName()));
            }
            resp.setSettings(items);
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object getConstants() {
        try {
            GetConstantsRespVo resp = new GetConstantsRespVo();
            List<ConstantVo> constants = new ArrayList<>();

            // Agency Type
            constants.add(createConstantVo("agency_type", AgencyType.values()));
            // Employment Type
            constants.add(createConstantVo("employment_type", EmploymentType.values()));
            // Gender
            constants.add(createConstantVo("gender", Gender.values()));
            // Marital Status
            constants.add(createConstantVo("marital_status", MaritalStatus.values()));
            // NIU Application Type
            constants.add(createConstantVo("niu_application_type", NiuApplicationType.values()));
            // Relationship
            constants.add(createConstantVo("relationship", Relationship.values()));
            // Residential Status
            constants.add(createConstantVo("residential_status", ResidentialStatus.values()));
            // Industry Type
            constants.add(createConstantVo("industry_type", IndustryType.values()));
            // NIU Application Tenure
            constants.add(createConstantVo("niu_application_tenure", NiuApplicationTenure.values()));
            // Contact Us Reason
            constants.add(createConstantVo("contact_us_reason", ContactUsReason.values()));
            // Redemption Method - Early Redemption
            constants.add(createConstantVo("redemption_method_early_redemption", RedemptionMethod.values()));
            // Redemption Method - 2 months before maturity
            constants.add(createConstantVo("redemption_method_matured", RedemptionMethodMatured.values()));
            // Withdrawal Reason
            constants.add(createConstantVo("withdrawal_reason", WithdrawalReason.values()));
            // Source of Income
            constants.add(createConstantVo("source_of_income", SourceOfIncome.values()));
            // Annual Turn Of Declaration
            constants.add(createConstantVo("annual_turn_of_declaration", AnnualTurnOfDeclaration.values()));
            // Corporate - Type of Entity
            constants.add(createConstantVo("corporate_type_of_entity", CorporateTypeOfEntity.values()));

            resp.setConstants(constants);
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object submitContactUsFormUpdate(ContactUsFormSubmitReqVo contactUsFormSubmitReqVo) {
        log.info("Contact Us Form Submission Request: {}", gson.toJson(contactUsFormSubmitReqVo));
        BaseResp resp = new BaseResp();

        JSONArray jsonArray = contactUsFormSubmitValidator(contactUsFormSubmitReqVo);
        if (!jsonArray.isEmpty()) {
            return getInvalidArgumentError(jsonArray);
        }

        ContactUsFormSubmission contactUsFormSubmission = new ContactUsFormSubmission();
        contactUsFormSubmission.setName(contactUsFormSubmitReqVo.getName());
        contactUsFormSubmission.setMobileCountryCode(contactUsFormSubmitReqVo.getMobileCountryCode());
        contactUsFormSubmission.setMobileNumber(contactUsFormSubmitReqVo.getMobileNumber());
        contactUsFormSubmission.setEmail(contactUsFormSubmitReqVo.getEmail());
        contactUsFormSubmission.setReason(contactUsFormSubmitReqVo.getReason());
        contactUsFormSubmission.setRemark(contactUsFormSubmitReqVo.getRemark());
        contactUsFormSubmission.setCreatedAt(new Date());
        contactUsFormSubmissionDao.save(contactUsFormSubmission);

        emailService.sendContactUsFormSubmissionEmailToAdmin(contactUsFormSubmission);
        return resp;
    }

    public Object getAppUser(String apiKey) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        AppUser appUser = appUserSession.getAppUser();

        Boolean hasPin = null;
        if (UserType.CLIENT.equals(appUser.getUserType())) {
            Client client = clientDao.findByAppUser(appUser).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
            hasPin = StringUtil.isNotEmpty(client.getPin());
        }
        else if (UserType.AGENT.equals(appUser.getUserType())) {
            Agent agent = agentDao.findByAppUserAndStatus(appUser, Agent.AgentStatus.ACTIVE).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
            hasPin = StringUtil.isNotEmpty(agent.getPin());
        }

        LoginRespVo resp = new LoginRespVo();
        resp.setHasPin(hasPin);
        resp.setUserType(appUser.getUserType());
        return resp;
    }

    private ConstantVo createConstantVo(String category, Enum<?>[] enumValues) {
        ConstantVo constantVo = new ConstantVo();
        constantVo.setCategory(category);
        constantVo.setList(Arrays.stream(enumValues)
                .map(e -> new KeyValueMapVo(e.name(), ((EnumWithValue) e).getValue()))
                .toList());
        return constantVo;
    }

    public Object webDeleteAppUser(WebUserDeleteReqVo req) {
        String email = req.getEmail().strip();
        String password = req.getPassword().strip();
        String reason = req.getReason() != null ? req.getReason().strip() : null;

        String key = REDIS_KEY_ACCOUNT_DELETE + email;

        if (RedisUtil.exists(key)) {
            BaseResp resp = new BaseResp();
            resp.setMessage("Account Deletion Under Process");
            return resp;
        } else {
            AppUser appUser = appUsersDao.findByEmailAddressAndIsDeletedIsFalse(email);
            if (appUser == null) {
                return getErrorObjectWithMsg("No user found for this email");
            }
            BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), appUser.getPassword());
            if (!result.verified) {
                return getErrorObjectWithMsg("Email or Password is wrong");
            }

            if (UserType.CLIENT.equals(appUser.getUserType())) {
                Client client = clientDao.findByAppUser(appUser).orElseThrow(() -> new GeneralException("Client account not found"));
                emailService.sendUserDeleteRequestEmailToAdmin(client, reason);
            } else if (UserType.AGENT.equals(appUser.getUserType())) {
                Agent agent = agentDao.findByAppUserAndStatus(appUser, Agent.AgentStatus.ACTIVE).orElseThrow(() -> new GeneralException("Agent profile not found"));
                emailService.sendUserDeleteRequestEmailToAdmin(agent, reason);
            }

            RedisUtil.set(key, "1", ONE_WEEK);
            return new BaseResp();
        }
    }

    public Object deleteAppUser(String apiKey, AppUserDeleteReqVo req) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        String email = appUser.getEmailAddress();

        String key = REDIS_KEY_ACCOUNT_DELETE + email;

        if (RedisUtil.exists(key)) {
            BaseResp resp = new BaseResp();
            resp.setMessage("Account Deletion Under Process");
            return resp;
        } else {
            String reason = req.getReason() != null ? req.getReason().strip() : null;
            if (UserType.CLIENT.equals(appUser.getUserType())) {
                Client client = clientDao.findByAppUser(appUser).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
                if (!validPinFormat(req.getPin()) || !client.getPin().equals(req.getPin())) {
                    return getErrorObjectWithMsg(INVALID_OLD_PIN);
                }
                emailService.sendUserDeleteRequestEmailToAdmin(client, reason);
            } else if (UserType.AGENT.equals(appUser.getUserType())) {
                Agent agent = agentDao.findByAppUserAndStatus(appUser, Agent.AgentStatus.ACTIVE).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
                if (!validPinFormat(req.getPin()) || !agent.getPin().equals(req.getPin())) {
                    return getErrorObjectWithMsg(INVALID_OLD_PIN);
                }
                emailService.sendUserDeleteRequestEmailToAdmin(agent, reason);
            }

            RedisUtil.set(key, "1", ONE_WEEK);
            return new BaseResp();
        }
    }

    public Object faceIdImageValidate(ImageValidateReqVo imageValidateReqVo) throws Exception {
        ImageValidateRespVo resp = new ImageValidateRespVo();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

        FaceIdImageValidate result = new FaceIdImageValidate();
        result.setIdNumber(imageValidateReqVo.getIdNumber());
        result.setCreatedAt(new Date());
        try {
            String selfieS3FilePath = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(imageValidateReqVo.getSelfie())
                    .fileName("selfie_" + result.getIdNumber() + "_" + result.getCreatedAt().getTime())
                    .filePath(S3_FACE_ID_IMAGE_VALIDATE_SELFIE_PATH + sdf.format(result.getCreatedAt())));
            result.setSelfieFilename(selfieS3FilePath);

            String idDocumentS3FilePath = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(imageValidateReqVo.getIdPhoto())
                    .fileName("id-document_" + result.getIdNumber() + "_" + result.getCreatedAt().getTime())
                    .filePath(S3_FACE_ID_IMAGE_VALIDATE_ID_DOCUMENT_PATH + sdf.format(result.getCreatedAt())));
            result.setIdDocumentFilename(idDocumentS3FilePath);
        } catch (Exception e) {
            log.error("Error", e);
            return getErrorObjectWithMsg("Error uploading image");
        }
        result.setConfidence(imageValidateReqVo.getConfidence());
        result.setLivenessScore(imageValidateReqVo.getLivenessScore());

        Double faceIdPassThreshold = Double.parseDouble(Optional.ofNullable(settingDao.findByKey(FACE_ID_PASS_THRESHOLD_SETTING_KEY))
                .map(Setting::getValue)
                .orElse("75.0"));
        result.setValid(result.getConfidence() >= faceIdPassThreshold);
        faceIdImageValidateDao.save(result);

        resp.setValid(result.getValid());
        resp.setConfidence(result.getConfidence());
        resp.setLivenessScore(result.getLivenessScore());
        return resp;
    }

    /**
     * New FaceNet-based face comparison endpoint.
     * Calls the FaceNet sidecar microservice to compare selfie against document image.
     */
    public Object faceCompare(FaceCompareReqVo req) throws Exception {
        FaceCompareRespVo resp = new FaceCompareRespVo();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        Date now = new Date();

        // Upload both images to S3
        try {
            String selfieS3FilePath = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(req.getSelfieImage())
                    .fileName("selfie_" + req.getDocumentNumber() + "_" + now.getTime())
                    .filePath(S3_FACE_ID_IMAGE_VALIDATE_SELFIE_PATH + sdf.format(now)));
            String idDocumentS3FilePath = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(req.getDocumentImage())
                    .fileName("id-document_" + req.getDocumentNumber() + "_" + now.getTime())
                    .filePath(S3_FACE_ID_IMAGE_VALIDATE_ID_DOCUMENT_PATH + sdf.format(now)));

            // Call FaceNet sidecar for face comparison
            FaceCompareRespVo faceNetResult = faceNetService.compareFaces(req);

            // Save to database
            FaceIdImageValidate result = new FaceIdImageValidate();
            result.setIdNumber(req.getDocumentNumber());
            result.setCreatedAt(now);
            result.setSelfieFilename(selfieS3FilePath);
            result.setIdDocumentFilename(idDocumentS3FilePath);
            result.setConfidence(faceNetResult.getScore());
            result.setLivenessScore(faceNetResult.getScore()); // Using same score as both liveness and confidence
            result.setValid(faceNetResult.getVerified());

            // Set new fields
            result.setDocumentType(req.getDocumentType());
            result.setFullName(req.getFullName());
            result.setNationality(req.getNationality());
            result.setGender(req.getGender());
            result.setFaceMatchScore(faceNetResult.getScore());
            result.setFaceVerified(faceNetResult.getVerified());

            // Parse and set date of birth
            try {
                SimpleDateFormat dobFormat = new SimpleDateFormat("yyyy-MM-dd");
                result.setDateOfBirth(dobFormat.parse(req.getDateOfBirth()));
            } catch (Exception e) {
                log.warn("[FaceCompare] Could not parse dateOfBirth: {}", req.getDateOfBirth());
            }

            faceIdImageValidateDao.save(result);

            resp.setVerified(faceNetResult.getVerified());
            resp.setScore(faceNetResult.getScore());
            resp.setMessage(faceNetResult.getMessage());
            resp.setDegraded(faceNetResult.getDegraded());

            return resp;
        } catch (Exception e) {
            log.error("[FaceCompare] Error during face comparison: {}", e.getMessage(), e);
            return getErrorObjectWithMsg("Error during face verification: " + e.getMessage());
        }
    }

    public Object checkForceUpdate(String version, String platform) {
        Version appVersion = new Version(version);
        Setting settingMinVersion;
        Setting settingAppStoreLink;

        switch (platform) {
            case Constant.PLATFORM_IOS: {
                settingMinVersion = settingDao.findByKey("app.ios_min_version");
                settingAppStoreLink = settingDao.findByKey("app.ios_appstore_link");
                break;
            }
            case Constant.PLATFORM_ANDROID: {
                settingMinVersion = settingDao.findByKey("app.android_min_version");
                settingAppStoreLink = settingDao.findByKey("app.android_playstore_link");
                break;
            }
            default:
                return getErrorObjectWithMsg(INVALID_PLATFORM);
        }

        if (settingMinVersion == null || settingAppStoreLink == null)
            return getErrorObjectWithMsg(INVALID_SYSTEM_SETTING);


        Version minVersion = new Version(settingMinVersion.getValue());
        ForceUpdateRespVo resp = new ForceUpdateRespVo();

        if (appVersion.compareTo(minVersion) < 0) {
            resp.setUpdateLink(settingAppStoreLink.getValue());
            resp.setUpdateRequired(true);
            resp.setMessage(UPDATE_REQUIRED);
        } else {
            resp.setUpdateRequired(false);
        }
        return resp;
    }
}
