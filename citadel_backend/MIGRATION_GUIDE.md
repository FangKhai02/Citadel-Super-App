# Data Migration Guide for Admin Panel

This guide documents the business logic and preprocessing steps required for migrating data through an admin panel interface (row-by-row insertion). Each section corresponds to a migration function in `MigrationService.java`.

---

## Table of Contents

1. [Agent Registration](#1-agent-registration)
2. [Agent Hierarchy](#2-agent-hierarchy)
3. [Individual Client Registration](#3-individual-client-registration)
4. [Client Bank Accounts](#4-client-bank-accounts)
5. [Client Beneficiaries](#5-client-beneficiaries)
6. [Client Guardians](#6-client-guardians)
7. [Beneficiary-Guardian Link](#7-beneficiary-guardian-link)
8. [Corporate Registration](#8-corporate-registration)
9. [Corporate Shareholders](#9-corporate-shareholders)
10. [Corporate Beneficiaries](#10-corporate-beneficiaries)
11. [Corporate Guardians](#11-corporate-guardians)
12. [Corporate Beneficiary-Guardian Link](#12-corporate-beneficiary-guardian-link)
13. [Corporate Bank Accounts](#13-corporate-bank-accounts)
14. [Product Orders](#14-product-orders)
15. [Product Order Beneficiaries](#15-product-order-beneficiaries)
16. [Dividend History (Auto-Generated)](#16-dividend-history-auto-generated)
17. [Agent Commission History](#17-agent-commission-history)
18. [Agency Commission History](#18-agency-commission-history)
19. [Product Redemption](#19-product-redemption)
20. [Early Redemption](#20-early-redemption)

---

## Migration Order (IMPORTANT)

Execute migrations in this exact order:

**Phase 1: Users**
1. Agent → 2. Agent Hierarchy

**Phase 2: Individual Clients**
3. Client → 4-7. Related entities (bank, beneficiaries, guardians)

**Phase 3: Corporate Clients**
8. Corporate → 9-13. Related entities (shareholders, beneficiaries, guardians, bank)

**Phase 4: Products**
14. Product Order → 15. Order Beneficiaries

**Phase 5: Financials**
16. Dividend History → 17. Agent Commission → 18. Agency Commission

**Phase 6: Redemptions**
19. Product Redemption → 20. Early Redemption

---

## 1. Agent Registration

### Required Fields
- `email` ✓
- `identityCardNumber` ✓
- `name` ✓
- `agencyId` ✓

### Preprocessing

**Clean email:**
```java
email = StringUtil.strip(email);
```

**Clean mobile number (remove spaces, dashes, plus):**
```java
mobileNumber = StringUtil.removeCharacters(mobileNumber, [' ', '-', '+']);
```

**Capitalize address fields:**
```java
address = StringUtil.capitalizeEachWord(address);
city = StringUtil.capitalizeEachWord(city);
state = StringUtil.capitalizeEachWord(state);
country = StringUtil.capitalizeEachWord(country);
```

**Clean postcode (remove .0 from Excel numbers):**
```java
if (postcode.endsWith(".0")) {
    postcode = postcode.substring(0, postcode.length() - 2).trim();
}
```

**Convert to enum:**
```java
identityDocType = StringUtil.getEnumFromString(IdentityDocumentType.class, identityDocTypeString);
agentRole = StringUtil.getEnumFromString(AgentRole.class, agentRoleString);
```

**Handle DOB:**
```java
dobString = StringUtil.isEmpty(dob) ? "1990-01-01" : dob;
dobDate = DateUtil.convertStringToDate(dobString);
```

### Validation Rules

1. **Email must not be used by CLIENT**
2. **If email used by AGENT, identity card must match**
3. **Agency must exist** (lookup by agencyId)

### Business Logic

**Generate Digital ID (Custom Utility):**
```java
DigitalIDResultVo digitalIDResult = DigitalIDUtil.createDigitalID(new DigitalIDBuilder()
    .builderType(DigitalIDBuilder.BuilderType.AGENT)
    .name(userDetail.getName())
    .agencyCode(agency.getAgencyCode()));

agent.setAgentId(digitalIDResult.getDigitalID());
```

**Generate Referral Code:**
```java
String referralCode = agency.getAgencyCode() + digitalIDResult.getRunningNumber();
agent.setReferralCode(referralCode);
```

**Password hashing (BCrypt):**
```java
String password = "PASSWORD";
String hashedPassword = BCrypt.with(BCrypt.Version.VERSION_2Y).hashToString(6, password.toCharArray());
appUser.setPassword(hashedPassword);
```

### Default Values
- Password: "PASSWORD" (BCrypt hashed)
- UserType: AGENT
- Agent Status: ACTIVE
- Agent Role: MGR (if not provided)
- DOB: 1990-01-01 (if not provided)

### Entities Created
1. **AppUser** (login credentials)
2. **UserDetail** (personal info)
3. **Agent** (agent-specific data)
4. **BankDetails** (optional, if bank account provided)

---

## 2. Agent Hierarchy

### Required Fields
- `agentIdentityCardNumber` ✓ (downline)
- `recruitManagerIdentityCardNumber` ✓ (upline)

### Business Logic

Simply link two existing agents:
```java
downLine.setRecruitManager(upLine);
```

**Both agents must exist with ACTIVE status before linking.**

---

## 3. Individual Client Registration

### Required Fields
- `email` ✓
- `identityCardNumber` ✓
- `name` ✓

### Preprocessing

Same as Agent, plus:

**Corresponding address logic:**
```java
if ("TRUE".equalsIgnoreCase(isSameCorrespondingAddress)) {
    correspondingAddress = address;
    correspondingPostcode = postcode;
    // ... copy all address fields
} else {
    correspondingAddress = StringUtil.capitalizeEachWord(correspondingAddress);
    // ... use provided corresponding address
}
```

**Additional enums:**
```java
gender = StringUtil.getEnumFromString(Gender.class, genderString);
maritalStatus = StringUtil.getEnumFromString(MaritalStatus.class, maritalStatusString);
employmentType = StringUtil.getEnumFromString(EmploymentType.class, employmentTypeString);
```

**PEP flag:**
```java
isPep = "TRUE".equalsIgnoreCase(isPepString);
```

### Validation Rules

1. **Email must not be used by AGENT**
2. **If email used by CLIENT, identity card must match**

### Business Logic

**Generate Digital ID:**
```java
DigitalIDResultVo digitalIDResult = DigitalIDUtil.createDigitalID(new DigitalIDBuilder()
    .builderType(DigitalIDBuilder.BuilderType.CLIENT)
    .name(userDetail.getName())
    .date(userDetail.getDob()));

client.setClientId(digitalIDResult.getDigitalID());
```

**Employment defaults (if EMPLOYED):**
```java
if (EmploymentType.EMPLOYED.equals(client.getEmploymentType())) {
    if (StringUtil.isEmpty(client.getEmployerName())) {
        client.setEmployerName("Please Update");
    }
    // ... same for other employer fields
}
```

**PEP Info (only if isPep = true):**
```java
if (isPep) {
    pepInfo.setPepType(relationship);
    pepInfo.setPepImmediateFamilyName(name);
    pepInfo.setPepPosition(position);
    pepInfo.setPepOrganisation(organisation);
}
```

### Default Values
- Password: "PASSWORD" (BCrypt hashed)
- UserType: CLIENT
- Client Status: true
- DOB: 1990-01-01 (if not provided)
- EmploymentType: EMPLOYED (if not provided)
- Employer fields: "Please Update" (if EMPLOYED and not provided)
- Corresponding address: Same as main address (if not specified)

### Entities Created
1. **AppUser** (login credentials)
2. **UserDetail** (personal info)
3. **Client** (client-specific data)
4. **PepInfo** (if isPep = true)

---

## 4. Client Bank Accounts

### Required Fields
- `clientIdentityCardNumber` ✓
- `bankAccountNumber` ✓

### Preprocessing

**Sanitize bank account number (remove ALL special characters):**
```java
sanitizedBankAccountNumber = StringUtil.removeAllSpecialCharacters(bankAccountNumber);
```

**Capitalize bank address:**
```java
bankAddress = StringUtil.capitalizeEachWord(bankAddress);
// ... same for city, state, country
```

### Entities Created
**BankDetails** linked to client's AppUser

---

## 5. Client Beneficiaries

### Required Fields
- `clientIdentityCardNumber` ✓
- `identityCardNumber` ✓ (beneficiary's IC)

### Preprocessing

**Gender uppercase:**
```java
gender = gender.toUpperCase();
```

**Mobile country code (add + prefix):**
```java
if (!mobileCountryCode.startsWith("+")) {
    mobileCountryCode = "+" + mobileCountryCode;
}
```

**All standard field processing:**
- Clean mobile number
- Capitalize addresses, nationality
- Convert enums (Gender, MaritalStatus, etc.)
- Convert DOB

### Entities Created
**IndividualBeneficiary** linked to client

---

## 6. Client Guardians

### Required Fields
- `clientIdentityCardNumber` ✓
- `identityCardNumber` ✓ (guardian's IC)

### Preprocessing

Same as Client Beneficiaries.

**Note:** Contact fields (mobile, email) are optional.

### Entities Created
**IndividualGuardian** linked to client

---

## 7. Beneficiary-Guardian Link

### Required Fields
- `clientIdentityCardNumber` ✓
- `beneficiaryIdentityCardNumber` ✓
- `guardianIdentityCardNumber` ✓

### Preprocessing

**Convert relationship enums:**
```java
relationshipToGuardian = StringUtil.getEnumFromString(Relationship.class, relationshipToGuardianString);
relationshipToBeneficiary = StringUtil.getEnumFromString(Relationship.class, relationshipToBeneficiaryString);
```

### Validation
**Both beneficiary and guardian must already exist for this client.**

### Entities Created
**IndividualBeneficiaryGuardian** (pivot table linking beneficiary to guardian)

---

## 8. Corporate Registration

### Required Fields
- `clientIdentityCardNumber` ✓ (representative individual client)
- `registrationNumber` ✓ (corporate reg number)

### Preprocessing

**Entity type uppercase:**
```java
entityType = entityType.toUpperCase();
```

**Business address logic:**
```java
isDifferentBusinessAddress = "TRUE".equalsIgnoreCase(isDifferentBusinessAddressString);

if (isDifferentBusinessAddress) {
    // Use provided business address
} else {
    // Copy from registered address
    businessAddress = registeredAddress;
    businessCity = city;
    // ...
}
```

**Contact person logic:**
```java
contactIsMyself = "TRUE".equalsIgnoreCase(contactIsMyselfString);

if (!contactIsMyself) {
    // Set contact person details
}
```

### Business Logic

**Generate Reference Number:**
```java
String corReferenceNumber = RandomCodeUtil.generateRandomCode(new RandomCodeBuilder()
    .prefix("COR" + System.currentTimeMillis())
    .postfix(RandomCodeBuilder.NUMBERS)
    .postfixLength(3));
```

**Generate Digital ID:**
```java
DigitalIDResultVo digitalIDResult = DigitalIDUtil.createDigitalID(new DigitalIDBuilder()
    .builderType(DigitalIDBuilder.BuilderType.CORPORATE_CLIENT)
    .name(entityName)
    .date(dateIncorporation));

corporateClient.setCorporateClientId(digitalIDResult.getDigitalID());
```

### Default Values
- Reference Number: "COR" + timestamp + 3 random digits
- Status: DRAFT (both CorporateClient and CorporateDetails)
- Business address: Same as registered (if not different)

### Entities Created
1. **CorporateClient** (corporate profile)
2. **CorporateDetails** (corporate info)

---

## 9. Corporate Shareholders

### Required Fields
- `companyRegistrationNumber` ✓
- `identityCardNumber` ✓ (shareholder's IC)

### Preprocessing

**Mobile country code, address processing** (same as individual beneficiaries)

**Percentage of shareholdings:**
```java
percentageOfShareholdings = Double.valueOf(percentageString);
```

**PEP flag:**
```java
isPep = "TRUE".equalsIgnoreCase(isPepString);
```

### Business Logic

**PEP Info (only if isPep = true):**
```java
if (isPep) {
    pepInfo.setPepType(relationship);
    pepInfo.setPepImmediateFamilyName(name);
    pepInfo.setPepPosition(position);
    pepInfo.setPepOrganisation(organisation);
}
```

### Entities Created
1. **CorporateShareholder** (shareholder details)
2. **PepInfo** (if PEP)
3. **CorporateShareholdersPivot** (links shareholder to corporate client)

**Note:** Total shareholdings should equal 100%

---

## 10. Corporate Beneficiaries

### Required Fields
- `companyRegistrationNumber` ✓
- `identityCardNumber` ✓

### Preprocessing
Same as Client Beneficiaries (gender uppercase, mobile processing, etc.)

### Entities Created
**CorporateBeneficiaries** linked to corporate client

---

## 11. Corporate Guardians

### Required Fields
- `companyRegistrationNumber` ✓
- `identityCardNumber` ✓

### Preprocessing
Same as Corporate Beneficiaries

### Entities Created
**CorporateGuardian** linked to corporate client

---

## 12. Corporate Beneficiary-Guardian Link

### Required Fields
- `companyRegistrationNumber` ✓
- `beneficiaryIdentityCardNumber` ✓
- `guardianIdentityCardNumber` ✓

### Preprocessing
Convert relationship enums (same as individual)

### Business Logic

**Different from Individual:** Updates beneficiary entity directly (no pivot table)
```java
beneficiary.setCorporateGuardian(guardian);
beneficiary.setRelationshipToSettlor(relationshipToBeneficiary);
beneficiary.setRelationshipToGuardian(relationshipToGuardian);
```

---

## 13. Corporate Bank Accounts

### Required Fields
- `companyRegistrationNumber` ✓
- `bankAccountNumber` ✓

### Preprocessing

**Important:** Account number is NOT sanitized (kept as-is, unlike individual bank accounts)

**Capitalize bank address fields only**

### Business Logic

Links to CorporateClient (not AppUser like individual accounts)

---

## 14. Product Orders

### Required Fields
- `purchaserIdentityNumber` ✓ (client IC or corporate reg number)
- `agreementNumber` ✓

### Preprocessing

**Sanitize agreement number:**
```java
agreementNumber = agreementNumber.replaceAll("/", "-").strip();
```

**Convert enums:**
```java
productOrderType = StringUtil.getEnumFromString(ProductOrderType.class, productOrderTypeString);
status = StringUtil.getEnumFromString(ProductOrder.ProductOrderStatus.class, statusString);
structureType = StringUtil.getEnumFromString(ProductDividendSchedule.StructureType.class, dividendTypeString);
```

**Convert numbers:**
```java
purchasedAmount = Double.valueOf(purchasedAmountString);
dividendPercentage = Double.valueOf(dividendPercentageString);
investmentTenureMonth = Integer.valueOf(investmentTenureMonthString);
```

**Convert dates:**
```java
agreementDate = DateUtil.convertStringToDate(agreementDateString);
agreementDateLocal = DateUtil.convertDateToLocalDate(agreementDate);
```

**Prorated flag:**
```java
isProrated = "TRUE".equalsIgnoreCase(isProratedString);
```

### Validation

Try to find individual client first, then corporate:
```java
client = clientDao.findByIC(purchaserIdentityNumber);
if (client == null) {
    corporateClient = corporateClientDao.findByRegNumber(purchaserIdentityNumber);
}
```

### Business Logic

**Generate order reference number:**
```java
orderReferenceNumber = ProductService.createOrderReferenceNumber();
```

**ProductOrderType mapping:**
```java
if (ProductOrderType.REALLOCATE.equals(productOrderType)) {
    productOrderType = ProductOrderType.ROLLOVER; // Convert REALLOCATE to ROLLOVER
}
```

**Tenure calculation:**
```java
startTenure = agreementDateLocal;
endTenure = agreementDateLocal.plusMonths(investmentTenureMonth).minusDays(1);
// Example: 2 years from 2025-01-01 = 2026-12-31
```

**Period & Dividend Counter (structure-based):**

For **FIXED** structure:
```java
quarter = DateUtil.getQuarter(LocalDate.now()); // Current quarter
periodStartingDate = quarter.getStartDate();
periodEndingDate = quarter.getEndDate();
dividendCounter = getFixedQuarterSequence(agreementDate, now) - 1;
```

For **FLEXIBLE** structure:
```java
localDates = getLastPeriodBeforeCurrent(agreementDate);
periodStartingDate = localDates[0];
periodEndingDate = localDates[1];
dividendCounter = getQuarterIntervalsByAddingMonths(agreementDate, now) - 1;
```

**Payment date (backdated):**
```java
paymentDate = agreementDate.minusDays(5);
```

### Default Values
- All workflow statuses: APPROVED (Checker, Finance, Approver)
- Agreement statuses: SUCCESS (Client, Witness)
- Payment Method: MANUAL_TRANSFER
- Payment Status: SUCCESS
- EnableLivingTrust: false
- Imported: true

### Entities Created
**ProductOrder** (can link to Client OR CorporateClient)

---

## 15. Product Order Beneficiaries

### Required Fields
- `agreementNumber` ✓
- `beneficiaryIdentityCardNumber` ✓

### Preprocessing

**Sanitize agreement number** (same as product order)

**Percentage:**
```java
percentageOfDistribution = Double.valueOf(percentageString);
```

### Business Logic

**Beneficiary Type Logic:**
```java
// Default to MAIN_BENEFICIARY
type = UserType.MAIN_BENEFICIARY;

// If main beneficiary IC provided and found
if (mainBeneficiaryExists) {
    type = UserType.SUB_BENEFICIARY;
    productBeneficiaries.setMainBeneficiary(mainBeneficiary);
}
```

**Handles both individual and corporate beneficiaries** based on product order type.

### Entities Created
**ProductBeneficiaries** (links beneficiary to product order)

---

## 16. Dividend History (Auto-Generated)

### Required Fields
- `agreementNumber` ✓

### Business Logic

**This migration GENERATES historical dividend records automatically.**

No additional input fields needed. It:
1. Gets product order configuration
2. Calculates all dividend periods from agreement date to current date
3. Creates ProductDividendCalculationHistory for each period

**Structure-based calculation:**

**FIXED:** Calendar quarters (Q1-Q4)
**FLEXIBLE:** Rolling 3-month periods from agreement date

**Stops when reaching current period** (period containing today's date)

### Custom Utilities Used
```java
DividendService.getPayoutFrequency(frequency)
DividendService.calculateFixedPeriodStartingDate(agreementDate, frequency)
DividendService.calculateFixedPeriodEndingDate(periodStart, frequency)
DividendService.calculateFlexiblePeriodEndingDate(periodStart, frequency)
```

---

## 17. Agent Commission History

### Required Fields
- `agreementNumber` ✓
- `managerIdentityCardNumber` ✓ (MGR)

### Preprocessing

**Sanitize agreement number** (same as product order)

**Convert commission amounts for each level:**
```java
mgrCommissionPercentage = Double.valueOf(mgrCommissionPercentageString);
mgrCommissionAmount = Double.valueOf(mgrCommissionAmountString);
// ... repeat for P2P, SM, AVP, VP levels
```

**Convert dates:**
```java
commissionCalculatedDate = LocalDate.parse(commissionCalculatedDateString);
paymentDate = DateUtil.convertStringToDate(paymentDateString);
```

### Business Logic

**Generate commission reference:**
```java
String referenceNumber = RandomCodeUtil.generateRandomCode(new RandomCodeBuilder()
    .prefix("COM" + System.currentTimeMillis())
    .postfix(RandomCodeBuilder.NUMBERS)
    .postfixLength(3));
```

**Commission hierarchy:**
- **MGR** (Manager): Always created - PERSONAL commission
- **P2P, SM, AVP, VP**: Optional - OVERRIDING commission (only if IC provided AND amount > 0)
- **SVP**: Tracked but no commission history created

**Two entities created:**
1. **AgentCommissionCalculationHistory** - One record with ALL agent commissions
2. **AgentCommissionHistory** - Multiple records, one per agent

### Default Values
- Reference Number: "COM" + timestamp + 3 digits
- Payment Status: SUCCESS (all records)
- MGR Commission Type: PERSONAL
- Others: OVERRIDING

---

## 18. Agency Commission History

### Required Fields
- `agreementNumber` ✓
- `agencyRegistrationNumber` ✓

### Preprocessing

**Same as Agent Commission** (sanitize agreement, convert numbers, dates)

**Additional field:**
```java
ytdSales = Double.valueOf(ytdSalesString); // Year-to-date sales
```

### Business Logic

**Generate commission reference** (same format as agent commission)

**Single entity created:**
**AgencyCommissionCalculationHistory** only (no separate history table)

### Default Values
- Reference Number: "COM" + timestamp + 3 digits
- Payment Status: SUCCESS
- Payment Date: Current date (if not provided)

---

## 19. Product Redemption

### Required Fields
- `agreementNumber` ✓
- `withdrawalMethod` ✓

### Preprocessing

**Sanitize agreement number**

**Convert enum:**
```java
redemptionType = StringUtil.getEnumFromString(ProductRedemption.RedemptionType.class, withdrawalMethodString);
```

**Convert amount:**
```java
withdrawalAmount = Double.valueOf(withdrawalAmountString);
```

### Business Logic

**One redemption per product order** (updates if exists)

### Default Values
- Status: SUCCESS
- StatusChecker: APPROVE_CHECKER
- StatusApprover: APPROVE_APPROVER
- UpdatedBankResult: true
- GeneratedBankFile: true

### Entities Created
**ProductRedemption** (regular/maturity redemption)

---

## 20. Early Redemption

### Required Fields
- `agreementNumber` ✓
- `withdrawalMethod` ✓

### Preprocessing

**Same as Product Redemption, plus:**

**Penalty fields:**
```java
penaltyAmount = Double.valueOf(penaltyAmountString);
penaltyPercentage = Double.valueOf(penaltyPercentageString);
```

### Business Logic

**Generate redemption reference:**
```java
String redemptionReferenceNumber = RandomCodeUtil.generateRandomCode(new RandomCodeBuilder()
    .prefix("RED" + System.currentTimeMillis())
    .postfix(RandomCodeBuilder.NUMBERS)
    .postfixLength(3));
```

**Always creates NEW record** (no update logic - allows multiple early redemptions)

### Default Values
- Reference Number: "RED" + timestamp + 3 digits
- All statuses: SUCCESS/APPROVED
- Signature statuses: SUCCESS (Client, Witness)
- Bank flags: true

### Entities Created
**ProductEarlyRedemptionHistory** (always new record)

---

## Common Preprocessing Patterns

### String Transformations
```java
// Clean email
email = StringUtil.strip(email);

// Clean mobile (remove spaces, dashes, plus)
mobileNumber = StringUtil.removeCharacters(mobileNumber, [' ', '-', '+']);

// Capitalize addresses
address = StringUtil.capitalizeEachWord(address);

// Excel postcode cleanup (remove .0)
if (postcode.endsWith(".0")) {
    postcode = postcode.substring(0, postcode.length() - 2).trim();
}

// Add + to country code
if (!mobileCountryCode.startsWith("+")) {
    mobileCountryCode = "+" + mobileCountryCode;
}

// Gender uppercase
gender = gender.toUpperCase();

// Sanitize agreement number
agreementNumber = agreementNumber.replaceAll("/", "-").strip();

// Sanitize bank account (remove ALL special chars)
bankAccountNumber = StringUtil.removeAllSpecialCharacters(bankAccountNumber);
```

### Enum Conversions
```java
enumValue = StringUtil.getEnumFromString(EnumType.class, stringValue);
```

### Boolean Conversions
```java
boolValue = "TRUE".equalsIgnoreCase(stringValue);
```

### Date Handling
```java
// Default DOB if not provided
dobString = StringUtil.isEmpty(dob) ? "1990-01-01" : dob;

// String to Date
date = DateUtil.convertStringToDate(dateString);

// Date to LocalDate
localDate = DateUtil.convertDateToLocalDate(date);

// ISO string to LocalDate
localDate = LocalDate.parse(dateString);
```

### Numeric Conversions
```java
doubleValue = Double.valueOf(stringValue);
intValue = Integer.valueOf(stringValue);
```

---

## Custom Business Logic Utilities

### Digital ID Generation
```java
DigitalIDResultVo digitalIDResult = DigitalIDUtil.createDigitalID(new DigitalIDBuilder()
    .builderType(DigitalIDBuilder.BuilderType.AGENT)  // or CLIENT, CORPORATE_CLIENT
    .name(name)
    .agencyCode(agencyCode));  // for AGENT only
    .date(dob));  // for CLIENT, CORPORATE_CLIENT

String digitalId = digitalIDResult.getDigitalID();
String runningNumber = digitalIDResult.getRunningNumber();
```

### Random Code Generation
```java
String referenceNumber = RandomCodeUtil.generateRandomCode(new RandomCodeBuilder()
    .prefix("PREFIX" + System.currentTimeMillis())
    .postfix(RandomCodeBuilder.NUMBERS)  // or ALPHABETS, ALPHANUMERIC
    .postfixLength(3));
```

**Prefixes used:**
- Agent Commission: "COM"
- Agency Commission: "COM"
- Corporate Reference: "COR"
- Early Redemption: "RED"

### Password Hashing (BCrypt)
```java
String password = "PASSWORD";
String hashedPassword = BCrypt.with(BCrypt.Version.VERSION_2Y).hashToString(6, password.toCharArray());
```

---

## Validation Checklist

Before inserting each record:

✅ **Required fields present**
✅ **Parent entities exist** (e.g., Client exists before adding beneficiary)
✅ **Enum values valid** (convert strings to enums)
✅ **Email/IC uniqueness** (check against existing records)
✅ **Lookup dependencies** (Agency, Agent, Product, etc.)
✅ **Apply string transformations** (capitalize, clean, sanitize)
✅ **Set default values** (if fields not provided)
✅ **Generate IDs** (Digital ID, Reference Numbers)

---

## Error Handling Strategy

### Strict (Throw Exception, Stop Process)
- Agent registration
- Client registration
- Product Order creation
- Missing required dependencies

### Lenient (Log Error, Continue)
- Child entities (beneficiaries, guardians)
- Commission history
- Redemption history
- Optional relationships

---

## Testing Checklist

For each migration:

- [ ] All preprocessing applied correctly
- [ ] Required validations pass
- [ ] Parent entities exist
- [ ] Enums convert successfully
- [ ] Dates parse correctly
- [ ] Numbers convert properly
- [ ] Default values applied
- [ ] IDs generated uniquely
- [ ] Relationships established
- [ ] Upsert logic works (create new OR update existing)
