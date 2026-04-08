package com.citadel.backend.service;

import com.citadel.backend.dao.Agent.AgentDao;
import com.citadel.backend.dao.BankDetailsDao;
import com.citadel.backend.dao.Client.ClientDao;
import com.citadel.backend.dao.Products.ProductOrderDao;
import com.citadel.backend.entity.*;
import com.citadel.backend.utils.AwsS3Util;
import com.citadel.backend.utils.BaseService;
import com.citadel.backend.utils.Builder.UploadBase64FileBuilder;
import com.citadel.backend.utils.StringUtil;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.vo.BankDetails.BankDetailsResp;
import com.citadel.backend.vo.BankDetails.BankDetailsReqVo;
import com.citadel.backend.vo.BankDetails.BankDetailsVo;
import com.citadel.backend.vo.BankDetails.CreateBankRespVo;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Enum.UserType;
import jakarta.annotation.Resource;
import org.json.JSONArray;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import static com.citadel.backend.utils.ApiErrorKey.*;

@Service
public class BankService extends BaseService {

    @Resource
    private ClientDao clientDao;
    @Resource
    private BankDetailsDao bankDetailsDao;
    @Resource
    private AgentDao agentDao;
    @Resource
    private ProductOrderDao productOrderDao;

    public Object createBankDetails(String apiKey, String clientId, BankDetailsReqVo bankDetailsReq) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        try {
            AppUser appUser = appUserSession.getAppUser();
            String s3FilePath = "";

            if (UserType.CLIENT.equals(appUser.getUserType())) {
                Client client = clientDao.findByAppUser(appUser).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
                s3FilePath = S3_CLIENT_PATH + client.getUserDetail().getIdentityCardNumber();
            } else if (UserType.AGENT.equals(appUser.getUserType())) {
                if (StringUtil.isNotEmpty(clientId)) {
                    Client client = clientDao.findByClientId(clientId).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
                    s3FilePath = S3_CLIENT_PATH + client.getUserDetail().getIdentityCardNumber();
                    appUser = client.getAppUser();
                } else {
                    Agent agent = agentDao.findByAppUserAndStatus(appUser, Agent.AgentStatus.ACTIVE).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
                    s3FilePath = S3_AGENT_PATH + agent.getUserDetail().getIdentityCardNumber();
                }
            }

            //Same user cannot create new record with same bank account number
            boolean exist = bankDetailsDao.existsByAccountNumberAndAppUserAndIsDeletedIsFalse(bankDetailsReq.getAccountNumber().strip(), appUser);
            if (exist) {
                return getErrorObjectWithMsg(BANK_ACCOUNT_EXISTS);
            }

            BankDetails bankDetail = new BankDetails();
            bankDetail.setAppUser(appUser);
            bankDetail.setBankName(bankDetailsReq.getBankName());
            bankDetail.setAccountNumber(bankDetailsReq.getAccountNumber().strip());
            bankDetail.setAccountHolderName(bankDetailsReq.getAccountHolderName().strip());
            String bankAccountProofFileBase64 = bankDetailsReq.getBankAccountProofFile();
            String bankAccountProofKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(bankAccountProofFileBase64)
                    .fileName(bankDetail.getBankName() + "_" + bankDetail.getAccountNumber() + "_bankAccountProofFile")
                    .filePath(s3FilePath + "/bankAccountProofs"));
            bankDetail.setBankAccountProofKey(bankAccountProofKey);
            //Address and SwiftCode is Optional
            Optional.ofNullable(StringUtil.capitalizeEachWord(bankDetailsReq.getBankAddress())).ifPresent(bankDetail::setBankAddress);
            Optional.ofNullable(bankDetailsReq.getPostcode()).ifPresent(bankDetail::setPostcode);
            Optional.ofNullable(StringUtil.capitalizeEachWord(bankDetailsReq.getCity())).ifPresent(bankDetail::setCity);
            Optional.ofNullable(StringUtil.capitalizeEachWord(bankDetailsReq.getState())).ifPresent(bankDetail::setState);
            Optional.ofNullable(StringUtil.capitalizeEachWord(bankDetailsReq.getCountry())).ifPresent(bankDetail::setCountry);
            Optional.ofNullable(bankDetailsReq.getSwiftCode()).map(String::strip).ifPresent(bankDetail::setSwiftCode);
            bankDetail.setIsDeleted(false);
            bankDetail.setCreatedAt(new Date());
            bankDetail.setUpdatedAt(new Date());

            bankDetail = bankDetailsDao.save(bankDetail);

            CreateBankRespVo resp = new CreateBankRespVo();
            resp.setBankDetails(BankDetailsVo.bankDetailsToBankDetailsVo(bankDetail));
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object getBankDetails(String apiKey, String clientId) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        try {
            AppUser appUser = appUserSession.getAppUser();
            if (StringUtil.isNotEmpty(clientId)) {
                appUser = clientDao.findByClientId(clientId).orElseThrow(() -> new GeneralException(USER_NOT_FOUND)).getAppUser();
            }
            List<BankDetails> bankDetailsEntities = bankDetailsDao.findAllByAppUserAndIsDeletedIsFalse(appUser);

            List<BankDetailsVo> bankDetailsList = bankDetailsEntities.stream()
                    .map(BankDetailsVo::bankDetailsToBankDetailsVo).toList();

            BankDetailsResp resp = new BankDetailsResp();
            resp.setBankDetails(bankDetailsList);
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object updateBankDetails(String apiKey, String clientId, Long bankId, BankDetailsReqVo bankDetailsReq) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        try {
            AppUser appUser = appUserSession.getAppUser();
            String s3FilePath = "";

            if (UserType.CLIENT.equals(appUser.getUserType())) {
                Client client = clientDao.findByAppUser(appUser).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
                s3FilePath = S3_CLIENT_PATH + client.getUserDetail().getIdentityCardNumber();
            } else if (UserType.AGENT.equals(appUser.getUserType())) {
                if (StringUtil.isNotEmpty(clientId)) {
                    Client client = clientDao.findByClientId(clientId).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
                    s3FilePath = S3_CLIENT_PATH + client.getUserDetail().getIdentityCardNumber();
                    appUser = client.getAppUser();
                } else {
                    Agent agent = agentDao.findByAppUserAndStatus(appUser, Agent.AgentStatus.ACTIVE).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
                    s3FilePath = S3_AGENT_PATH + agent.getUserDetail().getIdentityCardNumber();
                }
            }

            //Fetch the specific bank details by bank_details_id
            BankDetails bankDetail = bankDetailsDao.findByIdAndAppUserAndIsDeletedFalse(bankId, appUser).orElseThrow(() -> new GeneralException(BANK_DETAILS_NOT_FOUND));

            JSONArray jsonArray = new JSONArray();
            String bankAccountProofFile = bankDetailsReq.getBankAccountProofFile();
            if (StringUtil.isNotEmpty(bankAccountProofFile) && !bankAccountProofFile.startsWith("http")) {
                if (!validBase64FileExtension(bankAccountProofFile)) {
                    jsonArray.put(bankDetailsReq.getClass().getSimpleName() + "." + "bankAccountProofFile");
                }
            }
            if (!jsonArray.isEmpty()) {
                return getInvalidArgumentError(jsonArray);
            }

            Optional.ofNullable(bankDetailsReq.getBankName()).ifPresent(bankDetail::setBankName);
            Optional.ofNullable(bankDetailsReq.getAccountNumber()).map(String::strip).ifPresent(bankDetail::setAccountNumber);
            Optional.ofNullable(bankDetailsReq.getAccountHolderName()).map(String::strip).ifPresent(bankDetail::setAccountHolderName);
            Optional.ofNullable(StringUtil.capitalizeEachWord(bankDetailsReq.getBankAddress())).ifPresent(bankDetail::setBankAddress);
            Optional.ofNullable(bankDetailsReq.getPostcode()).ifPresent(bankDetail::setPostcode);
            Optional.ofNullable(StringUtil.capitalizeEachWord(bankDetailsReq.getCity())).ifPresent(bankDetail::setCity);
            Optional.ofNullable(StringUtil.capitalizeEachWord(bankDetailsReq.getState())).ifPresent(bankDetail::setState);
            Optional.ofNullable(StringUtil.capitalizeEachWord(bankDetailsReq.getCountry())).ifPresent(bankDetail::setCountry);
            Optional.ofNullable(bankDetailsReq.getSwiftCode()).map(String::strip).ifPresent(bankDetail::setSwiftCode);
            if (StringUtil.isNotEmpty(bankAccountProofFile) && !bankAccountProofFile.startsWith("http")) {
                String bankAccountProofKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(bankAccountProofFile)
                        .fileName(bankDetail.getBankName() + "_" + bankDetail.getAccountNumber() + "_bankAccountProofFile")
                        .filePath(s3FilePath + "/bankAccountProofs"));
                bankDetail.setBankAccountProofKey(bankAccountProofKey);
            }
            bankDetail.setUpdatedAt(new Date());
            bankDetailsDao.save(bankDetail);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object bankDetailsDelete(String apiKey, String clientId, Long bankId) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        try {
            AppUser appUser = appUserSession.getAppUser();
            if (StringUtil.isNotEmpty(clientId)) {
                appUser = clientDao.findByClientId(clientId).orElseThrow(() -> new GeneralException(USER_NOT_FOUND)).getAppUser();
            }
            BankDetails bankDetails = bankDetailsDao.findByIdAndAppUserAndIsDeletedFalse(bankId, appUser).orElseThrow(() -> new GeneralException(BANK_DETAILS_NOT_FOUND));

            // Check if user is not an agent and bank account is in use by active product orders
            if (!UserType.AGENT.equals(appUserSession.getAppUser().getUserType())) {
                boolean bankInUse = productOrderDao.existsByBankIdAndStatusNotMaturedOrWithdrawn(bankId);
                if (bankInUse) {
                    return getErrorObjectWithMsg("Bank account cannot be deleted as it is currently in use by active product orders");
                }
            }

            bankDetails.setIsDeleted(Boolean.TRUE);
            bankDetails.setUpdatedAt(new Date());

            bankDetailsDao.save(bankDetails);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }
}
