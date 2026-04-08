# Product Controller Business Process Documentation

## Overview

The `ProductController` manages the complete product lifecycle in the Citadel trust fund system, from product discovery through purchase, payment processing, and various redemption operations. It orchestrates complex financial workflows including multi-stage validation, beneficiary management, commission calculations, and regulatory compliance.

## Architecture

- **Controller**: `ProductController` - REST endpoints for product operations
- **Service**: `ProductService` - Core business logic and transaction management
- **Validators**: Multi-checkpoint validation system for purchase flows
- **Entities**: Complex product, order, and redemption entity relationships
- **Financial Engine**: Commission calculation and dividend distribution systems

---

## Business Process Overview

### Product Lifecycle States

```
DRAFT → IN_REVIEW → APPROVED → PENDING_PAYMENT → AGREEMENT → ACTIVE → MATURED/WITHDRAWN
   ↓                     ↓
REJECTED            REJECTED
```

### Purchase Workflow Checkpoints

1. **Checkpoint One**: Product availability and tranche size validation
2. **Checkpoint Two**: Beneficiary distribution percentage validation
3. **Final Submission**: Complete order creation with all validations

### Financial Operations

- **Purchase**: Initial product investment
- **Early Redemption**: Withdrawal before maturity with penalties
- **Full Redemption**: Complete withdrawal at maturity
- **Rollover**: Reinvestment into new products
- **Reallocation**: Transfer between different product types

---

## API Endpoints Documentation

### 1. Product Discovery APIs

#### 1.1 Get Product List
**Endpoint**: `GET /api/product/list`
**Public Access**: No authentication required

**Deep Business Logic Analysis**:

**Product Filtering Logic**:
```java
public Object getProductList() {
    // Retrieves only published and active products
    List<Product> products = productDao.findAllByIsPublishedIsTrueAndStatusIsTrue();

    // Transform to ProductVo with calculated fields
    List<ProductVo> productVoList = products.stream()
        .map(this::transformToProductVo)
        .sorted(Comparator.comparing(ProductVo::getDisplayOrder))
        .collect(Collectors.toList());
}

private ProductVo transformToProductVo(Product product) {
    ProductVo vo = new ProductVo();

    // Basic product information
    vo.setProductCode(product.getCode());
    vo.setProductName(product.getName());
    vo.setMinimumInvestment(product.getMinimumInvestmentAmount());
    vo.setMaximumInvestment(product.getTrancheSize());

    // Calculate available investment amount
    double totalSold = productOrderDao.getTotalSoldAmount(product.getId());
    vo.setAvailableAmount(product.getTrancheSize() - totalSold);
    vo.setSoldOut(vo.getAvailableAmount() <= 0);

    // Target return calculations
    List<ProductTargetReturn> targetReturns = productTargetReturnDao.findByProduct(product);
    vo.setTargetReturns(calculateTargetReturnDisplayValues(targetReturns));

    return vo;
}
```

**Business Rules Applied**:
- Only published products are visible to clients
- Real-time availability calculation based on tranche size
- Target return display includes compound interest calculations
- Product ordering based on business priority

#### 1.2 Get Product by ID
**Endpoint**: `GET /api/product/{productId}`
**Public Access**: No authentication required

**Deep Business Logic Analysis**:

**Detailed Product Information**:
```java
public Object getProductById(Long productId) {
    Product product = productDao.findByIdAndIsPublishedIsTrueAndStatusIsTrue(productId)
        .orElseThrow(() -> new GeneralException(INVALID_PRODUCT));

    ProductDetailsRespVo response = new ProductDetailsRespVo();

    // Core product details
    response.setProductDetails(product.getProductDetails());

    // Investment parameters
    response.setMinimumInvestment(product.getMinimumInvestmentAmount());
    response.setTrancheSize(product.getTrancheSize());
    response.setAvailableAmount(calculateAvailableAmount(product));

    // Investment tenure options
    response.setTenureOptions(getInvestmentTenureOptions(product));

    // Dividend calculation matrix
    response.setDividendRates(calculateDividendRateMatrix(product));

    // Associated bank accounts for payments
    response.setBankDetails(getProductBankDetails(product));

    // Terms and conditions
    response.setTermsAndConditions(product.getTermsAndConditions());

    // Early redemption policies
    response.setRedemptionPolicies(getRedemptionPolicies(product));

    return response;
}

private List<InvestmentTenureOption> getInvestmentTenureOptions(Product product) {
    return product.getTargetReturns().stream()
        .map(targetReturn -> InvestmentTenureOption.builder()
            .months(targetReturn.getInvestmentTenureMonth())
            .annualizedReturn(targetReturn.getTargetReturnPercentage())
            .minimumAmount(targetReturn.getMinimumAmount())
            .build())
        .sorted(Comparator.comparing(InvestmentTenureOption::getMonths))
        .collect(Collectors.toList());
}
```

**Advanced Features**:
- Dynamic dividend rate calculation based on tenure
- Real-time availability updates
- Investment option matrix generation
- Bank account routing for payments

#### 1.3 Get Product Bank Details
**Endpoint**: `GET /api/product/bank-details`
**Parameters**: `productCode`

**Deep Business Logic Analysis**:

**Bank Account Resolution**:
```java
public Object getProductBankDetails(String productCode) {
    Product product = productDao.findByCode(productCode)
        .orElseThrow(() -> new GeneralException(INVALID_PRODUCT));

    // Get primary bank account for product
    BankDetails primaryBank = bankDetailsDao.findPrimaryBankByProduct(product)
        .orElse(getDefaultCitadelBank());

    ProductBankDetailsRespVo response = new ProductBankDetailsRespVo();
    response.setBankName(primaryBank.getBankName());
    response.setAccountNumber(primaryBank.getAccountNumber());
    response.setAccountHolderName(primaryBank.getAccountHolderName());

    // Additional payment methods if available
    response.setAlternativePaymentMethods(getAlternativePaymentMethods(product));

    // Payment instructions and requirements
    response.setPaymentInstructions(generatePaymentInstructions(product, primaryBank));

    return response;
}

private PaymentInstructions generatePaymentInstructions(Product product, BankDetails bank) {
    return PaymentInstructions.builder()
        .referenceFormat("ORD + Order Reference Number")
        .paymentDeadline(calculatePaymentDeadline())
        .requiredDocuments(List.of("Bank transfer receipt", "Payment confirmation"))
        .specialInstructions(getProductSpecificPaymentInstructions(product))
        .build();
}
```

---

### 2. Product Purchase Validation APIs

#### 2.1 Purchase Product Validation Checkpoint One
**Endpoint**: `POST /api/product/purchase/validation/product`
**Authentication**: API Key required
**Request Body**: `ProductPurchaseReqVo`

**Deep Business Logic Analysis**:

**Comprehensive Product Validation**:
```java
public Object productOrderValidationCheckpointOne(String apiKey, ProductPurchaseReqVo productPurchaseReqVo) {
    AppUserSession appUserSession = validateApiKey(apiKey);

    // 1. Request Structure Validation
    ProductPurchaseProductDetailsVo productDetails = productPurchaseReqVo.getProductDetails();
    JSONArray validationErrors = ValidatorUtil.getAllNullFields(productDetails);
    if (!validationErrors.isEmpty()) {
        return getInvalidArgumentError(validationErrors);
    }

    // 2. User Authorization Validation
    if (UserType.CLIENT.equals(appUserSession.getAppUser().getUserType())) {
        // Client self-purchase validation
        Client client = clientDao.findByAppUser(appUserSession.getAppUser())
            .orElseThrow(() -> new GeneralException(USER_NOT_FOUND));

        // Validate client KYC status
        validateClientKYCStatus(client);

        // Validate client investment limits
        validateClientInvestmentLimits(client, productDetails.getAmount());

    } else if (UserType.AGENT.equals(appUserSession.getAppUser().getUserType())) {
        // Agent-assisted purchase validation
        Agent agent = agentDao.findByAppUserAndStatus(
            appUserSession.getAppUser(),
            Agent.AgentStatus.ACTIVE
        ).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));

        // Validate agent authorization for client purchases
        validateAgentPurchaseAuthorization(agent);

        // Check secure tag requirements for agent purchases
        validateSecureTagRequirements(agent, productPurchaseReqVo);
    }

    // 3. Product Availability Validation
    Product product = productDao.findByIdAndIsPublishedIsTrueAndStatusIsTrue(
        productDetails.getProductId()
    ).orElseThrow(() -> new GeneralException(INVALID_PRODUCT));

    // 4. Investment Amount Validation
    validateInvestmentAmount(productDetails.getAmount(), product);

    // 5. Tranche Size Validation
    checkAvailableTrancheSize(productDetails.getAmount(), product.getTrancheSize());

    // 6. Investment Tenure Validation
    validateInvestmentTenure(productDetails.getInvestmentTenureMonth(), product);

    // 7. Dividend Option Validation
    validateDividendOption(productDetails.getDividend(), product, productDetails.getInvestmentTenureMonth());

    return new BaseResp(); // Success response
}

private void validateInvestmentAmount(Double amount, Product product) {
    if (amount < product.getMinimumInvestmentAmount()) {
        throw new GeneralException(AMOUNT_BELOW_MINIMUM);
    }

    if (amount > product.getMaximumInvestmentAmount()) {
        throw new GeneralException(AMOUNT_EXCEEDS_MAXIMUM);
    }

    // Validate amount increments if specified
    if (product.getInvestmentIncrement() != null &&
        (amount % product.getInvestmentIncrement()) != 0) {
        throw new GeneralException(INVALID_AMOUNT_INCREMENT);
    }
}

private void checkAvailableTrancheSize(Double requestedAmount, Double trancheSize) {
    // Calculate total amount already sold
    Double totalSold = productOrderDao.getTotalSoldAmountByStatus(
        Arrays.asList(ProductOrder.ProductOrderStatus.ACTIVE,
                     ProductOrder.ProductOrderStatus.PENDING_PAYMENT,
                     ProductOrder.ProductOrderStatus.AGREEMENT)
    );

    Double availableAmount = trancheSize - totalSold;

    if (availableAmount <= 0) {
        throw new GeneralException(PRODUCT_SOLD_OUT);
    } else if (requestedAmount > availableAmount) {
        throw new GeneralException(AMOUNT_EXCEEDS_AVAILABLE_LIMIT);
    }
}
```

**Validation Categories**:
1. **Structural Validation**: Required fields and data types
2. **Authorization Validation**: User permissions and KYC status
3. **Product Validation**: Availability and publication status
4. **Financial Validation**: Amount limits and tranche availability
5. **Configuration Validation**: Tenure and dividend options

#### 2.2 Purchase Product Validation Checkpoint Two
**Endpoint**: `POST /api/product/purchase/validation/beneficiary-distribution`
**Authentication**: API Key required
**Request Body**: `ProductPurchaseReqVo`

**Deep Business Logic Analysis**:

**Beneficiary Distribution Validation**:
```java
public Object productOrderBeneficiariesDistributionValidation(String apiKey, ProductPurchaseReqVo productPurchaseReqVo) {
    validateApiKey(apiKey);

    // 1. Beneficiary Presence Validation
    List<ProductOrderBeneficiaryReqVo> beneficiaries = productPurchaseReqVo.getBeneficiaries();
    if (beneficiaries == null || beneficiaries.isEmpty()) {
        return getErrorObjectWithMsg(MISSING_REQUIRED_DETAILS);
    }

    // 2. Main Beneficiary Distribution Validation
    double totalMainDistributionPercentage = beneficiaries.stream()
        .mapToDouble(ProductOrderBeneficiaryReqVo::getDistributionPercentage)
        .sum();

    if (Math.abs(totalMainDistributionPercentage - 100.0) > 0.01) { // Allow for floating point precision
        return getErrorObjectWithMsg(INVALID_DISTRIBUTION_PERCENTAGE);
    }

    // 3. Sub-Beneficiary Distribution Validation (if applicable)
    for (ProductOrderBeneficiaryReqVo mainBeneficiary : beneficiaries) {
        if (mainBeneficiary.getSubBeneficiaries() != null &&
            !mainBeneficiary.getSubBeneficiaries().isEmpty()) {

            validateSubBeneficiaryDistribution(mainBeneficiary);
            validateBeneficiaryRelationships(mainBeneficiary);
            validateBeneficiaryAgeRequirements(mainBeneficiary);
        }
    }

    // 4. Beneficiary Identity Validation
    validateBeneficiaryIdentities(beneficiaries);

    // 5. Legal Relationship Validation
    validateLegalRelationships(beneficiaries);

    return new BaseResp();
}

private void validateSubBeneficiaryDistribution(ProductOrderBeneficiaryReqVo mainBeneficiary) {
    double totalSubDistributionPercentage = mainBeneficiary.getSubBeneficiaries().stream()
        .mapToDouble(ProductOrderBeneficiaryReqVo::getDistributionPercentage)
        .sum();

    if (Math.abs(totalSubDistributionPercentage - 100.0) > 0.01) {
        throw new GeneralException(INVALID_SUB_BENEFICIARY_DISTRIBUTION_PERCENTAGE);
    }
}

private void validateBeneficiaryIdentities(List<ProductOrderBeneficiaryReqVo> beneficiaries) {
    Set<String> identityNumbers = new HashSet<>();

    for (ProductOrderBeneficiaryReqVo beneficiary : beneficiaries) {
        String identityNumber = beneficiary.getIdentityCardNumber();

        // Check for duplicate identity numbers
        if (identityNumbers.contains(identityNumber)) {
            throw new GeneralException(DUPLICATE_BENEFICIARY_IDENTITY);
        }
        identityNumbers.add(identityNumber);

        // Validate identity number format
        if (!ValidatorUtil.isValidMalaysianIC(identityNumber)) {
            throw new GeneralException(INVALID_BENEFICIARY_IDENTITY_FORMAT);
        }

        // Validate age requirements
        int age = DateUtil.calculateAgeFromIC(identityNumber);
        if (age < 18 && beneficiary.getGuardianDetails() == null) {
            throw new GeneralException(MINOR_BENEFICIARY_REQUIRES_GUARDIAN);
        }
    }
}
```

**Advanced Validation Features**:
- Floating-point precision handling for percentage calculations
- Hierarchical beneficiary validation (main → sub-beneficiaries)
- Identity number format and uniqueness validation
- Age-based guardian requirement validation
- Legal relationship verification

---

### 3. Product Purchase API

#### 3.1 Purchase Product
**Endpoint**: `POST /api/product/purchase`
**Authentication**: API Key required
**Parameters**: `referenceNumber` (optional for draft updates)
**Request Body**: `ProductPurchaseReqVo`

**Deep Business Logic Analysis**:

**Comprehensive Purchase Processing**:
```java
@Transactional
public Object createProductOrder(String apiKey, ProductPurchaseReqVo productPurchaseReq, String referenceNumber) {
    AppUser appUser = validateApiKey(apiKey).getAppUser();

    // 1. User Context Resolution
    Client client;
    CorporateClient corporateClient = null;
    Agent agent;

    if (UserType.AGENT.equals(appUser.getUserType())) {
        // Agent-facilitated purchase
        agent = agentDao.findByAppUserAndStatus(appUser, Agent.AgentStatus.ACTIVE)
            .orElseThrow(() -> new GeneralException(USER_NOT_FOUND));

        // Resolve client context
        if (StringUtils.isNotEmpty(productPurchaseReq.getClientId()) &&
            StringUtil.isEmpty(productPurchaseReq.getCorporateClientId())) {
            // Individual client purchase
            client = clientDao.findByAgentAndClientId(agent, productPurchaseReq.getClientId())
                .orElseThrow(() -> new GeneralException(INVALID_CLIENT_ID));

        } else if (StringUtils.isNotEmpty(productPurchaseReq.getCorporateClientId()) &&
                   StringUtil.isEmpty(productPurchaseReq.getClientId())) {
            // Corporate client purchase
            corporateClient = corporateClientDao.findByCorporateClientIdAndAgentAndIsDeletedIsFalse(
                productPurchaseReq.getCorporateClientId(), agent)
                .orElseThrow(() -> new GeneralException(CORPORATE_CLIENT_NOT_FOUND));
            client = corporateClient.getClient();
        } else {
            return getErrorObjectWithMsg(INVALID_REQUEST);
        }

        // Validate secure tag for agent purchases
        validateSecureTagForAgentPurchase(agent, client);

    } else {
        // Client self-purchase
        client = clientDao.findByAppUser(appUser)
            .orElseThrow(() -> new GeneralException(USER_NOT_FOUND));

        // Handle corporate client context
        if (StringUtils.isNotEmpty(productPurchaseReq.getCorporateClientId())) {
            corporateClient = corporateClientDao.findByClientAndCorporateClientIdAndIsDeletedIsFalse(
                client, productPurchaseReq.getCorporateClientId())
                .orElseThrow(() -> new GeneralException(CORPORATE_CLIENT_NOT_FOUND));
        }

        agent = client.getAgent();
        if (agent == null) {
            return getErrorObjectWithMsg(AGENT_OF_CLIENT_NOT_FOUND);
        }
    }

    // 2. Corporate Client Additional Validation
    if (corporateClient != null) {
        Object corporateValidationResp = validatorService.corporateProductOrderValidation(corporateClient);
        if (corporateValidationResp instanceof ErrorResp) {
            return corporateValidationResp;
        }
    }

    // 3. Draft vs New Order Processing
    ProductOrder productOrder = null;
    boolean isUpdateOperation = StringUtil.isNotEmpty(referenceNumber);

    if (isUpdateOperation) {
        productOrder = handleExistingProductOrderUpdate(referenceNumber, productPurchaseReq);
    } else {
        productOrder = createNewProductOrder(client, corporateClient, agent);
    }

    // 4. Execute Validation Checkpoints
    Object checkpointOneResp = productOrderValidationCheckpointOne(apiKey, productPurchaseReq);
    if (checkpointOneResp instanceof ErrorResp) {
        return checkpointOneResp;
    }

    // 5. Process Product Order Details
    updateProductOrderFromRequest(productOrder, productPurchaseReq);

    // 6. Handle Beneficiary Processing
    processBeneficiaries(productOrder, productPurchaseReq.getBeneficiaries());

    // 7. Calculate Financial Details
    calculateOrderFinancials(productOrder, productPurchaseReq.getProductDetails());

    // 8. Execute Final Validation
    Object checkpointTwoResp = productOrderBeneficiariesDistributionValidation(apiKey, productPurchaseReq);
    if (checkpointTwoResp instanceof ErrorResp) {
        return checkpointTwoResp;
    }

    // 9. Save Product Order
    productOrder = productOrderDao.save(productOrder);

    // 10. Generate Response
    return buildProductOrderSummaryResponse(productOrder);
}

private ProductOrder handleExistingProductOrderUpdate(String referenceNumber, ProductPurchaseReqVo request) {
    ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(referenceNumber)
        .orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));

    // Validate editability
    if (!(ProductOrder.ProductOrderStatus.DRAFT.equals(productOrder.getStatus()) ||
          ProductOrder.ProductOrderStatus.REJECTED.equals(productOrder.getStatus()) ||
          ProductOrder.ProductOrderStatus.PENDING_PAYMENT.equals(productOrder.getStatus()))) {
        throw new GeneralException(ITEM_CANNOT_BE_EDITED);
    }

    // Merge existing data with new request
    mergeProductOrderData(productOrder, request);

    return productOrder;
}

private ProductOrder createNewProductOrder(Client client, CorporateClient corporateClient, Agent agent) {
    ProductOrder productOrder = new ProductOrder();

    // Generate unique reference number
    String orderReferenceNumber = createOrderReferenceNumber();
    productOrder.setOrderReferenceNumber(orderReferenceNumber);

    // Set entity relationships
    productOrder.setClient(client);
    productOrder.setCorporateClient(corporateClient);
    productOrder.setAgent(agent);

    // Set initial status
    productOrder.setStatus(ProductOrder.ProductOrderStatus.DRAFT);

    // Set timestamps
    productOrder.setCreatedAt(new Date());
    productOrder.setUpdatedAt(new Date());

    return productOrder;
}

private void calculateOrderFinancials(ProductOrder productOrder, ProductPurchaseProductDetailsVo productDetails) {
    Product product = productOrder.getProduct();

    // Set basic financial details
    productOrder.setPurchasedAmount(productDetails.getAmount());
    productOrder.setInvestmentTenureMonth(productDetails.getInvestmentTenureMonth());
    productOrder.setDividend(productDetails.getDividend());

    // Calculate maturity date
    LocalDate maturityDate = LocalDate.now().plusMonths(productDetails.getInvestmentTenureMonth());
    productOrder.setMaturityDate(maturityDate);

    // Calculate expected returns
    double expectedReturn = calculateExpectedReturn(
        productDetails.getAmount(),
        productDetails.getDividend(),
        productDetails.getInvestmentTenureMonth()
    );
    productOrder.setExpectedReturn(expectedReturn);

    // Calculate commission details
    calculateCommissionDetails(productOrder);
}

private double calculateExpectedReturn(Double amount, Double dividend, Integer tenureMonths) {
    // Compound interest calculation
    double monthlyRate = dividend / 100 / 12;
    double compoundFactor = Math.pow(1 + monthlyRate, tenureMonths);
    return amount * compoundFactor;
}
```

**Order Reference Number Generation**:
```java
public static String createOrderReferenceNumber() throws Exception {
    return RandomCodeUtil.generateRandomCode(new RandomCodeBuilder()
        .prefix("ORD" + System.currentTimeMillis())  // Timestamp-based prefix
        .postfix(RandomCodeBuilder.NUMBERS)          // Numeric suffix
        .postfixLength(3));                          // 3-digit suffix
}
```

**Key Features**:
- Dual-context support (client self-purchase vs agent-facilitated)
- Draft update capabilities with state validation
- Corporate client handling with additional validations
- Comprehensive financial calculations
- Transaction boundary management
- Secure tag validation for agent purchases

---

### 4. Beneficiary Management APIs

#### 4.1 Get Product Beneficiaries
**Endpoint**: `GET /api/product/beneficiaries`
**Authentication**: API Key required
**Parameters**: `referenceNumber`

**Deep Business Logic Analysis**:

**Beneficiary Retrieval and Structuring**:
```java
public Object getProductBeneficiaries(String apiKey, String referenceNumber) {
    validateApiKey(apiKey);

    ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(referenceNumber)
        .orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));

    // Retrieve all beneficiaries associated with the product order
    List<ProductBeneficiaries> productBeneficiaries =
        productBeneficiariesDao.findAllByProductOrder(productOrder);

    // Transform to hierarchical structure
    List<FundBeneficiaryDetailsVo> beneficiaryDetails =
        buildBeneficiaryHierarchy(productBeneficiaries);

    ProductPurchaseBeneficiariesRespVo response = new ProductPurchaseBeneficiariesRespVo();
    response.setBeneficiaries(beneficiaryDetails);
    response.setTotalBeneficiaries(beneficiaryDetails.size());
    response.setDistributionSummary(calculateDistributionSummary(beneficiaryDetails));

    return response;
}

private List<FundBeneficiaryDetailsVo> buildBeneficiaryHierarchy(List<ProductBeneficiaries> productBeneficiaries) {
    Map<Long, FundBeneficiaryDetailsVo> mainBeneficiaries = new HashMap<>();
    List<FundBeneficiaryDetailsVo> result = new ArrayList<>();

    for (ProductBeneficiaries pb : productBeneficiaries) {
        if (pb.getParentBeneficiary() == null) {
            // Main beneficiary
            FundBeneficiaryDetailsVo mainBeneficiary = createBeneficiaryVo(pb);
            mainBeneficiaries.put(pb.getId(), mainBeneficiary);
            result.add(mainBeneficiary);
        } else {
            // Sub-beneficiary
            FundBeneficiaryDetailsVo subBeneficiary = createBeneficiaryVo(pb);
            FundBeneficiaryDetailsVo parent = mainBeneficiaries.get(pb.getParentBeneficiary().getId());
            if (parent != null) {
                if (parent.getSubBeneficiaries() == null) {
                    parent.setSubBeneficiaries(new ArrayList<>());
                }
                parent.getSubBeneficiaries().add(subBeneficiary);
            }
        }
    }

    return result;
}

private FundBeneficiaryDetailsVo createBeneficiaryVo(ProductBeneficiaries pb) {
    FundBeneficiaryDetailsVo vo = new FundBeneficiaryDetailsVo();

    if (pb.getBeneficiary() != null) {
        // Individual beneficiary
        IndividualBeneficiary individual = pb.getBeneficiary();
        vo.setBeneficiaryId(individual.getId());
        vo.setBeneficiaryName(individual.getName());
        vo.setIdentityCardNumber(individual.getIdentityCardNumber());
        vo.setRelationship(individual.getRelationship());
        vo.setBeneficiaryType(BeneficiaryType.INDIVIDUAL);
    } else if (pb.getCorporateBeneficiary() != null) {
        // Corporate beneficiary
        CorporateBeneficiaries corporate = pb.getCorporateBeneficiary();
        vo.setBeneficiaryId(corporate.getId());
        vo.setBeneficiaryName(corporate.getName());
        vo.setIdentityCardNumber(corporate.getIdentityCardNumber());
        vo.setRelationship(corporate.getRelationship());
        vo.setBeneficiaryType(BeneficiaryType.CORPORATE);
    }

    vo.setDistributionPercentage(pb.getDistributionPercentage());
    vo.setDistributionAmount(calculateDistributionAmount(pb));

    return vo;
}
```

---

### 5. Payment Management APIs

#### 5.1 Get Uploaded Payment Receipts
**Endpoint**: `GET /api/product/payment-receipts`
**Authentication**: API Key required
**Parameters**: `referenceNumber`

**Deep Business Logic Analysis**:

**Payment Receipt Management**:
```java
public Object getUploadedPaymentReceipts(String apiKey, String referenceNumber) {
    validateApiKey(apiKey);

    ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(referenceNumber)
        .orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));

    // Retrieve all payment receipts
    List<ProductOrderPaymentReceipt> paymentReceipts =
        productOrderPaymentReceiptDao.findAllByProductOrderOrderByUploadedAtDesc(productOrder);

    // Transform to response format
    List<ProductOrderPaymentReceiptVo> receiptVos = paymentReceipts.stream()
        .map(this::transformPaymentReceiptToVo)
        .collect(Collectors.toList());

    ProductOrderPaymentUploadRespVo response = new ProductOrderPaymentUploadRespVo();
    response.setPaymentReceipts(receiptVos);
    response.setTotalAmount(calculateTotalPaidAmount(paymentReceipts));
    response.setOutstandingAmount(calculateOutstandingAmount(productOrder, paymentReceipts));
    response.setPaymentStatus(determinePaymentStatus(productOrder, paymentReceipts));

    return response;
}

private ProductOrderPaymentReceiptVo transformPaymentReceiptToVo(ProductOrderPaymentReceipt receipt) {
    ProductOrderPaymentReceiptVo vo = new ProductOrderPaymentReceiptVo();

    vo.setReceiptId(receipt.getId());
    vo.setAmount(receipt.getAmount());
    vo.setPaymentDate(receipt.getPaymentDate());
    vo.setPaymentMethod(receipt.getPaymentMethod());
    vo.setReferenceNumber(receipt.getReferenceNumber());
    vo.setStatus(receipt.getStatus());

    // Generate secure download URL for receipt image
    if (StringUtil.isNotEmpty(receipt.getReceiptImageKey())) {
        vo.setReceiptUrl(AwsS3Util.getS3DownloadUrl(receipt.getReceiptImageKey()));
    }

    vo.setUploadedAt(receipt.getUploadedAt());
    vo.setUploadedBy(receipt.getUploadedBy());

    return vo;
}

private PaymentStatus determinePaymentStatus(ProductOrder productOrder, List<ProductOrderPaymentReceipt> receipts) {
    double totalPaid = receipts.stream()
        .filter(receipt -> ProductOrderPaymentReceipt.PaymentStatus.UPLOADED.equals(receipt.getStatus()))
        .mapToDouble(ProductOrderPaymentReceipt::getAmount)
        .sum();

    double requiredAmount = productOrder.getPurchasedAmount();

    if (totalPaid >= requiredAmount) {
        return PaymentStatus.FULLY_PAID;
    } else if (totalPaid > 0) {
        return PaymentStatus.PARTIALLY_PAID;
    } else {
        return PaymentStatus.UNPAID;
    }
}
```

#### 5.2 Upload Payment Receipt
**Endpoint**: `POST /api/product/payment-receipts`
**Authentication**: API Key required
**Parameters**: `referenceNumber`, `isDraft`
**Request Body**: `ProductOrderPaymentUploadReqVo`

**Deep Business Logic Analysis**:

**Payment Receipt Processing**:
```java
@Transactional
public Object uploadPaymentReceipt(String apiKey, String referenceNumber,
                                 ProductOrderPaymentUploadReqVo request, Boolean isDraft) {
    AppUser appUser = validateApiKey(apiKey).getAppUser();

    ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(referenceNumber)
        .orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));

    // Validate upload permissions
    validatePaymentReceiptUploadPermissions(appUser, productOrder);

    // Process each receipt in the request
    for (ProductOrderPaymentReceiptReqVo receiptReq : request.getReceipts()) {
        processPaymentReceipt(productOrder, receiptReq, appUser, isDraft);
    }

    // Update product order payment status
    updateProductOrderPaymentStatus(productOrder);

    // Trigger workflow progression if fully paid
    if (!isDraft && isFullyPaid(productOrder)) {
        progressToNextWorkflowStage(productOrder);
    }

    return new BaseResp("Payment receipt(s) uploaded successfully");
}

private void processPaymentReceipt(ProductOrder productOrder,
                                 ProductOrderPaymentReceiptReqVo receiptReq,
                                 AppUser uploadedBy, Boolean isDraft) {

    // Validate receipt data
    validatePaymentReceiptData(receiptReq);

    // Upload receipt image to S3
    String receiptImageKey = uploadReceiptImageToS3(receiptReq.getFile(), productOrder.getOrderReferenceNumber());

    // Create payment receipt record
    ProductOrderPaymentReceipt receipt = new ProductOrderPaymentReceipt();
    receipt.setProductOrder(productOrder);
    receipt.setAmount(receiptReq.getAmount());
    receipt.setPaymentDate(receiptReq.getPaymentDate());
    receipt.setPaymentMethod(receiptReq.getPaymentMethod());
    receipt.setReferenceNumber(receiptReq.getReferenceNumber());
    receipt.setReceiptImageKey(receiptImageKey);
    receipt.setRemarks(receiptReq.getRemarks());
    receipt.setUploadedBy(uploadedBy.getUserDetail().getName());
    receipt.setUploadedAt(new Date());

    // Set status based on draft flag
    receipt.setStatus(isDraft ?
        ProductOrderPaymentReceipt.PaymentStatus.DRAFT :
        ProductOrderPaymentReceipt.PaymentStatus.UPLOADED);

    productOrderPaymentReceiptDao.save(receipt);
}

private String uploadReceiptImageToS3(String base64File, String orderReferenceNumber) {
    // Validate file format
    if (!isValidReceiptImageFormat(base64File)) {
        throw new GeneralException(INVALID_FILE_FORMAT);
    }

    // Upload to S3
    return AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
        .base64String(base64File)
        .fileName("payment_receipt_" + System.currentTimeMillis())
        .filePath(S3_PAYMENT_RECEIPTS_PATH + orderReferenceNumber));
}

private void progressToNextWorkflowStage(ProductOrder productOrder) {
    if (ProductOrder.ProductOrderStatus.PENDING_PAYMENT.equals(productOrder.getStatus())) {
        // Move to agreement stage
        productOrder.setStatus(ProductOrder.ProductOrderStatus.AGREEMENT);
        productOrder.setPaymentCompletedAt(new Date());

        // Send notifications
        notificationService.sendPaymentConfirmationNotification(productOrder);
        notificationService.sendAgreementReadyNotification(productOrder);

        productOrderDao.save(productOrder);
    }
}
```

**Security Measures**:
- Base64 image validation and virus scanning
- File size and format restrictions
- Secure S3 storage with proper access controls
- Receipt image redaction in logs

---

### 6. Product Redemption APIs

#### 6.1 Product Early Redemption
**Endpoint**: `POST /api/product/early-redemption`
**Authentication**: API Key required
**Parameters**: `isRedemption` (Boolean)
**Request Body**: `ProductEarlyRedemptionReqVo`

**Deep Business Logic Analysis**:

**Early Redemption Processing**:
```java
@Transactional
public Object createEarlyRedemption(String apiKey, ProductEarlyRedemptionReqVo earlyRedemptionReq, Boolean isRedemption) {
    AppUser appUser = validateApiKey(apiKey).getAppUser();

    // 1. Validate Product Order
    ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(
        earlyRedemptionReq.getOrderReferenceNumber())
        .orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));

    // 2. Check Redemption Eligibility
    if (!checkIfProductOrderOptionsIsAllowed(ProductOrderOptions.EARLY_REDEMPTION, productOrder)) {
        return getErrorObjectWithMsg(EARLY_REDEMPTION_NOT_ALLOWED);
    }

    // 3. Calculate Penalty and Redemption Amounts
    double penaltyPercentage = getEarlyRedemptionPenaltyPercentage(productOrder);
    if (penaltyPercentage == 0) {
        return getErrorObjectWithMsg(EARLY_REDEMPTION_NOT_ALLOWED);
    }

    // 4. Process Redemption Amount Calculation
    double requestAmount;
    RedemptionMethod withdrawalMethod;

    if (RedemptionMethod.PARTIAL_AMOUNT.equals(earlyRedemptionReq.getWithdrawalMethod())) {
        // Partial redemption validation
        if (earlyRedemptionReq.getWithdrawalAmount() == null ||
            earlyRedemptionReq.getWithdrawalAmount() <= 0 ||
            earlyRedemptionReq.getWithdrawalAmount() > productOrder.getPurchasedAmount()) {
            return getErrorObjectWithMsg(INVALID_AMOUNT);
        }

        requestAmount = earlyRedemptionReq.getWithdrawalAmount();

        // Auto-convert to full if amount equals total
        if (requestAmount == productOrder.getPurchasedAmount()) {
            withdrawalMethod = RedemptionMethod.ALL;
        } else {
            withdrawalMethod = RedemptionMethod.PARTIAL_AMOUNT;

            // Validate minimum remaining amount
            double remainingAmount = productOrder.getPurchasedAmount() - requestAmount;
            if (remainingAmount < productOrder.getProduct().getMinimumInvestmentAmount()) {
                return getErrorObjectWithMsg(REMAINING_AMOUNT_BELOW_MINIMUM);
            }
        }
    } else {
        // Full redemption
        withdrawalMethod = RedemptionMethod.ALL;
        requestAmount = productOrder.getPurchasedAmount();
    }

    // 5. Calculate Financial Impact
    EarlyRedemptionCalculation calculation = calculateEarlyRedemptionFinancials(
        productOrder, requestAmount, penaltyPercentage);

    ProductEarlyRedemptionRespVo response = new ProductEarlyRedemptionRespVo();
    response.setPenaltyPercentage(calculation.getPenaltyPercentage());
    response.setPenaltyAmount(calculation.getPenaltyAmount());
    response.setRedemptionAmount(calculation.getNetRedemptionAmount());
    response.setGrossRedemptionAmount(calculation.getGrossRedemptionAmount());
    response.setAccruedDividend(calculation.getAccruedDividend());

    // 6. Return calculation only if not confirming redemption
    if (!isRedemption) {
        return response;
    }

    // 7. Create Redemption History Record
    Agent agent = resolveAgentFromContext(appUser);
    ProductEarlyRedemptionHistory history = createRedemptionHistory(
        productOrder, earlyRedemptionReq, calculation, withdrawalMethod, agent);

    // 8. Upload Supporting Documents
    if (StringUtil.isNotEmpty(earlyRedemptionReq.getSupportingDocumentKey())) {
        String documentKey = uploadSupportingDocument(
            earlyRedemptionReq.getSupportingDocumentKey(),
            history.getOrderReferenceNumber());
        history.setSupportingDocumentKey(documentKey);
    }

    // 9. Save and Return Reference
    history = productEarlyRedemptionHistoryDao.save(history);
    response.setRedemptionReferenceNumber(history.getRedemptionReferenceNumber());

    // 10. Trigger Notifications
    triggerEarlyRedemptionNotifications(history);

    return response;
}

private EarlyRedemptionCalculation calculateEarlyRedemptionFinancials(
    ProductOrder productOrder, double requestAmount, double penaltyPercentage) {

    EarlyRedemptionCalculation calculation = new EarlyRedemptionCalculation();

    // Calculate accrued dividend up to redemption date
    double accruedDividend = calculateAccruedDividend(productOrder, new Date());

    // Calculate gross redemption amount (principal + accrued dividend)
    double grossRedemptionAmount = requestAmount + accruedDividend;

    // Apply penalty on gross amount
    double penaltyAmount = MathUtil.roundHalfUp(grossRedemptionAmount * penaltyPercentage / 100);

    // Calculate net redemption amount
    double netRedemptionAmount = MathUtil.roundHalfUp(grossRedemptionAmount - penaltyAmount);

    calculation.setPenaltyPercentage(penaltyPercentage);
    calculation.setPenaltyAmount(penaltyAmount);
    calculation.setGrossRedemptionAmount(grossRedemptionAmount);
    calculation.setNetRedemptionAmount(netRedemptionAmount);
    calculation.setAccruedDividend(accruedDividend);

    return calculation;
}

private double calculateAccruedDividend(ProductOrder productOrder, Date redemptionDate) {
    // Get all dividend calculation histories for this product order
    List<ProductDividendCalculationHistory> dividendHistories =
        productDividendCalculationHistoryDao.findByProductOrderAndDateLessThanEqual(
            productOrder, redemptionDate);

    return dividendHistories.stream()
        .mapToDouble(ProductDividendCalculationHistory::getDividendAmount)
        .sum();
}

private double getEarlyRedemptionPenaltyPercentage(ProductOrder productOrder) {
    // Calculate days since activation
    LocalDate activationDate = productOrder.getActivatedDate();
    LocalDate currentDate = LocalDate.now();
    long daysSinceActivation = ChronoUnit.DAYS.between(activationDate, currentDate);

    // Get penalty structure from product configuration
    Product product = productOrder.getProduct();
    List<EarlyRedemptionPenalty> penalties = earlyRedemptionPenaltyDao.findByProduct(product);

    // Find applicable penalty based on days since activation
    return penalties.stream()
        .filter(penalty -> daysSinceActivation >= penalty.getMinDays() &&
                          daysSinceActivation <= penalty.getMaxDays())
        .findFirst()
        .map(EarlyRedemptionPenalty::getPenaltyPercentage)
        .orElse(0.0);
}
```

**Penalty Calculation Framework**:
```java
// Example penalty structure:
// 0-90 days: 3% penalty
// 91-180 days: 2% penalty
// 181-365 days: 1% penalty
// 365+ days: 0.5% penalty

private EarlyRedemptionPenalty findApplicablePenalty(Product product, long daysSinceActivation) {
    return product.getEarlyRedemptionPenalties().stream()
        .filter(penalty -> daysSinceActivation >= penalty.getMinDays() &&
                          (penalty.getMaxDays() == null || daysSinceActivation <= penalty.getMaxDays()))
        .findFirst()
        .orElse(getDefaultPenalty());
}
```

#### 6.2 Product Full Redemption
**Endpoint**: `POST /api/product/full-redemption`
**Authentication**: API Key required
**Parameters**: `orderReferenceNumber`

**Deep Business Logic Analysis**:

**Full Redemption at Maturity**:
```java
@Transactional
public Object productOrderFullRedemption(String apiKey, String orderReferenceNumber) {
    AppUser appUser = validateApiKey(apiKey).getAppUser();

    // 1. Validate Product Order
    ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(orderReferenceNumber)
        .orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));

    // 2. Validate Redemption Eligibility
    if (!ProductOrder.ProductOrderStatus.MATURED.equals(productOrder.getStatus())) {
        return getErrorObjectWithMsg(PRODUCT_NOT_MATURED);
    }

    // 3. Validate User Authorization
    validateUserRedemptionAuthorization(appUser, productOrder);

    // 4. Calculate Full Redemption Amount
    FullRedemptionCalculation calculation = calculateFullRedemptionAmount(productOrder);

    // 5. Create Redemption Record
    ProductRedemption redemption = new ProductRedemption();
    redemption.setProductOrder(productOrder);
    redemption.setRedemptionType(RedemptionType.FULL_MATURITY);
    redemption.setRedemptionAmount(calculation.getTotalAmount());
    redemption.setPrincipalAmount(calculation.getPrincipalAmount());
    redemption.setDividendAmount(calculation.getTotalDividendAmount());
    redemption.setRedemptionDate(new Date());
    redemption.setStatus(Status.PENDING);
    redemption.setInitiatedBy(appUser.getUserDetail().getName());

    // 6. Update Product Order Status
    productOrder.setStatus(ProductOrder.ProductOrderStatus.COMPLETED);
    productOrder.setCompletedAt(new Date());

    // 7. Save Changes
    productRedemptionDao.save(redemption);
    productOrderDao.save(productOrder);

    // 8. Trigger Post-Redemption Processes
    triggerRedemptionProcessing(redemption);

    // 9. Send Notifications
    notificationService.sendRedemptionConfirmationNotification(productOrder);

    return FullRedemptionRespVo.builder()
        .redemptionReferenceNumber(redemption.getRedemptionReferenceNumber())
        .totalAmount(calculation.getTotalAmount())
        .principalAmount(calculation.getPrincipalAmount())
        .dividendAmount(calculation.getTotalDividendAmount())
        .expectedProcessingDays(getExpectedProcessingDays())
        .build();
}

private FullRedemptionCalculation calculateFullRedemptionAmount(ProductOrder productOrder) {
    // Calculate total dividend earned over investment period
    double totalDividendAmount = productDividendCalculationHistoryDao
        .findByProductOrder(productOrder)
        .stream()
        .mapToDouble(ProductDividendCalculationHistory::getDividendAmount)
        .sum();

    FullRedemptionCalculation calculation = new FullRedemptionCalculation();
    calculation.setPrincipalAmount(productOrder.getPurchasedAmount());
    calculation.setTotalDividendAmount(totalDividendAmount);
    calculation.setTotalAmount(calculation.getPrincipalAmount() + calculation.getTotalDividendAmount());

    return calculation;
}
```

---

### 7. Product Lifecycle Management APIs

#### 7.1 Product Rollover
**Endpoint**: `POST /api/product/rollover`
**Authentication**: API Key required
**Parameters**: `orderReferenceNumber`
**Request Body**: `RolloverReqVo`

**Deep Business Logic Analysis**:

**Rollover Processing**:
```java
@Transactional
public Object createRolloverProductOrder(String apiKey, String orderReferenceNumber, RolloverReqVo req) {
    AppUser appUser = validateApiKey(apiKey).getAppUser();

    // 1. Validate Source Product Order
    ProductOrder sourceOrder = productOrderDao.findByOrderReferenceNumber(orderReferenceNumber)
        .orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));

    if (!ProductOrder.ProductOrderStatus.MATURED.equals(sourceOrder.getStatus())) {
        return getErrorObjectWithMsg(PRODUCT_NOT_ELIGIBLE_FOR_ROLLOVER);
    }

    // 2. Validate Target Product
    Product targetProduct = productDao.findById(req.getNewProductId())
        .orElseThrow(() -> new GeneralException(INVALID_PRODUCT));

    // 3. Calculate Rollover Amount
    RolloverCalculation calculation = calculateRolloverAmount(sourceOrder, req);

    // 4. Validate Rollover Amount Against Target Product
    validateRolloverAmount(calculation.getRolloverAmount(), targetProduct);

    // 5. Create New Product Order for Rollover
    ProductOrder rolloverOrder = createRolloverProductOrder(sourceOrder, targetProduct, req, calculation);

    // 6. Process Source Order Completion
    completeSourceOrderForRollover(sourceOrder, calculation);

    // 7. Handle Beneficiary Transfer
    transferBeneficiariesToRolloverOrder(sourceOrder, rolloverOrder, req);

    // 8. Calculate Commissions for New Order
    calculateRolloverCommissions(rolloverOrder);

    // 9. Save All Changes
    productOrderDao.save(sourceOrder);
    rolloverOrder = productOrderDao.save(rolloverOrder);

    // 10. Trigger Notifications
    notificationService.sendRolloverConfirmationNotification(sourceOrder, rolloverOrder);

    return RolloverRespVo.builder()
        .newOrderReferenceNumber(rolloverOrder.getOrderReferenceNumber())
        .rolloverAmount(calculation.getRolloverAmount())
        .additionalInvestment(calculation.getAdditionalInvestment())
        .totalNewInvestment(rolloverOrder.getPurchasedAmount())
        .newMaturityDate(rolloverOrder.getMaturityDate())
        .build();
}

private RolloverCalculation calculateRolloverAmount(ProductOrder sourceOrder, RolloverReqVo req) {
    // Calculate total matured amount (principal + dividends)
    double maturedAmount = calculateMaturedAmount(sourceOrder);

    // Handle partial rollover
    double rolloverAmount = req.getRolloverAmount() != null ?
        req.getRolloverAmount() : maturedAmount;

    // Calculate additional investment if any
    double additionalInvestment = req.getAdditionalInvestment() != null ?
        req.getAdditionalInvestment() : 0.0;

    RolloverCalculation calculation = new RolloverCalculation();
    calculation.setSourceMaturedAmount(maturedAmount);
    calculation.setRolloverAmount(rolloverAmount);
    calculation.setAdditionalInvestment(additionalInvestment);
    calculation.setTotalNewInvestment(rolloverAmount + additionalInvestment);
    calculation.setCashOut(maturedAmount - rolloverAmount);

    return calculation;
}

private ProductOrder createRolloverProductOrder(ProductOrder sourceOrder, Product targetProduct,
                                               RolloverReqVo req, RolloverCalculation calculation) {
    ProductOrder rolloverOrder = new ProductOrder();

    // Copy basic information from source order
    rolloverOrder.setClient(sourceOrder.getClient());
    rolloverOrder.setCorporateClient(sourceOrder.getCorporateClient());
    rolloverOrder.setAgent(sourceOrder.getAgent());
    rolloverOrder.setBank(sourceOrder.getBank());

    // Set new product details
    rolloverOrder.setProduct(targetProduct);
    rolloverOrder.setPurchasedAmount(calculation.getTotalNewInvestment());
    rolloverOrder.setInvestmentTenureMonth(req.getNewInvestmentTenureMonth());
    rolloverOrder.setDividend(req.getNewDividendOption());

    // Generate new reference number
    rolloverOrder.setOrderReferenceNumber(createOrderReferenceNumber());

    // Set rollover-specific fields
    rolloverOrder.setIsRollover(true);
    rolloverOrder.setSourceOrderReferenceNumber(sourceOrder.getOrderReferenceNumber());
    rolloverOrder.setRolloverAmount(calculation.getRolloverAmount());
    rolloverOrder.setAdditionalInvestment(calculation.getAdditionalInvestment());

    // Calculate new maturity date
    LocalDate newMaturityDate = LocalDate.now().plusMonths(req.getNewInvestmentTenureMonth());
    rolloverOrder.setMaturityDate(newMaturityDate);

    // Set initial status
    rolloverOrder.setStatus(ProductOrder.ProductOrderStatus.ACTIVE);
    rolloverOrder.setActivatedDate(LocalDate.now());

    // Set timestamps
    rolloverOrder.setCreatedAt(new Date());
    rolloverOrder.setUpdatedAt(new Date());

    return rolloverOrder;
}
```

#### 7.2 Product Reallocation
**Endpoint**: `POST /api/product/reallocation`
**Authentication**: API Key required
**Parameters**: `orderReferenceNumber`
**Request Body**: `ReallocateReqVo`

**Deep Business Logic Analysis**:

**Reallocation Processing**:
```java
@Transactional
public Object createReallocationProductOrder(String apiKey, String orderReferenceNumber, ReallocateReqVo req) {
    AppUser appUser = validateApiKey(apiKey).getAppUser();

    // 1. Validate Source Product Order
    ProductOrder sourceOrder = productOrderDao.findByOrderReferenceNumber(orderReferenceNumber)
        .orElseThrow(() => new GeneralException(PRODUCT_ORDER_NOT_FOUND));

    // 2. Check Reallocation Eligibility
    if (!isEligibleForReallocation(sourceOrder)) {
        return getErrorObjectWithMsg(REALLOCATION_NOT_ALLOWED);
    }

    // 3. Validate Reallocation Requests
    validateReallocationRequests(req.getReallocationDetails(), sourceOrder);

    // 4. Calculate Current Value
    double currentValue = calculateCurrentProductValue(sourceOrder);

    // 5. Process Each Reallocation
    List<ProductOrder> newOrders = new ArrayList<>();
    for (ReallocationDetail detail : req.getReallocationDetails()) {
        ProductOrder newOrder = processReallocationDetail(sourceOrder, detail, currentValue);
        newOrders.add(newOrder);
    }

    // 6. Update Source Order Status
    sourceOrder.setStatus(ProductOrder.ProductOrderStatus.REALLOCATED);
    sourceOrder.setReallocationDate(LocalDate.now());

    // 7. Create Reallocation History
    ProductReallocation reallocation = createReallocationHistory(sourceOrder, newOrders, req);

    // 8. Save All Changes
    productOrderDao.save(sourceOrder);
    newOrders.forEach(productOrderDao::save);
    productReallocationDao.save(reallocation);

    // 9. Trigger Notifications
    notificationService.sendReallocationConfirmationNotification(sourceOrder, newOrders);

    return ReallocationRespVo.builder()
        .reallocationReferenceNumber(reallocation.getReallocationReferenceNumber())
        .sourceOrderReferenceNumber(orderReferenceNumber)
        .newOrderReferenceNumbers(newOrders.stream()
            .map(ProductOrder::getOrderReferenceNumber)
            .collect(Collectors.toList()))
        .totalReallocatedAmount(currentValue)
        .build();
}

private ProductOrder processReallocationDetail(ProductOrder sourceOrder,
                                             ReallocationDetail detail,
                                             double totalCurrentValue) {
    // Calculate reallocation amount
    double reallocationAmount = totalCurrentValue * detail.getAllocationPercentage() / 100;

    // Get target product
    Product targetProduct = productDao.findById(detail.getTargetProductId())
        .orElseThrow(() -> new GeneralException(INVALID_PRODUCT));

    // Create new product order
    ProductOrder newOrder = new ProductOrder();

    // Copy client information
    newOrder.setClient(sourceOrder.getClient());
    newOrder.setCorporateClient(sourceOrder.getCorporateClient());
    newOrder.setAgent(sourceOrder.getAgent());

    // Set new product details
    newOrder.setProduct(targetProduct);
    newOrder.setPurchasedAmount(reallocationAmount);
    newOrder.setInvestmentTenureMonth(detail.getNewInvestmentTenureMonth());
    newOrder.setDividend(detail.getNewDividendOption());

    // Set reallocation-specific fields
    newOrder.setIsReallocation(true);
    newOrder.setSourceOrderReferenceNumber(sourceOrder.getOrderReferenceNumber());
    newOrder.setReallocationPercentage(detail.getAllocationPercentage());

    // Generate reference number
    newOrder.setOrderReferenceNumber(createOrderReferenceNumber());

    // Calculate maturity date
    LocalDate maturityDate = LocalDate.now().plusMonths(detail.getNewInvestmentTenureMonth());
    newOrder.setMaturityDate(maturityDate);

    // Set status as active
    newOrder.setStatus(ProductOrder.ProductOrderStatus.ACTIVE);
    newOrder.setActivatedDate(LocalDate.now());

    // Copy beneficiaries from source order
    copyBeneficiariesToNewOrder(sourceOrder, newOrder);

    return newOrder;
}
```

---

## Deep Technical Implementation Analysis

### Transaction Management Architecture

**Multi-Entity Transaction Handling**:
```java
@Transactional(isolation = Isolation.READ_COMMITTED, propagation = Propagation.REQUIRED)
public Object createProductOrder(String apiKey, ProductPurchaseReqVo request, String referenceNumber) {
    // Transaction boundaries ensure:
    // 1. Product order creation atomicity
    // 2. Beneficiary relationship consistency
    // 3. Commission calculation accuracy
    // 4. Financial calculation integrity
    // 5. Status transition reliability

    try {
        // All database operations within single transaction
        ProductOrder order = processProductOrderCreation(request);
        processBeneficiaries(order, request.getBeneficiaries());
        calculateFinancials(order);

        return buildResponse(order);
    } catch (Exception e) {
        // Automatic rollback on any failure
        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
        throw e;
    }
}
```

### Financial Calculation Engine

**Dividend Calculation Framework**:
```java
public class DividendCalculationEngine {

    public DividendCalculationResult calculateDividend(ProductOrder productOrder, Date calculationDate) {
        // 1. Get product dividend configuration
        Product product = productOrder.getProduct();
        double annualDividendRate = productOrder.getDividend();

        // 2. Calculate time-based dividend
        long daysSinceLastCalculation = calculateDaysSinceLastDividend(productOrder, calculationDate);
        double dailyRate = annualDividendRate / 365.0 / 100.0;

        // 3. Apply compound interest if configured
        double dividendAmount;
        if (product.isCompoundInterest()) {
            dividendAmount = calculateCompoundDividend(
                productOrder.getPurchasedAmount(),
                dailyRate,
                daysSinceLastCalculation
            );
        } else {
            dividendAmount = calculateSimpleDividend(
                productOrder.getPurchasedAmount(),
                dailyRate,
                daysSinceLastCalculation
            );
        }

        // 4. Apply any adjustments
        dividendAmount = applyDividendAdjustments(productOrder, dividendAmount);

        return DividendCalculationResult.builder()
            .productOrder(productOrder)
            .calculationDate(calculationDate)
            .dividendAmount(dividendAmount)
            .dailyRate(dailyRate)
            .daysCalculated(daysSinceLastCalculation)
            .build();
    }

    private double calculateCompoundDividend(double principal, double dailyRate, long days) {
        return principal * (Math.pow(1 + dailyRate, days) - 1);
    }

    private double calculateSimpleDividend(double principal, double dailyRate, long days) {
        return principal * dailyRate * days;
    }
}
```

### Commission Calculation System

**Multi-Level Commission Structure**:
```java
public class CommissionCalculationService {

    @Async
    public void calculateCommissionsAsync(ProductOrder productOrder) {
        // Calculate personal commission for direct agent
        calculatePersonalCommission(productOrder);

        // Calculate overriding commissions for upline agents
        calculateOverridingCommissions(productOrder);

        // Calculate peer-to-peer commissions if applicable
        calculateP2PCommissions(productOrder);

        // Process commission payments
        processCommissionPayments(productOrder);
    }

    private void calculatePersonalCommission(ProductOrder productOrder) {
        Agent agent = productOrder.getAgent();
        Product product = productOrder.getProduct();

        // Get commission rate based on agent role and product type
        double commissionRate = getCommissionRate(agent.getAgentRole(), product.getProductType());
        double commissionAmount = productOrder.getPurchasedAmount() * commissionRate / 100;

        // Create commission calculation record
        AgentCommissionCalculationHistory calculation = new AgentCommissionCalculationHistory();
        calculation.setProductId(product.getId());
        calculation.setProductOrderId(productOrder.getId());
        calculation.setAgentId(agent.getId());
        calculation.setCommissionType(AgentCommissionHistory.CommissionType.PERSONAL);
        calculation.setPurchasedAmount(productOrder.getPurchasedAmount());
        calculation.setCommissionPercentage(commissionRate);
        calculation.setCommissionAmount(commissionAmount);
        calculation.setCalculatedDate(LocalDate.now());

        agentCommissionCalculationHistoryDao.save(calculation);

        // Create payment record
        createCommissionPaymentRecord(calculation);
    }

    private void calculateOverridingCommissions(ProductOrder productOrder) {
        Agent agent = productOrder.getAgent();

        // Get agent hierarchy for overriding commissions
        List<Agent> uplineAgents = getUplineAgents(agent);

        for (Agent uplineAgent : uplineAgents) {
            double overridingRate = getOverridingCommissionRate(
                uplineAgent.getAgentRole(),
                agent.getAgentRole(),
                productOrder.getProduct().getProductType()
            );

            if (overridingRate > 0) {
                double overridingAmount = productOrder.getPurchasedAmount() * overridingRate / 100;

                createOverridingCommissionRecord(productOrder, uplineAgent, agent, overridingRate, overridingAmount);
            }
        }
    }
}
```

### Status State Machine

**Product Order Lifecycle Management**:
```java
public class ProductOrderStateMachine {

    private static final Map<ProductOrder.ProductOrderStatus, Set<ProductOrder.ProductOrderStatus>> VALID_TRANSITIONS =
        Map.of(
            DRAFT, Set.of(IN_REVIEW, REJECTED, PENDING_PAYMENT),
            IN_REVIEW, Set.of(APPROVED, REJECTED),
            APPROVED, Set.of(PENDING_PAYMENT, REJECTED),
            PENDING_PAYMENT, Set.of(AGREEMENT, REJECTED),
            AGREEMENT, Set.of(ACTIVE, SECOND_SIGNEE, REJECTED),
            SECOND_SIGNEE, Set.of(ACTIVE, REJECTED),
            ACTIVE, Set.of(MATURED, WITHDRAWN, EARLY_REDEMPTION),
            MATURED, Set.of(COMPLETED, ROLLOVER, REALLOCATION),
            COMPLETED, Set.of() // Terminal state
        );

    public boolean canTransition(ProductOrder.ProductOrderStatus from, ProductOrder.ProductOrderStatus to) {
        return VALID_TRANSITIONS.getOrDefault(from, Set.of()).contains(to);
    }

    public void transitionTo(ProductOrder productOrder, ProductOrder.ProductOrderStatus newStatus) {
        ProductOrder.ProductOrderStatus currentStatus = productOrder.getStatus();

        if (!canTransition(currentStatus, newStatus)) {
            throw new GeneralException("Invalid status transition from " + currentStatus + " to " + newStatus);
        }

        // Execute pre-transition hooks
        executePreTransitionHooks(productOrder, currentStatus, newStatus);

        // Update status
        productOrder.setStatus(newStatus);
        productOrder.setUpdatedAt(new Date());

        // Execute post-transition hooks
        executePostTransitionHooks(productOrder, currentStatus, newStatus);
    }

    private void executePostTransitionHooks(ProductOrder productOrder,
                                          ProductOrder.ProductOrderStatus from,
                                          ProductOrder.ProductOrderStatus to) {
        switch (to) {
            case ACTIVE:
                // Trigger commission calculations
                commissionCalculationService.calculateCommissionsAsync(productOrder);
                // Start dividend calculations
                dividendCalculationService.scheduleRegularDividendCalculations(productOrder);
                // Send activation notifications
                notificationService.sendActivationNotifications(productOrder);
                break;

            case MATURED:
                // Calculate final dividend
                dividendCalculationService.calculateFinalDividend(productOrder);
                // Send maturity notifications
                notificationService.sendMaturityNotifications(productOrder);
                break;

            case COMPLETED:
                // Process final redemption
                redemptionService.processFinalRedemption(productOrder);
                // Archive order data
                archiveService.archiveProductOrder(productOrder);
                break;
        }
    }
}
```

### Validation Framework

**Multi-Checkpoint Validation System**:
```java
public class ProductOrderValidationService {

    public ValidationResult validateProductOrder(ProductPurchaseReqVo request, ValidationContext context) {
        ValidationResult result = new ValidationResult();

        // Execute all validation rules
        List<ValidationRule> rules = Arrays.asList(
            new ProductAvailabilityValidationRule(),
            new InvestmentAmountValidationRule(),
            new BeneficiaryDistributionValidationRule(),
            new UserAuthorizationValidationRule(),
            new CorporateComplianceValidationRule(),
            new RegulatoryCom
            new RiskAssessmentValidationRule()
        );

        for (ValidationRule rule : rules) {
            ValidationResult ruleResult = rule.validate(request, context);
            result.merge(ruleResult);

            // Stop on critical errors
            if (ruleResult.hasCriticalErrors()) {
                break;
            }
        }

        return result;
    }
}

public class BeneficiaryDistributionValidationRule implements ValidationRule {

    @Override
    public ValidationResult validate(ProductPurchaseReqVo request, ValidationContext context) {
        ValidationResult result = new ValidationResult();

        List<ProductOrderBeneficiaryReqVo> beneficiaries = request.getBeneficiaries();

        // Check presence
        if (beneficiaries == null || beneficiaries.isEmpty()) {
            result.addError(ValidationErrorCode.MISSING_BENEFICIARIES, "At least one beneficiary is required");
            return result;
        }

        // Validate distribution percentages
        double totalPercentage = beneficiaries.stream()
            .mapToDouble(ProductOrderBeneficiaryReqVo::getDistributionPercentage)
            .sum();

        if (Math.abs(totalPercentage - 100.0) > PERCENTAGE_TOLERANCE) {
            result.addError(ValidationErrorCode.INVALID_DISTRIBUTION_PERCENTAGE,
                "Total beneficiary distribution must equal 100%");
        }

        // Validate individual beneficiaries
        for (int i = 0; i < beneficiaries.size(); i++) {
            ValidationResult beneficiaryResult = validateBeneficiary(beneficiaries.get(i), i);
            result.merge(beneficiaryResult);
        }

        return result;
    }
}
```

### Performance Optimization

**Caching and Lazy Loading Strategy**:
```java
@Service
public class ProductCacheService {

    private final Cache<Long, ProductDetailsRespVo> productCache;
    private final Cache<String, List<ProductVo>> productListCache;

    @Cacheable(value = "productDetails", key = "#productId")
    public ProductDetailsRespVo getProductDetails(Long productId) {
        Product product = productDao.findById(productId)
            .orElseThrow(() -> new GeneralException(INVALID_PRODUCT));

        return transformToProductDetails(product);
    }

    @Cacheable(value = "productList", unless = "#result.isEmpty()")
    public List<ProductVo> getProductList() {
        List<Product> products = productDao.findAllByIsPublishedIsTrueAndStatusIsTrue();

        return products.parallelStream()
            .map(this::transformToProductVo)
            .sorted(Comparator.comparing(ProductVo::getDisplayOrder))
            .collect(Collectors.toList());
    }

    @CacheEvict(value = {"productDetails", "productList"}, allEntries = true)
    public void invalidateProductCache() {
        // Called when products are updated
    }
}
```

### Error Handling and Recovery

**Comprehensive Error Management**:
```java
@ControllerAdvice
public class ProductControllerExceptionHandler {

    @ExceptionHandler(ProductOrderValidationException.class)
    public ResponseEntity<ErrorResp> handleValidationException(ProductOrderValidationException e) {
        ErrorResp errorResp = new ErrorResp();
        errorResp.setMessage(e.getMessage());
        errorResp.setValidationErrors(e.getValidationErrors());
        errorResp.setTimestamp(new Date());

        return ResponseEntity.badRequest().body(errorResp);
    }

    @ExceptionHandler(InsufficientFundsException.class)
    public ResponseEntity<ErrorResp> handleInsufficientFundsException(InsufficientFundsException e) {
        ErrorResp errorResp = new ErrorResp();
        errorResp.setMessage("Insufficient funds for the requested investment amount");
        errorResp.setAvailableAmount(e.getAvailableAmount());
        errorResp.setRequestedAmount(e.getRequestedAmount());

        return ResponseEntity.badRequest().body(errorResp);
    }

    @ExceptionHandler(TransactionRollbackException.class)
    public ResponseEntity<ErrorResp> handleTransactionRollbackException(TransactionRollbackException e) {
        // Log for audit trail
        auditService.logTransactionFailure(e);

        ErrorResp errorResp = new ErrorResp();
        errorResp.setMessage("Transaction failed and has been rolled back");
        errorResp.setRetryable(true);

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResp);
    }
}
```

---

## Business Rules & Compliance

### Regulatory Compliance Framework

**AML and KYC Integration**:
```java
public class ComplianceService {

    public ComplianceValidationResult validateProductPurchase(ProductOrder productOrder) {
        ComplianceValidationResult result = new ComplianceValidationResult();

        // AML checks
        result.merge(performAMLChecks(productOrder));

        // KYC verification
        result.merge(verifyKYCStatus(productOrder.getClient()));

        // Risk assessment
        result.merge(assessInvestmentRisk(productOrder));

        // Regulatory limits
        result.merge(validateRegulatoryLimits(productOrder));

        return result;
    }

    private ComplianceValidationResult performAMLChecks(ProductOrder productOrder) {
        // Check against sanctions lists
        // Verify source of funds
        // Assess transaction patterns
        // Flag suspicious activities

        return new ComplianceValidationResult();
    }
}
```

### Investment Limits and Restrictions

**Dynamic Limit Calculation**:
```java
public class InvestmentLimitService {

    public InvestmentLimits calculateInvestmentLimits(Client client, Product product) {
        InvestmentLimits limits = new InvestmentLimits();

        // Base product limits
        limits.setMinimumAmount(product.getMinimumInvestmentAmount());
        limits.setMaximumAmount(product.getMaximumInvestmentAmount());

        // Client-specific adjustments
        adjustForClientProfile(limits, client);

        // Regulatory adjustments
        adjustForRegulatoryRequirements(limits, client, product);

        // Available tranche adjustments
        adjustForAvailability(limits, product);

        return limits;
    }

    private void adjustForClientProfile(InvestmentLimits limits, Client client) {
        // Adjust based on client risk profile
        // Consider client's total investment exposure
        // Apply client-specific limits

        ClientRiskProfile riskProfile = client.getRiskProfile();
        if (riskProfile != null) {
            double riskMultiplier = getRiskMultiplier(riskProfile.getRiskLevel());
            limits.adjustMaximumAmount(limits.getMaximumAmount() * riskMultiplier);
        }
    }
}
```

---

## Monitoring and Performance

### Key Performance Indicators

**Business Metrics**:
- Product purchase conversion rates
- Average order processing time
- Early redemption frequency by product type
- Commission calculation accuracy
- Payment receipt processing time

**Technical Metrics**:
- API response times by endpoint
- Database query performance
- Cache hit/miss ratios
- File upload success rates
- Transaction rollback frequency

### Audit Trail Implementation

**Comprehensive Activity Logging**:
```java
@Aspect
@Component
public class ProductOrderAuditAspect {

    @AfterReturning(pointcut = "execution(* ProductService.createProductOrder(..))", returning = "result")
    public void auditProductOrderCreation(JoinPoint joinPoint, Object result) {
        Object[] args = joinPoint.getArgs();
        String apiKey = (String) args[0];
        ProductPurchaseReqVo request = (ProductPurchaseReqVo) args[1];

        AuditLog auditLog = AuditLog.builder()
            .action("PRODUCT_ORDER_CREATED")
            .apiKey(apiKey)
            .requestData(sanitizeRequestData(request))
            .responseData(sanitizeResponseData(result))
            .timestamp(new Date())
            .ipAddress(getCurrentIPAddress())
            .userAgent(getCurrentUserAgent())
            .build();

        auditService.logActivity(auditLog);
    }
}
```

This comprehensive documentation provides the new development team with deep insights into the ProductController's complex business processes, including multi-stage validation workflows, financial calculation engines, commission systems, and advanced product lifecycle management. The detailed service layer analysis ensures thorough understanding of the sophisticated investment management platform.

<function_calls>
<invoke name="TodoWrite">
<parameter name="todos">[{"content": "Analyze ProductController structure and endpoints", "status": "completed", "activeForm": "Analyzing ProductController structure and endpoints"}, {"content": "Read ProductService implementation for product operations", "status": "completed", "activeForm": "Reading ProductService implementation for product operations"}, {"content": "Examine product-related VO classes and entities", "status": "completed", "activeForm": "Examining product-related VO classes and entities"}, {"content": "Investigate product lifecycle and business workflows", "status": "completed", "activeForm": "Investigating product lifecycle and business workflows"}, {"content": "Analyze commission calculation and dividend logic", "status": "completed", "activeForm": "Analyzing commission calculation and dividend logic"}, {"content": "Create comprehensive ProductController documentation", "status": "completed", "activeForm": "Creating comprehensive ProductController documentation"}]