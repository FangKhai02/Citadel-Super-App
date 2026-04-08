package com.citadel.backend.service;

import com.citadel.backend.dao.*;
import com.citadel.backend.dao.Agent.AgentDao;
import com.citadel.backend.dao.Corporate.CorporateClientDao;
import com.citadel.backend.dao.Corporate.CorporateDetailsDao;
import com.citadel.backend.dao.Corporate.CorporateShareholdersPivotDao;
import com.citadel.backend.entity.*;
import com.citadel.backend.entity.Corporate.CorporateClient;
import com.citadel.backend.entity.Corporate.CorporateDetails;
import com.citadel.backend.entity.Corporate.CorporateShareholder;
import com.citadel.backend.entity.Corporate.CorporateShareholdersPivot;
import com.citadel.backend.utils.BaseService;
import com.citadel.backend.utils.ValidatorUtil;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.vo.BankDetails.BankDetailsReqVo;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Corporate.*;
import com.citadel.backend.vo.Corporate.ShareHolder.CorporateShareholderReqVo;
import com.citadel.backend.vo.SignUp.Client.EmploymentDetailsVo;
import com.citadel.backend.vo.SignUp.PepDeclarationVo;
import jakarta.annotation.Resource;
import org.json.JSONArray;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

import static com.citadel.backend.utils.ApiErrorKey.*;

@Service
public class ValidatorService extends BaseService {

    @Resource
    private BankDetailsDao bankDetailsDao;
    @Resource
    private CorporateClientDao corporateClientDao;
    @Resource
    private CorporateDetailsDao corporateDetailsDao;
    @Resource
    private CorporateShareholdersPivotDao corporateShareholdersPivotDao;
    @Resource
    private AgencyDao agencyDao;
    @Resource
    private AgentDao agentDao;

    public Object pepValidator(PepDeclarationVo pepDeclaration) {
        try {
            JSONArray jsonArray = ValidatorUtil.pepOptionsValidator(pepDeclaration);
            return jsonArray.isEmpty() ? new BaseResp() : getInvalidArgumentError(jsonArray);
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object employmentDetailsValidator(EmploymentDetailsVo employmentDetailsVo) {
        try {
            JSONArray jsonArray = ValidatorUtil.employmentDetailsValidator(employmentDetailsVo);
            return jsonArray.isEmpty() ? new BaseResp() : getInvalidArgumentError(jsonArray);
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object bankDetailsValidator(BankDetailsReqVo bankDetailsReqVo) {
        try {
            //Commented for issue CSA-349. 2 users irrespective of user type can share same bank account.
            //Example : 2 clients can share same bank account. An individual can share bank account as Agent and as Client.
            //Possible for bank account number to be hijacked by another user, but concern is ignored by CITADEL.
//            BankDetails bankDetails = bankDetailsDao.findByAccountNumberAndIsDeletedFalse(bankDetailsReqVo.getAccountNumber());
//            if (bankDetails != null) {
//                return getErrorObjectWithMsg(BANK_ACCOUNT_EXISTS);
//            }
            JSONArray jsonArray = new JSONArray();
            if (!bankDetailsReqVo.getBankAccountProofFile().startsWith("http")) {
                if (!validBase64FileExtension(bankDetailsReqVo.getBankAccountProofFile())) {
                    jsonArray.put(bankDetailsReqVo.getClass().getSimpleName() + "." + "bankAccountProofFile");
                }
            }
            if (!jsonArray.isEmpty()) {
                return getInvalidArgumentError(jsonArray);
            }
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------Corporate SignUp Validation-----------------------------
    public Object corporateCompanyDetailsValidator(CorporateDetailsReqVo corporateDetailsReqVo) {
        try {
            CorporateDetails corporateDetails = corporateDetailsDao.findByRegistrationNumberAndIsDeletedFalseAndStatusNotDraft(corporateDetailsReqVo.getRegistrationNumber());
            if (corporateDetails != null && !CorporateDetails.CorporateDetailsStatus.DRAFT.equals(corporateDetails.getStatus()) && !CorporateDetails.CorporateDetailsStatus.REJECTED.equals(corporateDetails.getStatus())) {
                throw new GeneralException(COMPANY_REGISTRATION_NUMBER_HAS_TAKEN);
            }

            JSONArray jsonArray = ValidatorUtil.corporateDetailsValidator(corporateDetailsReqVo);
            return jsonArray.isEmpty() ? new BaseResp() : getInvalidArgumentError(jsonArray);
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object corporateShareholderDetailsValidator(String apiKey, String referenceNumber, CorporateShareholderReqVo corporateShareholderReqVo) {
        validateApiKey(apiKey);
        try {
            CorporateClient corporateClient = corporateClientDao.findByReferenceNumberAndIsDeletedFalse(referenceNumber);
            if (corporateClient == null) {
                return getErrorObjectWithMsg(CORPORATE_CLIENT_NOT_FOUND);
            }

            JSONArray jsonArray = ValidatorUtil.corporateShareholderDetailsValidator(corporateShareholderReqVo);
            if (!jsonArray.isEmpty()) {
                return getInvalidArgumentError(jsonArray);
            }
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------Corporate Edit Validation-----------------------------
    public Object corporateDetailsEditValidator(CorporateDetailsReqVo corporateDetailsReqVo) {
        try {
            JSONArray jsonArray = ValidatorUtil.validateCorporateDetails(corporateDetailsReqVo);
            return jsonArray.isEmpty() ? new BaseResp() : getInvalidArgumentError(jsonArray);
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object corporateProductOrderValidation(CorporateClient corporateClient) {
        if (!CorporateClient.CorporateClientStatus.APPROVED.equals(corporateClient.getStatus())) {
            return getErrorObjectWithMsg(CORPORATE_PROFILE_NOT_APPROVED);
        }
        List<CorporateShareholdersPivot> corporateShareholdersPivotList = corporateShareholdersPivotDao.findAllByCorporateClientAndIsDeletedFalse(corporateClient);
        List<CorporateShareholder> mappedShareHolderList = corporateShareholdersPivotList.stream()
                .map(CorporateShareholdersPivot::getCorporateShareholder)
                .toList();
        return ValidatorUtil.shareholderCountAndShareholdingsValidator(mappedShareHolderList);
    }

    public Object agentRecruitMangerValidator(String agencyId, String recruitMangerCode) {
        try {
            // CSA-538
            Agency agency = agencyDao.findByAgencyId(agencyId).orElseThrow(() -> new GeneralException(INVALID_AGENCY_ID));
            String masterCode = "CWPAPP001";
            if (masterCode.equals(recruitMangerCode)) {
                return new BaseResp();
            }
            agentDao.findByAgentIdAndAgency(recruitMangerCode, agency).orElseThrow(() -> new GeneralException("api.invalid.agent.code"));
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }
}

