# CAPSTAR Migration API Documentation

## Overview

This document defines the API structure for migrating CAPSTAR data into the Citadel platform. The migration process supports importing clients, agents, product orders, beneficiaries, guardians, and their relationships through JSON-based REST API endpoints.

**Base URL**: `/citadelBackend/api/migration`

**Authentication**: Not required

**Content-Type**: `application/json`

---

## API Endpoints

### 1. Migrate Client Data
**Endpoint**: `POST /citadelBackend/api/migration/client`

**Description**: Import individual client information including personal details, employment, PEP status, and address information.

#### Request Structure

```json
{
  "clients": [
    {
      "email": "john.doe@example.com",
      "name": "John Doe",
      "agentID": "AGENT001",
      "mobileCountryCode": "+60",
      "mobileNumber": "123456789",
      "identityCardNumber": "900101-01-5678",
      "identityDocType": "NRIC",
      "address": "123 Jalan Bukit Bintang",
      "postcode": "55100",
      "city": "Kuala Lumpur",
      "state": "Wilayah Persekutuan",
      "country": "Malaysia",
      "isSameCorrespondingAddress": "Y",
      "correspondingAddress": "123 Jalan Bukit Bintang",
      "correspondingPostcode": "55100",
      "correspondingCity": "Kuala Lumpur",
      "correspondingState": "Wilayah Persekutuan",
      "correspondingCountry": "Malaysia",
      "dob": "1990-01-01",
      "gender": "MALE",
      "nationality": "Malaysian",
      "maritalStatus": "SINGLE",
      "residentialStatus": "PERMANENT_RESIDENT",
      "employmentType": "EMPLOYED",
      "employerName": "ABC Corporation Sdn Bhd",
      "industryType": "FINANCE",
      "jobTitle": "Financial Analyst",
      "employerAddress": "456 Jalan Ampang",
      "employerPostcode": "50450",
      "employerCity": "Kuala Lumpur",
      "employerState": "Wilayah Persekutuan",
      "employerCountry": "Malaysia",
      "annualIncomeDeclaration": "RM100000-RM150000",
      "sourceOfIncome": "SALARY",
      "sourceOfIncomeRemark": "",
      "isPep": "N",
      "pepRelationship": "",
      "pepRelationshipName": "",
      "pepPosition": "",
      "pepOrganisation": ""
    }
  ]
}
```

#### Response Structure

```json
{
  "code": "SUCCESS",
  "message": "Client migration completed",
  "data": {
    "totalRecords": 1,
    "successCount": 1,
    "failureCount": 0,
    "errors": []
  }
}
```

#### Field Descriptions

| Field                              | Type | Required | Description | Valid Values                                                                         |
|------------------------------------|------|----------|-------------|--------------------------------------------------------------------------------------|
| email                              | String | Yes | Client email address | Valid email format                                                                   |
| name                               | String | Yes | Full name as per IC/Passport | -                                                                                    |
| agentID                            | String | Yes | Agent IC who recruited this client | Valid IC number                                                                      |
| mobileCountryCode                  | String | Yes | Country code for mobile | E.g., +60                                                                            |
| mobileNumber                       | String | Yes | Mobile number without country code | 9-10 digits                                                                          |
| identityCardNumber                 | String | Yes | IC/Passport number | -                                                                                    |
| identityDocType                    | String | Yes | Type of identity document | NRIC, PASSPORT                                                                       |
| address                            | String | Yes | Residential address | -                                                                                    |
| postcode                           | String | Yes | Postal code | -                                                                                    |
| city                               | String | Yes | City name | -                                                                                    |
| state                              | String | Yes | State/Province | -                                                                                    |
| country                            | String | Yes | Country name | -                                                                                    |
| isSameCorrespondingAddress         | String | Yes | Same as residential address | Y, N                                                                                 |
| correspondingAddress               | String | Conditional | Mailing address (if different) | Required if isSameCorrespondingAddress = N                                           |
| correspondingPostcode              | String | Conditional | Mailing postal code | Required if isSameCorrespondingAddress = N                                           |
| correspondingCity                  | String | Conditional | Mailing city | Required if isSameCorrespondingAddress = N                                           |
| correspondingState                 | String | Conditional | Mailing state | Required if isSameCorrespondingAddress = N                                           |
| correspondingCountry               | String | Conditional | Mailing country | Required if isSameCorrespondingAddress = N                                           |
| dob                                | String | Yes | Date of birth | Format: YYYY-MM-DD                                                                   |
| gender                             | String | Yes | Gender | MALE, FEMALE                                                                         |
| nationality                        | String | Yes | Nationality | -                                                                                    |
| maritalStatus                      | String | Yes | Marital status | SINGLE, MARRIED, DIVORCED, WIDOWED                                                   |
| residentialStatus                  | String | Yes | Residential status | CITIZEN, PERMANENT_RESIDENT, RESIDENT, NON_RESIDENT                        |
| employmentType                     | String | Yes | Employment type | EMPLOYED, SELF_EMPLOYED, UNEMPLOYED, RETIRED                                         |
| employerName                       | String | Conditional | Employer name | Required if employmentType = EMPLOYED                                                |
| industryType                       | String | Conditional | Industry type | Required if employmentType = EMPLOYED/SELF_EMPLOYED                                  |
| jobTitle                           | String | Conditional | Job title/position | Required if employmentType = EMPLOYED                                                |
| employerAddress                    | String | Conditional | Employer address | Required if employmentType = EMPLOYED                                                |
| employerPostcode                   | String | Conditional | Employer postal code | Required if employmentType = EMPLOYED                                                |
| employerCity                       | String | Conditional | Employer city | Required if employmentType = EMPLOYED                                                |
| employerState                      | String | Conditional | Employer state | Required if employmentType = EMPLOYED                                                |
| employerCountry                    | String | Conditional | Employer country | Required if employmentType = EMPLOYED                                                |
| annualIncomeDeclaration            | String | Yes | Annual income range | BELOW_500K, ABOVE_500K                                                               |
| sourceOfIncome                     | String | Yes | Primary source of income | BUSINESS_REVENUE, COMMISSION, INHERITANCE, INVESTMENT_PROCEEDS, SALARY_BONUS, OTHERS |
| sourceOfIncomeRemark               | String | Conditional | Additional remarks | Required if sourceOfIncome = OTHERS                                                  |
| isPep (Politically Exposed Person) | String | Yes | Politically Exposed Person | Y, N                                                                                 |
| pepRelationship                    | String | Conditional | Relationship to PEP | Required if isPep = Y: SELF, FAMILY, ASSOCIATE, SPOUSE, PARENTS                      |
| pepRelationshipName                | String | Conditional | Name of PEP (if family/associate) | Required if pepRelationship = FAMILY_MEMBER or CLOSE_ASSOCIATE                       |
| pepPosition                        | String | Conditional | Position held | Required if isPep = Y                                                                |
| pepOrganisation                    | String | Conditional | Organisation name | Required if isPep = Y                                                                |

---

### 2. Migrate Client Bank Accounts
**Endpoint**: `POST /citadelBackend/api/migration/client-bank-accounts`

**Description**: Import client bank account information for dividend payments and redemptions.

#### Request Structure

```json
{
  "clientBankAccounts": [
    {
      "clientIdentityCardNumber": "900101-01-5678",
      "bankAccountNumber": "1234567890",
      "bankAccountHolderName": "John Doe",
      "bankName": "Maybank",
      "bankSwiftCode": "MBBEMYKL",
      "bankAddress": "Menara Maybank, 100 Jalan Tun Perak",
      "bankPostcode": "50050",
      "bankCity": "Kuala Lumpur",
      "bankState": "Wilayah Persekutuan",
      "bankCountry": "Malaysia"
    }
  ]
}
```

#### Response Structure

```json
{
  "code": "SUCCESS",
  "message": "Client bank accounts migration completed",
  "data": {
    "totalRecords": 1,
    "successCount": 1,
    "failureCount": 0,
    "errors": []
  }
}
```

#### Field Descriptions

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| clientIdentityCardNumber | String | Yes | Client IC number (foreign key) |
| bankAccountNumber | String | Yes | Bank account number |
| bankAccountHolderName | String | Yes | Account holder name (must match client name) |
| bankName | String | Yes | Bank name |
| bankSwiftCode | String | No | SWIFT code |
| bankAddress | String | Yes | Bank branch address |
| bankPostcode | String | Yes | Bank branch postal code |
| bankCity | String | Yes | Bank branch city |
| bankState | String | Yes | Bank branch state |
| bankCountry | String | Yes | Bank branch country |

---

### 3. Migrate Client Beneficiaries
**Endpoint**: `POST /citadelBackend/api/migration/client-beneficiaries`

**Description**: Import beneficiary information for clients (inheritance designation).

#### Request Structure

```json
{
  "clientBeneficiaries": [
    {
      "clientIdentityCardNumber": "900101-01-5678",
      "relationshipToClient": "CHILD",
      "name": "Jane Doe",
      "identityCardNumber": "120101-01-9999",
      "identityDocType": "NRIC",
      "dob": "2012-01-01",
      "gender": "FEMALE",
      "nationality": "Malaysian",
      "address": "123 Jalan Bukit Bintang",
      "postcode": "55100",
      "city": "Kuala Lumpur",
      "state": "Wilayah Persekutuan",
      "country": "Malaysia",
      "mobileCountryCode": "+60",
      "mobileNumber": "987654321",
      "email": "jane.doe@example.com",
      "maritalStatus": "SINGLE",
      "residentialStatus": "PERMANENT_RESIDENT"
    }
  ]
}
```

#### Response Structure

```json
{
  "code": "SUCCESS",
  "message": "Client beneficiaries migration completed",
  "data": {
    "totalRecords": 1,
    "successCount": 1,
    "failureCount": 0,
    "errors": []
  }
}
```

#### Field Descriptions

| Field | Type | Required | Description | Valid Values                                          |
|-------|------|----------|-------------|-------------------------------------------------------|
| clientIdentityCardNumber | String | Yes | Client IC number (foreign key) | -                                                     |
| relationshipToClient | String | Yes | Relationship to client | SPOUSE, CHILD, PARENT, SIBLING, ADMINISTRATOR, FAMILY |
| name | String | Yes | Beneficiary full name | -                                                     |
| identityCardNumber | String | Yes | Beneficiary IC/Passport number | -                                                     |
| identityDocType | String | Yes | Type of identity document | NRIC, PASSPORT, BIRTH_CERTIFICATE                     |
| dob | String | Yes | Date of birth | Format: YYYY-MM-DD                                    |
| gender | String | Yes | Gender | MALE, FEMALE                                          |
| nationality | String | Yes | Nationality | -                                                     |
| address | String | Yes | Residential address | -                                                     |
| postcode | String | Yes | Postal code | -                                                     |
| city | String | Yes | City name | -                                                     |
| state | String | Yes | State/Province | -                                                     |
| country | String | Yes | Country name | -                                                     |
| mobileCountryCode | String | No | Country code for mobile | E.g., +60                                             |
| mobileNumber | String | No | Mobile number | -                                                     |
| email | String | No | Email address | -                                                     |
| maritalStatus | String | Yes | Marital status | SINGLE, MARRIED, DIVORCED, WIDOWED                    |
| residentialStatus | String | Yes | Residential status | CITIZEN, PERMANENT_RESIDENT, RESIDENT, NON_RESIDENT  |

---

### 4. Migrate Client Guardians
**Endpoint**: `POST /citadelBackend/api/migration/client-guardians`

**Description**: Import guardian information for minor clients (below 18 years old).

#### Request Structure

```json
{
  "clientGuardians": [
    {
      "clientIdentityCardNumber": "120101-01-9999",
      "relationshipToClient": "CHILD",
      "name": "John Doe",
      "identityCardNumber": "900101-01-5678",
      "identityDocType": "NRIC",
      "dob": "1990-01-01",
      "gender": "MALE",
      "nationality": "Malaysian",
      "address": "123 Jalan Bukit Bintang",
      "postcode": "55100",
      "city": "Kuala Lumpur",
      "state": "Wilayah Persekutuan",
      "country": "Malaysia",
      "mobileCountryCode": "+60",
      "mobileNumber": "123456789",
      "email": "john.doe@example.com",
      "maritalStatus": "MARRIED",
      "residentialStatus": "PERMANENT_RESIDENT"
    }
  ]
}
```

#### Response Structure

```json
{
  "code": "SUCCESS",
  "message": "Client guardians migration completed",
  "data": {
    "totalRecords": 1,
    "successCount": 1,
    "failureCount": 0,
    "errors": []
  }
}
```

#### Field Descriptions

| Field | Type | Required | Description | Valid Values                                          |
|-------|------|----------|-------------|-------------------------------------------------------|
| clientIdentityCardNumber | String | Yes | Client IC number (foreign key) | -                                                     |
| relationshipToClient | String | Yes | Relationship to client | SPOUSE, CHILD, PARENT, SIBLING, ADMINISTRATOR, FAMILY |
| name | String | Yes | Beneficiary full name | -                                                     |
| identityCardNumber | String | Yes | Beneficiary IC/Passport number | -                                                     |
| identityDocType | String | Yes | Type of identity document | NRIC, PASSPORT, BIRTH_CERTIFICATE                     |
| dob | String | Yes | Date of birth | Format: YYYY-MM-DD                                    |
| gender | String | Yes | Gender | MALE, FEMALE                                          |
| nationality | String | Yes | Nationality | -                                                     |
| address | String | Yes | Residential address | -                                                     |
| postcode | String | Yes | Postal code | -                                                     |
| city | String | Yes | City name | -                                                     |
| state | String | Yes | State/Province | -                                                     |
| country | String | Yes | Country name | -                                                     |
| mobileCountryCode | String | No | Country code for mobile | E.g., +60                                             |
| mobileNumber | String | No | Mobile number | -                                                     |
| email | String | No | Email address | -                                                     |
| maritalStatus | String | Yes | Marital status | SINGLE, MARRIED, DIVORCED, WIDOWED                    |
| residentialStatus | String | Yes | Residential status | CITIZEN, PERMANENT_RESIDENT, RESIDENT, NON_RESIDENT  |

---

### 5. Migrate Client Beneficiary-Guardian Relationships
**Endpoint**: `POST /citadelBackend/api/migration/client-beneficiary-guardians`

**Description**: Map guardians to minor beneficiaries (beneficiaries below 18 years who need guardian approval).

#### Request Structure

```json
{
  "clientBeneficiaryGuardians": [
    {
      "clientIdentityCardNumber": "900101-01-5678",
      "beneficiaryIdentityCardNumber": "120101-01-9999",
      "guardianIdentityCardNumber": "900101-01-5678",
      "relationshipToGuardian": "CHILD",
      "relationshipToBeneficiary": "PARENT"
    }
  ]
}
```

#### Response Structure

```json
{
  "code": "SUCCESS",
  "message": "Client beneficiary-guardian relationships migration completed",
  "data": {
    "totalRecords": 1,
    "successCount": 1,
    "failureCount": 0,
    "errors": []
  }
}
```

#### Field Descriptions

| Field | Type | Required | Description | Valid Values                                                         |
|-------|------|----------|-------------|----------------------------------------------------------------------|
| clientIdentityCardNumber | String | Yes | Client IC number | -                                                                    |
| beneficiaryIdentityCardNumber | String | Yes | Minor beneficiary IC number | -                                                                    |
| guardianIdentityCardNumber | String | Yes | Guardian IC number | -                                                                    |
| relationshipToGuardian | String | Yes | Beneficiary's relationship to guardian | FAMILY, GRANDPARENT, PARENTS, GRANDPARENT, SIBLING, GRAND_DAUGHTER, GRAND_SON |
| relationshipToBeneficiary | String | Yes | Guardian's relationship to beneficiary | FAMILY, GRANDPARENT, PARENTS, GRANDPARENT, SIBLING, GRAND_DAUGHTER, GRAND_SON                                |

---

### 6. Migrate Agent Data
**Endpoint**: `POST /citadelBackend/api/migration/agent`

**Description**: Import agent information including personal details, bank account, and agency hierarchy.

#### Request Structure

```json
{
  "agents": [
    {
      "agentId": "AGENT001",
      "identityCardNumber": "880123-01-1234"
    }
  ]
}
```

#### Response Structure

```json
{
  "code": "SUCCESS",
  "message": "Agent migration completed",
  "data": {
    "totalRecords": 1,
    "successCount": 1,
    "failureCount": 0,
    "errors": []
  }
}
```

#### Field Descriptions

| Field | Type | Required | Description | Valid Values |
|-------|------|----------|-------------|--------------|
| referralCode | String | Yes | Unique agent referral code | Alphanumeric, uppercase |
| identityCardNumber | String | Yes | IC/Passport number | Unique |

---

### 8. Migrate Product Orders
**Endpoint**: `POST /citadelBackend/api/migration/product-orders`

**Description**: Import investment product orders from CAPSTAR including agreement details, tenure, and dividend information.

#### Request Structure

```json
{
  "productOrders": [
    {
      "purchaserIdentityNumber": "900101-01-5678",
      "agentId" : "AGENT001",
      "agreementNumber": "AGR-2024-00001",
      "productOrderType": "NEW",
      "productCode": "CCREL",
      "purchasedAmount": "50000.00",
      "dividendPercentage": "8.00",
      "investmentTenureMonth": "12",
      "status": "ACTIVE",
      "submissionDate": "2024-01-15",
      "agreementDate": "2024-01-15",
      "startTenure": "2024-02-01",
      "endTenure": "2025-01-31",
      "purchaserBankAccountNumber": "1234567890",
      "beneficiaries" : [
        {
            "beneficiaryIdentityCardNumber": "120101-01-9999",
            "percentageOfDistribution": "100.00"
        },
        {
          "beneficiaryIdentityCardNumber": "900101-01-5678",
          "mainBeneficiaryIdentityCardNumber": "120101-01-9999",
          "percentageOfDistribution": "100.00"
        }
      ]
    }
  ]
}
```

#### Response Structure

```json
{
  "code": "SUCCESS",
  "message": "Product orders migration completed",
  "data": {
    "totalRecords": 1,
    "successCount": 1,
    "failureCount": 0,
    "errors": []
  }
}
```

#### Field Descriptions

| Field                      | Type | Required | Description                          | Valid Values                                |
|----------------------------|------|----------|--------------------------------------|---------------------------------------------|
| purchaserIdentityNumber    | String | Yes | Client/Corporate IC number           | -                                           |
| agentId                    | String | Yes | Agent unique code/ID                 | -                                           |
| agreementNumber            | String | Yes | Unique agreement number from CAPSTAR | Must be unique                              |
| productOrderType           | String | Yes | Type of order                        | NEW, ROLLOVER, REDEMPTION                   |
| productCode                | String | Yes | Product code                         | CCREL, CCFLX, etc. (must exist in system)   |
| purchasedAmount            | String | Yes | Investment amount in MYR             | Min: 10000.00                               |
| dividendPercentage         | String | Yes | Dividend/profit rate                 | Decimal value (e.g., 8.00 for 8%)           |
| investmentTenureMonth      | String | Yes | Investment tenure in months          | Integer value (6, 12, 24, 36, etc.)         |
| status                     | String | Yes | Order status                         | ACTIVE, MATURED, REDEEMED, CANCELLED        |
| submissionDate             | String | Yes | Date order was submitted             | Format: YYYY-MM-DD                          |
| agreementDate              | String | Yes | Date agreement was signed            | Format: YYYY-MM-DD                          |
| startTenure                | String | Yes | Investment start date                | Format: YYYY-MM-DD                          |
| endTenure                  | String | Yes | Investment end date                  | Format: YYYY-MM-DD                          |
| purchaserBankAccountNumber | String | Yes | Client's bank account for dividends  | Must match client's registered bank account |
| beneficiaryIdentityCardNumber | String | Yes | Beneficiary IC number |
| mainBeneficiaryIdentityCardNumber | String | Yes | Main client IC number (must match purchaser) |
| percentageOfDistribution | String | Yes | Distribution percentage (decimal, e.g., 50.00 for 50%) |

**Validation Rules**:
- `purchaserIdentityNumber` must exist in Client or Corporate table
- `productCode` must exist in Product table
- `agreementNumber` must be unique across all orders
- `startTenure` must be before `endTenure`
- `endTenure` must equal `startTenure` + `investmentTenureMonth` - 1 day
- `purchasedAmount` must meet product minimum investment requirement
- `dividendPercentage` must be within product's allowed range
- `purchaserBankAccountNumber` must match a registered bank account for the purchaser
- `beneficiaryIdentityCardNumber` must exist in ClientBeneficiaries table
- - Total `percentageOfDistribution` for all beneficiaries of one agreement must equal 100.00
- - Each `percentageOfDistribution` must be > 0 and <= 100

---

## Common Response Structure

### Success Response

```json
{
  "code": "SUCCESS",
  "message": "Api Request Successful",
  "data": {
    "totalRecords": 100,
    "successCount": 100,
    "failureCount": 0,
    "errors": []
  }
}
```

### Error Response

```json
{
  "code": "ERROR",
  "message": "Api Request Failed",
  "data": {
    "totalRecords": 100,
    "successCount": 95,
    "failureCount": 5,
    "errors": [
      {
        "recordIndex": 15,
        "identityCardNumber": "900101-01-5678",
        "errorMessage": "Client with this IC number already exists",
        "errorCode": "DUPLICATE_ENTRY"
      },
      {
        "recordIndex": 42,
        "identityCardNumber": "880123-01-1234",
        "errorMessage": "Invalid email format",
        "errorCode": "VALIDATION_ERROR"
      }
    ]
  }
}
```

---

## Error Codes and Handling

### HTTP Status Codes

| Status Code | Description |
|-------------|-------------|
| 200 OK | Migration completed (with partial success details) |
| 400 Bad Request | Invalid request format or missing required fields |
| 409 Conflict | Duplicate entry (e.g., IC number, email, agreement number) |
| 422 Unprocessable Entity | Validation errors in data |
| 500 Internal Server Error | Server error during processing |

### Application Error Codes

| Error Code | Description | Resolution |
|------------|-------------|------------|
| DUPLICATE_ENTRY | Record already exists (IC, email, agreement number) | Update existing record or skip |
| VALIDATION_ERROR | Field validation failed | Check field format and constraints |
| MISSING_REQUIRED_FIELD | Required field is null or empty | Provide all required fields |
| INVALID_FORMAT | Field format is incorrect | Check date formats, email formats, etc. |
| BUSINESS_RULE_VIOLATION | Business logic constraint violated | Review business rules (e.g., percentage total = 100) |
| AGENT_NOT_FOUND | Agent IC number not found in system | Migrate agent data first |
| CLIENT_NOT_FOUND | Client IC number not found in system | Migrate client data first |
| PRODUCT_NOT_FOUND | Product code does not exist | Verify product code against system |
| INVALID_DATE_RANGE | Date range is invalid | Ensure start date < end date |

---

## Validation Strategy

### Pre-Migration Validation

1. **Data Format Validation**
   - Validate all date formats (YYYY-MM-DD)
   - Validate email formats
   - Validate phone number formats
   - Validate IC number formats (Malaysian IC: YYMMDD-PB-GGGG)
   - Validate monetary amounts (decimal with 2 places)

2. **Business Rule Validation**
   - Age validation (clients must be >= 18, or have guardian if < 18)
   - PEP fields required if `isPep = Y`
   - Employment fields required if `employmentType = EMPLOYED`
   - Corresponding address fields required if `isSameCorrespondingAddress = N`
   - Bank account holder name should match client/agent name
   - Investment amount must meet product minimum
   - Total beneficiary distribution percentage must equal 100%

3. **Referential Integrity Validation**
   - Agent IC must exist before creating client with that agent
   - Client IC must exist before creating bank accounts, beneficiaries, guardians
   - Beneficiary IC must exist before mapping to guardians
   - Product order purchaser must exist in client/corporate table
   - Product code must exist in product master table

4. **Uniqueness Validation**
   - Email must be unique across clients and agents
   - IC number must be unique within entity type
   - Agreement number must be unique across all product orders
   - Referral code must be unique across all agents

### During Migration Processing

1. **Transaction Management**
   - Each record is processed within a database transaction
   - Failed records do not rollback successful records
   - Partial success is allowed with detailed error reporting

2. **Error Logging**
   - Each failed record is logged with:
     - Record index in the request array
     - Identifying field (IC number, email, agreement number)
     - Error message with details
     - Error code for programmatic handling

3. **Idempotency**
   - Migration can be re-run safely
   - Duplicate entries are detected and skipped
   - Idempotency is based on unique identifiers (IC number, agreement number)

---

## Migration Sequence and Dependencies

To ensure successful migration, data should be migrated in the following order:

```
1. Agents
   ↓
2. Clients (requires: Agents to be migrated first)
   ↓
3. Client Bank Accounts (requires: Clients)
   ↓
4. Client Guardians (requires: Clients)
   ↓
5. Client Beneficiaries (requires: Clients)
   ↓
6. Client Beneficiary-Guardian Relationships (requires: Clients, Guardians, Beneficiaries)
   ↓
7. Product Orders (requires: Clients, Client Bank Accounts)
```

## Data Type Specifications

### Date Format
- **Format**: `YYYY-MM-DD` (ISO 8601)
- **Examples**:
  - `2024-01-15`
  - `1990-01-01`

### Monetary Amount Format
- **Format**: Decimal string with 2 decimal places
- **Examples**:
  - `50000.00`
  - `8.50`
- **No currency symbols or thousand separators**

### Boolean Values
- **Format**: String "Y" or "N"
- **Examples**:
  - `"Y"` for Yes/True
  - `"N"` for No/False

### Identity Card Number Format (Malaysian NRIC)
- **Format**: `YYMMDD-PB-GGGG`
- **Example**: `900101-01-5678`
- **Components**:
  - YY: Year of birth
  - MM: Month of birth
  - DD: Day of birth
  - PB: Place of birth code
  - GGGG: Sequential number

### Phone Number Format
- **Mobile Country Code**: `+60` (with plus sign)
- **Mobile Number**: 9-10 digits without country code
- **Examples**:
  - mobileCountryCode: `"+60"`
  - mobileNumber: `"123456789"`

### Email Format
- **Format**: Valid email per RFC 5322
- **Examples**: `john.doe@example.com`

---

**End of Document**
