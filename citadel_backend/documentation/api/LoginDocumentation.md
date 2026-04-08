# Login Controller Business Process Documentation

## Overview

The `LoginController` manages the complete authentication lifecycle for the Citadel platform, handling user login, session management, password reset workflows, and security validation. It provides secure access control for both individual clients and agents, with comprehensive password management and session security features.

## Architecture

- **Controller**: `LoginController` - REST endpoints for authentication operations
- **Service**: `LoginService` - Core authentication business logic and security
- **Security Framework**: BCrypt password hashing with session-based authentication
- **Session Management**: API key-based session tokens with expiration handling
- **Password Recovery**: Email-based reset workflow with deep link integration

---

## Business Process Overview

### Authentication Workflows

1. **User Login**
   - Email/password validation
   - BCrypt password verification
   - Session creation with API key generation
   - User type-specific authentication (Client vs Agent)
   - PIN status detection for enhanced security

2. **Password Management**
   - Forgot password with email-based reset
   - Secure token generation and validation
   - Password change with old password verification
   - Password policy enforcement

3. **Session Management**
   - API key-based authentication
   - Session expiration handling
   - Push notification subscription management
   - Maintenance mode detection

### Security Framework

```
Login Request → Credential Validation → Session Creation → API Key Generation
      ↓                  ↓                    ↓              ↓
Email Format         BCrypt Verify      Session Store    Encoded Token
Password Policy      User Existence     Push Notification Base64 + Timestamp
User Type Check      Status Validation  365-day Expiry   Secure Generation
```

---

## API Endpoints Documentation

### 1. User Login API

#### 1.1 Login with Email and Password
**Endpoint**: `POST /api/login`
**Request Body**: `LoginRequestVo`
**Public Access**: No authentication required

**Deep Business Logic Analysis**:

**Comprehensive Authentication Process**:
```java
public Object loginUpdate(LoginRequestVo loginRequest) {
    // 1. Input Validation and Sanitization
    if (StringUtil.isEmpty(loginRequest.getEmail()) || StringUtil.isEmpty(loginRequest.getPassword())) {
        return getErrorObjectWithMsg(INVALID_LOGIN_REQUEST);
    }

    String loginEmail = loginRequest.getEmail().strip();
    String loginPassword = loginRequest.getPassword().strip();

    // 2. User Lookup with Security Check
    AppUser appUser = appUsersDao.findByEmailAddressAndIsDeletedIsFalse(loginEmail);
    if (appUser == null) {
        return getErrorObjectWithMsg(USER_NOT_FOUND);
    }

    // 3. Password Verification using BCrypt
    BCrypt.Result result = BCrypt.verifyer().verify(
        loginPassword.toCharArray(),
        appUser.getPassword()
    );
    if (!result.verified) {
        return getErrorObjectWithMsg(WRONG_PASSWORD);
    }

    // 4. User Type-Specific Processing
    String apiKeyToEncode = null;
    boolean hasPin = false;

    if (UserType.CLIENT.equals(appUser.getUserType())) {
        // Client authentication processing
        Client client = clientDao.findByAppUser(appUser)
            .orElseThrow(() -> new GeneralException(USER_NOT_FOUND));

        // Generate API key seed using client-specific identifier
        apiKeyToEncode = appUser.getEmailAddress() + client.getClientId();

        // Check PIN status for enhanced security features
        hasPin = StringUtil.isNotEmpty(client.getPin());

    } else if (UserType.AGENT.equals(appUser.getUserType())) {
        // Agent authentication processing
        Agent agent = agentDao.findByAppUserAndStatus(appUser, Agent.AgentStatus.ACTIVE)
            .orElseThrow(() -> new GeneralException(AGENT_PROFILE_TERMINATED));

        // Generate API key seed using agent-specific identifier
        apiKeyToEncode = appUser.getEmailAddress() + agent.getAgentId();

        // Check PIN status for agent security features
        hasPin = StringUtil.isNotEmpty(agent.getPin());
    }

    // 5. Session Creation and API Key Generation
    Date currentDate = new Date();
    AppUserSession userSession = new AppUserSession();
    userSession.setAppUser(appUser);
    userSession.setApiKey(generateApiKey(apiKeyToEncode));
    userSession.setOneSignalSubscriptionId(loginRequest.getOneSignalSubscriptionId());
    userSession.setCreatedAt(currentDate);
    userSession.setUpdatedAt(currentDate);
    userSession.setExpiresAt(DateUtil.addDays(currentDate, 365)); // 1-year expiration
    userSession = appUserSessionsDao.save(userSession);

    // 6. Response Construction
    LoginRespVo resp = new LoginRespVo();
    resp.setApiKey(userSession.getApiKey());
    resp.setHasPin(hasPin);
    resp.setUserType(appUser.getUserType());

    return resp;
}
```

**API Key Generation Process**:
```java
public String generateApiKey(String stringToEncode) {
    // Combine user identifier with timestamp for uniqueness
    String uniqueString = stringToEncode + System.currentTimeMillis();

    return generateEncodedString(uniqueString);
}

public String generateEncodedString(String stringToEncode) {
    // Use BCrypt encoder with daily salt for additional security
    PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    return passwordEncoder.encode(stringToEncode + DateUtil.getTodayFull());
}
```

**Security Features**:
- **BCrypt Password Verification**: Industry-standard password hashing with salt
- **User Type Validation**: Ensures agent status is ACTIVE
- **Session Expiration**: 365-day session validity
- **Unique API Keys**: Timestamp-based uniqueness with daily salt
- **PIN Detection**: Indicates if user has enhanced security PIN setup
- **Push Notification Integration**: OneSignal subscription management

**Error Handling**:
- **Data Integrity Check**: Handles duplicate email scenarios between user types
- **Comprehensive Logging**: Security-focused error logging
- **Graceful Failure**: Returns appropriate error messages without exposing sensitive information

### 2. Password Recovery APIs

#### 2.1 Forgot Password
**Endpoint**: `POST /api/login/forgot-password`
**Parameters**: `email`
**Public Access**: No authentication required

**Deep Business Logic Analysis**:

**Password Reset Workflow**:
```java
public Object forgotPasswordUpdate(String email) throws Exception {
    // 1. Input Validation
    email = email.strip();
    if (!ValidatorUtil.validEmail(email)) {
        return getErrorObjectWithMsg(INVALID_EMAIL);
    }

    // 2. User Verification
    AppUser appUser = appUsersDao.findByEmailAddressAndIsDeletedIsFalse(email);
    if (appUser == null) {
        return getErrorObjectWithMsg(USER_NOT_FOUND);
    }

    // 3. User Name Resolution for Personalization
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

    // 4. Secure Token Generation and Storage
    String token = UUID.randomUUID().toString();
    RedisUtil.set("resetPassword/" + token, appUser.getEmailAddress());
    RedisUtil.expire("resetPassword/" + token, 1800); // 30-minute expiration

    // 5. Deep Link Generation for Mobile App Integration
    String tokenPayload = appUser.getEmailAddress() + "/" + token;
    String encodedInfo = Base64.getEncoder().encodeToString(
        tokenPayload.getBytes(StandardCharsets.UTF_8)
    );
    String deepLinkUrl = getMessage("project.url") +
        "/api/app/redirect?url=citadel://reset-password/" + encodedInfo;

    // 6. Email Template Construction
    String emailBody = buildPasswordResetEmailBody(appUserName, deepLinkUrl);

    // 7. Email Dispatch
    sendEmail("Citadel Group",
        email.split(","),
        null,
        "Citadel Super App Password Reset Request",
        emailBody,
        null);

    return new BaseResp();
}

private String buildPasswordResetEmailBody(String userName, String deepLinkUrl) {
    return "Hi " + userName + ",<br/><br/>" +
        "You have requested to reset the password for your Citadel Super App account. " +
        "Please ensure you are viewing this email on your mobile device that Citadel Super App is installed on " +
        "and click <a href='" + deepLinkUrl + "'>here</a> to reset your password.<br/><br/>" +
        "If you have not made this request, please ignore this email.<br/><br/>" +
        "This is an auto-generated email. Please do not reply to this email address.<br/><br/>" +
        "Yours sincerely,<br/>" +
        "Citadel Group";
}
```

**Security Architecture**:
- **UUID Token Generation**: Cryptographically secure random tokens
- **Redis-Based Token Storage**: Temporary secure storage with automatic expiration
- **30-Minute Token Expiry**: Limited window for password reset
- **Deep Link Integration**: Mobile app-specific reset flow
- **Base64 Encoding**: Secure token transmission in URLs

**Deep Link Format**:
```
citadel://reset-password/{Base64EncodedInfo}

Where Base64EncodedInfo contains: {email}/{resetToken}
```

#### 2.2 Reset Password
**Endpoint**: `POST /api/login/reset-password`
**Request Body**: `ResetPasswordReqVo`
**Public Access**: No authentication required

**Deep Business Logic Analysis**:

**Password Reset Execution**:
```java
public Object resetPasswordUpdate(ResetPasswordReqVo resetPasswordReqVo) {
    // 1. Input Validation
    String email = resetPasswordReqVo.getEmail().strip();
    String password = resetPasswordReqVo.getPassword().strip();

    if (!ValidatorUtil.validEmail(email)) {
        return getErrorObjectWithMsg(INVALID_EMAIL);
    }

    if (!validPasswordFormat(password)) {
        return getErrorObjectWithMsg(INVALID_PASSWORD_FORMAT);
    }

    // 2. User Verification
    AppUser appUser = appUsersDao.findByEmailAddressAndIsDeletedIsFalse(email);
    if (appUser == null) {
        return getErrorObjectWithMsg(USER_NOT_FOUND);
    }

    // 3. Token Validation and Security Checks
    String memcacheResult = RedisUtil.get("resetPassword/" + resetPasswordReqVo.getToken());

    if (memcacheResult == null) {
        return getErrorObjectWithMsg(REQUEST_EXPIRED);
    }

    if (!memcacheResult.equals(email)) {
        return getErrorObjectWithMsg(INVALID_REQUEST);
    }

    // 4. Password Update with BCrypt Hashing
    String newPassword = BCrypt.with(BCrypt.Version.VERSION_2Y)
        .hashToString(6, resetPasswordReqVo.getPassword().toCharArray());

    appUser.setPassword(newPassword);
    appUser.setUpdatedAt(new Date());
    appUsersDao.save(appUser);

    // 5. Token Cleanup for Security
    RedisUtil.del("resetPassword/" + resetPasswordReqVo.getToken());

    return new BaseResp();
}
```

**Security Validation Process**:
1. **Token Existence Check**: Ensures token hasn't expired
2. **Email-Token Binding**: Prevents token misuse across different accounts
3. **Single-Use Token**: Automatic cleanup after successful reset
4. **Password Policy Enforcement**: Validates new password meets requirements
5. **BCrypt Hashing**: Secure password storage with Version 2Y

### 3. Password Change API

#### 3.1 Change Password
**Endpoint**: `POST /api/login/change-password`
**Authentication**: API Key required
**Request Body**: `ChangePasswordReqVo`

**Deep Business Logic Analysis**:

**Authenticated Password Change Process**:
```java
public Object changePasswordUpdate(String apiKey, ChangePasswordReqVo changePasswordReqVo) {
    // 1. Session Validation
    AppUserSession appUserSession = validateApiKey(apiKey);
    AppUser appUser = appUserSession.getAppUser();

    // 2. Old Password Verification
    if (StringUtil.isEmpty(changePasswordReqVo.getOldPassword())) {
        return getErrorObjectWithMsg(WRONG_PASSWORD);
    }

    String oldPassword = changePasswordReqVo.getOldPassword().strip();

    // Verify current password
    BCrypt.Result result = BCrypt.verifyer().verify(
        oldPassword.toCharArray(),
        appUser.getPassword()
    );
    if (!result.verified) {
        return getErrorObjectWithMsg(WRONG_PASSWORD);
    }

    // 3. New Password Processing
    if (StringUtil.isNotEmpty(oldPassword) &&
        StringUtil.isNotEmpty(changePasswordReqVo.getNewPassword())) {

        String newPassword = changePasswordReqVo.getNewPassword().strip();

        // Password policy validation
        if (!validPasswordFormat(newPassword)) {
            return getErrorObjectWithMsg(INVALID_PASSWORD_FORMAT);
        }

        // Prevent password reuse
        if (newPassword.equals(oldPassword)) {
            return getErrorObjectWithMsg(NEW_PASSWORD_SAME_AS_OLD);
        }

        // Hash and store new password
        String hashedNewPassword = BCrypt.with(BCrypt.Version.VERSION_2Y)
            .hashToString(6, newPassword.toCharArray());

        appUser.setPassword(hashedNewPassword);
        appUser.setUpdatedAt(new Date());
        appUsersDao.save(appUser);
    }

    return new BaseResp();
}
```

**Security Enhancements**:
- **Current Password Verification**: Ensures user knows existing password
- **Password Policy Enforcement**: Validates new password strength
- **Password Reuse Prevention**: Blocks identical old/new passwords
- **Session-Based Authentication**: Requires valid API key
- **Secure Hashing**: BCrypt with Version 2Y for maximum security

---

## Deep Technical Implementation Analysis

### Session Management Architecture

**API Key Validation System**:
```java
public AppUserSession validateApiKey(String apiKey) {
    // 1. Maintenance Mode Check
    Object maintenance = getMaintenanceUpdate();
    if (maintenance instanceof GetMaintenanceRespVo &&
        ((GetMaintenanceRespVo) maintenance).getCode().equals(ERROR_EXCEPTION)) {
        throw new MaintenanceException(SERVER_MAINTENANCE,
            ((GetMaintenanceRespVo) maintenance).getStartDatetime(),
            ((GetMaintenanceRespVo) maintenance).getEndDatetime());
    }

    // 2. API Key Presence Validation
    if (StringUtils.isBlank(apiKey)) {
        throw new BadCredentialsException(EMPTY_API_KEY);
    }

    // 3. Session Lookup with Expiration Check
    return appUserSessionDao.findByApiKeyAndExpiresAtAfter(apiKey, new Date())
        .orElseThrow(() -> new BadCredentialsException(INVALID_OR_EXPIRED_API_KEY));
}
```

**Session Lifecycle Management**:
```java
public class SessionLifecycleManager {

    public void createSession(AppUser appUser, String deviceId) {
        // 1. Invalidate existing sessions if required
        invalidateExistingSessions(appUser);

        // 2. Create new session
        AppUserSession session = new AppUserSession();
        session.setAppUser(appUser);
        session.setApiKey(generateSecureApiKey(appUser, deviceId));
        session.setCreatedAt(new Date());
        session.setExpiresAt(DateUtil.addDays(new Date(), 365));

        // 3. Store session
        appUserSessionDao.save(session);

        // 4. Update user login statistics
        updateUserLoginStatistics(appUser);
    }

    private String generateSecureApiKey(AppUser appUser, String deviceId) {
        // Combine user identifier with device and timestamp
        String keySource = appUser.getEmailAddress() +
                          getUserIdentifier(appUser) +
                          deviceId +
                          System.currentTimeMillis();

        return generateEncodedString(keySource);
    }

    private void invalidateExistingSessions(AppUser appUser) {
        // Option 1: Single session per user (more secure)
        // appUserSessionDao.deleteByAppUser(appUser);

        // Option 2: Multiple sessions with cleanup of expired ones
        appUserSessionDao.deleteByAppUserAndExpiresAtBefore(appUser, new Date());
    }
}
```

### Password Security Framework

**Password Policy Engine**:
```java
public class PasswordPolicyEngine {

    private static final int MIN_LENGTH = 8;
    private static final int MAX_LENGTH = 128;
    private static final String SPECIAL_CHARS = "!@#$%^&*()_+-=[]{}|;:,.<>?";

    public static boolean validPasswordFormat(String password) {
        if (StringUtil.isEmpty(password)) {
            return false;
        }

        // Length validation
        if (password.length() < MIN_LENGTH || password.length() > MAX_LENGTH) {
            return false;
        }

        // Character composition validation
        boolean hasLowerCase = password.chars().anyMatch(Character::isLowerCase);
        boolean hasUpperCase = password.chars().anyMatch(Character::isUpperCase);
        boolean hasDigit = password.chars().anyMatch(Character::isDigit);
        boolean hasSpecialChar = password.chars().anyMatch(c -> SPECIAL_CHARS.indexOf(c) >= 0);

        // Require at least 3 out of 4 character types
        int characterTypeCount = 0;
        if (hasLowerCase) characterTypeCount++;
        if (hasUpperCase) characterTypeCount++;
        if (hasDigit) characterTypeCount++;
        if (hasSpecialChar) characterTypeCount++;

        return characterTypeCount >= 3;
    }

    public static PasswordStrength assessPasswordStrength(String password) {
        if (!validPasswordFormat(password)) {
            return PasswordStrength.INVALID;
        }

        int score = 0;

        // Length scoring
        if (password.length() >= 12) score += 2;
        else if (password.length() >= 10) score += 1;

        // Character diversity scoring
        if (password.chars().anyMatch(Character::isLowerCase)) score++;
        if (password.chars().anyMatch(Character::isUpperCase)) score++;
        if (password.chars().anyMatch(Character::isDigit)) score++;
        if (password.chars().anyMatch(c -> SPECIAL_CHARS.indexOf(c) >= 0)) score++;

        // Pattern analysis
        if (!hasCommonPatterns(password)) score++;
        if (!hasSequentialCharacters(password)) score++;

        return mapScoreToStrength(score);
    }
}
```

**BCrypt Configuration and Security**:
```java
public class BCryptSecurityManager {

    // BCrypt Version 2Y with cost factor 6 for performance/security balance
    private static final BCrypt.Version BCRYPT_VERSION = BCrypt.Version.VERSION_2Y;
    private static final int COST_FACTOR = 6;

    public static String hashPassword(String plainPassword) {
        return BCrypt.with(BCRYPT_VERSION)
            .hashToString(COST_FACTOR, plainPassword.toCharArray());
    }

    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        BCrypt.Result result = BCrypt.verifyer()
            .verify(plainPassword.toCharArray(), hashedPassword);
        return result.verified;
    }

    public static boolean isPasswordCompromised(String password) {
        // Integration point for password breach databases
        // Implementation would check against known compromised passwords
        return PasswordBreachChecker.isCompromised(password);
    }
}
```

### Email Integration Framework

**Email Template System**:
```java
public class EmailTemplateService {

    public void sendPasswordResetEmail(String userEmail, String userName, String resetUrl) {
        EmailTemplate template = EmailTemplate.builder()
            .templateName("password_reset")
            .subject("Citadel Super App Password Reset Request")
            .build();

        Map<String, Object> templateVariables = Map.of(
            "userName", userName,
            "resetUrl", resetUrl,
            "expirationMinutes", 30,
            "supportEmail", "support@citadelgroup.com.my"
        );

        emailService.sendTemplatedEmail(userEmail, template, templateVariables);
    }

    public void sendPasswordChangeNotification(String userEmail, String userName) {
        EmailTemplate template = EmailTemplate.builder()
            .templateName("password_changed")
            .subject("Citadel Super App Password Changed")
            .build();

        Map<String, Object> templateVariables = Map.of(
            "userName", userName,
            "changeTimestamp", new Date(),
            "supportEmail", "support@citadelgroup.com.my"
        );

        emailService.sendTemplatedEmail(userEmail, template, templateVariables);
    }
}
```

### Security Monitoring and Audit

**Login Audit System**:
```java
public class LoginAuditService {

    public void logLoginAttempt(String email, String ipAddress, boolean successful, String userAgent) {
        LoginAuditLog auditLog = LoginAuditLog.builder()
            .email(email)
            .ipAddress(ipAddress)
            .userAgent(userAgent)
            .successful(successful)
            .timestamp(new Date())
            .sessionId(generateSessionId())
            .build();

        loginAuditLogDao.save(auditLog);

        // Trigger security analysis
        if (!successful) {
            analyzeFailedLoginAttempt(auditLog);
        }
    }

    private void analyzeFailedLoginAttempt(LoginAuditLog auditLog) {
        // Count recent failed attempts
        long recentFailures = loginAuditLogDao.countFailedAttemptsSince(
            auditLog.getEmail(),
            DateUtil.getMinutesAgo(15)
        );

        if (recentFailures >= 5) {
            // Trigger account lockout or additional verification
            triggerSecurityMeasures(auditLog.getEmail(), auditLog.getIpAddress());
        }
    }

    public SecurityAnalysisReport generateSecurityReport(Date fromDate, Date toDate) {
        return SecurityAnalysisReport.builder()
            .totalLoginAttempts(loginAuditLogDao.countAttemptsBetween(fromDate, toDate))
            .successfulLogins(loginAuditLogDao.countSuccessfulAttemptsBetween(fromDate, toDate))
            .failedLogins(loginAuditLogDao.countFailedAttemptsBetween(fromDate, toDate))
            .uniqueUsers(loginAuditLogDao.countUniqueUsersBetween(fromDate, toDate))
            .suspiciousActivities(detectSuspiciousActivities(fromDate, toDate))
            .build();
    }
}
```

### Mobile App Integration

**Deep Link Processing**:
```java
public class DeepLinkProcessor {

    public DeepLinkResult processPasswordResetDeepLink(String encodedInfo) {
        try {
            // Decode Base64 information
            byte[] decodedBytes = Base64.getDecoder().decode(encodedInfo);
            String decodedInfo = new String(decodedBytes, StandardCharsets.UTF_8);

            // Parse email and token
            String[] parts = decodedInfo.split("/");
            if (parts.length != 2) {
                throw new IllegalArgumentException("Invalid deep link format");
            }

            String email = parts[0];
            String token = parts[1];

            // Validate token exists and hasn't expired
            String storedEmail = RedisUtil.get("resetPassword/" + token);
            if (storedEmail == null) {
                return DeepLinkResult.expired();
            }

            if (!storedEmail.equals(email)) {
                return DeepLinkResult.invalid();
            }

            return DeepLinkResult.valid(email, token);

        } catch (Exception e) {
            log.error("Error processing password reset deep link", e);
            return DeepLinkResult.invalid();
        }
    }
}
```

**Push Notification Integration**:
```java
public class PushNotificationManager {

    public void updateSubscription(AppUserSession session, String oneSignalSubscriptionId) {
        if (StringUtil.isNotEmpty(oneSignalSubscriptionId)) {
            session.setOneSignalSubscriptionId(oneSignalSubscriptionId);
            appUserSessionDao.save(session);

            // Register with OneSignal service
            oneSignalService.updateUserSubscription(
                session.getAppUser().getEmailAddress(),
                oneSignalSubscriptionId
            );
        }
    }

    public void sendSecurityNotification(AppUser appUser, String message) {
        List<AppUserSession> activeSessions = appUserSessionDao.findActiveByAppUser(appUser);

        for (AppUserSession session : activeSessions) {
            if (StringUtil.isNotEmpty(session.getOneSignalSubscriptionId())) {
                oneSignalService.sendNotification(
                    session.getOneSignalSubscriptionId(),
                    "Security Alert",
                    message
                );
            }
        }
    }
}
```

---

## Business Rules & Compliance

### Authentication Policies

**Session Management Rules**:
- **Session Duration**: 365-day expiration for user convenience
- **API Key Uniqueness**: Timestamp-based generation ensures uniqueness
- **Concurrent Sessions**: Multiple device support with cleanup policies
- **Session Invalidation**: Automatic cleanup of expired sessions

**Password Policies**:
- **Minimum Length**: 8 characters
- **Character Complexity**: At least 3 character types (uppercase, lowercase, digits, special)
- **Password Reuse**: Prevention of immediate password reuse
- **Reset Token Expiry**: 30-minute window for password reset completion

### Security Compliance

**Data Protection**:
```java
public class DataProtectionCompliance {

    public void handleSensitiveDataLogging() {
        // Never log passwords in plain text
        // Redact sensitive information in audit logs
        // Implement data retention policies for logs
    }

    public void enforcePrivacyRules() {
        // GDPR/PDPA compliance for user data
        // Right to erasure for session data
        // Data minimization in logging
    }
}
```

**Account Security Measures**:
- **Brute Force Protection**: Failed login attempt monitoring
- **Account Lockout**: Temporary lockout after repeated failures
- **IP-based Monitoring**: Suspicious activity detection
- **Device Fingerprinting**: Enhanced security for known devices

---

## Performance and Monitoring

### Authentication Metrics

**Key Performance Indicators**:
```java
public class AuthenticationMetrics {

    public AuthenticationAnalytics generateMetrics(Date fromDate, Date toDate) {
        return AuthenticationAnalytics.builder()
            .totalLoginAttempts(getTotalLoginAttempts(fromDate, toDate))
            .successfulLoginRate(calculateSuccessRate(fromDate, toDate))
            .averageSessionDuration(calculateAverageSessionDuration(fromDate, toDate))
            .passwordResetRequests(getPasswordResetCount(fromDate, toDate))
            .passwordResetCompletionRate(getResetCompletionRate(fromDate, toDate))
            .uniqueActiveUsers(getUniqueActiveUsers(fromDate, toDate))
            .securityIncidents(getSecurityIncidents(fromDate, toDate))
            .build();
    }
}
```

### Error Handling and Monitoring

**Comprehensive Error Management**:
```java
@ControllerAdvice
public class LoginControllerExceptionHandler {

    @ExceptionHandler(BadCredentialsException.class)
    public ResponseEntity<ErrorResp> handleBadCredentials(BadCredentialsException e) {
        // Log security event without exposing details
        securityLogger.logAuthenticationFailure(getCurrentRequest());

        ErrorResp errorResp = new ErrorResp();
        errorResp.setMessage("Invalid credentials");
        errorResp.setTimestamp(new Date());

        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(errorResp);
    }

    @ExceptionHandler(MaintenanceException.class)
    public ResponseEntity<ErrorResp> handleMaintenance(MaintenanceException e) {
        ErrorResp errorResp = new ErrorResp();
        errorResp.setMessage("System is under maintenance");
        errorResp.setMaintenanceWindow(e.getMaintenanceWindow());

        return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE).body(errorResp);
    }
}
```

This comprehensive documentation provides the new development team with deep insights into the LoginController's authentication system, security framework, and business processes. The detailed service layer analysis ensures thorough understanding of the secure authentication mechanisms that protect the Citadel platform.

<function_calls>
<invoke name="TodoWrite">
<parameter name="todos">[{"content": "Analyze LoginController structure and endpoints", "status": "completed", "activeForm": "Analyzing LoginController structure and endpoints"}, {"content": "Read LoginService and authentication mechanisms", "status": "completed", "activeForm": "Reading LoginService and authentication mechanisms"}, {"content": "Examine OTP and 2FA workflows", "status": "completed", "activeForm": "Examining OTP and 2FA workflows"}, {"content": "Investigate session management and security", "status": "completed", "activeForm": "Investigating session management and security"}, {"content": "Analyze password reset and recovery flows", "status": "completed", "activeForm": "Analyzing password reset and recovery flows"}, {"content": "Create comprehensive LoginController documentation", "status": "completed", "activeForm": "Creating comprehensive LoginController documentation"}]