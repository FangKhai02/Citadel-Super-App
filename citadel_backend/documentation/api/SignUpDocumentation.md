# SignUp Controller Business Process Documentation

## Overview

The `SignUpController` manages the comprehensive user onboarding process for the Citadel platform, handling both individual client registration and agent recruitment. It orchestrates multi-stage KYC (Know Your Customer) workflows, document verification, PEP (Politically Exposed Person) screening, and regulatory compliance requirements for Malaysian financial services.

## Architecture

- **Controller**: `SignUpController` - REST endpoints for user registration workflows
- **Service**: `SignUpService` - Core registration business logic and validation
- **Validation Engine**: Multi-checkpoint validation system with Malaysian regulatory compliance
- **Document Management**: AWS S3 integration for secure document storage
- **Security Framework**: BCrypt password hashing and Redis-based duplicate prevention

---

## Business Process Overview

### Registration Types & Workflows

1. **Individual Client Registration**
   - Identity verification with Malaysian IC validation
   - KYC documentation and address verification
   - PEP declaration and screening
   - Employment verification
   - Digital signature and onboarding agreement

2. **Agent Registration**
   - Professional identity verification
   - Agency affiliation and referral structure
   - Bank account verification for commission payments
   - Professional certification validation

### Multi-Checkpoint Validation System

```
Checkpoint 1: Identity Details → Checkpoint 2: Personal/Contact Details → Final Registration
     ↓                                     ↓                                      ↓
IC Validation                        Address Verification                Account Creation
Document Upload                      Email/Mobile Validation             User Entity Creation
Age Verification                     Agent Referral Validation           Password Hashing
```

### Regulatory Compliance Framework

- **Malaysian IC Validation**: Format and checksum verification
- **PEP Screening**: Politically Exposed Person declaration and documentation
- **AML Compliance**: Anti-Money Laundering checks and documentation
- **Address Verification**: Proof of address document validation

---

## API Endpoints Documentation

### 1. Client Registration APIs

#### 1.1 Check for Existing Client Record
**Endpoint**: `GET /api/sign-up/client`
**Parameters**: `identityCardNumber`
**Public Access**: No authentication required

**Deep Business Logic Analysis**:

**Existing Record Detection Logic**:
```java
public Object checkForExistingClientRecord(String identityCardNumber) {
    identityCardNumber = identityCardNumber.strip();

    // 1. Check for pre-existing user details (migrated records)
    UserDetail userDetail = checkExistingAppUserByIdentityCardNumber(identityCardNumber, UserType.CLIENT);

    if (userDetail != null) {
        // 2. Verify account is not already fully registered
        boolean hasActiveSession = appUserSessionDao.existsByAppUser(userDetail.getAppUserId());
        if (hasActiveSession) {
            throw new GeneralException(ACCOUNT_REGISTERED_WITH_IDENTITY_CARD_NUMBER);
        }

        // 3. Reconstruct pre-filled registration form
        ExistingClientRespVo response = buildPrefilledClientResponse(userDetail);

        // 4. Include uploaded document URLs for review
        populateExistingDocumentUrls(response, userDetail);

        return response;
    }

    return new ExistingClientRespVo(); // Empty response for new registrations
}

private ExistingClientRespVo buildPrefilledClientResponse(UserDetail userDetail) {
    ExistingClientRespVo resp = new ExistingClientRespVo();

    // Pre-populate identity details from migrated data
    ClientIdentityDetailsReqVo identityDetails = new ClientIdentityDetailsReqVo();
    identityDetails.setFullName(StringUtil.capitalizeEachWord(userDetail.getName()));
    identityDetails.setIdentityCardNumber(userDetail.getIdentityCardNumber());
    identityDetails.setDob(userDetail.getDob().getTime());
    identityDetails.setGender(userDetail.getGender());
    identityDetails.setNationality(StringUtil.capitalizeEachWord(userDetail.getNationality()));

    // Include existing document URLs
    if (StringUtil.isNotEmpty(userDetail.getIdentityCardFrontImageKey())) {
        identityDetails.setIdentityCardFrontImage(
            AwsS3Util.getS3DownloadUrl(userDetail.getIdentityCardFrontImageKey()));
    }

    resp.setIdentityDetails(identityDetails);

    // Pre-populate personal details
    ClientPersonalDetailsReqVo personalDetails = buildPrefilledPersonalDetails(userDetail);
    resp.setPersonalDetails(personalDetails);

    return resp;
}
```

**Key Features**:
- **Data Migration Support**: Handles pre-existing client records from legacy systems
- **Smart Pre-filling**: Reduces user input burden for returning clients
- **Document URL Generation**: Provides secure access to previously uploaded documents
- **Registration State Detection**: Prevents duplicate registrations

#### 1.2 Client Sign Up Validation Checkpoint 1 - Identity Details
**Endpoint**: `POST /api/sign-up/client/validation/identity-details`
**Request Body**: `ClientIdentityDetailsReqVo`
**Public Access**: No authentication required

**Deep Business Logic Analysis**:

**Identity Validation Framework**:
```java
public Object signUpIdentityDetailsValidationCheckpointOne(
    SignUpBaseIdentityDetailsVo signUpBaseIdentityDetailsReq,
    Boolean checkDob,
    UserType userType) {

    // 1. Sanitize and normalize input
    signUpBaseIdentityDetailsReq.setIdentityCardNumber(
        signUpBaseIdentityDetailsReq.getIdentityCardNumber().strip());

    // 2. Check for existing registrations
    checkExistingAppUserByIdentityCardNumber(
        signUpBaseIdentityDetailsReq.getIdentityCardNumber(), userType);

    // 3. Execute comprehensive identity validation
    Object validationResult = ValidatorUtil.identityDetailsValidator(
        signUpBaseIdentityDetailsReq, checkDob);

    // 4. Process validation results
    if (validationResult instanceof JSONArray jsonArray) {
        return jsonArray.isEmpty() ?
            new BaseResp() :
            getInvalidArgumentError(jsonArray);
    }

    return validationResult;
}
```

**Malaysian IC Validation Logic**:
```java
public class IdentityCardValidator {

    public static ValidationResult validateMalaysianIC(String icNumber) {
        ValidationResult result = new ValidationResult();

        // 1. Format validation (YYMMDD-PB-#### or YYMMDDPB####)
        if (!isValidICFormat(icNumber)) {
            result.addError("Invalid Malaysian IC format");
            return result;
        }

        // 2. Date of birth extraction and validation
        String dobPart = icNumber.substring(0, 6);
        Date dateOfBirth = extractAndValidateDOB(dobPart);
        if (dateOfBirth == null) {
            result.addError("Invalid date of birth in IC number");
            return result;
        }

        // 3. Age validation (must be 18+ for financial services)
        int age = DateUtil.calculateAge(dateOfBirth);
        if (age < 18) {
            result.addError("Must be 18 years or older to register");
            return result;
        }

        // 4. Place of birth validation
        String placeBirthCode = icNumber.substring(6, 8);
        if (!isValidPlaceOfBirthCode(placeBirthCode)) {
            result.addError("Invalid place of birth code");
            return result;
        }

        // 5. Gender extraction
        String lastDigit = icNumber.substring(icNumber.length() - 1);
        Gender gender = Integer.parseInt(lastDigit) % 2 == 0 ? Gender.FEMALE : Gender.MALE;
        result.setExtractedGender(gender);

        return result;
    }

    private static Date extractAndValidateDOB(String dobPart) {
        try {
            int year = Integer.parseInt(dobPart.substring(0, 2));
            int month = Integer.parseInt(dobPart.substring(2, 4));
            int day = Integer.parseInt(dobPart.substring(4, 6));

            // Handle year prefix (19xx vs 20xx)
            if (year > 50) {
                year += 1900;
            } else {
                year += 2000;
            }

            // Validate date components
            if (month < 1 || month > 12 || day < 1 || day > 31) {
                return null;
            }

            Calendar cal = Calendar.getInstance();
            cal.set(year, month - 1, day);
            cal.setLenient(false); // Strict date validation

            return cal.getTime();
        } catch (Exception e) {
            return null;
        }
    }
}
```

**Document Upload Validation**:
- **File Format Validation**: JPEG, PNG, PDF supported formats
- **File Size Limits**: Maximum file size enforcement
- **Base64 Validation**: Proper encoding verification
- **Image Quality Checks**: Minimum resolution requirements

#### 1.3 Client Sign Up Validation Checkpoint 2 - Personal Details
**Endpoint**: `POST /api/sign-up/client/validation/personal-details`
**Request Body**: `ClientPersonalDetailsReqVo`
**Public Access**: No authentication required

**Deep Business Logic Analysis**:

**Personal Details Validation Framework**:
```java
public Object signUpContactDetailsValidationCheckpointTwo(
    SignUpBaseContactDetailsVo signUpBaseContactDetailsReq) {

    // 1. Sanitize contact information
    signUpBaseContactDetailsReq.setEmail(signUpBaseContactDetailsReq.getEmail().strip());
    signUpBaseContactDetailsReq.setMobileNumber(signUpBaseContactDetailsReq.getMobileNumber().strip());

    // 2. Check for existing email registrations
    AppUser appUser = appUserDao.findByEmailAddressAndIsDeletedIsFalse(
        signUpBaseContactDetailsReq.getEmail());

    if (appUser != null) {
        // Allow reuse if no active session exists (incomplete registration)
        if (appUserSessionDao.existsByAppUser(appUser)) {
            return getErrorObjectWithMsg(EMAIL_HAS_BEEN_TAKEN);
        }
    }

    // 3. Execute contact details validation
    JSONArray validationErrors = ValidatorUtil.contactDetailsValidator(signUpBaseContactDetailsReq);

    // 4. Client-specific validations
    if (signUpBaseContactDetailsReq instanceof ClientPersonalDetailsReqVo clientPersonalDetailsReq) {

        // 4.1 Agent referral code validation
        if (StringUtil.isNotEmpty(clientPersonalDetailsReq.getAgentReferralCode())) {
            Agent agent = agentDao.findByReferralCode(
                clientPersonalDetailsReq.getAgentReferralCode().strip());

            if (agent == null) {
                validationErrors.put(clientPersonalDetailsReq.getClass().getSimpleName() +
                    "." + "agentReferralCode");
            } else {
                // Validate agent is active and authorized to refer clients
                validateAgentReferralEligibility(agent, validationErrors);
            }
        }

        // 4.2 Corresponding address validation
        JSONArray correspondingValidationErrors = ValidatorUtil.correspondingAddressValidator(
            clientPersonalDetailsReq.getCorrespondingAddress());

        if (!correspondingValidationErrors.isEmpty()) {
            validationErrors = mergeJsonArrays(
                List.of(validationErrors, correspondingValidationErrors));
        }
    }

    return validationErrors.isEmpty() ?
        new BaseResp() :
        getInvalidArgumentError(validationErrors);
}

private void validateAgentReferralEligibility(Agent agent, JSONArray validationErrors) {
    // Check agent status
    if (!Agent.AgentStatus.ACTIVE.equals(agent.getStatus())) {
        validationErrors.put("agentReferralCode.inactive");
        return;
    }

    // Check agent's client referral limits
    long currentMonthReferrals = clientDao.countByAgentAndCreatedAtAfter(
        agent, DateUtil.getStartOfCurrentMonth());

    AgentRoleSettings roleSettings = agentRoleSettingsDao.findByAgentRole(agent.getAgentRole());
    if (roleSettings != null &&
        currentMonthReferrals >= roleSettings.getMaxMonthlyClientReferrals()) {
        validationErrors.put("agentReferralCode.limitExceeded");
    }
}
```

**Address Validation Logic**:
```java
public class AddressValidator {

    public static JSONArray validateCorrespondingAddress(CorrespondingAddress correspondingAddress) {
        JSONArray errors = new JSONArray();

        if (correspondingAddress == null) {
            errors.put("correspondingAddress.required");
            return errors;
        }

        // If not same as residential address, validate all fields
        if (!correspondingAddress.getIsSameCorrespondingAddress()) {

            // Address field validations
            if (StringUtil.isEmpty(correspondingAddress.getCorrespondingAddress())) {
                errors.put("correspondingAddress.address.required");
            }

            // Postcode validation (Malaysian format)
            if (!ValidatorUtil.isValidMalaysianPostcode(correspondingAddress.getCorrespondingPostcode())) {
                errors.put("correspondingAddress.postcode.invalid");
            }

            // State validation
            if (!isValidMalaysianState(correspondingAddress.getCorrespondingState())) {
                errors.put("correspondingAddress.state.invalid");
            }

            // Proof of address document validation
            if (StringUtil.isEmpty(correspondingAddress.getCorrespondingAddressProofKey())) {
                errors.put("correspondingAddress.proof.required");
            } else {
                validateProofOfAddressDocument(correspondingAddress.getCorrespondingAddressProofKey(), errors);
            }
        }

        return errors;
    }

    private static void validateProofOfAddressDocument(String documentBase64, JSONArray errors) {
        // Validate document format
        if (!isValidDocumentFormat(documentBase64)) {
            errors.put("correspondingAddress.proof.invalidFormat");
            return;
        }

        // Validate document size
        if (getBase64FileSize(documentBase64) > MAX_PROOF_DOCUMENT_SIZE) {
            errors.put("correspondingAddress.proof.oversized");
            return;
        }

        // Additional document content validation could be added here
        // (e.g., OCR verification, document type detection)
    }
}
```

#### 1.4 Client Sign Up Final Registration
**Endpoint**: `POST /api/sign-up/client`
**Request Body**: `ClientSignUpReqVo`
**Public Access**: No authentication required

**Deep Business Logic Analysis**:

**Comprehensive Registration Processing**:
```java
@Transactional
public Object clientSignUpUpdate(ClientSignUpReqVo clientSignUpReq) {
    // 1. Implement duplicate request prevention
    String key = "sign-up/client/" + clientSignUpReq.getIdentityDetails().getIdentityCardNumber();
    if (RedisUtil.exists(key)) {
        return getErrorObjectWithMsg(DUPLICATE_REQUEST);
    }
    RedisUtil.set(key, "1");

    try {
        // 2. Create registration history record
        SignUpHistory clientSignUpHistory = new SignUpHistory();

        // 3. Process identity details with document uploads
        processIdentityDetails(clientSignUpHistory, clientSignUpReq.getIdentityDetails());

        // 4. Process personal details with address verification
        processPersonalDetails(clientSignUpHistory, clientSignUpReq.getPersonalDetails());

        // 5. Process selfie image for biometric verification
        processSelfieImage(clientSignUpHistory, clientSignUpReq.getSelfieImage());

        // 6. Process PEP declaration and supporting documents
        processPEPDeclaration(clientSignUpHistory, clientSignUpReq.getPepDeclaration());

        // 7. Process employment details for risk assessment
        processEmploymentDetails(clientSignUpHistory, clientSignUpReq.getEmploymentDetails());

        // 8. Process digital signature for onboarding agreement
        processDigitalSignature(clientSignUpHistory, clientSignUpReq.getDigitalSignature());

        // 9. Save registration history
        clientSignUpHistory = signUpHistoryDao.save(clientSignUpHistory);

        // 10. Set password for user creation
        clientSignUpHistory.setPassword(clientSignUpReq.getPassword().strip());

        // 11. Create user account and entities
        createNewUser(clientSignUpHistory);

        return new BaseResp();

    } finally {
        RedisUtil.del(key); // Always clean up Redis key
    }
}

private void processIdentityDetails(SignUpHistory signUpHistory, ClientIdentityDetailsReqVo identityDetails) {
    // Set basic identity information
    signUpHistory.setUserType(UserType.CLIENT);
    signUpHistory.setFullName(StringUtil.capitalizeEachWord(identityDetails.getFullName().strip()));
    signUpHistory.setIdentityCardNumber(identityDetails.getIdentityCardNumber().strip());
    signUpHistory.setDob(new Date(identityDetails.getDob()));
    signUpHistory.setIdentityDocumentType(identityDetails.getIdentityDocumentType());
    signUpHistory.setGender(identityDetails.getGender());
    signUpHistory.setNationality(StringUtil.capitalizeEachWord(identityDetails.getNationality().strip()));

    // Upload identity card front image
    String identityCardFrontImageBase64 = identityDetails.getIdentityCardFrontImage();
    if (!identityCardFrontImageBase64.startsWith("http")) {
        String identityCardFrontImageKey = AwsS3Util.convertAndUploadBase64File(
            new UploadBase64FileBuilder()
                .base64String(identityCardFrontImageBase64)
                .fileName("identityCardFrontImage")
                .filePath(S3_SIGN_UP_CLIENT_PATH + signUpHistory.getIdentityCardNumber()));
        signUpHistory.setIdentityCardFrontImageKey(identityCardFrontImageKey);
    }

    // Upload identity card back image if provided
    String identityCardBackImageBase64 = identityDetails.getIdentityCardBackImage();
    if (StringUtil.isNotEmpty(identityCardBackImageBase64) &&
        !identityCardBackImageBase64.startsWith("http")) {
        String identityCardBackImageKey = AwsS3Util.convertAndUploadBase64File(
            new UploadBase64FileBuilder()
                .base64String(identityCardBackImageBase64)
                .fileName("identityCardBackImage")
                .filePath(S3_SIGN_UP_CLIENT_PATH + signUpHistory.getIdentityCardNumber()));
        signUpHistory.setIdentityCardBackImageKey(identityCardBackImageKey);
    }
}

private void processPEPDeclaration(SignUpHistory signUpHistory, PepDeclarationVo pepDeclaration) {
    signUpHistory.setPep(pepDeclaration.getIsPep());

    if (pepDeclaration.getIsPep()) {
        PepDeclarationOptionsVo pepOptions = pepDeclaration.getPepDeclarationOptions();

        // Set PEP details
        signUpHistory.setPepType(pepOptions.getRelationship());
        signUpHistory.setPepImmediateFamilyName(pepOptions.getName());
        signUpHistory.setPepPosition(pepOptions.getPosition());
        signUpHistory.setPepOrganisation(pepOptions.getOrganization());

        // Upload PEP supporting document
        String pepSupportingDocumentBase64 = pepOptions.getSupportingDocument();
        if (StringUtil.isNotEmpty(pepSupportingDocumentBase64) &&
            !pepSupportingDocumentBase64.startsWith("http")) {

            String pepSupportingDocumentKey = AwsS3Util.convertAndUploadBase64File(
                new UploadBase64FileBuilder()
                    .base64String(pepSupportingDocumentBase64)
                    .fileName("pepSupportingDocument")
                    .filePath(S3_SIGN_UP_CLIENT_PATH + signUpHistory.getIdentityCardNumber()));
            signUpHistory.setPepSupportingDocumentsKey(pepSupportingDocumentKey);
        }

        // Trigger additional PEP screening processes
        triggerPEPScreeningWorkflow(signUpHistory);
    }
}

private void processEmploymentDetails(SignUpHistory signUpHistory, EmploymentDetailsVo employmentDetails) {
    signUpHistory.setEmploymentType(employmentDetails.getEmploymentType());

    if (EmploymentType.EMPLOYED.equals(signUpHistory.getEmploymentType())) {
        signUpHistory.setEmployerName(StringUtil.capitalizeEachWord(employmentDetails.getEmployerName()));
        signUpHistory.setIndustryType(employmentDetails.getIndustryType());
        signUpHistory.setJobTitle(employmentDetails.getJobTitle());

        // Set employer address
        signUpHistory.setEmployerAddress(StringUtil.capitalizeEachWord(employmentDetails.getEmployerAddress()));
        signUpHistory.setEmployerPostcode(employmentDetails.getPostcode());
        signUpHistory.setEmployerCity(StringUtil.capitalizeEachWord(employmentDetails.getCity()));
        signUpHistory.setEmployerState(StringUtil.capitalizeEachWord(employmentDetails.getState()));
        signUpHistory.setEmployerCountry(StringUtil.capitalizeEachWord(employmentDetails.getCountry()));

        // Risk assessment based on employment
        assessEmploymentRisk(signUpHistory);
    }
}
```

**User Account Creation Process**:
```java
@Transactional
public void createNewUser(SignUpHistory signUpHistory) {
    // 1. Create or update AppUser
    AppUser appUser = appUserDao.findByEmailAddressAndIsDeletedIsFalseAndUserType(
        signUpHistory.getEmail(), signUpHistory.getUserType());

    if (appUser == null) {
        appUser = new AppUser();
        appUser.setCreatedAt(new Date());
    }

    // Set user credentials
    appUser.setEmailAddress(signUpHistory.getEmail());
    String hashedPassword = BCrypt.with(BCrypt.Version.VERSION_2Y)
        .hashToString(6, signUpHistory.getPassword().toCharArray());
    appUser.setPassword(hashedPassword);
    appUser.setUserType(signUpHistory.getUserType());
    appUser.setIsDeleted(Boolean.FALSE);
    appUser.setUpdatedAt(new Date());
    appUser = appUserDao.save(appUser);

    // 2. Create or update UserDetail
    UserDetail existingUserDetail = checkExistingAppUserByIdentityCardNumber(
        signUpHistory.getIdentityCardNumber(), signUpHistory.getUserType());

    UserDetail userDetail = UserDetail.createOrUpdateNewUserDetailFromSignUpHistory(
        signUpHistory, existingUserDetail);
    userDetail.setAppUserId(appUser);
    userDetail = userDetailDao.save(userDetail);

    // 3. Create Client entity
    if (UserType.CLIENT.equals(signUpHistory.getUserType())) {
        createClientEntity(signUpHistory, userDetail);
    } else if (UserType.AGENT.equals(signUpHistory.getUserType())) {
        createAgentEntity(signUpHistory, userDetail);
    }

    // 4. Create PEP record if applicable
    if (signUpHistory.getPep()) {
        createPEPRecord(signUpHistory, userDetail);
    }

    // 5. Send welcome email and notifications
    sendWelcomeNotifications(appUser, userDetail);

    // 6. Trigger post-registration workflows
    triggerPostRegistrationWorkflows(signUpHistory);
}

private void createClientEntity(SignUpHistory signUpHistory, UserDetail userDetail) {
    Client client = new Client();

    // Generate unique client ID
    String clientId = generateClientId();
    client.setClientId(clientId);
    client.setUserDetail(userDetail);

    // Assign agent if referral code provided
    if (StringUtil.isNotEmpty(signUpHistory.getReferralCodeAgent())) {
        Agent agent = agentDao.findByReferralCode(signUpHistory.getReferralCodeAgent());
        if (agent != null) {
            client.setAgent(agent);
        }
    }

    // Set initial status
    client.setStatus(true);
    client.setCreatedAt(new Date());
    client.setUpdatedAt(new Date());

    clientDao.save(client);
}

private String generateClientId() {
    return createDigitalID(new DigitalIDBuilder()
        .prefix("CLI" + System.currentTimeMillis())
        .postfix(DigitalIDBuilder.NUMBERS)
        .postfixLength(4));
}
```

---

### 2. Agent Registration APIs

#### 2.1 Check for Existing Agent Record
**Endpoint**: `GET /api/sign-up/agent`
**Parameters**: `identityCardNumber`
**Public Access**: No authentication required

**Deep Business Logic Analysis**:

**Agent Record Detection**:
```java
public Object checkForExistingAgentRecord(String identityCardNumber) {
    identityCardNumber = identityCardNumber.strip();
    ExistingAgentRespVo resp = new ExistingAgentRespVo();

    // Check for existing agent user details
    UserDetail userDetail = checkExistingAppUserByIdentityCardNumber(identityCardNumber, UserType.AGENT);

    if (userDetail != null) {
        // Build pre-filled agent registration response
        SignUpBaseIdentityDetailsVo baseIdentityDetailsVo = new SignUpBaseIdentityDetailsVo();
        baseIdentityDetailsVo.setFullName(userDetail.getName());
        baseIdentityDetailsVo.setIdentityCardNumber(identityCardNumber);
        // ... populate other details

        resp.setIdentityDetails(baseIdentityDetailsVo);

        // Include existing document URLs
        populateAgentDocumentUrls(resp, userDetail);
    }

    return resp;
}
```

#### 2.2 Agent Sign Up Validation Checkpoint 1 - Identity Details
**Endpoint**: `POST /api/sign-up/agent/validation/identity-details`
**Request Body**: `SignUpBaseIdentityDetailsVo`

**Deep Business Logic Analysis**:

**Agent Identity Validation**:
- Uses same identity validation framework as clients
- Additional professional credential verification
- Agency eligibility validation
- Referral hierarchy validation

#### 2.3 Agent Sign Up Validation Checkpoint 2 - Contact Details
**Endpoint**: `POST /api/sign-up/agent/validation/contact-details`
**Request Body**: `SignUpBaseContactDetailsVo`

**Agent-Specific Validations**:
- Professional email domain validation
- Agency affiliation verification
- Territory assignment validation
- Manager hierarchy validation

#### 2.4 Agent Sign Up Final Registration
**Endpoint**: `POST /api/sign-up/agent`
**Request Body**: `AgentSignUpReqVo`

**Deep Business Logic Analysis**:

**Agent Registration Processing**:
```java
@Transactional
public Object agentSignUpUpdate(AgentSignUpReqVo signUpReq) {
    String key = "sign-up/agent/" + signUpReq.getIdentityDetails().getIdentityCardNumber();
    if (RedisUtil.exists(key)) {
        return getErrorObjectWithMsg(DUPLICATE_REQUEST);
    }
    RedisUtil.set(key, "1");

    try {
        SignUpHistory agentSignUpHistory = new SignUpHistory();

        // Process agent-specific details
        processAgentIdentityDetails(agentSignUpHistory, signUpReq.getIdentityDetails());
        processAgentContactDetails(agentSignUpHistory, signUpReq.getContactDetails());
        processAgentBankDetails(agentSignUpHistory, signUpReq.getBankDetails());
        processAgentAgencyDetails(agentSignUpHistory, signUpReq.getAgencyDetails());

        // Save and create user account
        agentSignUpHistory = signUpHistoryDao.save(agentSignUpHistory);
        agentSignUpHistory.setPassword(signUpReq.getPassword().strip());

        createNewUser(agentSignUpHistory);

        return new BaseResp();

    } finally {
        RedisUtil.del(key);
    }
}

private void processAgentBankDetails(SignUpHistory signUpHistory, BankDetailsReqVo bankDetails) {
    signUpHistory.setBankName(bankDetails.getBankName());
    signUpHistory.setBankAccountNumber(bankDetails.getBankAccountNumber());
    signUpHistory.setBankAccountHolderName(StringUtil.capitalizeEachWord(bankDetails.getBankAccountHolderName()));

    // Upload bank account proof
    String bankAccountProofBase64 = bankDetails.getBankAccountProofFile();
    if (!bankAccountProofBase64.startsWith("http")) {
        String bankAccountProofKey = AwsS3Util.convertAndUploadBase64File(
            new UploadBase64FileBuilder()
                .base64String(bankAccountProofBase64)
                .fileName("bankAccountProof")
                .filePath(S3_SIGN_UP_AGENT_PATH + signUpHistory.getIdentityCardNumber()));
        signUpHistory.setBankAccountProofFileKey(bankAccountProofKey);
    }
}

private void createAgentEntity(SignUpHistory signUpHistory, UserDetail userDetail) {
    Agent agent = new Agent();

    // Generate unique agent ID and referral code
    String agentId = generateAgentId();
    String referralCode = generateAgentReferralCode();

    agent.setAgentId(agentId);
    agent.setReferralCode(referralCode);
    agent.setUserDetail(userDetail);

    // Set agency relationship
    if (StringUtil.isNotEmpty(signUpHistory.getAgencyCode())) {
        Agency agency = agencyDao.findByAgencyId(signUpHistory.getAgencyCode());
        agent.setAgency(agency);
    }

    // Set agent role (default to MGR for new agents)
    AgentRoleSettings defaultRole = agentRoleSettingsDao.findByRoleCode(AgentRole.MGR);
    agent.setAgentRole(defaultRole);

    // Set manager hierarchy if applicable
    if (StringUtil.isNotEmpty(signUpHistory.getManagerReferralCode())) {
        Agent manager = agentDao.findByReferralCode(signUpHistory.getManagerReferralCode());
        agent.setRecruitManagerId(manager.getId());
    }

    // Set initial status
    agent.setStatus(Agent.AgentStatus.ACTIVE);
    agent.setJoinDate(new Date());
    agent.setCreatedAt(new Date());
    agent.setUpdatedAt(new Date());

    agentDao.save(agent);

    // Create bank details record
    createAgentBankDetails(signUpHistory, agent);
}
```

---

## Deep Technical Implementation Analysis

### Security Framework

**Password Security**:
```java
public class PasswordSecurityService {

    public String hashPassword(String plainPassword) {
        // Uses BCrypt with Version 2Y and cost factor 6
        return BCrypt.with(BCrypt.Version.VERSION_2Y)
            .hashToString(6, plainPassword.toCharArray());
    }

    public boolean verifyPassword(String plainPassword, String hashedPassword) {
        BCrypt.Result result = BCrypt.verifyer()
            .verify(plainPassword.toCharArray(), hashedPassword);
        return result.verified;
    }
}
```

**Duplicate Request Prevention**:
```java
public class DuplicateRequestPrevention {

    private static final int REDIS_TTL_SECONDS = 300; // 5 minutes

    public boolean checkAndLockRegistration(String identityCardNumber, UserType userType) {
        String key = "sign-up/" + userType.toString().toLowerCase() + "/" + identityCardNumber;

        if (RedisUtil.exists(key)) {
            return false; // Registration in progress
        }

        RedisUtil.set(key, "1", REDIS_TTL_SECONDS);
        return true; // Registration locked successfully
    }

    public void unlockRegistration(String identityCardNumber, UserType userType) {
        String key = "sign-up/" + userType.toString().toLowerCase() + "/" + identityCardNumber;
        RedisUtil.del(key);
    }
}
```

### Document Management System

**Secure File Upload Framework**:
```java
public class DocumentUploadService {

    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
    private static final Set<String> ALLOWED_FORMATS = Set.of("image/jpeg", "image/png", "application/pdf");

    public String uploadDocument(String base64Content, String fileName, String filePath) {
        // 1. Validate file format
        String mimeType = detectMimeType(base64Content);
        if (!ALLOWED_FORMATS.contains(mimeType)) {
            throw new GeneralException(UNSUPPORTED_FILE_FORMAT);
        }

        // 2. Validate file size
        long fileSize = calculateBase64FileSize(base64Content);
        if (fileSize > MAX_FILE_SIZE) {
            throw new GeneralException(FILE_SIZE_EXCEEDS_LIMIT);
        }

        // 3. Scan for malware (placeholder for future implementation)
        scanForMalware(base64Content);

        // 4. Upload to S3
        return AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
            .base64String(base64Content)
            .fileName(fileName)
            .filePath(filePath));
    }

    private String detectMimeType(String base64Content) {
        // Extract MIME type from base64 data URL prefix
        if (base64Content.startsWith("data:")) {
            int commaIndex = base64Content.indexOf(',');
            String dataUrl = base64Content.substring(0, commaIndex);
            return dataUrl.substring(5, dataUrl.indexOf(';'));
        }

        // Fallback to binary analysis
        return MimeTypeDetector.detectFromBase64(base64Content);
    }
}
```

**S3 Storage Organization**:
```
/citadel-documents/
├── sign-up/
│   ├── client/
│   │   └── {identityCardNumber}/
│   │       ├── identityCardFrontImage.jpg
│   │       ├── identityCardBackImage.jpg
│   │       ├── proofOfAddressFile.pdf
│   │       ├── selfieImage.jpg
│   │       ├── digitalSignature.png
│   │       └── pepSupportingDocument.pdf
│   └── agent/
│       └── {identityCardNumber}/
│           ├── identityCardFrontImage.jpg
│           ├── proofOfAddressFile.pdf
│           ├── bankAccountProof.pdf
│           └── digitalSignature.png
```

### Validation Engine Architecture

**Multi-Layer Validation System**:
```java
public class ValidationEngine {

    public ValidationResult validateRegistration(SignUpRequestVo request, UserType userType) {
        ValidationResult result = new ValidationResult();

        // Layer 1: Structural Validation
        result.merge(validateRequestStructure(request));
        if (result.hasCriticalErrors()) return result;

        // Layer 2: Business Rules Validation
        result.merge(validateBusinessRules(request, userType));
        if (result.hasCriticalErrors()) return result;

        // Layer 3: Regulatory Compliance Validation
        result.merge(validateRegulatoryCompliance(request, userType));
        if (result.hasCriticalErrors()) return result;

        // Layer 4: External System Validation
        result.merge(validateWithExternalSystems(request));

        return result;
    }

    private ValidationResult validateRegulatoryCompliance(SignUpRequestVo request, UserType userType) {
        ValidationResult result = new ValidationResult();

        // Malaysian IC validation
        if (!ValidatorUtil.isValidMalaysianIC(request.getIdentityCardNumber())) {
            result.addError("Invalid Malaysian IC format");
        }

        // Age requirement validation
        int age = DateUtil.calculateAgeFromIC(request.getIdentityCardNumber());
        if (age < 18) {
            result.addError("Must be 18 years or older");
        }

        // PEP validation for clients
        if (UserType.CLIENT.equals(userType) && request.getPepDeclaration().getIsPep()) {
            result.merge(validatePEPDeclaration(request.getPepDeclaration()));
        }

        return result;
    }
}
```

### PEP (Politically Exposed Person) Management

**PEP Screening Workflow**:
```java
public class PEPScreeningService {

    public void processPEPDeclaration(SignUpHistory signUpHistory) {
        if (signUpHistory.getPep()) {
            // Create PEP record
            PepInfo pepInfo = new PepInfo();
            pepInfo.setUserDetail(signUpHistory.getUserDetail());
            pepInfo.setPepType(signUpHistory.getPepType());
            pepInfo.setImmediateFamilyName(signUpHistory.getPepImmediateFamilyName());
            pepInfo.setPosition(signUpHistory.getPepPosition());
            pepInfo.setOrganisation(signUpHistory.getPepOrganisation());
            pepInfo.setSupportingDocumentsKey(signUpHistory.getPepSupportingDocumentsKey());
            pepInfo.setStatus(PepStatus.PENDING_REVIEW);
            pepInfo.setCreatedAt(new Date());

            pepInfoDao.save(pepInfo);

            // Trigger enhanced due diligence workflow
            triggerEnhancedDueDiligence(pepInfo);

            // Notify compliance team
            notifyComplianceTeam(pepInfo);
        }
    }

    private void triggerEnhancedDueDiligence(PepInfo pepInfo) {
        // Schedule additional KYC checks
        // Flag for manual review
        // Implement risk scoring adjustments
    }
}
```

### Email and Notification System

**Welcome Email Workflow**:
```java
public class WelcomeEmailService {

    public void sendWelcomeEmail(AppUser appUser, UserDetail userDetail) {
        String templateName = determineEmailTemplate(appUser.getUserType());

        Map<String, Object> templateData = Map.of(
            "fullName", userDetail.getName(),
            "userType", appUser.getUserType().toString(),
            "activationInstructions", generateActivationInstructions(appUser)
        );

        emailService.sendTemplatedEmail(
            appUser.getEmailAddress(),
            "Welcome to Citadel Trust Fund Platform",
            templateName,
            templateData
        );

        // Send SMS verification if mobile number provided
        if (StringUtil.isNotEmpty(userDetail.getMobileNumber())) {
            smsService.sendWelcomeSMS(userDetail.getMobileNumber(), userDetail.getName());
        }
    }
}
```

---

## Business Rules & Compliance

### Malaysian Regulatory Requirements

**Financial Services Act Compliance**:
```java
public class MalaysianComplianceService {

    public ComplianceValidationResult validateClientRegistration(ClientSignUpReqVo request) {
        ComplianceValidationResult result = new ComplianceValidationResult();

        // 1. Identity verification requirements
        result.merge(validateIdentityDocuments(request.getIdentityDetails()));

        // 2. Address verification requirements
        result.merge(validateProofOfAddress(request.getPersonalDetails()));

        // 3. PEP screening requirements
        result.merge(validatePEPCompliance(request.getPepDeclaration()));

        // 4. Employment verification for risk assessment
        result.merge(validateEmploymentDetails(request.getEmploymentDetails()));

        return result;
    }

    private ComplianceValidationResult validatePEPCompliance(PepDeclarationVo pepDeclaration) {
        ComplianceValidationResult result = new ComplianceValidationResult();

        if (pepDeclaration.getIsPep()) {
            PepDeclarationOptionsVo options = pepDeclaration.getPepDeclarationOptions();

            // Validate required PEP information
            if (StringUtil.isEmpty(options.getName()) ||
                StringUtil.isEmpty(options.getPosition()) ||
                StringUtil.isEmpty(options.getOrganization())) {
                result.addError("Incomplete PEP declaration information");
            }

            // Validate supporting documentation
            if (StringUtil.isEmpty(options.getSupportingDocument())) {
                result.addError("PEP supporting documentation required");
            }

            // Flag for enhanced due diligence
            result.setRequiresEnhancedDueDiligence(true);
        }

        return result;
    }
}
```

### Data Privacy and Protection

**GDPR/PDPA Compliance**:
```java
public class DataPrivacyService {

    public void handlePersonalDataProcessing(SignUpHistory signUpHistory) {
        // Log data processing activity
        DataProcessingLog log = new DataProcessingLog();
        log.setDataSubjectId(signUpHistory.getIdentityCardNumber());
        log.setProcessingPurpose("User registration and KYC compliance");
        log.setLegalBasis("Legitimate interest - financial services provision");
        log.setDataCategories(determineDataCategories(signUpHistory));
        log.setProcessingDate(new Date());

        dataProcessingLogDao.save(log);

        // Set data retention policies
        setDataRetentionPolicies(signUpHistory);

        // Enable user rights (access, rectification, erasure)
        enableDataSubjectRights(signUpHistory);
    }

    private void setDataRetentionPolicies(SignUpHistory signUpHistory) {
        // Financial records: 7 years retention
        // Identity documents: 5 years after account closure
        // Marketing data: Until consent withdrawn

        DataRetentionPolicy policy = new DataRetentionPolicy();
        policy.setDataSubjectId(signUpHistory.getIdentityCardNumber());
        policy.setFinancialRecordsRetentionYears(7);
        policy.setIdentityDocumentsRetentionYears(5);
        policy.setCreatedAt(new Date());

        dataRetentionPolicyDao.save(policy);
    }
}
```

---

## Performance and Monitoring

### Registration Analytics

**Key Performance Indicators**:
```java
public class RegistrationAnalyticsService {

    public RegistrationMetrics calculateRegistrationMetrics(Date fromDate, Date toDate) {
        RegistrationMetrics metrics = new RegistrationMetrics();

        // Completion rates by checkpoint
        metrics.setCheckpoint1CompletionRate(
            calculateCheckpointCompletionRate(1, fromDate, toDate));
        metrics.setCheckpoint2CompletionRate(
            calculateCheckpointCompletionRate(2, fromDate, toDate));
        metrics.setFinalRegistrationCompletionRate(
            calculateFinalRegistrationCompletionRate(fromDate, toDate));

        // Registration funnel analysis
        metrics.setRegistrationFunnelAnalysis(
            calculateRegistrationFunnel(fromDate, toDate));

        // Document upload success rates
        metrics.setDocumentUploadSuccessRates(
            calculateDocumentUploadSuccessRates(fromDate, toDate));

        // Validation error analysis
        metrics.setValidationErrorAnalysis(
            analyzeValidationErrors(fromDate, toDate));

        return metrics;
    }

    private Map<String, Double> analyzeValidationErrors(Date fromDate, Date toDate) {
        // Analyze common validation failures
        // IC format errors, document quality issues, PEP declaration errors, etc.
        return validationErrorDao.getErrorFrequencyAnalysis(fromDate, toDate);
    }
}
```

### Security Monitoring

**Fraud Detection System**:
```java
public class RegistrationFraudDetectionService {

    public FraudRiskScore assessRegistrationRisk(SignUpHistory signUpHistory) {
        FraudRiskScore riskScore = new FraudRiskScore();

        // Check for suspicious patterns
        riskScore.addRiskFactor(checkDuplicateDocuments(signUpHistory));
        riskScore.addRiskFactor(checkSuspiciousPersonalInfo(signUpHistory));
        riskScore.addRiskFactor(checkRegistrationVelocity(signUpHistory));
        riskScore.addRiskFactor(checkDeviceFingerprinting(signUpHistory));

        // Geolocation analysis
        riskScore.addRiskFactor(analyzeRegistrationLocation(signUpHistory));

        // Behavioral analysis
        riskScore.addRiskFactor(analyzeRegistrationBehavior(signUpHistory));

        return riskScore;
    }

    private RiskFactor checkRegistrationVelocity(SignUpHistory signUpHistory) {
        // Check for unusual registration patterns
        // Multiple registrations from same IP/device
        // Rapid successive registrations

        String ipAddress = getCurrentIPAddress();
        long recentRegistrations = signUpHistoryDao.countByIPAddressAndCreatedAtAfter(
            ipAddress, DateUtil.getHoursAgo(24));

        if (recentRegistrations > 5) {
            return RiskFactor.HIGH_VELOCITY_REGISTRATION;
        }

        return RiskFactor.NORMAL;
    }
}
```

This comprehensive documentation provides the new development team with deep insights into the SignUpController's sophisticated user onboarding processes, including multi-checkpoint validation, regulatory compliance, document management, and security frameworks specifically designed for Malaysian financial services requirements.

<function_calls>
<invoke name="TodoWrite">
<parameter name="todos">[{"content": "Analyze SignUpController structure and endpoints", "status": "completed", "activeForm": "Analyzing SignUpController structure and endpoints"}, {"content": "Read SignUpService and related authentication services", "status": "completed", "activeForm": "Reading SignUpService and related authentication services"}, {"content": "Examine user registration and KYC workflows", "status": "completed", "activeForm": "Examining user registration and KYC workflows"}, {"content": "Investigate OTP and verification processes", "status": "completed", "activeForm": "Investigating OTP and verification processes"}, {"content": "Analyze corporate client onboarding flows", "status": "completed", "activeForm": "Analyzing corporate client onboarding flows"}, {"content": "Create comprehensive SignUpController documentation", "status": "completed", "activeForm": "Creating comprehensive SignUpController documentation"}]