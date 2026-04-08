package com.citadel.backend.service;

import com.citadel.backend.dao.*;
import com.citadel.backend.dao.Client.ClientDao;
import com.citadel.backend.dao.Client.IndividualBeneficiaryDao;
import com.citadel.backend.dao.Client.IndividualBeneficiaryGuardianDao;
import com.citadel.backend.dao.Client.IndividualGuardianDao;
import com.citadel.backend.dao.Products.*;
import com.citadel.backend.entity.AppUserSession;
import com.citadel.backend.entity.Client;
import com.citadel.backend.entity.Corporate.CorporateClient;
import com.citadel.backend.entity.IndividualBeneficiary;
import com.citadel.backend.entity.*;
import com.citadel.backend.entity.Products.ProductOrder;
import com.citadel.backend.utils.*;
import com.citadel.backend.utils.Builder.UploadBase64FileBuilder;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Client.*;
import com.citadel.backend.vo.Client.Beneficiary.IndividualBeneficiaryVo;
import com.citadel.backend.vo.Client.ClientBeneficiaryGuardianRespVo;
import com.citadel.backend.vo.Client.Guardian.GuardianVo;
import com.citadel.backend.vo.Client.Guardian.IndividualGuardianCreateReqVo;
import com.citadel.backend.vo.Client.Guardian.BeneficiaryGuardianRelationshipUpdateReqVo;
import com.citadel.backend.vo.Client.Guardian.IndividualGuardianUpdateReqVo;
import com.citadel.backend.vo.Enum.*;
import com.citadel.backend.vo.SignUp.Client.EmploymentDetailsVo;
import com.citadel.backend.vo.SignUp.CorrespondingAddress;
import com.citadel.backend.vo.SignUp.PepDeclarationVo;
import com.citadel.backend.vo.Transaction.TransactionRespVo;
import com.citadel.backend.vo.Transaction.TransactionVo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.*;

import com.citadel.backend.vo.Client.Beneficiary.IndividualBeneficiaryCreateReqVo;
import com.citadel.backend.vo.Client.ClientPinReqVo;
import com.citadel.backend.vo.Client.ClientProfileRespVo;
import com.citadel.backend.vo.Client.Beneficiary.IndividualBeneficiaryUpdateReqVo;
import com.citadel.backend.vo.Client.Beneficiary.IndividualBeneficiaryRespVo;
import org.json.JSONArray;
import org.springframework.transaction.annotation.Transactional;

import java.util.stream.Collectors;

import static com.citadel.backend.utils.ApiErrorKey.*;

@Service
public class ClientService extends BaseService {

    @Resource
    private ClientDao clientDao;
    @Resource
    private UserDetailDao userDetailDao;
    @Resource
    private IndividualBeneficiaryDao individualBeneficiaryDao;
    @Resource
    private IndividualGuardianDao individualGuardianDao;
    @Resource
    private ProductService productService;
    @Resource
    private ProductOrderDao productOrderDao;
    @Resource
    private SecureTagDao secureTagDao;
    @Resource
    private PushNotificationService pushNotificationService;
    @Resource
    private IndividualBeneficiaryGuardianDao individualBeneficiaryGuardianDao;
    @Resource
    private PepInfoDao pepInfoDao;
    @Resource
    private DividendService dividendService;
    @Resource
    private ProductRedemptionDao productRedemptionDao;
    @Resource
    private ProductReallocationDao productReallocationDao;
    @Resource
    private ProductEarlyRedemptionHistoryDao productEarlyRedemptionHistoryDao;
    @Resource
    private ProductRolloverHistoryDao productRolloverHistoryDao;
    @Resource
    private ProductBeneficiariesDao productBeneficiariesDao;

    public Client getClient(AppUser appUser, String clientId) {
        Client client;
        if (UserType.AGENT.equals(appUser.getUserType()) && StringUtil.isNotEmpty(clientId)) {
            client = clientDao.findByClientId(clientId).orElseThrow(() -> new GeneralException(CLIENT_NOT_FOUND));
        } else {
            client = clientDao.findByAppUser(appUser).orElseThrow(() -> new GeneralException(CLIENT_NOT_FOUND));
        }
        return client;
    }

    public Object getClientProfile(String apiKey, String clientId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            Client client = getClient(appUser, clientId);

            ClientProfileRespVo resp = new ClientProfileRespVo();
            resp.setClientId(client.getClientId());
            resp.setPersonalDetails(client.getUserDetail().getClientPersonalDetails());
            resp.setEmploymentDetails(client.getClientEmploymentDetails());
            resp.setWealthSourceDetails(client.getClientWealthSourceDetails());
            resp.setAgentDetails(client.getClientAgentDetails());
            resp.setPepDeclaration(client.getClientPepInfo());
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object updateClientProfile(String apiKey, String clientId, ClientProfileEditReqVo clientProfileEditReqVo) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            Client client = getClient(appUser, clientId);

            UserDetail userDetail = client.getUserDetail();

            JSONArray jsonArray = new JSONArray();
            if (StringUtil.isNotEmpty(clientProfileEditReqVo.getMobileCountryCode()) && StringUtil.isNotEmpty(clientProfileEditReqVo.getMobileNumber())) {
                String mobileNumber = clientProfileEditReqVo.getMobileCountryCode() + clientProfileEditReqVo.getMobileNumber();
                if (!ValidatorUtil.validMobileNumber(mobileNumber.strip())) {
                    jsonArray.put(clientProfileEditReqVo.getClass().getSimpleName() + "." + "mobileNumber");
                }
            }

            if (StringUtil.isNotEmpty(clientProfileEditReqVo.getEmail()) && !ValidatorUtil.validEmail(clientProfileEditReqVo.getEmail().strip())) {
                jsonArray.put(clientProfileEditReqVo.getClass().getSimpleName() + "." + "email");
            }

            EmploymentDetailsVo employmentDetails = clientProfileEditReqVo.getEmploymentDetails();
            JSONArray employmentArray = ValidatorUtil.employmentDetailsValidator(employmentDetails);
            if (!employmentArray.isEmpty()) {
                jsonArray = mergeJsonArrays(List.of(jsonArray, employmentArray));
            }

            CorrespondingAddress correspondingAddress = clientProfileEditReqVo.getCorrespondingAddress();
            JSONArray addressArray = ValidatorUtil.correspondingAddressValidator(correspondingAddress);
            if (!addressArray.isEmpty()) {
                jsonArray = mergeJsonArrays(List.of(jsonArray, addressArray));
            }


            if (!jsonArray.isEmpty()) {
                return getInvalidArgumentError(jsonArray);
            }

            //UserDetail
            if (StringUtil.isNotEmpty(clientProfileEditReqVo.getName())) {
                userDetail.setName(clientProfileEditReqVo.getName());
                productOrderDao.updateClientNameByClient(clientProfileEditReqVo.getName(), client);
            }
            Optional.of(StringUtil.capitalizeEachWord(clientProfileEditReqVo.getAddress())).ifPresent(userDetail::setAddress);
            Optional.ofNullable(clientProfileEditReqVo.getPostcode()).ifPresent(userDetail::setPostcode);
            Optional.of(StringUtil.capitalizeEachWord(clientProfileEditReqVo.getCity())).ifPresent(userDetail::setCity);
            Optional.of(StringUtil.capitalizeEachWord(clientProfileEditReqVo.getState())).ifPresent(userDetail::setState);
            Optional.of(StringUtil.capitalizeEachWord(clientProfileEditReqVo.getCountry())).ifPresent(userDetail::setCountry);
            Optional.ofNullable(clientProfileEditReqVo.getMaritalStatus()).ifPresent(userDetail::setMaritalStatus);
            Optional.ofNullable(clientProfileEditReqVo.getResidentialStatus()).ifPresent(userDetail::setResidentialStatus);
            Optional.ofNullable(clientProfileEditReqVo.getMobileCountryCode()).ifPresent(userDetail::setMobileCountryCode);
            Optional.ofNullable(clientProfileEditReqVo.getMobileNumber()).map(String::strip).ifPresent(userDetail::setMobileNumber);
            Optional.ofNullable(clientProfileEditReqVo.getEmail()).map(String::strip).ifPresent(userDetail::setEmail);
            Optional.ofNullable(clientProfileEditReqVo.getNationality()).ifPresent(userDetail::setNationality);
            //Employment details
            if (EmploymentType.EMPLOYED.equals(employmentDetails.getEmploymentType()) ||
                    EmploymentType.SELF_EMPLOYED.equals(employmentDetails.getEmploymentType())) {
                client.setEmploymentType(employmentDetails.getEmploymentType());
                Optional.ofNullable(employmentDetails.getEmployerName()).ifPresent(client::setEmployerName);
                Optional.ofNullable(employmentDetails.getIndustryType()).ifPresent(client::setIndustryType);
                Optional.ofNullable(employmentDetails.getJobTitle()).ifPresent(client::setJobTitle);
                Optional.of(StringUtil.capitalizeEachWord(employmentDetails.getEmployerAddress())).ifPresent(client::setEmployerAddress);
                Optional.ofNullable(employmentDetails.getPostcode()).ifPresent(client::setEmployerPostcode);
                Optional.of(StringUtil.capitalizeEachWord(employmentDetails.getCity())).ifPresent(client::setEmployerCity);
                Optional.of(StringUtil.capitalizeEachWord(employmentDetails.getState())).ifPresent(client::setEmployerState);
                Optional.of(StringUtil.capitalizeEachWord(employmentDetails.getCountry())).ifPresent(client::setEmployerCountry);
            } else {
                client.setEmploymentType(clientProfileEditReqVo.getEmploymentDetails().getEmploymentType());
                client.setEmployerName(null);
                client.setIndustryType(null);
                client.setJobTitle(null);
                client.setEmployerAddress(null);
                client.setEmployerPostcode(null);
                client.setEmployerCity(null);
                client.setEmployerState(null);
                client.setEmployerCountry(null);
            }

            //Corresponding address
            userDetail.setIsSameCorrespondingAddress(correspondingAddress.getIsSameCorrespondingAddress());

            if (Boolean.FALSE.equals(correspondingAddress.getIsSameCorrespondingAddress())) {
                // Different corresponding address - save the values
                userDetail.setCorrespondingAddress(StringUtil.capitalizeEachWord(correspondingAddress.getCorrespondingAddress()));
                userDetail.setCorrespondingPostcode(correspondingAddress.getCorrespondingPostcode());
                userDetail.setCorrespondingCity(StringUtil.capitalizeEachWord(correspondingAddress.getCorrespondingCity()));
                userDetail.setCorrespondingState(StringUtil.capitalizeEachWord(correspondingAddress.getCorrespondingState()));
                userDetail.setCorrespondingCountry(StringUtil.capitalizeEachWord(correspondingAddress.getCorrespondingCountry()));

                String proofKey = correspondingAddress.getCorrespondingAddressProofKey();
                if (proofKey != null && !proofKey.isEmpty() && !proofKey.startsWith("http")) {
                    String uploadedKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                            .base64String(proofKey)
                            .fileName("proofOfCorrespondingAddressFile")
                            .filePath(S3_SIGN_UP_CLIENT_PATH + userDetail.getIdentityCardNumber()));
                    userDetail.setCorrespondingAddressProofKey(uploadedKey);
                }
            } else {
                // Same as residential address - update with residential address values
                userDetail.setCorrespondingAddress(userDetail.getAddress());
                userDetail.setCorrespondingPostcode(userDetail.getPostcode());
                userDetail.setCorrespondingCity(userDetail.getCity());
                userDetail.setCorrespondingState(userDetail.getState());
                userDetail.setCorrespondingCountry(userDetail.getCountry());

                // During updates where previous data was corresponding address is false, the proof of address file key would be empty.
                // The proof file would be saved in corresponding address proof key field. So we need to move it back to proof of address file key field.
                if (StringUtil.isEmpty(userDetail.getProofOfAddressFileKey()) && StringUtil.isNotEmpty(userDetail.getCorrespondingAddressProofKey())) {
                    userDetail.setProofOfAddressFileKey(userDetail.getCorrespondingAddressProofKey());
                }
            }

            //Wealth source
            Optional.ofNullable(clientProfileEditReqVo.getAnnualIncomeDeclaration()).ifPresent(client::setAnnualIncomeDeclaration);
            Optional.ofNullable(clientProfileEditReqVo.getSourceOfIncome()).ifPresent(client::setSourceOfIncome);

            userDetail.setUpdatedAt(new Date());
            userDetail = userDetailDao.save(userDetail);

            client.setUserDetail(userDetail);
            client.setUpdatedAt(new Date());
            clientDao.save(client);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object updateClientProfileImage(String apiKey, ClientProfileImageAddEditReqVo clientProfileImageAddEditReqVo) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        try {
            Client client = clientDao.findByAppUser(appUserSession.getAppUser())
                    .orElseThrow(() -> new GeneralException(USER_NOT_FOUND));

            UserDetail userDetail = client.getUserDetail();
            // Update Profile Image if not null
            String profilePictureImageBase64 = clientProfileImageAddEditReqVo.getProfilePicture();
            if (StringUtil.isNotEmpty(profilePictureImageBase64)) {
                if (!profilePictureImageBase64.startsWith("http")) {
                    String profilePictureImageKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                            .base64String(profilePictureImageBase64)
                            .fileName("profilePictureImage")
                            .filePath(S3_CLIENT_PATH + client.getUserDetail().getIdentityCardNumber()));
                    userDetail.setProfilePictureImageKey(profilePictureImageKey);
                }
            } else {
                AwsS3Util.deleteFile(userDetail.getProfilePictureImageKey());
                userDetail.setProfilePictureImageKey(null);
            }
            userDetail.setUpdatedAt(new Date());
            userDetailDao.save(userDetail);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------------Pin-----------------------------------
    public Object saveOrUpdateClientPin(String apiKey, ClientPinReqVo pinReq) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        try {
            if (StringUtil.isEmpty(pinReq.getOldPin()) && StringUtil.isEmpty(pinReq.getNewPin())) {
                return getErrorObjectWithMsg(INVALID_REQUEST);
            }
            Client client = clientDao.findByAppUser(appUserSession.getAppUser()).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));

            if (StringUtil.isNotEmpty(pinReq.getNewPin()) && StringUtil.isEmpty(pinReq.getOldPin())) {
                // Register new PIN
                if (StringUtil.isNotEmpty(client.getPin())) {
                    return getErrorObjectWithMsg(INVALID_REQUEST);
                }
                validateAndRegisterNewPin(pinReq, client);
            } else if (StringUtil.isNotEmpty(pinReq.getOldPin()) && StringUtil.isEmpty(pinReq.getNewPin())) {
                // Validate old PIN
                validateOldPin(pinReq, client);
            } else {
                // Update old PIN to new PIN
                validateOldPin(pinReq, client);
                if (StringUtil.isNotEmpty(pinReq.getOldPin()) && StringUtil.isNotEmpty(pinReq.getNewPin())) {
                    validateAndRegisterNewPin(pinReq, client);
                }
            }
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    private void validateOldPin(ClientPinReqVo pinReq, Client client) {
        if (StringUtil.isNotEmpty(client.getPin())) {
            pinReq.setOldPin(pinReq.getOldPin().strip());
            if (!validPinFormat(pinReq.getOldPin()) || !client.getPin().equals(pinReq.getOldPin())) {
                throw new GeneralException(INVALID_OLD_PIN);
            }
        }
    }

    private void validateAndRegisterNewPin(ClientPinReqVo pinReq, Client client) {
        if (!validPinFormat(pinReq.getNewPin())) {
            throw new GeneralException(INVALID_NEW_PIN);
        }
        client.setPin(pinReq.getNewPin().strip());
        client.setUpdatedAt(new Date());
        clientDao.save(client);
    }

    //-----------------------------------Beneficiary-----------------------------------
    public Object createBeneficiary(String apiKey, String clientId, IndividualBeneficiaryCreateReqVo individualBeneficiaryCreateReqVo) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            Client client = getClient(appUser, clientId);

            if (StringUtil.isEmpty(individualBeneficiaryCreateReqVo.getIdentityCardFrontImage())) {
                return getErrorObjectWithMsg(INVALID_REQUEST);
            }

            List<IndividualBeneficiary> beneficiaries = individualBeneficiaryDao.findByClientAndIsDeletedFalse(client);
            if (beneficiaries.size() >= 5) {
                return getErrorObjectWithMsg(INDIVIDUAL_BENEFICIARY_LIMIT_EXCEEDED);
            }

            JSONArray validationErrors = ValidatorUtil.individualBeneficiaryValidator(individualBeneficiaryCreateReqVo);
            if (!validationErrors.isEmpty()) {
                return getInvalidArgumentError(validationErrors);
            }

            String identityCardNumber = individualBeneficiaryCreateReqVo.getIdentityCardNumber().strip();
            IndividualBeneficiary individualBeneficiary = new IndividualBeneficiary();
            individualBeneficiary.setRelationshipToSettlor(individualBeneficiaryCreateReqVo.getRelationshipToSettlor());
            individualBeneficiary.setFullName(individualBeneficiaryCreateReqVo.getFullName());
            individualBeneficiary.setIdentityCardNumber(identityCardNumber);
            individualBeneficiary.setDob(new Date(individualBeneficiaryCreateReqVo.getDob()));
            individualBeneficiary.setGender(individualBeneficiaryCreateReqVo.getGender());
            individualBeneficiary.setNationality(individualBeneficiaryCreateReqVo.getNationality());
            individualBeneficiary.setAddress(StringUtil.capitalizeEachWord(individualBeneficiaryCreateReqVo.getAddress()));
            individualBeneficiary.setPostcode(individualBeneficiaryCreateReqVo.getPostcode());
            individualBeneficiary.setCity(StringUtil.capitalizeEachWord(individualBeneficiaryCreateReqVo.getCity()));
            individualBeneficiary.setState(StringUtil.capitalizeEachWord(individualBeneficiaryCreateReqVo.getState()));
            individualBeneficiary.setCountry(StringUtil.capitalizeEachWord(individualBeneficiaryCreateReqVo.getCountry()));
            individualBeneficiary.setResidentialStatus(individualBeneficiaryCreateReqVo.getResidentialStatus());
            individualBeneficiary.setMaritalStatus(individualBeneficiaryCreateReqVo.getMaritalStatus());
            individualBeneficiary.setMobileCountryCode(individualBeneficiaryCreateReqVo.getMobileCountryCode());
            individualBeneficiary.setMobileNumber(individualBeneficiaryCreateReqVo.getMobileNumber().strip());
            individualBeneficiary.setEmail(individualBeneficiaryCreateReqVo.getEmail().strip());
            individualBeneficiary.setIdentityDocumentType(individualBeneficiaryCreateReqVo.getIdentityDocumentType());
            String identityCardFrontImageBase64 = individualBeneficiaryCreateReqVo.getIdentityCardFrontImage();
            String identityCardFrontImageKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(identityCardFrontImageBase64)
                    .fileName("identityCardFrontImage")
                    .filePath(S3_CLIENT_PATH + client.getUserDetail().getIdentityCardNumber() + "/beneficiary/" + individualBeneficiary.getIdentityCardNumber()));
            individualBeneficiary.setIdentityCardFrontImageKey(identityCardFrontImageKey);

            String identityCardBackImageBase64 = individualBeneficiaryCreateReqVo.getIdentityCardBackImage();
            if (StringUtil.isNotEmpty(identityCardBackImageBase64)) {
                String identityCardBackImageKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(identityCardBackImageBase64)
                        .fileName("identityCardBackImage")
                        .filePath(S3_CLIENT_PATH + client.getUserDetail().getIdentityCardNumber() + "/beneficiary/" + individualBeneficiary.getIdentityCardNumber()));
                individualBeneficiary.setIdentityCardBackImageKey(identityCardBackImageKey);
            }
            individualBeneficiary.setClient(client);
            individualBeneficiary.setIsDeleted(Boolean.FALSE);
            individualBeneficiary.setCreatedAt(new Date());
            individualBeneficiary.setUpdatedAt(new Date());
            individualBeneficiary.setIsDeleted(false);

            individualBeneficiary = individualBeneficiaryDao.save(individualBeneficiary);
            Long individualBeneficiaryId = individualBeneficiary.getId();
            Date dob = individualBeneficiary.getDob();

            IndividualBeneficiaryRespVo resp = new IndividualBeneficiaryRespVo();
            resp.setIsUnderAge(DateUtil.isUnder18(dob));
            resp.setGuardianVo(new GuardianVo());
            resp.setIndividualBeneficiaryId(individualBeneficiaryId);
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    @Transactional
    public Object individualBeneficiaryUpdate(String apiKey, String clientId, Long beneficiaryId, IndividualBeneficiaryUpdateReqVo individualBeneficiaryReqVo) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            //Fetch client based on the user session
            Client client = getClient(appUser, clientId);

            //Fetch the specific beneficiary by ID and Client
            IndividualBeneficiary individualBeneficiary = individualBeneficiaryDao.findByIdAndClientAndIsDeletedFalse(beneficiaryId, client)
                    .orElseThrow(() -> new GeneralException(INDIVIDUAL_BENEFICIARY_NOT_FOUND));

            JSONArray validationErrors = ValidatorUtil.individualBeneficiaryValidator(individualBeneficiaryReqVo);
            if (!validationErrors.isEmpty()) {
                return getInvalidArgumentError(validationErrors);
            }

            // Update the fields in the existing beneficiary
            Optional.ofNullable(individualBeneficiaryReqVo.getRelationshipToSettlor()).ifPresent(individualBeneficiary::setRelationshipToSettlor);
            Optional.ofNullable(individualBeneficiaryReqVo.getFullName()).ifPresent(individualBeneficiary::setFullName);
            Optional.ofNullable(individualBeneficiaryReqVo.getGender()).ifPresent(individualBeneficiary::setGender);
            Optional.ofNullable(StringUtil.capitalizeEachWord(individualBeneficiaryReqVo.getNationality())).ifPresent(individualBeneficiary::setNationality);
            Optional.ofNullable(StringUtil.capitalizeEachWord(individualBeneficiaryReqVo.getAddress())).ifPresent(individualBeneficiary::setAddress);
            Optional.ofNullable(individualBeneficiaryReqVo.getPostcode()).ifPresent(individualBeneficiary::setPostcode);
            Optional.ofNullable(StringUtil.capitalizeEachWord(individualBeneficiaryReqVo.getCity())).ifPresent(individualBeneficiary::setCity);
            Optional.ofNullable(StringUtil.capitalizeEachWord(individualBeneficiaryReqVo.getState())).ifPresent(individualBeneficiary::setState);
            Optional.ofNullable(StringUtil.capitalizeEachWord(individualBeneficiaryReqVo.getCountry())).ifPresent(individualBeneficiary::setCountry);
            Optional.ofNullable(individualBeneficiaryReqVo.getResidentialStatus()).ifPresent(individualBeneficiary::setResidentialStatus);
            Optional.ofNullable(individualBeneficiaryReqVo.getMaritalStatus()).ifPresent(individualBeneficiary::setMaritalStatus);
            Optional.ofNullable(individualBeneficiaryReqVo.getMobileCountryCode()).ifPresent(individualBeneficiary::setMobileCountryCode);
            Optional.ofNullable(individualBeneficiaryReqVo.getMobileNumber()).map(String::strip).ifPresent(individualBeneficiary::setMobileNumber);
            Optional.ofNullable(individualBeneficiaryReqVo.getEmail()).map(String::strip).ifPresent(individualBeneficiary::setEmail);
            individualBeneficiary.setUpdatedAt(new Date());
            individualBeneficiary = individualBeneficiaryDao.save(individualBeneficiary);

            IndividualBeneficiaryGuardian beneficiaryGuardian = individualBeneficiaryGuardianDao.findByIndividualBeneficiaryAndIsDeletedIsFalse(individualBeneficiary);
            if (individualBeneficiaryReqVo.getGuardianId() != null) {
                IndividualGuardian guardian = individualGuardianDao.findById(individualBeneficiaryReqVo.getGuardianId()).orElseThrow(() -> new GeneralException(GUARDIAN_NOT_FOUND));
                if (beneficiaryGuardian == null) {
                    beneficiaryGuardian = new IndividualBeneficiaryGuardian();
                    beneficiaryGuardian.setIndividualBeneficiary(individualBeneficiary);
                    beneficiaryGuardian.setCreatedAt(new Date());
                }
                beneficiaryGuardian.setIndividualGuardian(guardian);
                if (individualBeneficiaryReqVo.getRelationshipToGuardian() != null) {
                    beneficiaryGuardian.setRelationshipToGuardian(individualBeneficiaryReqVo.getRelationshipToGuardian());
                }
                if (individualBeneficiaryReqVo.getRelationshipToBeneficiary() != null) {
                    beneficiaryGuardian.setRelationshipToBeneficiary(individualBeneficiaryReqVo.getRelationshipToBeneficiary());
                }
                beneficiaryGuardian.setUpdatedAt(new Date());
                individualBeneficiaryGuardianDao.save(beneficiaryGuardian);
            }

            Date dob = individualBeneficiary.getDob();
            IndividualGuardian individualGuardian = beneficiaryGuardian != null ? beneficiaryGuardian.getIndividualGuardian() : null;
            GuardianVo guardianVo = GuardianVo.individualGuardianToGuardianVo(individualGuardian);

            IndividualBeneficiaryRespVo resp = new IndividualBeneficiaryRespVo();
            resp.setIsUnderAge(DateUtil.isUnder18(dob));
            resp.setGuardianVo(guardianVo);
            resp.setIndividualBeneficiaryId(beneficiaryId);
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object getBeneficiariesGuardians(String apiKey, String clientId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            Client client = getClient(appUser, clientId);

            List<IndividualBeneficiaryVo> beneficiaryViewVoList = new ArrayList<>();

            List<IndividualBeneficiary> beneficiaries = individualBeneficiaryDao.findByClientAndIsDeletedFalse(client);
            if (beneficiaries != null && !beneficiaries.isEmpty()) {
                Map<Long, IndividualBeneficiaryVo> beneficiaryVoMap = beneficiaries.stream()
                        .collect(Collectors.toMap(IndividualBeneficiary::getId, IndividualBeneficiaryVo::individualBeneficiaryToBeneficiaryViewVo));

                List<IndividualBeneficiaryGuardian> beneficiaryGuardianList = individualBeneficiaryGuardianDao.findByIndividualBeneficiaryInAndIsDeletedIsFalse(beneficiaries);
                beneficiaryGuardianList.forEach(beneficiaryGuardian -> {
                    IndividualBeneficiaryVo beneficiaryVo = beneficiaryVoMap.get(beneficiaryGuardian.getIndividualBeneficiary().getId());
                    if (beneficiaryVo != null) {
                        beneficiaryVo.setRelationshipToGuardian(beneficiaryGuardian.getRelationshipToGuardian());
                        GuardianVo guardianVo = GuardianVo.individualGuardianToGuardianVo(beneficiaryGuardian.getIndividualGuardian());
                        guardianVo.setRelationshipToBeneficiary(beneficiaryGuardian.getRelationshipToBeneficiary());
                        beneficiaryVo.setGuardian(guardianVo);
                    }
                });
                beneficiaryViewVoList.addAll(beneficiaryVoMap.values());
            }

            ClientBeneficiaryGuardianRespVo resp = new ClientBeneficiaryGuardianRespVo();
            resp.setBeneficiaries(beneficiaryViewVoList);
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object individualBeneficiaryDelete(String apiKey, String clientId, Long beneficiaryId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            Client client = getClient(appUser, clientId);

            IndividualBeneficiary individualBeneficiary = individualBeneficiaryDao.findByIdAndClientAndIsDeletedFalse(beneficiaryId, client)
                    .orElseThrow(() -> new GeneralException(INDIVIDUAL_BENEFICIARY_NOT_FOUND));

            // Check if beneficiary is associated with active product orders
            boolean beneficiaryInUse = productBeneficiariesDao.existsByBeneficiaryInActiveProductOrders(beneficiaryId);
            if (beneficiaryInUse) {
                return getErrorObjectWithMsg("Beneficiary cannot be deleted as it is associated with active product orders");
            }

            //Unlink beneficiary from guardian first before deleting beneficiary
            IndividualBeneficiaryGuardian individualBeneficiaryGuardian = individualBeneficiaryGuardianDao.findByIndividualBeneficiaryAndIsDeletedIsFalse(individualBeneficiary);
            if (individualBeneficiaryGuardian != null) {
                individualBeneficiaryGuardian.setIsDeleted(Boolean.TRUE);
                individualBeneficiaryGuardian.setUpdatedAt(new Date());
                individualBeneficiaryGuardianDao.save(individualBeneficiaryGuardian);
            }

            individualBeneficiary.setIsDeleted(Boolean.TRUE);
            individualBeneficiary.setUpdatedAt(new Date());
            individualBeneficiaryDao.save(individualBeneficiary);

            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object getBeneficiariesGuardiansById(String apiKey, Long beneficiaryId) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        try {
            Client client = clientDao.findByAppUser(appUserSession.getAppUser())
                    .orElseThrow(() -> new GeneralException(USER_NOT_FOUND));

            IndividualBeneficiary beneficiary = individualBeneficiaryDao.findByIdAndClientAndIsDeletedFalse(beneficiaryId, client)
                    .orElseThrow(() -> new GeneralException(INDIVIDUAL_BENEFICIARY_NOT_FOUND));

            IndividualBeneficiaryVo beneficiaryVo = IndividualBeneficiaryVo.individualBeneficiaryToBeneficiaryViewVo(beneficiary);

            IndividualBeneficiaryGuardian beneficiaryGuardian = individualBeneficiaryGuardianDao.findByIndividualBeneficiaryAndIsDeletedIsFalse(beneficiary);
            if (beneficiaryGuardian != null) {
                beneficiaryVo.setRelationshipToGuardian(beneficiaryGuardian.getRelationshipToGuardian());
                GuardianVo guardianVo = GuardianVo.individualGuardianToGuardianVo(beneficiaryGuardian.getIndividualGuardian());
                guardianVo.setRelationshipToBeneficiary(beneficiaryGuardian.getRelationshipToBeneficiary());
                beneficiaryVo.setGuardian(guardianVo);
            }

            List<IndividualBeneficiaryVo> beneficiaryViewVoList = new ArrayList<>();
            beneficiaryViewVoList.add(beneficiaryVo);
            ClientBeneficiaryGuardianRespVo resp = new ClientBeneficiaryGuardianRespVo();
            resp.setBeneficiaries(beneficiaryViewVoList);
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------------Guardian-----------------------------------
    @Transactional
    public Object createGuardian(String apiKey, String clientId, IndividualGuardianCreateReqVo req) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            Client client = getClient(appUser, clientId);

            JSONArray validationErrors = ValidatorUtil.individualGuardianValidator(req);
            if (!validationErrors.isEmpty()) {
                return getInvalidArgumentError(validationErrors);
            }

            IndividualGuardian guardian = new IndividualGuardian();
            guardian.setClient(client);
            guardian.setFullName(req.getFullName());
            guardian.setIdentityCardNumber(req.getIdentityCardNumber().strip());
            guardian.setDob(new Date(req.getDob()));
            guardian.setGender(req.getGender());
            guardian.setNationality(req.getNationality());
            guardian.setAddress(StringUtil.capitalizeEachWord(req.getAddress()));
            guardian.setPostcode(req.getPostcode());
            guardian.setCity(StringUtil.capitalizeEachWord(req.getCity()));
            guardian.setState(StringUtil.capitalizeEachWord(req.getState()));
            guardian.setCountry(StringUtil.capitalizeEachWord(req.getCountry()));
            guardian.setResidentialStatus(req.getResidentialStatus());
            guardian.setMaritalStatus(req.getMaritalStatus());
            guardian.setMobileCountryCode(req.getMobileCountryCode());
            guardian.setMobileNumber(req.getMobileNumber());
            guardian.setEmail(req.getEmail().strip());
            guardian.setIsDeleted(false);
            guardian.setIdentityDocumentType(req.getIdentityDocumentType());
            String identityCardFrontImageBase64 = req.getIdentityCardFrontImage();
            if (StringUtil.isNotEmpty(identityCardFrontImageBase64)) {
                String identityCardFrontImageKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(identityCardFrontImageBase64)
                        .fileName("identityCardFrontImage")
                        .filePath(S3_CLIENT_PATH + client.getUserDetail().getIdentityCardNumber() + "/guardian/" + guardian.getIdentityCardNumber()));
                guardian.setIdentityCardFrontImageKey(identityCardFrontImageKey);
            }

            String identityCardBackImageBase64 = req.getIdentityCardBackImage();
            if (StringUtil.isNotEmpty(identityCardBackImageBase64) && !identityCardBackImageBase64.startsWith("http")) {
                String identityCardBackImageKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(identityCardBackImageBase64)
                        .fileName("identityCardBackImage")
                        .filePath(S3_CLIENT_PATH + client.getUserDetail().getIdentityCardNumber() + "/guardian/" + guardian.getIdentityCardNumber()));
                guardian.setIdentityCardBackImageKey(identityCardBackImageKey);
            }
            guardian.setCreatedAt(new Date());
            guardian.setUpdatedAt(new Date());
            guardian = individualGuardianDao.save(guardian);

            if (req.getBeneficiaryId() != null) {
                IndividualBeneficiary individualBeneficiary = individualBeneficiaryDao.findByIdAndClientAndIsDeletedFalse(req.getBeneficiaryId(), client)
                        .orElseThrow(() -> new GeneralException(INDIVIDUAL_BENEFICIARY_NOT_FOUND));

                IndividualBeneficiaryGuardian beneficiaryGuardian = individualBeneficiaryGuardianDao.findByIndividualBeneficiaryAndIsDeletedIsFalse(individualBeneficiary);
                if (beneficiaryGuardian == null) {
                    beneficiaryGuardian = new IndividualBeneficiaryGuardian();
                    beneficiaryGuardian.setIndividualBeneficiary(individualBeneficiary);
                    beneficiaryGuardian.setCreatedAt(new Date());
                }
                beneficiaryGuardian.setIndividualGuardian(guardian);
                if (req.getRelationshipToGuardian() != null) {
                    beneficiaryGuardian.setRelationshipToGuardian(req.getRelationshipToGuardian());
                }
                if (req.getRelationshipToBeneficiary() != null) {
                    beneficiaryGuardian.setRelationshipToBeneficiary(req.getRelationshipToBeneficiary());
                }
                beneficiaryGuardian.setIsDeleted(Boolean.FALSE);
                beneficiaryGuardian.setUpdatedAt(new Date());
                individualBeneficiaryGuardianDao.save(beneficiaryGuardian);
            }

            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object individualGuardianUpdate(String apiKey, String clientId, Long guardianId, IndividualGuardianUpdateReqVo individualGuardianUpdateReq) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {

            Client client = getClient(appUser, clientId);

            IndividualGuardian guardian = individualGuardianDao.findGuardianByIdAndClientAndIsDeletedFalse(guardianId, client);
            if (guardian == null) {
                throw new GeneralException(GUARDIAN_NOT_FOUND);
            }

            JSONArray validationErrors = new JSONArray();

            if (StringUtil.isNotEmpty(individualGuardianUpdateReq.getMobileCountryCode()) && StringUtil.isNotEmpty(individualGuardianUpdateReq.getMobileNumber())) {
                String mobileNumber = individualGuardianUpdateReq.getMobileCountryCode() + individualGuardianUpdateReq.getMobileNumber().strip();
                if (!ValidatorUtil.validMobileNumber(mobileNumber)) {
                    validationErrors.put(individualGuardianUpdateReq.getClass().getSimpleName() + "." + "mobileNumber");
                }
            }

            if (StringUtil.isNotEmpty(individualGuardianUpdateReq.getEmail())) {
                if (!ValidatorUtil.validEmail(individualGuardianUpdateReq.getEmail().strip())) {
                    validationErrors.put(individualGuardianUpdateReq.getClass().getSimpleName() + "." + "email");
                }
            }

            if (!validationErrors.isEmpty()) {
                return getInvalidArgumentError(validationErrors);
            }
            Optional.ofNullable(individualGuardianUpdateReq.getFullName()).ifPresent(guardian::setFullName);
            Optional.ofNullable(individualGuardianUpdateReq.getGender()).ifPresent(guardian::setGender);
            Optional.ofNullable(individualGuardianUpdateReq.getNationality()).ifPresent(guardian::setNationality);
            Optional.ofNullable(StringUtil.capitalizeEachWord(individualGuardianUpdateReq.getAddress())).ifPresent(guardian::setAddress);
            Optional.ofNullable(individualGuardianUpdateReq.getPostcode()).ifPresent(guardian::setPostcode);
            Optional.ofNullable(StringUtil.capitalizeEachWord(individualGuardianUpdateReq.getCity())).ifPresent(guardian::setCity);
            Optional.ofNullable(StringUtil.capitalizeEachWord(individualGuardianUpdateReq.getState())).ifPresent(guardian::setState);
            Optional.ofNullable(StringUtil.capitalizeEachWord(individualGuardianUpdateReq.getCountry())).ifPresent(guardian::setCountry);
            Optional.ofNullable(individualGuardianUpdateReq.getResidentialStatus()).ifPresent(guardian::setResidentialStatus);
            Optional.ofNullable(individualGuardianUpdateReq.getMaritalStatus()).ifPresent(guardian::setMaritalStatus);
            Optional.ofNullable(individualGuardianUpdateReq.getMobileCountryCode()).ifPresent(guardian::setMobileCountryCode);
            Optional.ofNullable(individualGuardianUpdateReq.getMobileNumber()).map(String::strip).ifPresent(guardian::setMobileNumber);
            Optional.ofNullable(individualGuardianUpdateReq.getEmail()).map(String::strip).ifPresent(guardian::setEmail);

            guardian.setUpdatedAt(new Date());
            individualGuardianDao.save(guardian);

            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object individualGuardianDelete(String apiKey, String clientId, Long guardianId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            Client client = getClient(appUser, clientId);

            IndividualGuardian guardian = individualGuardianDao.findGuardianByIdAndClientAndIsDeletedFalse(guardianId, client);
            if (guardian == null) {
                throw new GeneralException(GUARDIAN_NOT_FOUND);
            }

            // Unlink relationship with beneficiaries first before deleting guardian
            List<IndividualBeneficiaryGuardian> beneficiaryGuardianList = individualBeneficiaryGuardianDao.findByIndividualGuardianAndIsDeletedIsFalse(guardian);
            beneficiaryGuardianList.forEach(beneficiaryGuardian -> {
                beneficiaryGuardian.setIsDeleted(Boolean.TRUE);
                beneficiaryGuardian.setUpdatedAt(new Date());
                individualBeneficiaryGuardianDao.save(beneficiaryGuardian);
            });

            guardian.setIsDeleted(Boolean.TRUE);
            guardian.setUpdatedAt(new Date());
            individualGuardianDao.save(guardian);

            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object createOrEditBeneficiaryGuardianRelationship(String apiKey, String clientId, BeneficiaryGuardianRelationshipUpdateReqVo reqVo) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            Client client = getClient(appUser, clientId);

            IndividualBeneficiary individualBeneficiary = individualBeneficiaryDao.findByIdAndClientAndIsDeletedFalse(reqVo.getBeneficiaryId(), client)
                    .orElseThrow(() -> new GeneralException(INDIVIDUAL_BENEFICIARY_NOT_FOUND));

            IndividualGuardian individualGuardian = individualGuardianDao.findGuardianByIdAndClientAndIsDeletedFalse(reqVo.getGuardianId(), client);
            if (individualGuardian == null) {
                throw new GeneralException(GUARDIAN_NOT_FOUND);
            }

            IndividualBeneficiaryGuardian beneficiaryGuardian = individualBeneficiaryGuardianDao.findByIndividualBeneficiaryAndIndividualGuardianAndIsDeletedIsFalse(individualBeneficiary, individualGuardian);
            if (beneficiaryGuardian == null) {
                beneficiaryGuardian = new IndividualBeneficiaryGuardian();
                beneficiaryGuardian.setIndividualBeneficiary(individualBeneficiary);
                beneficiaryGuardian.setIndividualGuardian(individualGuardian);
                beneficiaryGuardian.setIsDeleted(Boolean.FALSE);
                beneficiaryGuardian.setCreatedAt(new Date());
            }

            if (reqVo.getRelationshipToGuardian() != null) {
                beneficiaryGuardian.setRelationshipToGuardian(reqVo.getRelationshipToGuardian());
            }
            if (reqVo.getRelationshipToBeneficiary() != null) {
                beneficiaryGuardian.setRelationshipToBeneficiary(reqVo.getRelationshipToBeneficiary());
            }

            beneficiaryGuardian.setUpdatedAt(new Date());
            individualBeneficiaryGuardianDao.save(beneficiaryGuardian);

            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------------Portfolio-----------------------------------
    public Object getClientPortfolioByClient(String apiKey) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        try {
            Client client = clientDao.findByAppUser(appUserSession.getAppUser()).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
            return getClientPortfolioByClient(client);
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public ClientPortfolioRespVo getClientPortfolioByClient(Client client) {
        List<ProductOrder> clientPurchasedProducts = productOrderDao.findAllByClient(client);
        List<ClientPortfolioVo> portfolioVoList = clientPurchasedProducts.stream()
                .map(productOrder -> productService.getClientPortfolioVoWithOptions(productOrder))
                .sorted(Comparator.comparing(ClientPortfolioVo::getProductPurchaseDate).reversed())
                .toList();
        ClientPortfolioRespVo resp = new ClientPortfolioRespVo();
        resp.setPortfolio(portfolioVoList);
        return resp;
    }

    public Object getClientPortfolioProductDetails(String apiKey, String clientId, String orderReferenceNumber) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            Client client = getClient(appUser, clientId);
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumberAndClient(orderReferenceNumber, client)
                    .orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));

            return productService.getClientPortfolioProductDetailsRespVo(productOrder);
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------------Transactions-----------------------------------
    // Includes ProductOrder(PaymentSuccess only), DividendPayment
    public Object getClientTransactions(String apiKey) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        try {
            Client client = clientDao.findByAppUser(appUserSession.getAppUser()).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
            return productService.getProductTransaction(client, null);
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------Secure Tag-----------------------------
    public Object getClientSecureTag(String apiKey) {
        ClientSecureTagRespVo resp = new ClientSecureTagRespVo();
        AppUserSession appUserSession = validateApiKey(apiKey);
        Client client = clientDao.findByAppUser(appUserSession.getAppUser()).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));

        ClientSecureTagVo secureTag = null;
        SecureTag pendingApprovalSecureTag = secureTagDao.getLatestSecureTagByClientAndStatus(client, SecureTagStatus.PENDING_APPROVAL);
        if (pendingApprovalSecureTag != null) {
            Agent agent = pendingApprovalSecureTag.getAgent();
            secureTag = new ClientSecureTagVo();
            secureTag.setAgentName(agent.getUserDetail().getName());
            secureTag.setAgentId(agent.getAgentId());
        }
        resp.setSecureTag(secureTag);
        return resp;
    }

    public Object approveRejectSecureTagUpdate(String apiKey, SecureTagAction action) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        Client client = clientDao.findByAppUser(appUserSession.getAppUser()).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
        log.info("Debug client secure tag action, action: {}, client: {}", action, client.getClientId());

        SecureTag pendingApprovalSecureTag = secureTagDao.getLatestSecureTagByClientAndStatus(client, SecureTagStatus.PENDING_APPROVAL);
        if (pendingApprovalSecureTag != null) {
            SecureTagStatus status;
            if (SecureTagAction.APPROVE.equals(action)) {
                status = SecureTagStatus.APPROVED;
            } else if (SecureTagAction.REJECT.equals(action)) {
                status = SecureTagStatus.REJECTED;
            } else {
                return getErrorObjectWithMsg(INVALID_REQUEST);
            }
            pendingApprovalSecureTag.setStatus(status);
            secureTagDao.save(pendingApprovalSecureTag);

            String title;
            String message;
            if (status.equals(SecureTagStatus.APPROVED)) {
                title = "Secure Tag Request Approved";
                message = "Your client " + client.getUserDetail().getName() + " (" + client.getClientId() + ") has successfully approved.";
            } else {
                title = "Secure Tag Request Rejected";
                message = "Your client " + client.getUserDetail().getName() + " (" + client.getClientId() + ") has rejected your request.";
            }
            pushNotificationService.notifyAppUser(client.getAgent().getAppUser(), title, message, new Date(), null, null);
        } else {
            return getErrorObjectWithMsg(INVALID_REQUEST);
        }
        return new BaseResp();
    }

    //-----------------------------Pep Details-----------------------------
    public Object editClientPep(String apiKey, String clientId, PepDeclarationVo pepDeclarationVo) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            Client client = getClient(appUser, clientId);

            PepInfo pepInfo = pepInfoDao.findById(client.getPepInfo().getId())
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
                            .filePath(S3_CLIENT_PATH + client.getUserDetail().getIdentityCardNumber()));
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

            ClientPepRespVo resp = new ClientPepRespVo();
            resp.setPepDeclaration(PepDeclarationVo.getPepDeclarationVoFromPepInfo(pepInfo));
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }
}