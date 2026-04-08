package com.citadel.backend.service;

import com.citadel.backend.dao.Client.ClientDao;
import com.citadel.backend.dao.EsmsHistoryDao;
import com.citadel.backend.dao.UserDetailDao;
import com.citadel.backend.entity.AppUserSession;
import com.citadel.backend.entity.Client;
import com.citadel.backend.entity.EsmsHistory;
import com.citadel.backend.entity.UserDetail;
import com.citadel.backend.utils.BaseService;
import com.citadel.backend.utils.Builder.RandomCodeBuilder;
import com.citadel.backend.utils.EsmsUtil;
import com.citadel.backend.utils.RedisUtil;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Otp.OtpVerificationReq;
import jakarta.annotation.Resource;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import java.util.Date;

import static com.citadel.backend.utils.ApiErrorKey.USER_NOT_FOUND;
import static com.citadel.backend.utils.RandomCodeUtil.generateRandomCode;

@Service
public class OtpService extends BaseService {

    @Resource
    private ClientDao clientDao;
    @Resource
    private EsmsHistoryDao esmsHistoryDao;

    public Object sendOtp(String apiKey) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        try {
            Client client = clientDao.findByAppUser(appUserSession.getAppUser()).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
            UserDetail userDetail = client.getUserDetail();
            String otp = generateRandomCode(new RandomCodeBuilder()
                    .length(4)
                    .charSet(RandomCodeBuilder.NUMBERS));

            // Save OTP to redis
            String key = "otp_"+ userDetail.getMobileNumber();
            if(RedisUtil.exists(key)) {
                RedisUtil.del(key);
            }
            RedisUtil.set(key, otp, 300);
            String countryCode = userDetail.getMobileCountryCode();
            String mobileNumber = userDetail.getMobileNumber();

            String phoneNo = countryCode + mobileNumber;

            //remove + on phoneNo if exist
            if(phoneNo.startsWith("+")) {
                phoneNo = phoneNo.substring(1);
            }

            String message = "Citadel - Your OTP code is " + otp + ". This is valid for the next 5 minutes. Please do not share this code with anyone.";
            String responseBody = EsmsUtil.sendSmsToEsms(phoneNo, message);
            String remarks = "";
            int status = -1;
            if (responseBody != null) {
                try {
                    JSONObject jsonResponse = new JSONObject(responseBody);
                    remarks = jsonResponse.optString("message", "No message provided");
                    status = jsonResponse.optInt("status", -1);
                } catch (Exception e) {
                    log.error("Failed to parse response body: " + responseBody, e);
                    remarks = "Parsing error";
                    status = -1;
                }
            } else {
                remarks = "No response body";
            }

            EsmsHistory esmsHistory = new EsmsHistory();
            esmsHistory.setMobileNumber(phoneNo);
            esmsHistory.setClientName(userDetail.getName());
            esmsHistory.setRemarks(remarks);
            esmsHistory.setStatus(status == 0 ? "SENT" : "FAILED");
            esmsHistory.setOtp(otp);
            esmsHistory.setExpiredAt(new Date(System.currentTimeMillis() + 300000));
            esmsHistoryDao.save(esmsHistory);

            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object verifyOtp(OtpVerificationReq otpVerificationReq, String apiKey) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        try {
            Client client = clientDao.findByAppUser(appUserSession.getAppUser()).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
            UserDetail userDetail = client.getUserDetail();
            String key = "otp_"+ userDetail.getMobileNumber();
            if(RedisUtil.exists(key)) {
                String savedOtp = RedisUtil.get(key);
                if(otpVerificationReq.getOtp().equals(savedOtp)) {

                    return new BaseResp();
                } else {
                    return getErrorObjectWithMsg("Invalid OTP");
                }
            } else {
                return getErrorObjectWithMsg("OTP expired");
            }

        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }
}
