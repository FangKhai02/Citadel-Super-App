package com.citadel.backend.service;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.citadel.backend.dao.Agent.AgentDao;
import com.citadel.backend.dao.AppUser.AppUserSessionDao;
import com.citadel.backend.dao.AppUser.AppUserDao;
import com.citadel.backend.dao.Client.ClientDao;
import com.citadel.backend.entity.Agent;
import com.citadel.backend.entity.AppUserSession;
import com.citadel.backend.entity.AppUser;
import com.citadel.backend.entity.Client;
import com.citadel.backend.utils.BaseService;
import com.citadel.backend.utils.DateUtil;
import com.citadel.backend.utils.StringUtil;
import com.citadel.backend.utils.ValidatorUtil;
import com.citadel.backend.utils.RedisUtil;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Enum.UserType;
import com.citadel.backend.vo.Login.ChangePasswordReqVo;
import com.citadel.backend.vo.Login.ResetPasswordReqVo;
import com.citadel.backend.vo.Login.LoginRequestVo;
import com.citadel.backend.vo.Login.LoginRespVo;
import jakarta.annotation.Resource;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Date;
import java.util.UUID;

import static com.citadel.backend.utils.ApiErrorKey.*;
import static com.citadel.backend.utils.SpringUtil.getMessage;

@Service
public class LoginService extends BaseService {

    @Resource
    private AppUserDao appUsersDao;
    @Resource
    private AppUserSessionDao appUserSessionsDao;
    @Resource
    private ClientDao clientDao;
    @Resource
    private AgentDao agentDao;

    public Object loginUpdate(LoginRequestVo loginRequest) {
        try {
            if (StringUtil.isEmpty(loginRequest.getEmail()) && StringUtil.isEmpty(loginRequest.getPassword())) {
                return getErrorObjectWithMsg(INVALID_LOGIN_REQUEST);
            }
            String loginEmail = loginRequest.getEmail().strip();
            String loginPassword = loginRequest.getPassword().strip();
            AppUser appUser = appUsersDao.findByEmailAddressAndIsDeletedIsFalse(loginEmail);
            if (appUser == null) {
                return getErrorObjectWithMsg(USER_NOT_FOUND);
            }
            BCrypt.Result result = BCrypt.verifyer().verify(loginPassword.toCharArray(), appUser.getPassword());
            if (!result.verified)
                return getErrorObjectWithMsg(WRONG_PASSWORD);

            String apiKeyToEncode = null;
            boolean hasPin = false;

            if (UserType.CLIENT.equals(appUser.getUserType())) {
                Client client = clientDao.findByAppUser(appUser).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
                apiKeyToEncode = appUser.getEmailAddress() + client.getClientId();
                hasPin = StringUtil.isNotEmpty(client.getPin());
            } else if (UserType.AGENT.equals(appUser.getUserType())) {
                Agent agent = agentDao.findByAppUserAndStatus(appUser, Agent.AgentStatus.ACTIVE).orElseThrow(() -> new GeneralException(AGENT_PROFILE_TERMINATED));
                apiKeyToEncode = appUser.getEmailAddress() + agent.getAgentId();
                hasPin = StringUtil.isNotEmpty(agent.getPin());
            }

            Date currentDate = new Date();
            AppUserSession userSession = new AppUserSession();
            userSession.setAppUser(appUser);
            userSession.setApiKey(generateApiKey(apiKeyToEncode));
            userSession.setOneSignalSubscriptionId(loginRequest.getOneSignalSubscriptionId());
            userSession.setCreatedAt(currentDate);
            userSession.setUpdatedAt(currentDate);
            userSession.setExpiresAt(DateUtil.addDays(currentDate, 365));
            userSession = appUserSessionsDao.save(userSession);

            LoginRespVo resp = new LoginRespVo();
            resp.setApiKey(userSession.getApiKey());
            resp.setHasPin(hasPin);
            resp.setUserType(appUser.getUserType());
            return resp;

        } catch (IncorrectResultSizeDataAccessException ex) {
            log.error("Multiple records found for user query - data integrity issue", ex);
            return getErrorObjectWithMsg("api.duplicate.email.between.profiles");
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object forgotPasswordUpdate(String email) throws Exception {
        BaseResp resp = new BaseResp();
        email = email.strip();
        if (!ValidatorUtil.validEmail(email)) {
            return getErrorObjectWithMsg(INVALID_EMAIL);
        }
        AppUser appUser = appUsersDao.findByEmailAddressAndIsDeletedIsFalse(email);
        if (appUser == null) {
            return getErrorObjectWithMsg(USER_NOT_FOUND);
        }
        String appUserName = "user";
        if (UserType.CLIENT.equals(appUser.getUserType())) {
            Client client = clientDao.findByAppUser(appUser).orElse(null);
            if (client != null && client.getUserDetail() != null) {
                appUserName = client.getUserDetail().getName();
            }
        } else if (UserType.AGENT.equals(appUser.getUserType())) {
            Agent agent = agentDao.findByAppUserAndStatus(appUser, Agent.AgentStatus.ACTIVE).orElse(null);
            if (agent != null && agent.getUserDetail() != null) {
                appUserName = agent.getUserDetail().getName();
            }
        }

        String token = UUID.randomUUID().toString();
        RedisUtil.set("resetPassword/" + token, appUser.getEmailAddress());
        RedisUtil.expire("resetPassword/" + token, 1800);//30 minutes

        String encodedInfo = Base64.getEncoder().encodeToString((appUser.getEmailAddress() + "/" + token).getBytes(StandardCharsets.UTF_8));
        String deepLinkUrl = getMessage("project.url") + "/api/app/redirect?url=citadel://reset-password/" + encodedInfo;
        String emailBody = "Hi " + appUserName + ",<br/><br/>" +
                "You have requested to reset the password for your Citadel Super App account. Please ensure you are viewing this email on your mobile device that Citadel Super App is installed on and click <a href='" + deepLinkUrl + "'>here</a> to reset your password.<br/><br/>" +
                "If you have not made this request, please ignore this email.<br/><br/>" +
                "This is an auto-generated email. Please do not reply to this email address.<br/><br/>" +
                "Yours sincerely,<br/>" +
                "Citadel Group";

        sendEmail("Citadel Group",
                email.split(","),
                null,
                "Citadel Super App Password Reset Request",
                emailBody,
                null);

        return resp;
    }

    public Object resetPasswordUpdate(ResetPasswordReqVo resetPasswordReqVo) {
        BaseResp resp = new BaseResp();
        String email = resetPasswordReqVo.getEmail().strip();
        String password = resetPasswordReqVo.getPassword().strip();
        if (!ValidatorUtil.validEmail(email)) {
            return getErrorObjectWithMsg(INVALID_EMAIL);
        }
        if (!validPasswordFormat(password)) {
            return getErrorObjectWithMsg(INVALID_PASSWORD_FORMAT);
        }
        AppUser appUser = appUsersDao.findByEmailAddressAndIsDeletedIsFalse(email);
        if (appUser == null) {
            return getErrorObjectWithMsg(USER_NOT_FOUND);
        }

        String memcacheResult = RedisUtil.get("resetPassword/" + resetPasswordReqVo.getToken());
        if (memcacheResult == null)
            return getErrorObjectWithMsg(REQUEST_EXPIRED);
        if (!memcacheResult.equals(email))
            return getErrorObjectWithMsg(INVALID_REQUEST);


        String newPassword = BCrypt.with(BCrypt.Version.VERSION_2Y).hashToString(6, resetPasswordReqVo.getPassword().toCharArray());
        appUser.setPassword(newPassword);
        appUser.setUpdatedAt(new Date());
        appUsersDao.save(appUser);
        RedisUtil.del("resetPassword/" + resetPasswordReqVo.getToken());

        return resp;
    }

    public Object changePasswordUpdate(String apiKey, ChangePasswordReqVo changePasswordReqVo) {
        BaseResp resp = new BaseResp();
        AppUserSession appUserSession = validateApiKey(apiKey);
        AppUser appUser = appUserSession.getAppUser();

        if (StringUtil.isEmpty(changePasswordReqVo.getOldPassword())) {
            return getErrorObjectWithMsg(WRONG_PASSWORD);
        }

        String oldPassword = changePasswordReqVo.getOldPassword().strip();

        // Validate old password
        BCrypt.Result result = BCrypt.verifyer().verify(oldPassword.toCharArray(), appUser.getPassword());
        if (!result.verified) {
            return getErrorObjectWithMsg(WRONG_PASSWORD);
        }

        if (StringUtil.isNotEmpty(oldPassword) && StringUtil.isNotEmpty(changePasswordReqVo.getNewPassword())) {
            String newPassword = changePasswordReqVo.getNewPassword().strip();
            if (!validPasswordFormat(newPassword)) {
                return getErrorObjectWithMsg(INVALID_PASSWORD_FORMAT);
            }
            if (newPassword.equals(oldPassword)) {
                return getErrorObjectWithMsg(NEW_PASSWORD_SAME_AS_OLD);
            }
            newPassword = BCrypt.with(BCrypt.Version.VERSION_2Y).hashToString(6, newPassword.toCharArray());
            appUser.setPassword(newPassword);
            appUser.setUpdatedAt(new Date());
            appUsersDao.save(appUser);
        }
        return resp;
    }

    public static void main(String[] args) {
        String pwd = "PASSWORD";
        String newPassword = BCrypt.with(BCrypt.Version.VERSION_2Y).hashToString(6, pwd.toCharArray());
        System.out.println(newPassword);
    }
}
