package com.citadel.backend.utils;

import com.citadel.backend.entity.Corporate.CorporateShareholder;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Client.Beneficiary.IndividualBeneficiaryCreateReqVo;
import com.citadel.backend.vo.Client.Guardian.IndividualGuardianCreateReqVo;
import com.citadel.backend.vo.ContactUsFormSubmitReqVo;
import com.citadel.backend.vo.Corporate.*;
import com.citadel.backend.vo.Corporate.Documents.CorporateDocumentsVo;
import com.citadel.backend.vo.Corporate.ShareHolder.CorporateShareholderReqVo;
import com.citadel.backend.vo.Enum.EmploymentType;
import com.citadel.backend.vo.Enum.NiuApplicationType;
import com.citadel.backend.vo.Niu.NiuApplyDocumentVo;
import com.citadel.backend.vo.Niu.NiuApplyRequestVo;
import com.citadel.backend.vo.SignUp.*;
import com.citadel.backend.vo.SignUp.Client.EmploymentDetailsVo;
import com.citadel.backend.vo.SignUp.PepDeclarationOptionsVo;
import com.citadel.backend.vo.SignUp.PepDeclarationVo;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Field;
import java.util.*;

import org.xbill.DNS.Lookup;
import org.xbill.DNS.Record;
import org.xbill.DNS.Type;

import static com.citadel.backend.utils.ApiErrorKey.*;

public class ValidatorUtil extends BaseService {
    protected static final Logger log = LoggerFactory.getLogger(ValidatorUtil.class);

    private static final String EMAIL_REGEX = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@"
            + "[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";
    private static final String MOBILE_NO_REGEX = "[+](?:[0-9] ?){6,14}[0-9]$";
    //Reference: https://stackoverflow.com/a/77575469
    private static final String NRIC_REGEX = "^((\\d{2}(?!0229))|([02468][048]|[13579][26])(?=0229))(0[1-9]|1[0-2])(0[1-9]|[12]\\d|(?<!02)30|(?<!02|4|6|9|11)31)-(\\d{2})-(\\d{4})$";

    public static boolean isValidNric(String nric) {
        return nric.matches(NRIC_REGEX);
    }

    /**
     * This method validates a given email.
     *
     * @param email email address
     * @return true/ false
     */
    public static boolean validEmail(String email) {
        if (StringUtil.isEmpty(email) || !email.matches(EMAIL_REGEX)) {
            return false;
        }
        String[] parts = email.split("@");
        if (parts.length != 2) {
            return false;
        }

        String domain = parts[1];
        try {
            Lookup lookup = new Lookup(domain, Type.MX);
            Record[] records = lookup.run();
            if (records.length > 0) {
                return true;
            }
        } catch (Exception e) {
            return false;
        }
        return false;
    }

    /**
     * This method validates a given mobile no.
     *
     * @param mobileNo mobile no
     * @return true/ false
     */
    public static boolean isValidMobileNo(String mobileNo) {
        return mobileNo.matches(MOBILE_NO_REGEX);
    }

    //Return true if valid
    public static Boolean validMobileNumber(String mobileNumber) {
        if (StringUtils.isEmpty(mobileNumber)) {
            return false;
        }
        if (isValidMobileNo(mobileNumber)) {
            //validate malaysian number between 9 and 11 excluding country code
            if (mobileNumber.startsWith("+60")) {
                String length = StringUtil.substring(mobileNumber, 3);
                return length.length() >= 9 && length.length() <= 11;
            } else {
                //validate international number between and 12 excluding country code
                String length = StringUtil.substring(mobileNumber, 1);
                return length.length() >= 7 && length.length() <= 16;
            }
        }
        return false;
    }

    public static Object identityDetailsValidator(SignUpBaseIdentityDetailsVo signUpBaseIdentityDetails, Boolean checkDob) {
        JSONArray jsonArray = new JSONArray();
        if (checkDob) {
            try {
                Calendar now = Calendar.getInstance();
                Calendar dateOfBirth = Calendar.getInstance();
                dateOfBirth.setTime(new Date(signUpBaseIdentityDetails.getDob()));
                if (now.get(Calendar.YEAR) - dateOfBirth.get(Calendar.YEAR) < 18) {
                    return getErrorObjectWithMsg("api.age.must.be.above.18");
                }
            } catch (Exception ex) {
                log.error("Error", ex);
                jsonArray.put(signUpBaseIdentityDetails.getClass().getSimpleName() + "." + "dob");
            }
        }
        String identityCardFrontImage = signUpBaseIdentityDetails.getIdentityCardFrontImage();
        if (!identityCardFrontImage.startsWith("http")) {
            if (!validBase64FileExtension(identityCardFrontImage)) {
                jsonArray.put(signUpBaseIdentityDetails.getClass().getSimpleName() + "." + "identityCardFrontImage");
            }
        }

        String identityCardBackImage = signUpBaseIdentityDetails.getIdentityCardBackImage();
        if (StringUtil.isNotEmpty(identityCardBackImage)) {
            if (!identityCardFrontImage.startsWith("http")) {
                if (!validBase64FileExtension(identityCardBackImage)) {
                    jsonArray.put(signUpBaseIdentityDetails.getClass().getSimpleName() + "." + "identityCardBackImage");
                }
            }
        }
        return jsonArray;
    }

    public static JSONArray contactDetailsValidator(SignUpBaseContactDetailsVo signUpBaseContactDetails) {
        JSONArray jsonArray = new JSONArray();
        String mobileNumber = signUpBaseContactDetails.getMobileCountryCode() + signUpBaseContactDetails.getMobileNumber();
        if (!validMobileNumber(mobileNumber)) {
            jsonArray.put(signUpBaseContactDetails.getClass().getSimpleName() + "." + "mobileNumber");
        }
        if (!validEmail(signUpBaseContactDetails.getEmail())) {
            jsonArray.put(signUpBaseContactDetails.getClass().getSimpleName() + "." + "email");
        }
        String proofOfAddressFile = signUpBaseContactDetails.getProofOfAddressFile();
        if (!proofOfAddressFile.startsWith("http")) {
            if (!validBase64FileExtension(proofOfAddressFile)) {
                jsonArray.put(signUpBaseContactDetails.getClass().getSimpleName() + "." + "proofOfAddressFile");
            }
        }
        return jsonArray;
    }

    public static JSONArray pepOptionsValidator(PepDeclarationVo pepDeclaration) {
        if (pepDeclaration.getIsPep()) {
            PepDeclarationOptionsVo options = pepDeclaration.getPepDeclarationOptions();
            if (options == null) {
                options = new PepDeclarationOptionsVo();
            }
            JSONArray jsonArray = getAllNullFields(options);
            if (!jsonArray.isEmpty()) {
                return jsonArray;
            }
            String pepDocument = options.getSupportingDocument();
            if (!pepDocument.startsWith("http")) {
                if (!validBase64FileExtension(pepDocument)) {
                    jsonArray.put(options.getClass().getSimpleName() + "." + "supportingDocument");
                }
            }
            return jsonArray;
        }
        return new JSONArray();
    }

    public static JSONArray employmentDetailsValidator(EmploymentDetailsVo employmentDetailsVo) {
        JSONArray jsonArray = new JSONArray();
        if (employmentDetailsVo == null || employmentDetailsVo.getEmploymentType() == null) {
            jsonArray.put(EmploymentDetailsVo.class.getSimpleName() + "." + "employmentType");
            return jsonArray;
        }
        if (EmploymentType.EMPLOYED.equals(employmentDetailsVo.getEmploymentType()) || EmploymentType.SELF_EMPLOYED.equals(employmentDetailsVo.getEmploymentType())) {
            return getAllNullFields(employmentDetailsVo);
        }
        return jsonArray;
    }

    public static JSONArray correspondingAddressValidator(CorrespondingAddress correspondingAddress) {
        JSONArray jsonArray = new JSONArray();

        // Validate if the correspondingAddress or its fields are null
        if (correspondingAddress == null || correspondingAddress.getIsSameCorrespondingAddress() == null) {
            jsonArray.put(CorrespondingAddress.class.getSimpleName() + "." + "isSameCorrespondingAddress");
            return jsonArray;
        }

        // If IsSameCorrespondingAddress is FALSE, validate all fields for null
        if (!correspondingAddress.getIsSameCorrespondingAddress()) {
            jsonArray = getAllNullFields(correspondingAddress);

            if (StringUtil.isNotEmpty(correspondingAddress.getCorrespondingAddressProofKey()) && !correspondingAddress.getCorrespondingAddressProofKey().startsWith("http")) {
                if (!validBase64FileExtension(correspondingAddress.getCorrespondingAddressProofKey())) {
                    jsonArray.put(CorrespondingAddress.class.getSimpleName() + "." + "correspondingAddressProofKey");
                }
            }
        }
        return jsonArray;
    }

    public static JSONArray niuApplicationValidator(NiuApplyRequestVo niuApplyRequestVo) {
        JSONArray jsonArray = getAllNullFields(niuApplyRequestVo);
        if (!jsonArray.isEmpty()) {
            return jsonArray;
        }
        if (niuApplyRequestVo.getApplicationType() != null) {
            if (!(niuApplyRequestVo.getApplicationType().equals(NiuApplicationType.PERSONAL)) &&
                    !(niuApplyRequestVo.getApplicationType().equals(NiuApplicationType.COMPANY))) {
                jsonArray.put(niuApplyRequestVo.getClass().getSimpleName() + "." + "applicationType");
            }
        }
//        if (niuApplyRequestVo.getApplicationType().equals(NiuApplicationType.PERSONAL.name()) &&
//                !isValidNric(niuApplyRequestVo.getDocumentNumber())) {
//            jsonArray.put(niuApplyRequestVo.getClass().getSimpleName() + "." + "documentNumber");
//        }
        String mobileNumber = niuApplyRequestVo.getMobileCountryCode() + niuApplyRequestVo.getMobileNumber();
        if (!validMobileNumber(mobileNumber)) {
            jsonArray.put(niuApplyRequestVo.getClass().getSimpleName() + "." + "mobileNumber");
        }
        if (!validEmail(niuApplyRequestVo.getEmail())) {
            jsonArray.put(niuApplyRequestVo.getClass().getSimpleName() + "." + "email");
        }
        if (niuApplyRequestVo.getDocuments() != null && !niuApplyRequestVo.getDocuments().isEmpty()) {
            for (NiuApplyDocumentVo document : niuApplyRequestVo.getDocuments()) {
                if (!validBase64FileExtension(document.getSignature())) {
                    jsonArray.put(niuApplyRequestVo.getClass().getSimpleName() + "." + "documents");
                    break;
                }
            }
        }
        if (niuApplyRequestVo.getFirstSignee() != null) {
            jsonArray.putAll(getAllNullFields(niuApplyRequestVo.getFirstSignee()));
            if (niuApplyRequestVo.getFirstSignee().getSignature() != null) {
                if (!validBase64FileExtension(niuApplyRequestVo.getFirstSignee().getSignature())) {
                    jsonArray.put(niuApplyRequestVo.getFirstSignee().getClass().getSimpleName() + "." + "signature");
                }
            }
//            if (!isValidNric(niuApplyRequestVo.getFirstSignee().getNric())) {
//                jsonArray.put(niuApplyRequestVo.getFirstSignee().getClass().getSimpleName() + "." + "nric");
//            }
        }
        if (niuApplyRequestVo.getSecondSignee() != null) {
            jsonArray.putAll(getAllNullFields(niuApplyRequestVo.getSecondSignee()));
            if (niuApplyRequestVo.getSecondSignee().getSignature() != null) {
                if (!validBase64FileExtension(niuApplyRequestVo.getSecondSignee().getSignature())) {
                    jsonArray.put(niuApplyRequestVo.getSecondSignee().getClass().getSimpleName() + "." + "signature");
                }
            }
//            if (!isValidNric(niuApplyRequestVo.getSecondSignee().getNric())) {
//                jsonArray.put(niuApplyRequestVo.getSecondSignee().getClass().getSimpleName() + "." + "nric");
//            }
        }
        return jsonArray;
    }

    public static JSONArray contactUsFormSubmitValidator(ContactUsFormSubmitReqVo contactUsFormSubmitReqVo) {
        JSONArray jsonArray = getAllNullFields(contactUsFormSubmitReqVo);
        if (!jsonArray.isEmpty()) {
            return jsonArray;
        }

        String mobileNumber = contactUsFormSubmitReqVo.getMobileCountryCode() + contactUsFormSubmitReqVo.getMobileNumber();
        if (!validMobileNumber(mobileNumber)) {
            jsonArray.put(contactUsFormSubmitReqVo.getClass().getSimpleName() + "." + "mobileNumber");
        }
        if (!validEmail(contactUsFormSubmitReqVo.getEmail())) {
            jsonArray.put(contactUsFormSubmitReqVo.getClass().getSimpleName() + "." + "email");
        }
        return jsonArray;
    }

    public static JSONArray getAllNullFields(Object object) {
        JSONArray jsonArray = new JSONArray();
        Field[] fields = object.getClass().getDeclaredFields();
        for (Field field : fields) {
            field.setAccessible(true);
            try {
                if (field.get(object) == null) {
                    jsonArray.put(object.getClass().getSimpleName() + "." + field.getName());
                }
            } catch (IllegalAccessException ex) {
                log.error("Error while validating {}", ex.getMessage());
            }
        }
        return jsonArray;
    }

    //----------------------Individual Beneficiary Validation----------------------
    public static JSONArray individualBeneficiaryValidator(IndividualBeneficiaryCreateReqVo req) {
        JSONArray validationErrors = new JSONArray();
        String mobileNumber = req.getMobileNumber().strip();
        String mobileNumberWithCountryCode = req.getMobileCountryCode() + mobileNumber;
        if (!ValidatorUtil.validMobileNumber(mobileNumberWithCountryCode)) {
            validationErrors.put(req.getClass().getSimpleName() + "." + "mobileNumber");
        }
        if (StringUtil.isNotEmpty(req.getEmail())) {
            String email = req.getEmail().strip();
            if (!ValidatorUtil.validEmail(email)) {
                validationErrors.put(req.getClass().getSimpleName() + "." + "email");
            }
        }
        return validationErrors;
    }

    public static JSONArray individualGuardianValidator(IndividualGuardianCreateReqVo req) {
        JSONArray validationErrors = new JSONArray();
        String mobileNumber = req.getMobileNumber().strip();
        String mobileNumberWithCountryCode = req.getMobileCountryCode() + mobileNumber;
        if (!ValidatorUtil.validMobileNumber(mobileNumberWithCountryCode)) {
            validationErrors.put(req.getClass().getSimpleName() + "." + "mobileNumber");
        }
        if (StringUtil.isNotEmpty(req.getEmail())) {
            String email = req.getEmail().strip();
            if (!ValidatorUtil.validEmail(email)) {
                validationErrors.put(req.getClass().getSimpleName() + "." + "email");
            }
        }
        return validationErrors;
    }

    //----------------------Corporate SignUp Validation----------------------
    public static JSONArray corporateDetailsValidator(CorporateDetailsReqVo corporateDetailsReqVo) {
        JSONArray validationErrors = getAllNullFields(corporateDetailsReqVo);
        if (!validationErrors.isEmpty()) {
            return validationErrors;
        }

        String mobileNumber = corporateDetailsReqVo.getContactMobileCountryCode() + corporateDetailsReqVo.getContactMobileNumber();
        if (!ValidatorUtil.validMobileNumber(mobileNumber)) {
            validationErrors.put(corporateDetailsReqVo.getClass().getSimpleName() + "." + "contactMobileNumber");
        }
        if (!ValidatorUtil.validEmail(corporateDetailsReqVo.getContactEmail())) {
            validationErrors.put(corporateDetailsReqVo.getClass().getSimpleName() + "." + "contactEmail");
        }

        Boolean isDifferentRegisteredAddress = corporateDetailsReqVo.getCorporateAddressDetails().getIsDifferentRegisteredAddress();
        if (isDifferentRegisteredAddress == null) {
            validationErrors.put(corporateDetailsReqVo.getCorporateAddressDetails().getClass().getSimpleName() + "." + "isDifferentRegisteredAddress");
        } else if (isDifferentRegisteredAddress.equals(Boolean.TRUE)) {
            JSONArray addressNullFieldErrors = getAllNullFields(corporateDetailsReqVo.getCorporateAddressDetails());
            if (!addressNullFieldErrors.isEmpty()) {
                List<JSONArray> validationErrorsList = List.of(validationErrors, addressNullFieldErrors);
                return mergeJsonArrays(validationErrorsList);
            }
        }

        return validationErrors;
    }

    public static Object shareholderCountAndShareholdingsValidator(List<CorporateShareholder> shareholderList) {
        /* Function is used to validate shareholder count and total shareholdings percentage */

        if (shareholderList == null || shareholderList.isEmpty()) {
            return getErrorObjectWithMsg(SHAREHOLDER_NOT_FOUND);
        }

        if (shareholderList.size() > 5) {
            return getErrorObjectWithMsg(CORPORATE_SHAREHOLDER_LIMIT_EXCEEDED);
        }

        double totalShareholding = 0.0;
        for (CorporateShareholder shareholder : shareholderList) {
            totalShareholding += shareholder.getPercentageOfShareholdings();
        }
        if (totalShareholding != 100) {
            return getErrorObjectWithMsg(INVALID_SHAREHOLDINGS_PERCENTAGE);
        }
        return new BaseResp();
    }

    public static JSONArray corporateShareholderDetailsValidator(CorporateShareholderReqVo corporateShareholderReqVo) {
        JSONArray jsonArray = getAllNullFields(corporateShareholderReqVo);
        if (!jsonArray.isEmpty()) {
            return jsonArray;
        }

        String mobileNumber = corporateShareholderReqVo.getMobileCountryCode() + corporateShareholderReqVo.getMobileNumber();
        if (!validMobileNumber(mobileNumber)) {
            jsonArray.put(corporateShareholderReqVo.getClass().getSimpleName() + "." + "mobileNumber");
        }
        if (!validEmail(corporateShareholderReqVo.getEmail())) {
            jsonArray.put(corporateShareholderReqVo.getClass().getSimpleName() + "." + "email");
        }
        String identityCardFrontImage = corporateShareholderReqVo.getIdentityCardFrontImage();
        if (!identityCardFrontImage.startsWith("http") && !validBase64FileExtension(corporateShareholderReqVo.getIdentityCardFrontImage())) {
            jsonArray.put(corporateShareholderReqVo.getClass().getSimpleName() + "." + "identityCardFrontImage");
        }
        String identityCardBackImage = corporateShareholderReqVo.getIdentityCardBackImage();
        if (StringUtil.isNotEmpty(identityCardBackImage) && !identityCardBackImage.startsWith("http")) {
            if (!validBase64FileExtension(corporateShareholderReqVo.getIdentityCardBackImage())) {
                jsonArray.put(corporateShareholderReqVo.getClass().getSimpleName() + "." + "identityCardBackImage");
            }
        }

        PepDeclarationVo pepDeclaration = corporateShareholderReqVo.getPepDeclaration();
        JSONArray pepValidation = pepOptionsValidator(pepDeclaration);
        if (!pepValidation.isEmpty()) {
            return mergeJsonArrays(List.of(jsonArray, pepValidation));
        }
        return jsonArray;
    }

    public static Object corporateDocumentsValidator(List<CorporateDocumentsVo> companyDocuments) {
        int documentCount = companyDocuments == null ? 0 : companyDocuments.size();
        if (documentCount < 2) {
            return getErrorObjectWithMsg(MINIMUM_TWO_DOCUMENTS_REQUIRED);
        } else if (documentCount > 6) {
            return getErrorObjectWithMsg(MAXIMUM_SIX_DOCUMENTS_ALLOWED);
        }

        List<String> fileNames = companyDocuments.stream()
                .map(CorporateDocumentsVo::getFileName)
                .filter(Objects::nonNull) // Filters out null values
                .toList();

        // Use a HashSet to track seen file names
        if (!fileNames.isEmpty()) {
            Set<String> seen = new HashSet<>();
            for (String fileName : fileNames) {
                if (!seen.add(fileName)) {
                    // If add returns false, there's a duplicate
                    return getErrorObjectWithMsg(DUPLICATE_FILE_NAME);
                }
            }
        }

        JSONArray jsonArray = new JSONArray();
        for (int i = 0; i < documentCount; i++) {
            String file = companyDocuments.get(i).getFile();
            if (StringUtil.isNotEmpty(file) && !file.startsWith("http")) {
                if (!validBase64FileExtension(file)) {
                    jsonArray.put(companyDocuments.get(i).getClass().getSimpleName() + "." + "file" + "." + (i + 1));
                }
            }
        }
        return jsonArray.isEmpty() ? new BaseResp() : getInvalidArgumentError(jsonArray);
    }

    //----------------------Corporate Edit Validation----------------------

    public static JSONArray validateCorporateDetails(CorporateDetailsReqVo reqVo) {
        if (reqVo == null) return null;

        JSONArray jsonArray = new JSONArray();
        String contactCountryCode = reqVo.getContactMobileCountryCode();
        String contactMobileNumber = reqVo.getContactMobileNumber();
        if (StringUtil.isNotEmpty(contactCountryCode) && StringUtil.isNotEmpty(contactMobileNumber)) {
            String mobileNumber = contactCountryCode + contactMobileNumber;
            if (!validMobileNumber(mobileNumber)) {
                jsonArray.put(reqVo.getClass().getSimpleName() + ".contactMobileNumber");
            }
        }
        String contactEmail = reqVo.getContactEmail();
        if (StringUtil.isNotEmpty(contactEmail)) {
            if (!validEmail(contactEmail)) {
                jsonArray.put(reqVo.getClass().getSimpleName() + ".contactEmail");
            }
        }

        if (reqVo.getCorporateAddressDetails() != null) {
            Boolean isDifferentRegisteredAddress = reqVo.getCorporateAddressDetails().getIsDifferentRegisteredAddress();
            if (Boolean.TRUE.equals(isDifferentRegisteredAddress)) {
                JSONArray nullFieldErrors = ValidatorUtil.getAllNullFields(reqVo.getCorporateAddressDetails());
                if (!nullFieldErrors.isEmpty()) {
                    for (int i = 0; i < nullFieldErrors.length(); i++) {
                        jsonArray.put(nullFieldErrors.get(i));
                    }
                }
            }
        }
        return jsonArray;
    }
}
