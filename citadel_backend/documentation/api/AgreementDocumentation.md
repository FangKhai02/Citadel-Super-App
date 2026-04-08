# Agreement Controller Business Process Documentation

## Overview

The `AgreementController` manages the complete agreement lifecycle in the Citadel system, from onboarding agreements to complex trust fund agreements with multi-party signature workflows. It orchestrates document generation, signature collection, and approval processes for various user types (CLIENT, AGENT, CORPORATE_CLIENT).

## Architecture

- **Controller**: `AgreementController` - REST endpoints for agreement operations
- **Primary Services**:
  - `PdfService` - Document generation and template processing
  - `ProductService` - Business logic for trust fund and redemption agreements
- **Template Engine**: FreeMarker for dynamic document generation
- **Storage**: AWS S3 for document storage and retrieval
- **Authentication**: API key-based session validation

---

## Business Process Overview

### Agreement Types & Workflows

1. **Onboarding Agreement** - User registration and service agreements
2. **Trust Fund Agreement** - Product purchase agreements with dual-party signatures
3. **Early Redemption Agreement** - Product withdrawal with witness requirements
4. **Corporate Second Signee Agreement** - Corporate entity dual-signature process

### Signature Workflow States

```
PENDING → IN_PROGRESS → SUCCESS
                    ↓
                 REJECTED
```

### Multi-Party Signature Process

**Trust Fund Agreements**:
1. Client signs first (`ClientAgreementStatus: SUCCESS`)
2. Agent/Witness signs second (`WitnessAgreementStatus: SUCCESS`)
3. Corporate clients may require second signee (`ClientTwoAgreementStatus`)

---

## API Endpoints Documentation

### 1. Onboarding Agreement API

#### 1.1 Get Onboarding Agreement
**Endpoint**: `POST /api/agreement/onboarding-agreement`
**Parameters**:
- `userType`: CLIENT, AGENT, or CORPORATE_CLIENT
**Request Body**: `OnboardingAgreementReqVo`

**Deep Business Logic Analysis**:

**Template Selection & Processing**:
```java
public AgreementRespVo getPrefilledOnboardingAgreement(UserType userType, OnboardingAgreementReqVo req) {
    // 1. Template Selection Based on User Type
    String templateName = "client_onboarding_agreement_V2.html";
    // Same template used for all user types currently

    // 2. Dynamic Data Population
    HashMap<String, Object> hashMap = new HashMap<>();
    hashMap.put("citadelAdminName", settingDao.findByKey(CITADEL_ADMIN_NAME_SETTING_KEY));
    hashMap.put("citadelCorporateEmail", settingDao.findByKey(CITADEL_ADMIN_EMAIL_SETTING_KEY));
    hashMap.put("serviceAmount", "1000.00"); // Fixed service amount
    hashMap.put("userName", StringUtil.capitalizeEachWord(req.getName()));
    hashMap.put("signedDate", getFormattedDateWithOrdinal(new Date()));

    // 3. Agreement Version Control
    Date agreementUpdatedAt = settingDao.findByKey(CLIENT_ONBOARDING_AGREEMENT_SETTING_KEY)
        .map(Setting::getUpdatedAt)
        .orElse(new Date());
    hashMap.put("agreementUpdatedDate", getFormattedDateWithOrdinal(agreementUpdatedAt));
}
```

**Document Generation Process**:
1. **Template Rendering**: Uses FreeMarker to populate HTML template with user data
2. **PDF Generation**: Converts HTML to PDF using OpenHTMLToPDF library
3. **S3 Storage**: Uploads PDF to user-specific S3 path
4. **URL Generation**: Returns pre-signed URL for document access

**S3 Path Strategy**:
- **CLIENT**: `S3_SIGN_UP_CLIENT_PATH + identityCardNumber`
- **AGENT**: `S3_SIGN_UP_AGENT_PATH + identityCardNumber`
- **CORPORATE_CLIENT**: `S3_CORPORATE_PATH + corporateClientId`
- **Fallback**: Uses "temp" folder if identifier not provided

**Date Formatting Logic**:
```java
public static String getFormattedDateWithOrdinal(Date date) {
    // Creates formatted dates with superscript ordinals
    // Examples: "1<sup>st</sup> January 2024", "23<sup>rd</sup> March 2024"
    // Special handling for 11th, 12th, 13th (always "th")
}
```

**Key Features**:
- Version-controlled agreements using database settings
- Automatic name capitalization for professional appearance
- Temporary file handling with fallback paths
- Base64 encoding for secure file transfer

---

### 2. Trust Fund Agreement APIs

#### 2.1 Get Trust Fund Agreement
**Endpoint**: `GET /api/agreement/trust-fund-agreement`
**Authentication**: API Key required
**Parameters**:
- `orderReferenceNumber`: Product order reference

**Deep Business Logic Analysis**:

**Access Control Logic**:
```java
public Object getTrustFundAgreement(String apiKey, String referenceNumber) {
    // 1. Order Validation
    ProductOrder productOrder = productOrderDao.findByOrderReferenceNumberAndStatusAndStatusApprover(
        referenceNumber,
        ProductOrder.ProductOrderStatus.ACTIVE,
        CmsAdmin.ApproverStatus.APPROVE_APPROVER
    );

    // 2. User-Specific Access Rules
    if (UserType.AGENT.equals(appUser.getUserType())) {
        // Agent can only view if client has already signed
        if (!Status.SUCCESS.equals(productOrder.getClientAgreementStatus())) {
            return emptyResponse(); // Silent denial
        }
        // Agent cannot view if they've already signed
        if (Status.SUCCESS.equals(productOrder.getWitnessAgreementStatus())) {
            return error(AGREEMENT_SIGNED);
        }
    }

    if (UserType.CLIENT.equals(appUser.getUserType())) {
        // Client cannot view if they've already signed
        if (Status.SUCCESS.equals(productOrder.getClientAgreementStatus())) {
            return error(AGREEMENT_SIGNED);
        }
    }
}
```

**Agreement Type Detection**:
```java
// Corporate vs Individual Agreement Selection
String template;
if (productOrder.getCorporateClient() != null) {
    template = pdfService.prefillTrustProductAgreementCorporate(
        userType, productOrder, null, null, null, Boolean.FALSE
    );
} else {
    template = pdfService.prefillTrustProductAgreementIndividual(
        userType, productOrder, null, null, null, Boolean.FALSE
    );
}
```

**Document Storage Strategy**:
- Temporary agreements: `temp/` prefix for preview purposes
- Signed agreements: Permanent storage in product-specific paths
- URL expiration: Pre-signed URLs with time-based access control

#### 2.2 Verify Witness Eligibility
**Endpoint**: `POST /api/agreement/trust-fund-agreement/verification`
**Authentication**: API Key required
**Request Body**: `TrustFundAgreementReqVo`

**Deep Business Logic Analysis**:

**Witness Eligibility Rules**:
```java
private void verifyWitnessEligibility(UserType userType, ProductOrder productOrder, String witnessIdentityCardNumber) {
    if (UserType.AGENT.equals(userType)) {
        // Rule 1: Witness cannot be the client
        String clientIdentityCardNumber = productOrder.getClientIdentityId();
        String formatClientId = clientIdentityCardNumber.replaceAll("-", "");
        String formatWitnessId = witnessIdentityCardNumber.replaceAll("-", "");

        if (formatWitnessId.equals(formatClientId)) {
            throw new GeneralException(INVALID_SIGNER);
        }

        // Rule 2: Witness cannot be any beneficiary
        List<ProductBeneficiaries> beneficiaries = productBeneficiariesDao.findAllByProductOrder(productOrder);
        for (ProductBeneficiaries beneficiary : beneficiaries) {
            // Check individual beneficiaries
            if (beneficiary.getBeneficiary() != null) {
                String beneficiaryId = beneficiary.getBeneficiary().getIdentityCardNumber().replaceAll("-", "");
                if (beneficiaryId.equals(formatWitnessId)) {
                    throw new GeneralException(INVALID_SIGNER);
                }
            }
            // Check corporate beneficiaries
            if (beneficiary.getCorporateBeneficiary() != null) {
                String corpBeneficiaryId = beneficiary.getCorporateBeneficiary().getIdentityCardNumber().replaceAll("-", "");
                if (corpBeneficiaryId.equals(formatWitnessId)) {
                    throw new GeneralException(INVALID_SIGNER);
                }
            }
        }
    }
}
```

**Verification Process**:
1. **Identity Normalization**: Removes dashes from IC numbers for comparison
2. **Conflict Detection**: Prevents conflicts of interest in witnessing
3. **Pre-validation**: Validates before actual signature to prevent errors

#### 2.3 Submit Trust Fund Agreement
**Endpoint**: `POST /api/agreement/trust-fund-agreement`
**Authentication**: API Key required
**Request Body**: `TrustFundAgreementReqVo` (with digital signature)

**Deep Business Logic Analysis**:

**Signature Processing Workflow**:
```java
public Object submitTrustFundAgreement(String apiKey, String orderReferenceNumber, TrustFundAgreementReqVo req) {
    // 1. Re-verify witness eligibility (security measure)
    verifyWitnessEligibility(appUser.getUserType(), productOrder, req.getIdentityCardNumber());

    // 2. Process digital signature
    String fileExtension = getFileTypeFromBase64(req.getDigitalSignature());
    String signatureBase64 = "data:" + fileExtension + ";base64," + req.getDigitalSignature();

    // 3. Generate final signed agreement PDF
    byte[] pdfByte = pdfService.generateTrustProductAgreementPdf(
        userType, productOrder, signatureBase64, req, Boolean.FALSE
    );

    // 4. Store permanent agreement file
    storeTrustFundAgreementFile(productOrder, pdfByte, false);
}
```

**Client Signature Logic**:
```java
if (UserType.CLIENT.equals(appUser.getUserType())) {
    // Extract Base64 signature content
    String digitalSignatureBase64 = signatureBase64.substring(signatureBase64.indexOf(",") + 1);

    // Store signature image separately
    String clientSignatureKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
        .base64String(digitalSignatureBase64)
        .fileName("clientSignature")
        .filePath(S3_PRODUCT_ORDER_PATH + productOrder.getOrderReferenceNumber()));

    // Update product order status
    productOrder.setClientSignatureKey(clientSignatureKey);
    productOrder.setClientSignatureDate(LocalDate.now());
    productOrder.setClientAgreementStatus(Status.SUCCESS);
    productOrder.setClientRole(req.getRole());

    // Check for corporate second signee requirement
    boolean requiresSecondSignee = productOrder.isCorporateClientWithSecondSigneeRequirement();
    if (requiresSecondSignee) {
        productOrder.setClientTwoAgreementStatus(Status.PENDING);
        productOrder.setRemark("Pending 2nd Signee");
    }

    // Notify agent for witness signature
    pushNotificationService.notifyAppUser(
        productOrder.getAgent().getAppUser(),
        "Pending Witness Signature",
        "Client agreement signed - witness signature required",
        new Date(), null, null
    );
}
```

**Agent/Witness Signature Logic**:
```java
if (UserType.AGENT.equals(appUser.getUserType())) {
    // Store witness signature
    String witnessSignatureKey = AwsS3Util.convertAndUploadBase64File(/*...*/);
    productOrder.setWitnessSignatureKey(witnessSignatureKey);
    productOrder.setWitnessSignatureDate(LocalDate.now());
    productOrder.setWitnessAgreementStatus(Status.SUCCESS);
    productOrder.setWitnessName(req.getFullName());

    // Auto-activate if no second signee required
    if (!productOrder.isCorporateClientWithSecondSigneeRequirement()) {
        productOrder.setStatus(ProductOrder.ProductOrderStatus.ACTIVE);
        productOrder.setActivatedDate(LocalDate.now());

        // Trigger commission calculations
        calculateCommissionsAsync(productOrder);

        // Send activation notifications
        emailService.sendProductOrderActivationEmail(productOrder);
        pushNotificationService.notifyClientOfActivation(productOrder);
    }
}
```

**Security Measures**:
- Digital signature redaction in logs for security
- Re-verification of witness eligibility before processing
- Base64 signature validation and format detection
- Separate storage of signature images and agreement documents

---

### 3. Corporate Second Signee Agreement APIs

#### 3.1 Get Second Signee Agreement Link
**Endpoint**: `GET /api/agreement/second-signee-agreement-link`
**Authentication**: API Key required

**Deep Business Logic Analysis**:

**Link Generation Process**:
```java
public Object getSecondSigneeAgreementLink(String apiKey, String orderReferenceNumber) {
    // 1. Validation - same as getTrustFundAgreement
    ProductOrder productOrder = productOrderDao.findByOrderReferenceNumberAndStatusAndStatusApprover(
        orderReferenceNumber, ProductOrder.ProductOrderStatus.ACTIVE, CmsAdmin.ApproverStatus.APPROVE_APPROVER
    );

    // 2. Generate unique identifier for secure access
    String uniqueIdentifier = UUID.randomUUID().toString();

    // 3. Store identifier mapping (temporary access)
    // Implementation would store orderReferenceNumber -> uniqueIdentifier mapping
    // with expiration time for security

    // 4. Return shareable link
    String shareableLink = buildSecondSigneeUrl(uniqueIdentifier);
    return AgreementRespVo.builder().link(shareableLink).build();
}
```

**Security Features**:
- UUID-based unique identifiers prevent URL guessing
- Temporary access links with expiration
- No sensitive data in URLs
- Separate endpoint for HTML content retrieval

#### 3.2 Get Second Signee Agreement HTML
**Endpoint**: `GET /api/agreement/second-signee-agreement`
**Parameters**: `uniqueIdentifier` (no authentication required)

**Deep Business Logic Analysis**:

**Secure Document Retrieval**:
```java
public Object getSecondSigneeAgreementHtml(String uniqueIdentifier) {
    // 1. Resolve unique identifier to order reference
    String orderReferenceNumber = resolveUniqueIdentifier(uniqueIdentifier);

    // 2. Validate identifier hasn't expired
    validateIdentifierExpiration(uniqueIdentifier);

    // 3. Generate agreement HTML for second signee
    ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(orderReferenceNumber);

    // 4. Corporate-specific template rendering
    String htmlContent = pdfService.generateSecondSigneeAgreementHtml(productOrder);

    return SecondSigneeAgreementRespVo.builder()
        .htmlContent(htmlContent)
        .corporateClientName(productOrder.getCorporateClient().getCorporateClientName())
        .build();
}
```

**Template Customization**:
- Corporate client-specific branding
- Pre-filled corporate information
- Second signee role designation
- Simplified signature workflow

#### 3.3 Submit Second Signee Agreement
**Endpoint**: `POST /api/agreement/second-signee-agreement`
**Request Body**: `ClientTwoSignatureReqVo`

**Deep Business Logic Analysis**:

**Second Signee Processing**:
```java
public Object submitSecondSigneeAgreement(ClientTwoSignatureReqVo request) {
    // 1. Resolve order from unique identifier
    ProductOrder productOrder = resolveProductOrderFromRequest(request);

    // 2. Validate second signee requirements
    validateSecondSigneeEligibility(productOrder, request);

    // 3. Process second signature
    String signatureBase64 = processSecondSigneeSignature(request.getDigitalSignature());

    // 4. Update order status
    productOrder.setClientTwoSignatureKey(signatureBase64);
    productOrder.setClientTwoSignatureDate(LocalDate.now());
    productOrder.setClientTwoAgreementStatus(Status.SUCCESS);
    productOrder.setSecondSigneeName(request.getFullName());
    productOrder.setSecondSigneeRole(request.getRole());

    // 5. Check if all signatures complete
    if (allSignaturesComplete(productOrder)) {
        activateProductOrder(productOrder);
    }

    return new SecondSigneeAgreementRespVo("Agreement signed successfully");
}
```

**Activation Criteria**:
- Client signature: SUCCESS
- Witness signature: SUCCESS
- Second signee signature: SUCCESS (for applicable entities)
- All validations passed

---

### 4. Early Redemption Agreement APIs

#### 4.1 Get Early Redemption Agreement
**Endpoint**: `GET /api/agreement/early-redemption-agreement`
**Authentication**: API Key required
**Parameters**: `redemptionReferenceNumber`

**Deep Business Logic Analysis**:

**Redemption Agreement Access Logic**:
```java
public Object getEarlyRedemptionAgreement(String apiKey, String redemptionReferenceNumber) {
    // 1. Fetch redemption record
    ProductEarlyRedemptionHistory earlyRedemptionHistory =
        productEarlyRedemptionHistoryDao.findByRedemptionReferenceNumber(redemptionReferenceNumber);

    // 2. User-specific access control
    if (UserType.AGENT.equals(appUser.getUserType())) {
        // Agent can only view after client signs
        if (!Status.SUCCESS.equals(earlyRedemptionHistory.getClientSignatureStatus())) {
            return emptyResponse();
        }
        // Agent cannot re-sign
        if (Status.SUCCESS.equals(earlyRedemptionHistory.getWitnessSignatureStatus())) {
            return error(AGREEMENT_SIGNED);
        }
    }

    if (UserType.CLIENT.equals(appUser.getUserType())) {
        // Client cannot re-sign
        if (Status.SUCCESS.equals(earlyRedemptionHistory.getClientSignatureStatus())) {
            return error(AGREEMENT_SIGNED);
        }
    }

    // 3. Generate withdrawal-specific agreement
    String template = pdfService.prefillWithdrawalAgreement(
        userType, earlyRedemptionHistory, null, null
    );

    return AgreementRespVo.builder()
        .html(template)
        .link(generateTempAgreementUrl())
        .build();
}
```

**Withdrawal Agreement Features**:
- Product-specific withdrawal terms
- Penalty calculations if applicable
- Beneficiary notification requirements
- Settlement instructions

#### 4.2 Submit Early Redemption Agreement
**Endpoint**: `POST /api/agreement/early-redemption-agreement`
**Authentication**: API Key required
**Request Body**: `WithdrawalAgreementReqVo`

**Deep Business Logic Analysis**:

**Redemption Signature Workflow**:
```java
public Object submitEarlyRedemptionAgreement(String apiKey, String redemptionReferenceNumber, WithdrawalAgreementReqVo req) {
    // 1. Fetch related entities
    ProductEarlyRedemptionHistory earlyRedemptionHistory = /*...*/;
    ProductOrder productOrder = /*...*/;

    // 2. Agent witness validation (same as trust fund)
    if (UserType.AGENT.equals(appUser.getUserType())) {
        validateWitnessEligibility(productOrder, req.getIdentityCardNumber());
        witnessName = StringUtil.isNotEmpty(req.getFullName()) ?
            req.getFullName() : productOrder.getAgent().getUserDetail().getName();
    }

    // 3. Generate signed withdrawal agreement
    String signatureBase64 = processDigitalSignature(req.getDigitalSignature());
    byte[] pdfByte = pdfService.generateWithdrawalAgreementPdf(
        userType, earlyRedemptionHistory, signatureBase64, witnessName
    );

    // 4. Client signature processing
    if (UserType.CLIENT.equals(appUser.getUserType())) {
        earlyRedemptionHistory.setClientSignatureStatus(Status.SUCCESS);
        earlyRedemptionHistory.setClientSignatureDate(LocalDate.now());

        // Notify agent for witness signature
        pushNotificationService.notifyAppUser(
            earlyRedemptionHistory.getAgent().getAppUser(),
            "Pending Witness Signature",
            "Need your signature! One of your clients has submitted an early redemption request.",
            new Date(), null, null
        );
    }

    // 5. Agent signature processing
    if (UserType.AGENT.equals(appUser.getUserType())) {
        earlyRedemptionHistory.setWitnessSignatureStatus(Status.SUCCESS);
        earlyRedemptionHistory.setStatus(Status.IN_REVIEW);
        earlyRedemptionHistory.setStatusChecker(CmsAdmin.CheckerStatus.PENDING_CHECKER);
        earlyRedemptionHistory.setStatusApprover(CmsAdmin.ApproverStatus.PENDING_APPROVER);

        // Send email to admin for processing
        emailService.sendWithdrawalRequestEmailToAdmin(earlyRedemptionHistory);
    }
}
```

**Redemption Workflow States**:
1. **Client Initiates**: Creates redemption request
2. **Client Signs**: Agreement signature required
3. **Agent Witnesses**: Witness signature required
4. **Admin Review**: Checker/Approver workflow
5. **Processing**: Fund disbursement
6. **Completion**: Final status update

---

## Deep Technical Implementation Analysis

### Template Engine Architecture

**FreeMarker Integration**:
```java
@Service
public class PdfService {
    @Resource
    private Configuration freeMakerConfiguration;

    public String renderTemplate(String templateName, HashMap<String, Object> hashMap) throws Exception {
        Template template = freeMakerConfiguration.getTemplate(templateName);
        return FreeMarkerTemplateUtils.processTemplateIntoString(template, hashMap);
    }

    public String renderHtmlTemplateFromString(String htmlContent, Map<String, Object> model) {
        // Dynamic template creation from S3-stored content
        Template temp = new Template("templateFromS3", new StringReader(htmlContent), freeMakerConfiguration);
        return FreeMarkerTemplateUtils.processTemplateIntoString(temp, model);
    }
}
```

**Template Types & Locations**:
- **Static Templates**: Stored in application resources
- **Dynamic Templates**: Retrieved from S3 for customization
- **Agreement Templates**: Version-controlled with database settings

### Document Generation Pipeline

**PDF Generation Process**:
```java
public byte[] generatePdf(String renderedTemplate) {
    try (ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
        // 1. Sanitize HTML content
        renderedTemplate = StringUtil.sanitizeFullHtml(renderedTemplate);

        // 2. Configure PDF renderer
        PdfRendererBuilder builder = new PdfRendererBuilder();
        builder.useFastMode(); // Performance optimization
        builder.withHtmlContent(renderedTemplate, null);
        builder.toStream(outputStream);

        // 3. Generate PDF
        builder.run();
        return outputStream.toByteArray();
    } catch (Exception e) {
        throw new RuntimeException("Failed to generate PDF", e);
    }
}
```

**Performance Optimizations**:
- Fast mode rendering for improved performance
- Stream-based processing to minimize memory usage
- HTML sanitization for security and compatibility

### Digital Signature Processing

**Signature Validation & Storage**:
```java
private String processDigitalSignature(String digitalSignature) {
    // 1. Detect file type from Base64 content
    String fileExtension = getFileTypeFromBase64(digitalSignature);

    // 2. Create data URL format for embedding
    String signatureBase64 = "data:" + fileExtension + ";base64," + digitalSignature;

    // 3. Extract clean Base64 for storage
    String cleanBase64 = digitalSignature;
    if (signatureBase64.contains(",")) {
        cleanBase64 = signatureBase64.substring(signatureBase64.indexOf(",") + 1);
    }

    // 4. Upload to S3 with proper naming
    String signatureKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
        .base64String(cleanBase64)
        .fileName("signature")
        .filePath(generateSignaturePath()));

    return signatureKey;
}
```

**Signature Security Measures**:
- Base64 validation and format detection
- Separate storage from agreement documents
- Audit trail with signature timestamps
- Log redaction for sensitive signature data

### Database Transaction Management

**Agreement Status Updates**:
```java
@Transactional
public Object submitTrustFundAgreement(String apiKey, String orderReferenceNumber, TrustFundAgreementReqVo req) {
    // Transactional boundaries ensure:
    // 1. Agreement status consistency
    // 2. Signature storage atomicity
    // 3. Notification reliability
    // 4. Rollback on any failure
}
```

**Status Consistency Rules**:
- Atomic updates for multi-field status changes
- Validation before status transitions
- Audit trail maintenance
- Notification sending within transactions

### File Storage Architecture

**S3 Storage Strategy**:
```java
// Path Structure:
// /{environment}/client/{identityNumber}/agreements/{type}_{timestamp}.pdf
// /{environment}/agent/{agentId}/witness_signatures/{orderRef}_signature.png
// /{environment}/corporate/{corporateId}/second_signee/{orderRef}.pdf

private String generateStoragePath(UserType userType, String identifier, String documentType) {
    return switch (userType) {
        case CLIENT -> S3_CLIENT_PATH + identifier + "/agreements/";
        case AGENT -> S3_AGENT_PATH + identifier + "/signatures/";
        case CORPORATE_CLIENT -> S3_CORPORATE_PATH + identifier + "/agreements/";
    };
}
```

**File Naming Conventions**:
- Timestamp-based naming for versions
- Document type prefixes for organization
- Reference number inclusion for traceability
- Extension-based type identification

### Notification & Communication

**Multi-Channel Notifications**:
```java
private void sendAgreementNotifications(ProductOrder productOrder, String eventType) {
    switch (eventType) {
        case "CLIENT_SIGNED":
            // Notify agent for witness signature
            pushNotificationService.notifyAppUser(
                productOrder.getAgent().getAppUser(),
                "Pending Witness Signature",
                generateNotificationMessage(productOrder),
                new Date(), null, null
            );
            break;

        case "WITNESS_SIGNED":
            // Notify client of activation
            pushNotificationService.notifyAppUser(
                productOrder.getClient().getAppUser(),
                "Product Activated",
                "Your investment is now active and earning returns",
                new Date(), null, null
            );

            // Email admin for record keeping
            emailService.sendProductActivationNotificationToAdmin(productOrder);
            break;
    }
}
```

**Communication Channels**:
- Push notifications for real-time alerts
- Email notifications for formal communication
- SMS notifications for critical updates (if configured)
- In-app notifications for status updates

---

## Business Rules & Validation

### Signature Eligibility Rules

**Witness Validation**:
1. Witness cannot be the client
2. Witness cannot be any beneficiary (individual or corporate)
3. Identity card format normalization (remove dashes)
4. Cross-validation with all related parties

**Corporate Signee Requirements**:
- Private Limited companies require dual signatures
- Public Limited companies require dual signatures
- Sole proprietorships and partnerships single signature
- Director-level authorization requirements

### Agreement Access Control

**Viewing Restrictions**:
- Clients can view before signing, not after
- Agents can view only after client signature
- No re-signing allowed once status is SUCCESS
- Empty responses for unauthorized access (security by obscurity)

**Document Security**:
- Unique identifiers for shareable links
- Time-based expiration for temporary access
- No sensitive data in URLs
- Separate authentication for different document types

### Status Transition Rules

**Trust Fund Agreement Flow**:
```
PENDING_CLIENT → CLIENT_SIGNED → WITNESS_SIGNED → ACTIVE
                                      ↓
                                 (if corporate)
                                PENDING_SECOND_SIGNEE → ACTIVE
```

**Early Redemption Flow**:
```
REQUEST_CREATED → CLIENT_SIGNED → WITNESS_SIGNED → IN_REVIEW → PROCESSED
```

### Validation Error Handling

**Common Validation Errors**:
- `INVALID_SIGNER`: Witness eligibility violations
- `AGREEMENT_SIGNED`: Duplicate signature attempts
- `PRODUCT_ORDER_NOT_FOUND`: Invalid reference numbers
- `EARLY_REDEMPTION_NOT_FOUND`: Invalid redemption requests

**Error Response Strategy**:
- Silent failures for unauthorized access
- Descriptive errors for validation failures
- Exception-based error handling with rollback
- Audit logging for all error scenarios

---

## Performance & Scalability

### Caching Strategy

**Template Caching**:
- FreeMarker template compilation cache
- S3 content caching for dynamic templates
- Pre-compiled PDF generation templates

**Document Generation Optimization**:
- Asynchronous PDF generation for large documents
- Stream-based processing for memory efficiency
- Fast mode rendering for improved performance

### Database Performance

**Query Optimization**:
- Indexed lookups for reference numbers
- Eager loading for related entities in agreement generation
- Batch processing for bulk operations

**Transaction Management**:
- Minimal transaction scopes
- Read-only transactions for document retrieval
- Proper isolation levels for concurrent operations

### Scalability Considerations

**Horizontal Scaling**:
- Stateless service design
- S3-based document storage
- Database connection pooling
- Load balancer compatibility

**Resource Management**:
- Memory-efficient PDF generation
- Connection pool optimization
- Garbage collection tuning for document processing

---

## Security Considerations

### Data Protection

**Sensitive Data Handling**:
- Digital signature redaction in logs
- Encrypted storage for signature files
- Access logging for audit trails
- PII masking in error messages

**Access Control**:
- API key validation for all operations
- Role-based document access
- Session-based authentication
- Rate limiting for document generation

### Compliance & Audit

**Audit Trail Requirements**:
- Complete signature workflow logging
- Document version tracking
- Access attempt logging
- Compliance reporting capabilities

**Regulatory Compliance**:
- Digital signature legal validity
- Document retention policies
- Privacy regulation compliance
- Cross-border data transfer restrictions

---

## Monitoring & Maintenance

### Key Metrics

**Business Metrics**:
- Agreement completion rates by type
- Average signature time per agreement
- Error rates by validation type
- Document generation performance

**Technical Metrics**:
- PDF generation latency
- S3 upload/download performance
- Database query performance
- Memory usage during document processing

### Error Monitoring

**Critical Error Alerts**:
- PDF generation failures
- S3 storage failures
- Database transaction failures
- Notification delivery failures

**Performance Monitoring**:
- Response time thresholds
- Memory usage patterns
- File size distribution
- Concurrent user handling

---

## Development Guidelines

### Testing Strategy

**Unit Testing Requirements**:
- Agreement business logic validation
- PDF generation functionality
- Signature processing workflows
- Error handling scenarios

**Integration Testing**:
- End-to-end signature workflows
- S3 storage operations
- Notification delivery
- Database transaction integrity

### Deployment Considerations

**Environment Configuration**:
- S3 bucket setup per environment
- Template deployment strategy
- Database migration scripts
- Configuration externalization

**Rollback Strategy**:
- Agreement template versioning
- Database schema compatibility
- S3 content rollback procedures
- Service deployment rollback

This comprehensive documentation provides the new development team with deep insights into the AgreementController's business processes, technical implementation, and operational considerations. The detailed analysis of service layer logic ensures thorough understanding of the complex agreement workflows and signature processes.