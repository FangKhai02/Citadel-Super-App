package com.citadel.backend.utils;

import com.citadel.backend.dao.AppUser.AppUserSessionDao;
import com.citadel.backend.dao.Client.ClientDao;
import com.citadel.backend.dao.MaintenanceWindowDao;
import com.citadel.backend.entity.AppUserSession;
import com.citadel.backend.entity.Client;
import com.citadel.backend.entity.MaintenanceWindow;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.utils.exception.MaintenanceException;
import com.citadel.backend.vo.GetMaintenanceRespVo;
import com.citadel.backend.vo.SendGrid.*;
import com.github.kevinsawicki.http.HttpRequest;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.IntStream;

import static com.citadel.backend.utils.ApiErrorKey.*;
import static com.citadel.backend.utils.BaseRestController.ERROR_EXCEPTION;
import static com.citadel.backend.utils.SpringUtil.getMessage;

public abstract class BaseService {
    public final Logger log = LoggerFactory.getLogger(getClass());
    public static final Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDate.class, new LocalDateTypeAdapter())
            .create();

    @Value("${server.env}")
    public String ENV;
    @Value("${citadel.cms.host}")
    public String CMS_HOST;
    @Value("${citadel.second.signee.webpage.link}")
    public String SECONDSIGNEEWEBPAGELINK;

    public static final String STATIC_RESOURCES_PATH = "src/main/resources/static";
    public static final String STATIC_DOWNLOADS_PATH = STATIC_RESOURCES_PATH + "/downloads";
    public static final Set<String> supportedFileExtensions = Set.of("png", "jpg", "jpeg", "pdf");
    //TODO migrate signup/path for agent and client
    public static final String S3_SIGN_UP_CLIENT_PATH = "signup/client/";
    public static final String S3_SIGN_UP_AGENT_PATH = "signup/agent/";
    public static final String S3_CLIENT_PATH = "client/";
    public static final String S3_NIU_APPLICATION_PATH = "niu/application/";
    public static final String S3_AGENT_PATH = "agent/";
    public static final String S3_CORPORATE_PATH = "corporate/";
    public static final String S3_PRODUCT_ORDER_PATH = "product-order/";
    public static final String S3_PRODUCT_EARLY_REDEMPTION_PATH = "product-early-redemption/";
    public static final String S3_FACE_ID_IMAGE_VALIDATE_SELFIE_PATH = "face-id-image-validate/selfie/";
    public static final String S3_FACE_ID_IMAGE_VALIDATE_ID_DOCUMENT_PATH = "face-id-image-validate/id-document/";
    public static final String S3_DIVIDEND_CSV_DOCUMENT_PATH = "dividend-csv/";
    public static final String S3_DIVIDEND_EXCEL_DOCUMENT_PATH = "dividend-excel/";
    public static final String S3_DIVIDEND_STATEMENT_OF_ACCOUNT_DOCUMENT_PATH = "dividend-statement-of-account/";
    public static final String S3_DIVIDEND_BANK_FILE_DOCUMENT_PATH = "dividend-bank-file/";
    public static final String S3_COMMISSION_EXCEL_DOCUMENT_PATH = "commission-excel/";
    public static final String S3_COMMISSION_BANK_FILE_DOCUMENT_PATH = "commission-bank-file/";
    public static final String S3_REDEMPTION_BANK_FILE_DOCUMENT_PATH = "redemption-bank-file/";
    public static final String S3_PRODUCT_AGREEMENT_DOCUMENT_PATH = "product-agreement/";
    public static final String PDF_FILETYPE = "application/pdf";
    public static final String CLIENT_ONBOARDING_AGREEMENT_SETTING_KEY = "app.onboarding_agreement";
    public static final String AGENT_ONBOARDING_AGREEMENT_SETTING_KEY = "app.onboarding_agreement";
    public static final String CORPORATE_ONBOARDING_AGREEMENT_SETTING_KEY = "app.onboarding_agreement";
    public static final String CITADEL_WEBSITE_NAME_SETTING_KEY = "app.citadel.website.name";
    public static final String CITADEL_WEBSITE_URL_SETTING_KEY = "app.citadel.website.url";
    public static final String CITADEL_ADMIN_NAME_SETTING_KEY = "app.citadel.admin.name";
    public static final String CITADEL_ADMIN_EMAIL_SETTING_KEY = "app.citadel.admin.email";
    public static final String CITADEL_CONTACT_URL_SETTING_KEY = "app.contact_us_url";
    public static final String CITADEL_CORPORATE_EMAIL_SETTING_KEY = "app.citadel.corporate.email";
    public static final String FACE_ID_PASS_THRESHOLD_SETTING_KEY = "app.face_id_pass_threshold";
    public static final String CITADEL_COMMISSION_EMAIL_SETTING_KEY = "app.citadel.commission.email";
    public static final String CITADEL_WITHDRAWAL_DIVIDEND_SETTING_KEY = "app.citadel.withdrawal_dividend.email";
    public static final String CITADEL_CTB_GROUP_EMAIL_SETTING_KEY = "app.ctb.group.email";
    public static final Integer ONE_MINUTE = 60;
    public static final Integer ONE_HOUR = ONE_MINUTE * 60;
    public static final Integer ONE_DAY = ONE_HOUR * 24;
    public static final Integer ONE_WEEK = ONE_DAY * 7;
    @Resource
    private AppUserSessionDao appUserSessionDao;
    @Resource
    private ClientDao clientDao;
    @Resource
    MaintenanceWindowDao maintenanceWindowDao;

    public String getTempDir() {
        //Get temp file directory based on OS
        String tempDir = System.getProperty("java.io.tmpdir");
        if (!tempDir.endsWith(File.separator)) {
            tempDir += File.separator;
        }
        return tempDir;
    }

    public ErrorResp getErrorException(Exception ex) {
        ErrorResp errorResp = new ErrorResp();
        errorResp.setMessage("Error: " + ex.getMessage());
        return errorResp;
    }

    public static ErrorResp getErrorObjectWithMsg(String message) {
        ErrorResp errorResp = new ErrorResp();
        errorResp.setMessage(message);
        return errorResp;
    }

    public static ResponseEntity<Object> getInvalidArgumentError(JSONArray jsonArray) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("error", "validation");
        jsonObject.put("fields", jsonArray);

        ErrorResp errorResp = new ErrorResp();
        errorResp.setCode(String.valueOf(HttpStatus.BAD_REQUEST.value()));
        errorResp.setMessage(jsonObject.toString());
        return new ResponseEntity<>(errorResp, new HttpHeaders(), HttpStatus.BAD_REQUEST);
    }

    public String generateApiKey(String stringToEncode) {
        return generateEncodedString(stringToEncode + System.currentTimeMillis());
    }

    public String generateEncodedString(String stringToEncode) {
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        return passwordEncoder.encode(stringToEncode + DateUtil.getTodayFull());
    }

    public static JSONArray mergeJsonArrays(List<JSONArray> jsonArrays) {
        JSONArray mergedArray = new JSONArray();
        for (JSONArray array : jsonArrays) {
            if (array == null || array.isEmpty()) {
                // Skip if the array is null or empty
                continue;
            }
            IntStream.range(0, array.length()).forEach(i -> mergedArray.put(array.get(i)));
        }
        return mergedArray;
    }

    public static String getFileTypeFromBase64(String base64String) {
        byte[] byteArray = StringUtil.decodeBase64ToFile(base64String);
        return MimeTypeUtil.getMimeType(byteArray);
    }

    public static Boolean validBase64FileExtension(String base64String) {
        if (StringUtil.isEmpty(base64String)) {
            return false;
        }
        String extension = getFileTypeFromBase64(base64String);
        if (StringUtil.isNotEmpty(extension)) {
            return supportedFileExtensions.contains(extension.toLowerCase());
        }
        return false;
    }

    public AppUserSession validateApiKey(String apiKey) {
        Object maintenance = getMaintenanceUpdate();
        if (maintenance instanceof GetMaintenanceRespVo &&
                ((GetMaintenanceRespVo) maintenance).getCode().equals(ERROR_EXCEPTION)) {
            throw new MaintenanceException(SERVER_MAINTENANCE, ((GetMaintenanceRespVo) maintenance).getStartDatetime(), ((GetMaintenanceRespVo) maintenance).getEndDatetime());
        }

        if (StringUtils.isBlank(apiKey)) {
            throw new BadCredentialsException(EMPTY_API_KEY);
        }

        return appUserSessionDao.findByApiKeyAndExpiresAtAfter(apiKey, new Date())
                .orElseThrow(() -> new AccessDeniedException(INVALID_KEY));
    }

    public boolean validPinFormat(String pin) {
        return !StringUtil.isEmpty(pin) && pin.matches("\\d{4}");
    }

    public void validateClientPin(String clientId, String pin) {
        validPinFormat(pin);

        Client client = clientDao.findByClientIdAndPin(clientId, pin);
        if (client == null || !pin.equals(client.getPin())) {
            throw new GeneralException(INVALID_OLD_PIN);
        }
    }

    public boolean validPasswordFormat(String password) {
        return !StringUtil.isEmpty(password) && password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$");
    }

    public boolean sendEmail(String fromName, String[] toEmails, String[] bccEmail, String subject, String emailBody, List<Attachment> attachments) {
        Gson gson = new Gson();
        List<SendGridEmail> receivers = new ArrayList<>();
        for (String email : toEmails) {
            receivers.add(new SendGridEmail(email, null));
            log.info("SendGrid toEmail: " + email);
        }

        SendGridReq sendGridReq = new SendGridReq();
        if (bccEmail != null) {
            List<SendGridEmail> bccEmails = new ArrayList<>();
            for (String email : bccEmail) {
                bccEmails.add(new SendGridEmail(email, null));
                log.info("SendGrid bccEmail: " + email);
            }
            sendGridReq.setPersonalizations(List.of(new Personalization(receivers, null, bccEmails, subject)));
        } else
            sendGridReq.setPersonalizations(List.of(new Personalization(receivers, null, null, subject)));

        sendGridReq.setFrom(new SendGridEmail(getMessage("sendgrid.from-email"), fromName));
        sendGridReq.setSubject(subject);
        sendGridReq.setContent(List.of(new Content("text/html", emailBody)));
        sendGridReq.setAttachments(attachments);

        try {
            HttpRequest httpRequest = HttpRequest.post(getMessage("sendgrid.host") + "/mail/send").authorization("Bearer " + getMessage("sendgrid.api-key")).contentType("application/json").send(gson.toJson(sendGridReq));
            log.info("SendGrid: {} {}", httpRequest.code(), httpRequest.body());
            return httpRequest.code() == 200;
        } catch (Exception e) {
            log.info("Failed to send email {} {}", e.getMessage(), subject);
            return false;
        }
    }

    public String getS3PublicUrl(String key) {
        return getMessage("aws.s3.host") + File.separator + getMessage("aws.bucket.name") +
                File.separator + key;
    }

    public String getFilename(String s3FilePath) {
        return s3FilePath.substring(s3FilePath.lastIndexOf("/") + 1);
    }

    public static String encodeFileToBase64(String filePath) throws IOException {
        byte[] fileBytes = Files.readAllBytes(Paths.get(filePath));
        String base64String = Base64.getEncoder().encodeToString(fileBytes);
        String fileExtension = getFileTypeFromBase64(base64String);
        return "data:" + fileExtension + ";base64," + base64String;
    }

    public Object getMaintenanceUpdate() {
        GetMaintenanceRespVo resp = new GetMaintenanceRespVo();
        try {
            MaintenanceWindow maintenanceWindow = maintenanceWindowDao.getMaintenanceWindowByDateAndEnabled(new Date());
            if (maintenanceWindow != null) {
                SimpleDateFormat hhmmK = new SimpleDateFormat("h:mma");
                SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy, h:mma");
                SimpleDateFormat date = new SimpleDateFormat("dd MMMM yyyy");
                String startTime, endTime;

                //If not same date, then show date and time
                if (!date.format(maintenanceWindow.getStartDatetime()).equals(date.format(maintenanceWindow.getEndDatetime()))) {
                    startTime = sdf.format(maintenanceWindow.getStartDatetime()).replace("PM", "pm").replace("AM", "am");
                    endTime = sdf.format(maintenanceWindow.getEndDatetime()).replace("PM", "pm").replace("AM", "am");
                } else {//else only show time
                    startTime = hhmmK.format(maintenanceWindow.getStartDatetime()).toLowerCase();
                    endTime = hhmmK.format(maintenanceWindow.getEndDatetime()).toLowerCase();
                }
                resp.setStartDatetime(startTime);
                resp.setEndDatetime(endTime);
                resp.setCode(ERROR_EXCEPTION);
                resp.setMessage(SERVER_MAINTENANCE);
                return resp;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            return getErrorObjectWithMsg(SERVER_MAINTENANCE);
        }

        return resp;
    }

    protected String getFunctionName() {
        // Use index 1 to get the calling method
        return new Throwable()
                .getStackTrace()[1] // Use index 1 to get the calling method
                .getMethodName();
    }
}