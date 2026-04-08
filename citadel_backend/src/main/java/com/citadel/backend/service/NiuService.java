package com.citadel.backend.service;

import com.citadel.backend.dao.Client.ClientDao;
import com.citadel.backend.dao.Corporate.CorporateClientDao;
import com.citadel.backend.dao.Niu.NiuApplicationDao;
import com.citadel.backend.dao.Niu.NiuApplicationDocumentDao;
import com.citadel.backend.entity.*;
import com.citadel.backend.entity.Corporate.CorporateClient;
import com.citadel.backend.utils.AwsS3Util;
import com.citadel.backend.utils.BaseService;
import com.citadel.backend.utils.Builder.UploadBase64FileBuilder;
import com.citadel.backend.utils.StringUtil;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Niu.NiuApplyDocumentVo;
import com.citadel.backend.vo.Niu.NiuApplyRequestVo;
import com.citadel.backend.vo.Niu.NiuGetApplicationDetailsVo;
import com.citadel.backend.vo.Niu.NiuGetApplicationRespVo;
import com.citadel.backend.vo.SendGrid.Attachment;
import jakarta.annotation.Resource;
import org.json.JSONArray;
import org.springframework.stereotype.Service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static com.citadel.backend.utils.ApiErrorKey.*;
import static com.citadel.backend.utils.ValidatorUtil.niuApplicationValidator;

@Service
public class NiuService extends BaseService {

    @Resource
    NiuApplicationDao niuApplicationDao;
    @Resource
    NiuApplicationDocumentDao niuApplicationDocumentDao;
    @Resource
    private EmailService emailService;

    public Object getNiuApplicationUpdate(String apiKey) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        NiuGetApplicationRespVo resp = new NiuGetApplicationRespVo();
        List<NiuApplication> niuApplications;
        niuApplications = niuApplicationDao.findByAppUser(appUser);
        resp.setApplications(niuApplications
                .stream()
                .map(NiuGetApplicationDetailsVo::getNiuApplicationDetailsVo)
                .toList());
        return resp;
    }

    public Object submitNiuApplicationUpdate(NiuApplyRequestVo niuApplyRequestVo, String apiKey) {
        try {
            log.info("NIU Application Submission Request: {}", gson.toJson(niuApplyRequestVo));
            AppUser appUser = validateApiKey(apiKey).getAppUser();

            JSONArray jsonArray = niuApplicationValidator(niuApplyRequestVo);
            if (!jsonArray.isEmpty()) {
                return getInvalidArgumentError(jsonArray);
            }
            if (niuApplyRequestVo.getDocuments() == null || niuApplyRequestVo.getDocuments().size() < 2) {
                return getErrorObjectWithMsg("Minimum 2 documents are required");
            }

            NiuApplication niuApplication = new NiuApplication();
            niuApplication.setAppUser(appUser);
            niuApplication.setAmountRequested(niuApplyRequestVo.getAmountRequested());
            niuApplication.setTenure(niuApplyRequestVo.getTenure());
            niuApplication.setApplicationType(niuApplyRequestVo.getApplicationType());
            niuApplication.setName(niuApplyRequestVo.getName());
            niuApplication.setDocumentNumber(niuApplyRequestVo.getDocumentNumber());
            niuApplication.setAddress(StringUtil.capitalizeEachWord(niuApplyRequestVo.getAddress()));
            niuApplication.setPostcode(niuApplyRequestVo.getPostcode());
            niuApplication.setCity(StringUtil.capitalizeEachWord(niuApplyRequestVo.getCity()));
            niuApplication.setState(StringUtil.capitalizeEachWord(niuApplyRequestVo.getState()));
            niuApplication.setCountry(StringUtil.capitalizeEachWord(niuApplyRequestVo.getCountry()));
            niuApplication.setMobileCountryCode(niuApplyRequestVo.getMobileCountryCode());
            niuApplication.setMobileNumber(niuApplyRequestVo.getMobileNumber());
            niuApplication.setEmail(niuApplyRequestVo.getEmail());
            niuApplication.setNatureOfBusiness(niuApplyRequestVo.getNatureOfBusiness());
            niuApplication.setPurposeOfAdvances(niuApplyRequestVo.getPurposeOfAdvances());
            niuApplication.setCreatedAt(new Date());
            niuApplicationDao.save(niuApplication);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
            niuApplication.setFirstSigneeName(niuApplyRequestVo.getFirstSignee().getFullName());
            niuApplication.setFirstSigneeNric(niuApplyRequestVo.getFirstSignee().getNric());
            niuApplication.setFirstSigneeSignedDate(niuApplyRequestVo.getFirstSignee().getSignedDate());
            String firstSigneeSignatureS3FilePath = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(niuApplyRequestVo.getFirstSignee().getSignature())
                    .fileName("first-signee-signature")
                    .filePath(S3_NIU_APPLICATION_PATH + sdf.format(niuApplication.getCreatedAt()) + File.separator + niuApplication.getDocumentNumber() + File.separator + niuApplication.getId()));
            niuApplication.setFirstSigneeSignature(getS3PublicUrl(firstSigneeSignatureS3FilePath));

            niuApplication.setSecondSigneeName(niuApplyRequestVo.getSecondSignee().getFullName());
            niuApplication.setSecondSigneeNric(niuApplyRequestVo.getSecondSignee().getNric());
            niuApplication.setSecondSigneeSignedDate(niuApplyRequestVo.getSecondSignee().getSignedDate());
            String secondSigneeSignatureS3FilePath = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                    .base64String(niuApplyRequestVo.getSecondSignee().getSignature())
                    .fileName("second-signee-signature")
                    .filePath(S3_NIU_APPLICATION_PATH + sdf.format(niuApplication.getCreatedAt()) + File.separator + niuApplication.getDocumentNumber() + File.separator + niuApplication.getId()));
            niuApplication.setSecondSigneeSignature(getS3PublicUrl(secondSigneeSignatureS3FilePath));

            niuApplication = niuApplicationDao.save(niuApplication);

            List<Attachment> attachments = new ArrayList<>();
            for (NiuApplyDocumentVo document : niuApplyRequestVo.getDocuments()) {
                String documentS3FilePath = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                        .base64String(document.getSignature())
                        .fileName(document.getFilename())
                        .filePath(S3_NIU_APPLICATION_PATH + sdf.format(niuApplication.getCreatedAt()) + File.separator + niuApplication.getDocumentNumber() + File.separator + niuApplication.getId()));

                NiuApplicationDocument niuApplicationDocument = new NiuApplicationDocument();
                niuApplicationDocument.setNiuApplication(niuApplication);
                niuApplicationDocument.setFilename(getFilename(documentS3FilePath));
                niuApplicationDocument.setUrl(getS3PublicUrl(documentS3FilePath));
                niuApplicationDocument.setCreatedAt(new Date());
                niuApplicationDocumentDao.save(niuApplicationDocument);

                Attachment attachment = new Attachment(document.getSignature(), AwsS3Util.determineContentType(document.getFilename()), document.getFilename());
                attachments.add(attachment);
            }

            emailService.sendNiuApplicationEmail(niuApplication, attachments);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in submitNiuApplication", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }
}
