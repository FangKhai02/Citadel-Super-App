package com.citadel.backend.service;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.citadel.backend.dao.*;
import com.citadel.backend.dao.Agent.AgentDao;
import com.citadel.backend.dao.Agent.AgentRoleSettingsDao;
import com.citadel.backend.dao.AppUser.AppUserDao;
import com.citadel.backend.dao.AppUser.AppUserSessionDao;
import com.citadel.backend.dao.Client.ClientDao;
import com.citadel.backend.entity.*;
import com.citadel.backend.utils.*;
import com.citadel.backend.utils.Builder.DigitalIDBuilder;
import com.citadel.backend.utils.Builder.UploadBase64FileBuilder;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.vo.BankDetails.BankDetailsReqVo;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.DigitalIDResultVo;
import com.citadel.backend.vo.SignUp.Agent.ExistingAgentRespVo;
import com.citadel.backend.vo.SignUp.Agent.SignUpAgentAgencyDetailsReqVo;
import com.citadel.backend.vo.SignUp.Client.EmploymentDetailsVo;
import com.citadel.backend.vo.Enum.AgentRole;
import com.citadel.backend.vo.Enum.EmploymentType;
import com.citadel.backend.vo.Enum.UserType;
import com.citadel.backend.vo.SignUp.*;
import com.citadel.backend.vo.SignUp.Agent.AgentSignUpReqVo;
import com.citadel.backend.vo.SignUp.Client.ClientIdentityDetailsReqVo;
import com.citadel.backend.vo.SignUp.Client.ClientPersonalDetailsReqVo;
import com.citadel.backend.vo.SignUp.Client.ClientSignUpReqVo;
import jakarta.annotation.Resource;
import org.json.JSONArray;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

import static com.citadel.backend.utils.ApiErrorKey.*;
import static com.citadel.backend.utils.DigitalIDUtil.createDigitalID;
import static com.citadel.backend.utils.RandomCodeUtil.generateRandomCode;

@Service
public class SignUpService extends BaseService {

    @Resource
    private AgentDao agentDao;
    @Resource
    private SignUpHistoryDao signUpHistoryDao;
    @Resource
    private AppUserDao appUserDao;
    @Resource
    private UserDetailDao userDetailDao;
    @Resource
    private PepInfoDao pepInfoDao;
    @Resource
    private ClientDao clientDao;
    @Resource
    private AgencyDao agencyDao;
    @Resource
    private BankDetailsDao bankDetailsDao;
    @Resource
    private EmailService emailService;
    @Resource
    private AgentRoleSettingsDao agentRoleSettingsDao;
    @Resource
    private AppUserSessionDao appUserSessionDao;

    //Common validators
    public Object signUpIdentityDetailsValidationCheckpointOne(SignUpBaseIdentityDetailsVo signUpBaseIdentityDetailsReq, Boolean checkDob, UserType userType) {
        try {
            signUpBaseIdentityDetailsReq.setIdentityCardNumber(signUpBaseIdentityDetailsReq.getIdentityCardNumber().strip());
            checkExistingAppUserByIdentityCardNumber(signUpBaseIdentityDetailsReq.getIdentityCardNumber(), userType);
            Object resp = ValidatorUtil.identityDetailsValidator(signUpBaseIdentityDetailsReq, checkDob);
            if (resp instanceof JSONArray jsonArray) {
                return jsonArray.isEmpty() ? new BaseResp() : getInvalidArgumentError(jsonArray);
            } else {
                return resp;
            }
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object signUpContactDetailsValidationCheckpointTwo(SignUpBaseContactDetailsVo signUpBaseContactDetailsReq) {
        try {
            signUpBaseContactDetailsReq.setEmail(signUpBaseContactDetailsReq.getEmail().strip());
            signUpBaseContactDetailsReq.setMobileNumber(signUpBaseContactDetailsReq.getMobileNumber().strip());
            AppUser appUser = appUserDao.findByEmailAddressAndIsDeletedIsFalse(signUpBaseContactDetailsReq.getEmail());
            if (appUser != null) {
                if (appUserSessionDao.existsByAppUser(appUser)) {
                    return getErrorObjectWithMsg(EMAIL_HAS_BEEN_TAKEN);
                }
            }
            JSONArray jsonArray = ValidatorUtil.contactDetailsValidator(signUpBaseContactDetailsReq);
            if (signUpBaseContactDetailsReq instanceof ClientPersonalDetailsReqVo clientPersonalDetailsReq) {
                if (StringUtil.isNotEmpty(clientPersonalDetailsReq.getAgentReferralCode())) {
                    Agent agent = agentDao.findByReferralCode(clientPersonalDetailsReq.getAgentReferralCode().strip());
                    if (agent == null) {
                        jsonArray.put(clientPersonalDetailsReq.getClass().getSimpleName() + "." + "agentReferralCode");
                    }
                }

                JSONArray correspondingValidationArray = ValidatorUtil.correspondingAddressValidator(clientPersonalDetailsReq.getCorrespondingAddress());
                if (!correspondingValidationArray.isEmpty()) {
                    jsonArray = mergeJsonArrays(List.of(jsonArray, correspondingValidationArray));
                }
            }

            return jsonArray.isEmpty() ? new BaseResp() : getInvalidArgumentError(jsonArray);
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    private UserDetail checkExistingAppUserByIdentityCardNumber(String identityCardNumber, UserType userType) {

        UserDetail userDetail = userDetailDao.checkExistingUser(identityCardNumber, userType);
        if (userDetail == null) {
            return null;
        }
        // If app user session exist client/agent has already registered account -> need to login -> no sign up
        boolean exist = appUserSessionDao.existsByAppUser(userDetail.getAppUserId());
        if (exist) {
            throw new GeneralException(ACCOUNT_REGISTERED_WITH_IDENTITY_CARD_NUMBER);
        }
        return userDetail;
    }
    // -----------------------------Client SignUp-----------------------------

    //check for migrated agent/client record for after ekyc
    public Object checkForExistingClientRecord(String identityCardNumber) {
        try {
            identityCardNumber = identityCardNumber.strip();
            ExistingClientRespVo resp = new ExistingClientRespVo();
            UserDetail userDetail = checkExistingAppUserByIdentityCardNumber(identityCardNumber, UserType.CLIENT);
            Client client = clientDao.findByUserDetailAndStatusIsTrue(userDetail);
            if (userDetail != null) {
                //Identity Details
                ClientIdentityDetailsReqVo identityDetails = new ClientIdentityDetailsReqVo();
                identityDetails.setFullName(StringUtil.capitalizeEachWord(userDetail.getName()));
                identityDetails.setIdentityCardNumber(userDetail.getIdentityCardNumber());
                identityDetails.setDob(userDetail.getDob().getTime());
                identityDetails.setGender(userDetail.getGender());
                identityDetails.setNationality(StringUtil.capitalizeEachWord(userDetail.getNationality()));
                identityDetails.setIdentityDocumentType(userDetail.getIdentityDocumentType());
                identityDetails.setIdentityCardFrontImage(AwsS3Util.getS3DownloadUrl(userDetail.getIdentityCardFrontImageKey()));
                identityDetails.setIdentityCardBackImage(AwsS3Util.getS3DownloadUrl(userDetail.getIdentityCardBackImageKey()));
                resp.setIdentityDetails(identityDetails);
                //Personal Details
                ClientPersonalDetailsReqVo personalDetails = new ClientPersonalDetailsReqVo();
                personalDetails.setAddress(StringUtil.capitalizeEachWord(userDetail.getAddress()));
                personalDetails.setPostcode(userDetail.getPostcode());
                personalDetails.setCity(StringUtil.capitalizeEachWord(userDetail.getCity()));
                personalDetails.setState(StringUtil.capitalizeEachWord(userDetail.getState()));
                personalDetails.setCountry(StringUtil.capitalizeEachWord(userDetail.getCountry()));
                personalDetails.setMobileCountryCode(userDetail.getMobileCountryCode());
                personalDetails.setMobileNumber(userDetail.getMobileNumber());
                personalDetails.setEmail(userDetail.getEmail());
                personalDetails.setProofOfAddressFile(userDetail.getProofOfAddressFileKey());
                personalDetails.setMaritalStatus(userDetail.getMaritalStatus());
                personalDetails.setResidentialStatus(userDetail.getResidentialStatus());

                CorrespondingAddress correspondingAddress = new CorrespondingAddress();
                correspondingAddress.setIsSameCorrespondingAddress(userDetail.getIsSameCorrespondingAddress());
                correspondingAddress.setCorrespondingAddress(StringUtil.capitalizeEachWord(userDetail.getCorrespondingAddress()));
                correspondingAddress.setCorrespondingPostcode(userDetail.getCorrespondingPostcode());
                correspondingAddress.setCorrespondingCity(StringUtil.capitalizeEachWord(userDetail.getCorrespondingCity()));
                correspondingAddress.setCorrespondingState(StringUtil.capitalizeEachWord(userDetail.getCorrespondingState()));
                correspondingAddress.setCorrespondingCountry(StringUtil.capitalizeEachWord(userDetail.getCorrespondingCountry()));
                correspondingAddress.setCorrespondingAddressProofKey(userDetail.getCorrespondingAddressProofKey());

                personalDetails.setCorrespondingAddress(correspondingAddress);

                resp.setPersonalDetails(personalDetails);
                //Selfie Image
                resp.setSelfieImage(AwsS3Util.getS3DownloadUrl(userDetail.getSelfieImageKey()));
                //Digital Signature
                resp.setDigitalSignature(AwsS3Util.getS3DownloadUrl(userDetail.getDigitalSignatureKey()));
                //Pep Declaration
                PepDeclarationVo pepDeclaration = new PepDeclarationVo();
                resp.setPepDeclaration(pepDeclaration);
                //Employment Details
                EmploymentDetailsVo employmentDetails = new EmploymentDetailsVo();
                resp.setEmploymentDetails(employmentDetails);
                //Password
                resp.setPassword(null);

                if (client != null) {
                    //Pep Declaration
                    resp.setPepDeclaration(client.getClientPepInfo());

                    //Employment Details
                    employmentDetails.setEmploymentType(client.getEmploymentType());
                    employmentDetails.setEmployerName(StringUtil.capitalizeEachWord(client.getEmployerName()));
                    employmentDetails.setIndustryType(client.getIndustryType());
                    employmentDetails.setJobTitle(client.getJobTitle());
                    employmentDetails.setEmployerAddress(StringUtil.capitalizeEachWord(client.getEmployerAddress()));
                    employmentDetails.setPostcode(client.getEmployerPostcode());
                    employmentDetails.setCity(StringUtil.capitalizeEachWord(client.getEmployerCity()));
                    employmentDetails.setState(StringUtil.capitalizeEachWord(client.getEmployerState()));
                    employmentDetails.setCountry(StringUtil.capitalizeEachWord(client.getEmployerCountry()));
                    //Agent Referral Code
                    resp.setAgentReferralCode(client.getAgent() != null ? client.getAgent().getReferralCode() : null);
                    //Password
                    if (client.getAppUser() != null) {
                        resp.setPassword(client.getAppUser().getPassword());
                    }
                }
            }
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    @Transactional
    public Object clientSignUpUpdate(ClientSignUpReqVo clientSignUpReq) {
        String key = "sign-up/client/" + clientSignUpReq.getIdentityDetails().getIdentityCardNumber();
        if (RedisUtil.exists(key)) {
            return getErrorObjectWithMsg(DUPLICATE_REQUEST);
        }
        RedisUtil.set(key, "1");
        try {
            SignUpHistory clientSignUpHistory = new SignUpHistory();
            //Identity Details
            clientSignUpHistory.setUserType(UserType.CLIENT);
            clientSignUpHistory.setFullName(StringUtil.capitalizeEachWord(clientSignUpReq.getIdentityDetails().getFullName().strip()));
            clientSignUpHistory.setIdentityCardNumber(clientSignUpReq.getIdentityDetails().getIdentityCardNumber().strip());
            clientSignUpHistory.setDob(new Date(clientSignUpReq.getIdentityDetails().getDob()));
            clientSignUpHistory.setIdentityDocumentType(clientSignUpReq.getIdentityDetails().getIdentityDocumentType());

            String identityCardFrontImageBase64 = clientSignUpReq.getIdentityDetails().getIdentityCardFrontImage();
            if (!identityCardFrontImageBase64.startsWith("http")) {
                String identityCardFrontImageKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(identityCardFrontImageBase64)
                        .fileName("identityCardFrontImage")
                        .filePath(S3_SIGN_UP_CLIENT_PATH + clientSignUpHistory.getIdentityCardNumber()));
                clientSignUpHistory.setIdentityCardFrontImageKey(identityCardFrontImageKey);
            }

            String identityCardBackImageBase64 = clientSignUpReq.getIdentityDetails().getIdentityCardBackImage();
            if (StringUtil.isNotEmpty(identityCardBackImageBase64) && !identityCardBackImageBase64.startsWith("http")) {
                String identityCardBackImageKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(identityCardBackImageBase64)
                        .fileName("identityCardBackImage")
                        .filePath(S3_SIGN_UP_CLIENT_PATH + clientSignUpHistory.getIdentityCardNumber()));
                clientSignUpHistory.setIdentityCardBackImageKey(identityCardBackImageKey);
            }

            clientSignUpHistory.setGender(clientSignUpReq.getIdentityDetails().getGender());
            clientSignUpHistory.setNationality(StringUtil.capitalizeEachWord(clientSignUpReq.getIdentityDetails().getNationality().strip()));

            //Personal Details
            clientSignUpHistory.setAddress(StringUtil.capitalizeEachWord(clientSignUpReq.getPersonalDetails().getAddress().strip()));
            clientSignUpHistory.setPostcode(clientSignUpReq.getPersonalDetails().getPostcode().strip());
            clientSignUpHistory.setCity(StringUtil.capitalizeEachWord(clientSignUpReq.getPersonalDetails().getCity().strip()));
            clientSignUpHistory.setState(StringUtil.capitalizeEachWord(clientSignUpReq.getPersonalDetails().getState().strip()));
            clientSignUpHistory.setCountry(StringUtil.capitalizeEachWord(clientSignUpReq.getPersonalDetails().getCountry()));
            clientSignUpHistory.setMobileCountryCode(clientSignUpReq.getPersonalDetails().getMobileCountryCode());
            clientSignUpHistory.setMobileNumber(clientSignUpReq.getPersonalDetails().getMobileNumber().strip());
            clientSignUpHistory.setEmail(clientSignUpReq.getPersonalDetails().getEmail().strip());
            clientSignUpHistory.setMaritalStatus(clientSignUpReq.getPersonalDetails().getMaritalStatus());
            clientSignUpHistory.setResidentialStatus(clientSignUpReq.getPersonalDetails().getResidentialStatus());
            if (StringUtil.isNotEmpty(clientSignUpReq.getPersonalDetails().getAgentReferralCode())) {
                clientSignUpHistory.setReferralCodeAgent(clientSignUpReq.getPersonalDetails().getAgentReferralCode().strip());
            }

            clientSignUpHistory.setIsSameCorrespondingAddress(clientSignUpReq.getPersonalDetails().getCorrespondingAddress().getIsSameCorrespondingAddress());
            clientSignUpHistory.setCorrespondingAddress(StringUtil.capitalizeEachWord(clientSignUpReq.getPersonalDetails().getCorrespondingAddress().getCorrespondingAddress()));
            clientSignUpHistory.setCorrespondingCity(StringUtil.capitalizeEachWord(clientSignUpReq.getPersonalDetails().getCorrespondingAddress().getCorrespondingCity()));
            clientSignUpHistory.setCorrespondingState(StringUtil.capitalizeEachWord(clientSignUpReq.getPersonalDetails().getCorrespondingAddress().getCorrespondingState()));
            clientSignUpHistory.setCorrespondingPostcode(clientSignUpReq.getPersonalDetails().getCorrespondingAddress().getCorrespondingPostcode());
            clientSignUpHistory.setCorrespondingCountry(StringUtil.capitalizeEachWord(clientSignUpReq.getPersonalDetails().getCorrespondingAddress().getCorrespondingCountry()));
            String proofOfCorrespondingAddressFileBase64 = clientSignUpReq.getPersonalDetails().getCorrespondingAddress().getCorrespondingAddressProofKey();
            if (StringUtil.isNotEmpty(proofOfCorrespondingAddressFileBase64) && !proofOfCorrespondingAddressFileBase64.startsWith("http")) {
                String proofOfCorrespondingAddressFileKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(proofOfCorrespondingAddressFileBase64)
                        .fileName("proofOfCorrespondingAddressFile")
                        .filePath(S3_SIGN_UP_CLIENT_PATH + clientSignUpHistory.getIdentityCardNumber()));
                clientSignUpHistory.setCorrespondingAddressProofKey(proofOfCorrespondingAddressFileKey);
            }

            String proofOfAddressFileBase64 = clientSignUpReq.getPersonalDetails().getProofOfAddressFile();
            if (StringUtil.isNotEmpty(proofOfAddressFileBase64) && !proofOfAddressFileBase64.startsWith("http")) {
                String proofOfAddressFileKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(proofOfAddressFileBase64)
                        .fileName("proofOfAddressFile")
                        .filePath(S3_SIGN_UP_CLIENT_PATH + clientSignUpHistory.getIdentityCardNumber()));
                clientSignUpHistory.setProofOfAddressFileKey(proofOfAddressFileKey);
            }

            //Selfie Image
            String selfieImageBase64 = clientSignUpReq.getSelfieImage();
            if (!selfieImageBase64.startsWith("http")) {
                String selfieImageKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(selfieImageBase64)
                        .fileName("selfieImage")
                        .filePath(S3_SIGN_UP_CLIENT_PATH + clientSignUpHistory.getIdentityCardNumber()));
                clientSignUpHistory.setSelfieImageKey(selfieImageKey);
            }

            //PEP
            clientSignUpHistory.setPep(clientSignUpReq.getPepDeclaration().getIsPep());
            if (clientSignUpReq.getPepDeclaration().getIsPep()) {
                clientSignUpHistory.setPepType(clientSignUpReq.getPepDeclaration().getPepDeclarationOptions().getRelationship());
                clientSignUpHistory.setPepImmediateFamilyName(clientSignUpReq.getPepDeclaration().getPepDeclarationOptions().getName());
                clientSignUpHistory.setPepPosition(clientSignUpReq.getPepDeclaration().getPepDeclarationOptions().getPosition());
                clientSignUpHistory.setPepOrganisation(clientSignUpReq.getPepDeclaration().getPepDeclarationOptions().getOrganization());

                String pepSupportingDocumentBase64 = clientSignUpReq.getPepDeclaration().getPepDeclarationOptions().getSupportingDocument();
                if (!pepSupportingDocumentBase64.startsWith("http")) {
                    String pepSupportingDocumentKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                            .base64String(pepSupportingDocumentBase64)
                            .fileName("pepSupportingDocument")
                            .filePath(S3_SIGN_UP_CLIENT_PATH + clientSignUpHistory.getIdentityCardNumber()));
                    clientSignUpHistory.setPepSupportingDocumentsKey(pepSupportingDocumentKey);
                }
            }

            //Employment
            clientSignUpHistory.setEmploymentType(clientSignUpReq.getEmploymentDetails().getEmploymentType());
            if (clientSignUpHistory.getEmploymentType().equals(EmploymentType.EMPLOYED)) {
                clientSignUpHistory.setEmployerName(StringUtil.capitalizeEachWord(clientSignUpReq.getEmploymentDetails().getEmployerName()));
                clientSignUpHistory.setIndustryType(clientSignUpReq.getEmploymentDetails().getIndustryType());
                clientSignUpHistory.setJobTitle(clientSignUpReq.getEmploymentDetails().getJobTitle());
                clientSignUpHistory.setEmployerAddress(StringUtil.capitalizeEachWord(clientSignUpReq.getEmploymentDetails().getEmployerAddress()));
                clientSignUpHistory.setEmployerPostcode(clientSignUpReq.getEmploymentDetails().getPostcode());
                clientSignUpHistory.setEmployerCity(StringUtil.capitalizeEachWord(clientSignUpReq.getEmploymentDetails().getCity()));
                clientSignUpHistory.setEmployerState(StringUtil.capitalizeEachWord(clientSignUpReq.getEmploymentDetails().getState()));
                clientSignUpHistory.setEmployerCountry(StringUtil.capitalizeEachWord(clientSignUpReq.getEmploymentDetails().getCountry()));
            }

            //Digital Signature
            String digitalSignatureBase64 = clientSignUpReq.getDigitalSignature();
            if (!digitalSignatureBase64.startsWith("http")) {
                String digitalSignatureKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(digitalSignatureBase64)
                        .fileName("digitalSignature")
                        .filePath(S3_SIGN_UP_CLIENT_PATH + clientSignUpHistory.getIdentityCardNumber()));
                clientSignUpHistory.setDigitalSignatureKey(digitalSignatureKey);
            }

            clientSignUpHistory.setCreatedAt(new Date());
            clientSignUpHistory.setUpdatedAt(new Date());

            clientSignUpHistory = signUpHistoryDao.save(clientSignUpHistory);
            clientSignUpHistory.setPassword(clientSignUpReq.getPassword().strip());

            createNewUser(clientSignUpHistory);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        } finally {
            RedisUtil.del(key);
        }
    }

    //-----------------------------Agent SignUp-----------------------------
    public Object checkForExistingAgentRecord(String identityCardNumber) {
        try {
            identityCardNumber = identityCardNumber.strip();
            ExistingAgentRespVo resp = new ExistingAgentRespVo();
            UserDetail userDetail = checkExistingAppUserByIdentityCardNumber(identityCardNumber, UserType.AGENT);

            if (userDetail != null) {
                SignUpBaseIdentityDetailsVo baseIdentityDetailsVo = new SignUpBaseIdentityDetailsVo();
                baseIdentityDetailsVo.setFullName(userDetail.getName());
                baseIdentityDetailsVo.setIdentityCardNumber(identityCardNumber);
                baseIdentityDetailsVo.setDob(userDetail.getDob().getTime());
                baseIdentityDetailsVo.setIdentityDocumentType(userDetail.getIdentityDocumentType());
                resp.setIdentityDetails(baseIdentityDetailsVo);

                SignUpBaseContactDetailsVo baseContactDetailsVo = new SignUpBaseContactDetailsVo();
                baseContactDetailsVo.setAddress(userDetail.getAddress());
                baseContactDetailsVo.setPostcode(userDetail.getPostcode());
                baseContactDetailsVo.setCity(userDetail.getCity());
                baseContactDetailsVo.setState(userDetail.getState());
                baseContactDetailsVo.setCountry(userDetail.getCountry());
                baseContactDetailsVo.setMobileCountryCode(userDetail.getMobileCountryCode());
                baseContactDetailsVo.setMobileNumber(userDetail.getMobileNumber());
                baseContactDetailsVo.setEmail(userDetail.getEmail());
                baseContactDetailsVo.setProofOfAddressFile(userDetail.getProofOfAddressFileKey());
                resp.setContactDetails(baseContactDetailsVo);
            }

            Agent agent = agentDao.findAgentByIdentityCardNumber(identityCardNumber, Agent.AgentStatus.ACTIVE);
            if (agent != null && agent.getAgency() != null) {
                SignUpAgentAgencyDetailsReqVo agencyDetailsVo = new SignUpAgentAgencyDetailsReqVo();
                agencyDetailsVo.setAgencyId(agent.getAgency().getAgencyId());
                if (agent.getRecruitManager() != null) {
                    agencyDetailsVo.setRecruitManagerCode(agent.getRecruitManager().getAgentId());
                }
                resp.setAgencyCode(agent.getAgency().getAgencyCode());
                resp.setAgencyDetails(agencyDetailsVo);

                BankDetails bankDetails = bankDetailsDao.findByAppUserAndIsDeletedIsFalse(agent.getAppUser());
                if (bankDetails != null) {
                    BankDetailsReqVo bankDetailsVo = new BankDetailsReqVo();
                    bankDetailsVo.setBankName(bankDetails.getBankName());
                    bankDetailsVo.setAccountNumber(bankDetails.getAccountNumber());
                    bankDetailsVo.setAccountHolderName(bankDetails.getAccountHolderName());
                    bankDetailsVo.setBankAddress(bankDetails.getBankAddress());
                    bankDetailsVo.setPostcode(bankDetails.getPostcode());
                    bankDetailsVo.setCity(bankDetails.getCity());
                    bankDetailsVo.setState(bankDetails.getState());
                    bankDetailsVo.setCountry(bankDetails.getCountry());
                    bankDetailsVo.setSwiftCode(bankDetails.getSwiftCode());
                    bankDetailsVo.setBankAccountProofFile(bankDetails.getBankAccountProofKey());
                    resp.setBankDetails(bankDetailsVo);
                }
            }

            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    @Transactional
    public Object agentSignUpUpdate(AgentSignUpReqVo signUpReq) {
        String key = "sign-up/agent/" + signUpReq.getIdentityDetails().getIdentityCardNumber();
        if (RedisUtil.exists(key)) {
            return getErrorObjectWithMsg(DUPLICATE_REQUEST);
        }
        RedisUtil.set(key, "1");
        try {
            SignUpHistory agentSignUpHistory = new SignUpHistory();
            //Identity Details
            agentSignUpHistory.setUserType(UserType.AGENT);
            agentSignUpHistory.setFullName(StringUtil.capitalizeEachWord(signUpReq.getIdentityDetails().getFullName()));
            agentSignUpHistory.setIdentityCardNumber(signUpReq.getIdentityDetails().getIdentityCardNumber().strip());
            agentSignUpHistory.setDob(new Date(signUpReq.getIdentityDetails().getDob()));
            agentSignUpHistory.setIdentityDocumentType(signUpReq.getIdentityDetails().getIdentityDocumentType());

            String identityCardFrontImageBase64 = signUpReq.getIdentityDetails().getIdentityCardFrontImage();
            if (!identityCardFrontImageBase64.startsWith("http")) {
                String identityCardFrontImageKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(identityCardFrontImageBase64)
                        .fileName("identityCardFrontImage")
                        .filePath(S3_SIGN_UP_AGENT_PATH + agentSignUpHistory.getIdentityCardNumber()));
                agentSignUpHistory.setIdentityCardFrontImageKey(identityCardFrontImageKey);
            }

            String identityCardBackImageBase64 = signUpReq.getIdentityDetails().getIdentityCardBackImage();
            if (StringUtil.isNotEmpty(identityCardBackImageBase64) && !identityCardBackImageBase64.startsWith("http")) {
                String identityCardBackImageKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(identityCardBackImageBase64)
                        .fileName("identityCardBackImage")
                        .filePath(S3_SIGN_UP_AGENT_PATH + agentSignUpHistory.getIdentityCardNumber()));
                agentSignUpHistory.setIdentityCardBackImageKey(identityCardBackImageKey);
            }

            //Contact Details
            agentSignUpHistory.setAddress(StringUtil.capitalizeEachWord(signUpReq.getContactDetails().getAddress()));
            agentSignUpHistory.setPostcode(signUpReq.getContactDetails().getPostcode());
            agentSignUpHistory.setCity(StringUtil.capitalizeEachWord(signUpReq.getContactDetails().getCity()));
            agentSignUpHistory.setState(StringUtil.capitalizeEachWord(signUpReq.getContactDetails().getState()));
            agentSignUpHistory.setCountry(StringUtil.capitalizeEachWord(signUpReq.getContactDetails().getCountry()));
            agentSignUpHistory.setMobileCountryCode(signUpReq.getContactDetails().getMobileCountryCode());
            agentSignUpHistory.setMobileNumber(signUpReq.getContactDetails().getMobileNumber().strip());
            agentSignUpHistory.setEmail(signUpReq.getContactDetails().getEmail().strip());

            String proofOfAddressFileBase64 = signUpReq.getContactDetails().getProofOfAddressFile();
            if (!proofOfAddressFileBase64.startsWith("http")) {
                String proofOfAddressFileKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(proofOfAddressFileBase64)
                        .fileName("proofOfAddressFile")
                        .filePath(S3_SIGN_UP_AGENT_PATH + agentSignUpHistory.getIdentityCardNumber()));
                agentSignUpHistory.setProofOfAddressFileKey(proofOfAddressFileKey);
            }

            //Selfie Image
            String selfieImageBase64 = signUpReq.getSelfieImage();
            String selfieImageKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(selfieImageBase64)
                    .fileName("selfieImage")
                    .filePath(S3_SIGN_UP_AGENT_PATH + agentSignUpHistory.getIdentityCardNumber()));
            agentSignUpHistory.setSelfieImageKey(selfieImageKey);

            //Agency Details
            agentSignUpHistory.setAgencyId(signUpReq.getAgencyDetails().getAgencyId());
            agentSignUpHistory.setRecruitManagerCode(signUpReq.getAgencyDetails().getRecruitManagerCode());

            //Bank Details
            agentSignUpHistory.setBankName(signUpReq.getBankDetails().getBankName());
            agentSignUpHistory.setAccountNumber(signUpReq.getBankDetails().getAccountNumber().strip());
            agentSignUpHistory.setAccountHolderName(signUpReq.getBankDetails().getAccountHolderName().strip());
            agentSignUpHistory.setBankAddress(StringUtil.capitalizeEachWord(signUpReq.getBankDetails().getBankAddress()));
            agentSignUpHistory.setBankPostcode(signUpReq.getBankDetails().getPostcode());
            agentSignUpHistory.setBankCity(StringUtil.capitalizeEachWord(signUpReq.getBankDetails().getCity()));
            agentSignUpHistory.setBankState(StringUtil.capitalizeEachWord(signUpReq.getBankDetails().getState()));
            agentSignUpHistory.setBankCountry(StringUtil.capitalizeEachWord(signUpReq.getBankDetails().getCountry()));
            agentSignUpHistory.setSwiftCode(signUpReq.getBankDetails().getSwiftCode());

            String bankAccountProofBase64 = signUpReq.getBankDetails().getBankAccountProofFile();
            if (!bankAccountProofBase64.startsWith("http")) {
                String bankAccountProofKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(bankAccountProofBase64)
                        .fileName("bankAccountProofFile")
                        .filePath(S3_SIGN_UP_AGENT_PATH + agentSignUpHistory.getIdentityCardNumber()));
                agentSignUpHistory.setProofOfBankAccountKey(bankAccountProofKey);
            }

            //Digital Signature
            String digitalSignatureBase64 = signUpReq.getDigitalSignature();
            String digitalSignatureKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(digitalSignatureBase64)
                    .fileName("digitalSignature")
                    .filePath(S3_SIGN_UP_AGENT_PATH + agentSignUpHistory.getIdentityCardNumber()));
            agentSignUpHistory.setDigitalSignatureKey(digitalSignatureKey);

            agentSignUpHistory.setCreatedAt(new Date());
            agentSignUpHistory.setUpdatedAt(new Date());

            agentSignUpHistory = signUpHistoryDao.save(agentSignUpHistory);
            agentSignUpHistory.setPassword(signUpReq.getPassword().strip());

            createNewUser(agentSignUpHistory);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        } finally {
            RedisUtil.del(key);
        }
    }

    @Transactional
    public void createNewUser(SignUpHistory signUpHistory) {
        try {
            //Create OR Update App user
            AppUser appUser = appUserDao.findByEmailAddressAndIsDeletedIsFalseAndUserType(signUpHistory.getEmail(), signUpHistory.getUserType());
            if (appUser == null) {
                appUser = new AppUser();
                appUser.setCreatedAt(new Date());
            }
            appUser.setEmailAddress(signUpHistory.getEmail());
            String hashedPassword = BCrypt.with(BCrypt.Version.VERSION_2Y).hashToString(6, signUpHistory.getPassword().toCharArray());
            appUser.setPassword(hashedPassword);
            appUser.setUserType(signUpHistory.getUserType());
            appUser.setIsDeleted(Boolean.FALSE);
            appUser.setUpdatedAt(new Date());
            appUser = appUserDao.save(appUser);

            //Create Or Update User Detail
            UserDetail userDetail = checkExistingAppUserByIdentityCardNumber(signUpHistory.getIdentityCardNumber(), signUpHistory.getUserType());
            userDetail = UserDetail.createOrUpdateNewUserDetailFromSignUpHistory(signUpHistory, userDetail);
            userDetail.setAppUserId(appUser);
            userDetail = userDetailDao.save(userDetail);

            if (UserType.CLIENT.equals(appUser.getUserType())) {
                Client client = clientDao.findByUserDetailAndStatusIsTrue(userDetail);
                if (client == null) {
                    client = new Client();
                    client.setCreatedAt(new Date());
                }
                DigitalIDResultVo digitalIDResult = createDigitalID(new DigitalIDBuilder()
                        .builderType(DigitalIDBuilder.BuilderType.CLIENT)
                        .name(userDetail.getName())
                        .date(userDetail.getDob()));
                client.setClientId(digitalIDResult.getDigitalID());
                client.setAppUser(appUser);
                client.setUserDetail(userDetail);
                if (StringUtil.isNotEmpty(signUpHistory.getReferralCodeAgent())) {
                    client.setAgent(agentDao.findByReferralCode(signUpHistory.getReferralCodeAgent()));
                }
                //Client Employment Details
                client.setEmploymentType(signUpHistory.getEmploymentType());
                if (client.getEmploymentType().equals(EmploymentType.EMPLOYED)) {
                    client.setEmployerName(StringUtil.capitalizeEachWord(signUpHistory.getEmployerName()));
                    client.setIndustryType(signUpHistory.getIndustryType());
                    client.setJobTitle(signUpHistory.getJobTitle());
                    client.setEmployerAddress(StringUtil.capitalizeEachWord(signUpHistory.getEmployerAddress()));
                    client.setEmployerPostcode(signUpHistory.getEmployerPostcode());
                    client.setEmployerCity(StringUtil.capitalizeEachWord(signUpHistory.getEmployerCity()));
                    client.setEmployerState(StringUtil.capitalizeEachWord(signUpHistory.getEmployerState()));
                    client.setEmployerCountry(StringUtil.capitalizeEachWord(signUpHistory.getEmployerCountry()));
                }
                //Client Pep Info
                PepInfo pepInfo = PepInfo.createNewPepInfoFromSignUpHistory(signUpHistory);
                pepInfo = pepInfoDao.save(pepInfo);
                client.setPepInfo(pepInfo);
                client.setStatus(true);
                client.setUpdatedAt(new Date());
                client = clientDao.save(client);

                String onboardingAgreementKey = emailService.sendOnboardingAgreementEmail(client, digitalIDResult.getRunningNumber());
                userDetail.setOnboardingAgreementKey(onboardingAgreementKey);
                userDetailDao.save(userDetail);

            } else if (UserType.AGENT.equals(appUser.getUserType())) {
                Agency agency = agencyDao.findByAgencyId(signUpHistory.getAgencyId()).orElseThrow(() -> new GeneralException(INVALID_AGENCY_ID));
                Agent agent = agentDao.findAgentByIdentityCardNumber(signUpHistory.getIdentityCardNumber(), Agent.AgentStatus.ACTIVE);
                if (agent == null) {
                    agent = new Agent();
                    agent.setCreatedAt(new Date());
                }
                DigitalIDResultVo digitalIDResult = createDigitalID(new DigitalIDBuilder()
                        .builderType(DigitalIDBuilder.BuilderType.AGENT)
                        .name(userDetail.getName())
                        .agencyCode(agency.getAgencyCode()));
                agent.setAgentId(digitalIDResult.getDigitalID());
                agent.setAppUser(appUser);
                agent.setUserDetail(userDetail);
                agent.setAgency(agency);
                String referralCode = agency.getAgencyCode() + digitalIDResult.getRunningNumber();
                agent.setReferralCode(referralCode);
                Agent recruitManager = agentDao.findByAgentIdAndStatus(signUpHistory.getRecruitManagerCode(), Agent.AgentStatus.ACTIVE).orElse(null);
                agent.setRecruitManager(recruitManager);
                agent.setAgentRole(Optional.ofNullable(agentRoleSettingsDao.findByRoleCode(AgentRole.MGR))
                        .orElseGet(() -> {
                            AgentRoleSettings newRole = new AgentRoleSettings();
                            newRole.setId(1L);
                            newRole.setRoleCode(AgentRole.MGR);
                            return newRole;
                        }));
                agent.setStatus(Agent.AgentStatus.ACTIVE);
                agent.setUpdatedAt(new Date());
                agent = agentDao.save(agent);

                //Bank Details
                BankDetails bankDetails = BankDetails.createNewBankDetailFromSignUpHistory(signUpHistory);
                bankDetails.setAppUser(appUser);
                bankDetailsDao.save(bankDetails);

                String onboardingAgreementKey = emailService.sendOnboardingAgreementEmail(agent, digitalIDResult.getRunningNumber());
                userDetail.setOnboardingAgreementKey(onboardingAgreementKey);
                userDetailDao.save(userDetail);
            }
        } catch (Exception ex) {
            log.error("Error", ex);
            throw new GeneralException(ex.getMessage());
        }
    }
}
