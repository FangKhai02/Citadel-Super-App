# CAPSTAR NEW Product Order and Callback API Documentation V1

### Date : 07-11-2025

## Overview

This document defines the callback API structure for Citadel to send dividend calculation and payment status updates
back to the CAPSTAR system. These callbacks are triggered automatically when dividend calculations are completed or
payment statuses are updated in the Citadel platform.

**Direction**: Citadel → CAPSTAR (Outbound callbacks)

**Base URL**: `{CAPSTAR_BASE_URL}/api/callback` (to be provided by CAPSTAR)

**Authentication**: API Key based (to be provided by CAPSTAR)

**Content-Type**: `application/json`

**Headers**:

```
X-API-Key: {CAPSTAR_API_KEY}
Content-Type: application/json
```

---

## CAPSTAR to Citadel API Endpoints

### 1. New Product Order Request API

**Endpoint**: `POST {CITADEL_BASE_URL}/api/external-agency/product-order-request`

**Direction**: CAPSTAR → Citadel (Inbound API Request)

**Description**: CAPSTAR calls this Citadel API endpoint to create a new product order in the Citadel system. This
request is sent when CAPSTAR needs to submit a new investment order on behalf of a client or agent.

**Use Cases**:

- CAPSTAR creates product order for migrated client
- CAPSTAR initiates bulk product orders
- CAPSTAR submits orders received from external channels

#### Request Structure

```json
{
  "capstarReferenceNumber": "AGR-2024-00001",
  "clientIdentityCardNumber": "900101-01-5678",
  "agentId": "AGENT001",
  "productDetails": {
    "productOrderType": "NEW",
    "productCode": "ICHT3",
    "amount": 10000.00,
    "investmentTenureMonth": 24
  },
  "livingTrustOptionEnabled": true,
  "clientBankAccountNumber": "356385375938593",
  "beneficiaries": [
    {
      "beneficiaryIdentityCardNumber": "120101-01-9999",
      "distributionPercentage": 100,
      "subBeneficiaries": [
        {
          "beneficiaryIdentityCardNumber": "850505-02-1234",
          "distributionPercentage": 100
        }
      ]
    }
  ]
}
```

#### Response Structure

**Success Response** (HTTP 200):

```json
{
  "code": "SUCCESS",
  "message": "Product order request processed successfully",
  "data": {
    "totalRecords": 1,
    "successCount": 1,
    "failureCount": 0,
    "createdOrders": [
      {
        "capstarReferenceNumber": "AGR-2024-00001",
        "citadelOrderReferenceNumber": "ORDO2024011000001",
        "orderStatus": "DRAFT"
      }
    ],
    "errors": []
  }
}
```

**Error Response** (HTTP 4xx/5xx):

```json
{
  "code": "ERROR",
  "message": "Failed to process product order request",
  "data": {
    "totalRecords": 1,
    "successCount": 0,
    "failureCount": 1,
    "createdOrders": [],
    "errors": [
      {
        "capstarAgreementNumber": "AGR-2024-00001",
        "errorMessage": "Client with IC number 900101-01-5678 not found in Citadel system",
        "errorCode": "CLIENT_NOT_FOUND"
      }
    ]
  }
}
```

#### Request Field Descriptions

| Field                                                            | Type    | Required | Description                                           | Valid Values              |
|------------------------------------------------------------------|---------|----------|-------------------------------------------------------|---------------------------|
| capstarReferenceNumber                                           | String  | Yes      | Unique tracking key from CAPSTAR system to track this request. This reference will be returned in all Citadel callbacks related to this request for correlation and idempotency. | Must be unique            |
| clientIdentityCardNumber                                         | String  | Yes      | Client IC/Passport number                             | Must exist in Citadel     |
| agentId                                                          | String  | Yes      | Agent referral code/ID                                | Must exist in Citadel     |
| productDetails                                                   | Object  | Yes      | Product order details                                 | -                         |
| productDetails.productOrderType                                  | String  | Yes      | Type of product order                                 | NEW, ROLLOVER, REDEMPTION |
| productDetails.productCode                                       | String  | Yes      | Product code identifier                               | ICHT3, CCREL, CCFLX, etc. |
| productDetails.amount                                            | Number  | Yes      | Investment amount in MYR                              | Min: 10000.00             |
| productDetails.investmentTenureMonth                             | Integer | Yes      | Investment tenure in months                           | 6, 12, 24, 36, etc.       |
| livingTrustOptionEnabled                                         | Boolean | Yes      | Enable living trust for this order                    | true, false               |
| clientBankAccountNumber                                          | String  | Yes      | Client's bank account number for dividends            | -                         |
| beneficiaries                                                    | Array   | Yes      | Array of primary beneficiary details                  | Must have at least 1      |
| beneficiaries[].beneficiaryIdentityCardNumber                    | String  | Yes      | Beneficiary IC/Passport number                        | -                         |
| beneficiaries[].distributionPercentage                           | Number  | Yes      | Distribution percentage                               | > 0 and <= 100            |
| beneficiaries[].subBeneficiaries                                 | Array   | No       | Array of sub-beneficiaries (contingent)               | Optional                  |
| beneficiaries[].subBeneficiaries[].beneficiaryIdentityCardNumber | String  | Yes      | Sub-beneficiary IC/Passport number                    | -                         |
| beneficiaries[].subBeneficiaries[].distributionPercentage        | Number  | Yes      | Sub-beneficiary distribution percentage               | > 0 and <= 100            |

#### Response Field Descriptions

**Success Response**

| Field                                            | Type    | Description                           |
|--------------------------------------------------|---------|---------------------------------------|
| code                                             | String  | Response status code                  |
| message                                          | String  | Human-readable message                |
| data                                             | Object  | Response data object                  |
| data.totalRecords                                | Integer | Total number of orders processed      |
| data.successCount                                | Integer | Number of successfully created orders |
| data.failureCount                                | Integer | Number of failed orders               |
| data.createdOrders                               | Array   | Array of successfully created orders  |
| data.createdOrders[].capstarReferenceNumber      | String  | Reference number from request         |
| data.createdOrders[].citadelOrderReferenceNumber | String  | Generated Citadel order reference     |
| data.createdOrders[].orderStatus                 | String  | Current order status                  |
| data.errors                                      | Array   | Array of errors (empty on success)    |

**Error Response**

| Field                                | Type    | Description                           |
|--------------------------------------|---------|---------------------------------------|
| code                                 | String  | Response status code (ERROR)          |
| message                              | String  | Human-readable error message          |
| data                                 | Object  | Response data object                  |
| data.totalRecords                    | Integer | Total number of orders attempted      |
| data.successCount                    | Integer | Number of successfully created orders |
| data.failureCount                    | Integer | Number of failed orders               |
| data.createdOrders                   | Array   | Array of successfully created orders  |
| data.errors                          | Array   | Array of error details                |
| data.errors[].capstarAgreementNumber | String  | Reference number that failed          |
| data.errors[].errorMessage           | String  | Detailed error message                |
| data.errors[].errorCode              | String  | Error code                            |

**Validation Rules**:

- `clientIdentityCardNumber` must exist in Citadel client records (from migration)
- `agentId` must exist in Citadel agent records (from migration)
- `productCode` must be valid and active in Citadel
- `purchasedAmount` must meet product minimum investment requirement
- Total `percentageOfDistribution` for all beneficiaries must equal 100.00
- Each `percentageOfDistribution` must be > 0 and <= 100
- `capstarReferenceNumber` must be unique (not already exist in Citadel)

---

## Citadel to CAPSTAR Callback Endpoints

### 2. Product Order Status Update Callback (Checker/Finance/Approver/Status update Workflow)

**Endpoint**: `POST {CAPSTAR_BASE_URL}/api/callback/product-order-update`

**Description**: Called when a product order's approval/status changes through the checker, finance, or approver
workflow in Citadel CMS. This tracks the complete approval chain from initial submission through to final activation.

**Trigger Events**:

- Checker approves/rejects product order
- Finance approves/rejects product order (generates agreement on approval)
- Approver approves/rejects product order

#### Request Structure

```json
{
  "capstarReferenceNumber": "AGR-2024-00001",
  "citadelOrderReferenceNumber": "ORDO2024011500001",
  "clientIdentityCardNumber": "900101-01-5678",
  "agentId": "AGENT001",
  "productCode": "CCREL",
  "productOrderType": "NEW",
  "purchasedAmount": "50000.00",
  "investmentTenureMonth": 12,
  "submissionDate": "2024-01-10",
  "status": "ACTIVE",
  "remark": "",
  "checkerStatus": "APPROVE_CHECKER",
  "checkedBy": "checker@citadel.com",
  "checkerUpdatedAt": "2024-01-12T09:00:00Z",
  "checkerRemark": "",
  "financeStatus": "APPROVE_FINANCE",
  "financedBy": "finance@citadel.com",
  "financeUpdatedAt": "2024-01-13T14:30:00Z",
  "financeRemark": "",
  "approverStatus": "APPROVE_APPROVER",
  "approvedBy": "approver@citadel.com",
  "approverUpdatedAt": "2024-01-15T10:30:00Z",
  "approverRemark": "",
  "paymentStatus": "SUCCESS",
  "paymentDate": "2024-01-11",
  "paymentMethod": "ONLINE_BANKING",
  "agreementName": "ICHT2-IND2023-10-0224",
  "agreementDate": "2024-02-01",
  "startTenure": "2024-02-01",
  "endTenure": "2025-01-31",
  "structureType": "FIXED",
  "frequencyOfPayout": "QUARTERLY",
  "isProrated": true,
  "periodStartingDate": "2024-01-01",
  "periodEndingDate": "2024-03-31",
  "agreementFileKey": "s3://product-orders/ORDO2024011500001/ICHT2-IND2023-10-0224.pdf",
  "profitSharingScheduleKey": "s3://product-orders/ORDO2024011500001/profit_sharing_schedule.pdf",
  "officialReceiptKey": "s3://product-orders/ORDO2024011500001/official_receipt.pdf",
  "officialReceiptDate": "2024-01-11",
  "statementOfAgreementKey": "s3://product-orders/ORDO2024011500001/statement_of_agreement.pdf",
  "statementOfAgreementDate": "2024-01-15"
}
```

#### Field Descriptions

| Field                       | Type    | Description                                      | Valid Values                                                                                           |
|-----------------------------|---------|--------------------------------------------------|--------------------------------------------------------------------------------------------------------|
| capstarReferenceNumber      | String  | Original reference/agreement number from CAPSTAR | -                                                                                                      |
| citadelOrderReferenceNumber | String  | Citadel internal order reference                 | Format: ORDO{YYYYMMDD}{ID}                                                                             |
| clientIdentityCardNumber    | String  | Client IC/Passport number                        | -                                                                                                      |
| agentId                     | String  | Agent referral code/ID                           | -                                                                                                      |
| productCode                 | String  | Product code identifier                          | CCREL, CCFLX, ICHT3, etc.                                                                              |
| productOrderType            | String  | Type of product order                            | NEW, ROLLOVER, REDEMPTION                                                                              |
| purchasedAmount             | String  | Investment amount in MYR (decimal format)        | -                                                                                                      |
| investmentTenureMonth       | Integer | Investment tenure in months                      | 6, 12, 24, 36, etc.                                                                                    |
| submissionDate              | String  | Order submission date                            | Format: YYYY-MM-DD                                                                                     |
| status                      | String  | Current product order status                     | DRAFT, IN_REVIEW, REJECTED, PENDING_PAYMENT, ACTIVE, MATURED, WITHDRAWN, PENDING_ACTIVATION, COMPLETED |
| remark                      | String  | General order remarks                            | -                                                                                                      |
| checkerStatus               | String  | Checker approval status                          | PENDING_CHECKER, APPROVE_CHECKER, REJECT_CHECKER                                                       |
| checkedBy                   | String  | Checker email/username                           | Set when checkerStatus != PENDING_CHECKER                                                              |
| checkerUpdatedAt            | String  | ISO 8601 timestamp of checker action             | Set when checkerStatus != PENDING_CHECKER                                                              |
| checkerRemark               | String  | Checker specific remarks                         | -                                                                                                      |
| financeStatus               | String  | Finance approval status                          | PENDING_FINANCE, APPROVE_FINANCE, REJECT_FINANCE                                                       |
| financedBy                  | String  | Finance officer email/username                   | Set when financeStatus != PENDING_FINANCE                                                              |
| financeUpdatedAt            | String  | ISO 8601 timestamp of finance action             | Set when financeStatus != PENDING_FINANCE                                                              |
| financeRemark               | String  | Finance specific remarks                         | -                                                                                                      |
| approverStatus              | String  | Approver approval status                         | PENDING_APPROVER, APPROVE_APPROVER, REJECT_APPROVER                                                    |
| approvedBy                  | String  | Approver email/username                          | Set when approverStatus != PENDING_APPROVER                                                            |
| approverUpdatedAt           | String  | ISO 8601 timestamp of approver action            | Set when approverStatus != PENDING_APPROVER                                                            |
| approverRemark              | String  | Approver specific remarks                        | -                                                                                                      |
| paymentStatus               | String  | Payment status                                   | PENDING, SUCCESS, FAILED                                                                               |
| paymentDate                 | String  | Payment completion date                          | Format: YYYY-MM-DD, set when paymentStatus = SUCCESS                                                   |
| paymentMethod               | String  | Payment method used                              | ONLINE_BANKING, FPX, BANK_TRANSFER, CHEQUE, CASH                                                       |
| agreementNumber             | String  | Generated agreement number                       | Set after approval workflow                                                                            |
| agreementDate               | String  | Agreement effective date                         | Format: YYYY-MM-DD, set after Finance approval                                                         |
| startTenure                 | String  | Investment period start date                     | Format: YYYY-MM-DD, set after approval                                                                 |
| endTenure                   | String  | Investment period end date                       | Format: YYYY-MM-DD, set after approval                                                                 |
| structureType               | String  | Dividend structure type                          | FIXED, FLEXIBLE                                                                                        |
| frequencyOfPayout           | String  | Dividend payout frequency                        | MONTHLY, QUARTERLY, HALF_YEARLY, ANNUALLY, AT_MATURITY                                                 |
| isProrated                  | Boolean | Whether dividend is prorated                     | true, false                                                                                            |
| periodStartingDate          | String  | First dividend period start date                 | Format: YYYY-MM-DD                                                                                     |
| periodEndingDate            | String  | First dividend period end date                   | Format: YYYY-MM-DD                                                                                     |
| agreementFileKey            | String  | S3 key for agreement file PDF                    | Set after agreement generation                                                                         |
| profitSharingScheduleKey    | String  | S3 key for profit sharing schedule PDF           | Set after agreement generation                                                                         |
| officialReceiptKey          | String  | S3 key for official receipt PDF                  | Set after receipt upload                                                                               |
| officialReceiptDate         | String  | Official receipt issue date                      | Format: YYYY-MM-DD                                                                                     |
| statementOfAgreementKey     | String  | S3 key for statement of agreement PDF            | Set after agreement finalization                                                                       |
| statementOfAgreementDate    | String  | Statement of agreement issue date                | Format: YYYY-MM-DD                                                                                     |

---

### 3. Dividend Calculation Callback

**Endpoint**: `POST {CAPSTAR_BASE_URL}/api/callback/dividend-calculation`

**Description**: Called when Citadel completes a dividend calculation (fixed, flexible, or maturity). This notification
includes the calculated dividend amount, trustee fees, period details, and initial payment status.

**Trigger Events**:

- Fixed dividend calculation completion
- Flexible dividend calculation completion
- Final/maturity dividend calculation completion

#### Request Structure

```json
{
  "citadelOrderReferenceNumber": "ORDO2024011500001",
  "citadelDividendReferenceNumber": "DIV172634567890123",
  "productCode": "CCREL",
  "dividendQuarter": 1,
  "periodStartingDate": "2024-02-01",
  "periodEndingDate": "2024-04-30",
  "closingDate": "2024-04-30",
  "calculationDate": "2024-05-01",
  "dividendAmount": "980.00",
  "trusteeFeeAmount": "20.00",
  "paymentStatus": "PENDING",
  "isFinalDividend": false
}
```

#### Field Descriptions

| Field                          | Type    | Description                                                               |
|--------------------------------|---------|---------------------------------------------------------------------------|
| citadelOrderReferenceNumber    | String  | Citadel order reference number                                            |
| citadelDividendReferenceNumber | String  | Unique dividend reference number (format: DIV{timestamp}{3-digit-number}) |
| productCode                    | String  | Product code (CCREL, CCFLX, ICHT3, etc.)                                  |
| dividendQuarter                | Integer | Dividend payment number/counter (1, 2, 3, etc.)                           |
| periodStartingDate             | String  | Calculation period start date (YYYY-MM-DD)                                |
| periodEndingDate               | String  | Calculation period end date (YYYY-MM-DD)                                  |
| closingDate                    | String  | Closing date for the dividend period (YYYY-MM-DD)                         |
| calculationDate                | String  | Date when dividend was calculated (YYYY-MM-DD)                            |
| dividendAmount                 | String  | Calculated dividend amount in MYR (decimal format)                        |
| trusteeFeeAmount               | String  | Trustee fee deducted from dividend in MYR (decimal format)                |
| paymentStatus                  | String  | Payment status (PENDING, SUCCESS, FAILED)                                 |
| isFinalDividend                | Boolean | Whether this is the final/maturity dividend                               |

---

### 4. Early Withdrawal/Redemption Status Update Callback

**Endpoint**: `POST {CITADEL_BASE_URL}/api/external-agency/early-redemption-request`

**Description**: Called when a product order withdrawal/redemption status changes (full redemption at maturity). Tracks
the approval workflow and payment status.

**Trigger Events**:

- Client requests full redemption at maturity
- Checker approves/rejects redemption
- Approver approves/rejects redemption
- Payment status changes (PENDING → SUCCESS/FAILED)

#### Request Structure

```json
{
  "capstarReferenceNumber": "AGR-2024-00001",
  "citadelOrderReferenceNumber": "ORDO2024011500001",
  "purchaserIdentityNumber": "900101-01-5678",
  "withdrawalMethod": "ALL/PARTIAL_AMOUNT",
  "withdrawalAmount": "50000.00"
}
```

#### Response Structure

**Success Response** (HTTP 200):

```json
{
  "code": "SUCCESS",
  "message": "Redemption request received successfully",
  "data": {
    "totalRecords": 1,
    "successCount": 1,
    "failureCount": 0,
    "errors": []
  }
}
```

#### Request Field Descriptions

| Field                       | Type   | Required | Description                      | Valid Values               |
|-----------------------------|--------|----------|----------------------------------|----------------------------|
| capstarReferenceNumber      | String | Yes      | Unique tracking key from CAPSTAR system to track this request. This reference will be returned in all Citadel callbacks related to this request for correlation and idempotency. | -                          |
| citadelOrderReferenceNumber | String | Yes      | Citadel internal order reference | Format: ORDO{YYYYMMDD}{ID} |
| purchaserIdentityNumber     | String | Yes      | Client IC/Passport number        | -                          |
| withdrawalMethod              | String | Yes      | Type of redemption               | ALL, PARTIAL_AMOUNT        |
| withdrawalAmount            | String | Yes      | Amount to be redeemed in MYR     | Decimal format             |

#### Response Field Descriptions

**Success Response**

| Field             | Type    | Description                               |
|-------------------|---------|-------------------------------------------|
| code              | String  | Response status code                      |
| message           | String  | Human-readable message                    |
| data              | Object  | Response data object                      |
| data.totalRecords | Integer | Total number of requests processed        |
| data.successCount | Integer | Number of successfully processed requests |
| data.failureCount | Integer | Number of failed requests                 |
| data.errors       | Array   | Array of errors (empty on success)        |

---

### 5. Early Redemption/Withdrawal Status Update Callback

**Endpoint**: `POST {CAPSTAR_BASE_URL}/api/callback/early-redemption-status`

**Description**: Called when an early redemption/withdrawal request status changes (premature withdrawal before maturity
with penalties). Tracks the complete workflow from request through payment.

**Trigger Events**:

- Client requests early redemption/withdrawal
- Client signs early redemption agreement
- Witness signs early redemption agreement
- Checker approves/rejects early redemption
- Approver approves/rejects early redemption
- Payment status changes (PENDING → SUCCESS/FAILED)

#### Request Structure

```json
{
  "redemptionReferenceNumber": "RED1723728900123",
  "capstarReferenceNumber": "AGR-2024-00001",
  "citadelOrderReferenceNumber": "ORDO2024011500001",
  "purchaserIdentityNumber": "900101-01-5678",
  "productCode": "CCREL",
  "withdrawalMethod": "BANK_TRANSFER",
  "withdrawalMethod": "ALL/PARTIAL_AMOUNT",
  "withdrawalAmount": "50000.00",
  "penaltyAmount": "2500.00",
  "penaltyPercentage": "2500.00",
  "withdrawalReason": "Financial emergency",
  "withdrawalStatus": "APPROVED",
  "statusChecker": "APPROVE_CHECKER",
  "checkedBy": "checker@citadel.com",
  "checkerUpdatedAt": "2024-08-12T09:00:00Z",
  "statusApprover": "APPROVE_APPROVER",
  "approvedBy": "approver@citadel.com",
  "approverUpdatedAt": "2024-08-15T14:30:00Z",
  "paymentStatus": "PENDING",
  "paymentDate": "2024-08-20"
}
```

#### Field Descriptions

| Field                       | Type   | Description                                                       |
|-----------------------------|--------|-------------------------------------------------------------------|
| redemptionReferenceNumber   | String | Unique early redemption reference (Format: RED{timestamp}{3-digit-number}) |
| capstarReferenceNumber      | String | Original reference/agreement number from CAPSTAR                  |
| citadelOrderReferenceNumber | String | Citadel internal order reference (Format: ORDO{YYYYMMDD}{ID})    |
| purchaserIdentityNumber     | String | Client IC/Passport number                                         |
| productCode                 | String | Product code (CCREL, CCFLX, ICHT3, etc.)                          |
| withdrawalMethod            | String | Withdrawal method (BANK_TRANSFER, CHEQUE, ALL, PARTIAL_AMOUNT)    |
| withdrawalAmount            | String | Withdrawal amount in MYR (decimal format)                         |
| penaltyAmount               | String | Penalty amount in MYR (decimal format)                            |
| penaltyPercentage           | String | Penalty percentage applied (decimal format)                       |
| withdrawalReason            | String | Client's reason for early withdrawal                              |
| withdrawalStatus            | String | Current withdrawal status (PENDING, IN_REVIEW, APPROVED, REJECTED, SUCCESS) |
| statusChecker               | String | Checker approval status (PENDING_CHECKER, APPROVE_CHECKER, REJECT_CHECKER) |
| checkedBy                   | String | Checker email/username                                            |
| checkerUpdatedAt            | String | ISO 8601 timestamp of checker action                              |
| statusApprover              | String | Approver approval status (PENDING_APPROVER, APPROVE_APPROVER, REJECT_APPROVER) |
| approvedBy                  | String | Approver email/username                                           |
| approverUpdatedAt           | String | ISO 8601 timestamp of approver action                             |
| paymentStatus               | String | Payment status (PENDING, SUCCESS, FAILED)                         |
| paymentDate                 | String | Actual payment date (Format: YYYY-MM-DD)                          |

---

### 6. Full Redemption Request API

**Endpoint**: `POST {CITADEL_BASE_URL}/api/external-agency/full-redemption-request`

**Direction**: CAPSTAR → Citadel (Inbound API Request)

**Description**: CAPSTAR calls this Citadel API endpoint to initiate a full redemption request for a matured product order. This creates a redemption record that goes through checker and approver workflow before payment processing.

**Trigger Events**:
- Client requests full redemption at product maturity
- CAPSTAR system automatically initiates redemption at maturity date

#### Request Structure

```json
{
  "capstarReferenceNumber": "AGR-2024-00001",
  "citadelOrderReferenceNumber": "ORDO2024011500001",
  "clientIdentityCardNumber": "900101-01-5678"
}
```

#### Response Structure

**Success Response** (HTTP 200):
```json
{
  "code": "SUCCESS",
  "message": "Full redemption request received successfully",
  "data": {
    "totalRecords": 1,
    "successCount": 1,
    "failureCount": 0,
    "errors": []
  }
}
```

**Error Response** (HTTP 4xx/5xx):
```json
{
  "code": "ERROR",
  "message": "Failed to process full redemption request",
  "data": {
    "totalRecords": 1,
    "successCount": 0,
    "failureCount": 1,
    "errors": [
      {
        "referenceNumber": "AGR-2024-00001",
        "errorMessage": "Product order not eligible for full redemption",
        "errorCode": "REDEMPTION_NOT_ALLOWED"
      }
    ]
  }
}
```

#### Request Field Descriptions

| Field                       | Type   | Required | Description                          | Valid Values               |
|-----------------------------|--------|----------|--------------------------------------|----------------------------|
| capstarReferenceNumber      | String | Yes      | Unique tracking key from CAPSTAR system to track this request. This reference will be returned in all Citadel callbacks related to this request for correlation and idempotency. | -                          |
| citadelOrderReferenceNumber | String | Yes      | Citadel internal order reference     | Format: ORDO{YYYYMMDD}{ID} |
| clientIdentityCardNumber    | String | Yes      | Client IC/Passport number            | Must match order client    |

#### Response Field Descriptions

| Field             | Type    | Description                               |
|-------------------|---------|-------------------------------------------|
| code              | String  | Response status code                      |
| message           | String  | Human-readable message                    |
| data              | Object  | Response data object                      |
| data.totalRecords | Integer | Total number of requests processed        |
| data.successCount | Integer | Number of successfully processed requests |
| data.failureCount | Integer | Number of failed requests                 |
| data.errors       | Array   | Array of errors (empty on success)        |

---

### 7. Full Redemption Status Callback

**Endpoint**: `POST {CAPSTAR_BASE_URL}/api/callback/full-redemption-status`

**Direction**: Citadel → CAPSTAR (Outbound Callback)

**Description**: Called when a full redemption request status changes through the checker and approver workflow in Citadel CMS. This tracks the complete approval chain from initial submission through to final payment.

**Trigger Events**:
- Checker approves/rejects full redemption
- Approver approves/rejects full redemption
- Payment status changes (PENDING → SUCCESS/FAILED)

#### Request Structure

```json
{
  "capstarReferenceNumber": "AGR-2024-00001",
  "citadelOrderReferenceNumber": "ORDO2024011500001",
  "clientIdentityCardNumber": "900101-01-5678",
  "productCode": "CCREL",
  "redemptionType": "FULL",
  "redemptionAmount": "50000.00",
  "redemptionStatus": "APPROVED",
  "statusChecker": "APPROVE_CHECKER",
  "checkedBy": "checker@citadel.com",
  "checkerUpdatedAt": "2024-08-12T09:00:00Z",
  "remarkChecker": "",
  "statusApprover": "APPROVE_APPROVER",
  "approvedBy": "approver@citadel.com",
  "approverUpdatedAt": "2024-08-15T14:30:00Z",
  "remarkApprover": "",
  "paymentStatus": "PENDING",
  "paymentDate": null
}
```

#### Field Descriptions

| Field                       | Type    | Description                                                                |
|-----------------------------|---------|----------------------------------------------------------------------------|
| capstarReferenceNumber      | String  | Original reference/agreement number from CAPSTAR                           |
| citadelOrderReferenceNumber | String  | Citadel internal order reference (Format: ORDO{YYYYMMDD}{ID})             |
| clientIdentityCardNumber    | String  | Client IC/Passport number                                                  |
| productCode                 | String  | Product code (CCREL, CCFLX, ICHT3, etc.)                                   |
| redemptionType              | String  | Type of redemption (FULL, PARTIAL, REFUND)                                 |
| redemptionAmount            | String  | Amount to be redeemed in MYR (decimal format)                              |
| redemptionStatus            | String  | Current redemption status (IN_REVIEW, APPROVED, REJECTED, SUCCESS)         |
| statusChecker               | String  | Checker approval status (PENDING_CHECKER, APPROVE_CHECKER, REJECT_CHECKER) |
| checkedBy                   | String  | Checker email/username                                                     |
| checkerUpdatedAt            | String  | ISO 8601 timestamp of checker action                                       |
| remarkChecker               | String  | Checker specific remarks                                                   |
| statusApprover              | String  | Approver approval status (PENDING_APPROVER, APPROVE_APPROVER, REJECT_APPROVER) |
| approvedBy                  | String  | Approver email/username                                                    |
| approverUpdatedAt           | String  | ISO 8601 timestamp of approver action                                      |
| remarkApprover              | String  | Approver specific remarks                                                  |
| paymentStatus               | String  | Payment status (PENDING, SUCCESS, FAILED)                                  |
| paymentDate                 | String  | Actual payment date (Format: YYYY-MM-DD, null if not paid)                 |

---

### 8. Rollover Request API

**Endpoint**: `POST {CITADEL_BASE_URL}/api/external-agency/rollover-request`

**Direction**: CAPSTAR → Citadel (Inbound API Request)

**Description**: CAPSTAR calls this Citadel API endpoint to initiate a rollover request where a client reinvests their matured product into the same product. This can be full or partial rollover, with remaining amount going to redemption.

**Trigger Events**:
- Client chooses to rollover matured investment
- CAPSTAR processes client's rollover instruction

#### Request Structure

```json
{
  "capstarReferenceNumber": "AGR-2024-00001",
  "citadelOrderReferenceNumber": "ORDO2024011500001",
  "clientIdentityCardNumber": "900101-01-5678",
  "rolloverAmount": 50000.00
}
```

#### Response Structure

**Success Response** (HTTP 200):
```json
{
  "code": "SUCCESS",
  "message": "Rollover request received successfully",
  "data": {
    "totalRecords": 1,
    "successCount": 1,
    "failureCount": 0,
    "errors": []
  }
}
```

**Error Response** (HTTP 4xx/5xx):
```json
{
  "code": "ERROR",
  "message": "Failed to process rollover request",
  "data": {
    "totalRecords": 1,
    "successCount": 0,
    "failureCount": 1,
    "errors": [
      {
        "referenceNumber": "AGR-2024-00001",
        "errorMessage": "Rollover not allowed for this product order",
        "errorCode": "ROLLOVER_NOT_ALLOWED"
      }
    ]
  }
}
```

#### Request Field Descriptions

| Field                       | Type   | Required | Description                              | Valid Values               |
|-----------------------------|--------|----------|------------------------------------------|----------------------------|
| capstarReferenceNumber      | String | Yes      | Unique tracking key from CAPSTAR system to track this request. This reference will be returned in all Citadel callbacks related to this request for correlation and idempotency. | -                          |
| citadelOrderReferenceNumber | String | Yes      | Citadel internal order reference         | Format: ORDO{YYYYMMDD}{ID} |
| clientIdentityCardNumber    | String | Yes      | Client IC/Passport number                | Must match order client    |
| rolloverAmount              | Number | Yes      | Amount to rollover in MYR                | > 0 and <= purchased amount|

#### Response Field Descriptions

| Field             | Type    | Description                               |
|-------------------|---------|-------------------------------------------|
| code              | String  | Response status code                      |
| message           | String  | Human-readable message                    |
| data              | Object  | Response data object                      |
| data.totalRecords | Integer | Total number of requests processed        |
| data.successCount | Integer | Number of successfully processed requests |
| data.failureCount | Integer | Number of failed requests                 |
| data.errors       | Array   | Array of errors (empty on success)        |

---

### 9. Rollover Status Callback

**Endpoint**: `POST {CAPSTAR_BASE_URL}/api/callback/rollover-status`

**Direction**: Citadel → CAPSTAR (Outbound Callback)

**Description**: Called when a rollover request status changes through the approval workflow. Since rollover creates a new product order, this callback tracks both the rollover history status and the new product order approval workflow.

**Trigger Events**:
- New rollover product order created (status: IN_REVIEW)
- Checker/Finance/Approver approves or rejects the new product order
- New product order becomes ACTIVE (rollover SUCCESS)

#### Request Structure

```json
{
  "capstarReferenceNumber": "AGR-2024-00001",
  "citadelOrderReferenceNumber": "ORDO2024011500001",
  "newCitadelOrderReferenceNumber": "ORDO2024120100002",
  "clientIdentityCardNumber": "900101-01-5678",
  "productCode": "CCREL",
  "rolloverAmount": "50000.00",
  "remainingAmount": "0.00",
  "rolloverStatus": "APPROVED",
  "newOrderStatus": "PENDING_ACTIVATION",
  "checkerStatus": "APPROVE_CHECKER",
  "checkedBy": "checker@citadel.com",
  "checkerUpdatedAt": "2024-12-02T09:00:00Z",
  "financeStatus": "APPROVE_FINANCE",
  "financedBy": "finance@citadel.com",
  "financeUpdatedAt": "2024-12-02T14:30:00Z",
  "approverStatus": "APPROVE_APPROVER",
  "approvedBy": "approver@citadel.com",
  "approverUpdatedAt": "2024-12-02T16:00:00Z",
  "agreementName": "CCREL-IND2024-12-0002",
  "agreementDate": "2025-01-01",
  "startTenure": "2025-01-01",
  "endTenure": "2026-12-31"
}
```

#### Field Descriptions

| Field                          | Type   | Description                                                                    |
|--------------------------------|--------|--------------------------------------------------------------------------------|
| capstarReferenceNumber         | String | Original reference/agreement number from CAPSTAR                               |
| citadelOrderReferenceNumber    | String | Original Citadel order reference (Format: ORDO{YYYYMMDD}{ID})                 |
| newCitadelOrderReferenceNumber | String | New Citadel order reference created for rollover (Format: ORDO{YYYYMMDD}{ID}) |
| clientIdentityCardNumber       | String | Client IC/Passport number                                                      |
| productCode                    | String | Product code (CCREL, CCFLX, ICHT3, etc.)                                       |
| rolloverAmount                 | String | Amount rolled over in MYR (decimal format)                                     |
| remainingAmount                | String | Remaining amount sent to redemption (0.00 for full rollover)                   |
| rolloverStatus                 | String | Rollover history status (IN_REVIEW, APPROVED, REJECTED, SUCCESS)               |
| newOrderStatus                 | String | New product order status (DRAFT, IN_REVIEW, PENDING_PAYMENT, PENDING_ACTIVATION, ACTIVE) |
| checkerStatus                  | String | Checker approval status for new order (PENDING_CHECKER, APPROVE_CHECKER, REJECT_CHECKER) |
| checkedBy                      | String | Checker email/username                                                         |
| checkerUpdatedAt               | String | ISO 8601 timestamp of checker action                                           |
| financeStatus                  | String | Finance approval status for new order (PENDING_FINANCE, APPROVE_FINANCE, REJECT_FINANCE) |
| financedBy                     | String | Finance officer email/username                                                 |
| financeUpdatedAt               | String | ISO 8601 timestamp of finance action                                           |
| approverStatus                 | String | Approver approval status for new order (PENDING_APPROVER, APPROVE_APPROVER, REJECT_APPROVER) |
| approvedBy                     | String | Approver email/username                                                        |
| approverUpdatedAt              | String | ISO 8601 timestamp of approver action                                          |
| agreementName                  | String | Generated agreement name for new order                                         |
| agreementDate                  | String | Agreement effective date (Format: YYYY-MM-DD)                                  |
| startTenure                    | String | New investment period start date (Format: YYYY-MM-DD)                          |
| endTenure                      | String | New investment period end date (Format: YYYY-MM-DD)                            |

---

### 10. Reallocation Request API

**Endpoint**: `POST {CITADEL_BASE_URL}/api/external-agency/reallocation-request`

**Direction**: CAPSTAR → Citadel (Inbound API Request)

**Description**: CAPSTAR calls this Citadel API endpoint to initiate a reallocation request where a client reallocates their matured product investment into a different product. This can be full or partial reallocation, with remaining amount going to redemption.

**Trigger Events**:
- Client chooses to reallocate matured investment to different product
- CAPSTAR processes client's reallocation instruction

#### Request Structure

```json
{
  "capstarReferenceNumber": "AGR-2024-00001",
  "citadelOrderReferenceNumber": "ORDO2024011500001",
  "clientIdentityCardNumber": "900101-01-5678",
  "newProductCode": "ICHT3",
  "reallocationAmount": 50000.00
}
```

#### Response Structure

**Success Response** (HTTP 200):
```json
{
  "code": "SUCCESS",
  "message": "Reallocation request received successfully",
  "data": {
    "totalRecords": 1,
    "successCount": 1,
    "failureCount": 0,
    "errors": []
  }
}
```

**Error Response** (HTTP 4xx/5xx):
```json
{
  "code": "ERROR",
  "message": "Failed to process reallocation request",
  "data": {
    "totalRecords": 1,
    "successCount": 0,
    "failureCount": 1,
    "errors": [
      {
        "referenceNumber": "AGR-2024-00001",
        "errorMessage": "Product ICHT3 is not eligible for reallocation from CCREL",
        "errorCode": "REALLOCATION_NOT_ALLOWED"
      }
    ]
  }
}
```

#### Request Field Descriptions

| Field                       | Type   | Required | Description                              | Valid Values               |
|-----------------------------|--------|----------|------------------------------------------|----------------------------|
| capstarReferenceNumber      | String | Yes      | Unique tracking key from CAPSTAR system to track this request. This reference will be returned in all Citadel callbacks related to this request for correlation and idempotency. | -                          |
| citadelOrderReferenceNumber | String | Yes      | Citadel internal order reference         | Format: ORDO{YYYYMMDD}{ID} |
| clientIdentityCardNumber    | String | Yes      | Client IC/Passport number                | Must match order client    |
| newProductCode              | String | Yes      | Target product code for reallocation     | Must be in allowed list    |
| reallocationAmount          | Number | Yes      | Amount to reallocate in MYR              | > 0 and <= purchased amount|

#### Response Field Descriptions

| Field             | Type    | Description                               |
|-------------------|---------|-------------------------------------------|
| code              | String  | Response status code                      |
| message           | String  | Human-readable message                    |
| data              | Object  | Response data object                      |
| data.totalRecords | Integer | Total number of requests processed        |
| data.successCount | Integer | Number of successfully processed requests |
| data.failureCount | Integer | Number of failed requests                 |
| data.errors       | Array   | Array of errors (empty on success)        |

---

### 11. Reallocation Status Callback

**Endpoint**: `POST {CAPSTAR_BASE_URL}/api/callback/reallocation-status`

**Direction**: Citadel → CAPSTAR (Outbound Callback)

**Description**: Called when a reallocation request status changes through the approval workflow. Since reallocation creates a new product order with a different product, this callback tracks both the reallocation history status and the new product order approval workflow.

**Trigger Events**:
- New reallocation product order created (status: IN_REVIEW)
- Checker/Finance/Approver approves or rejects the new product order
- New product order becomes ACTIVE (reallocation SUCCESS)

#### Request Structure

```json
{
  "capstarReferenceNumber": "AGR-2024-00001",
  "citadelOrderReferenceNumber": "ORDO2024011500001",
  "newCitadelOrderReferenceNumber": "ORDO2024120100003",
  "clientIdentityCardNumber": "900101-01-5678",
  "originalProductCode": "CCREL",
  "newProductCode": "ICHT3",
  "reallocationAmount": "50000.00",
  "remainingAmount": "0.00",
  "reallocationStatus": "APPROVED",
  "newOrderStatus": "PENDING_ACTIVATION",
  "checkerStatus": "APPROVE_CHECKER",
  "checkedBy": "checker@citadel.com",
  "checkerUpdatedAt": "2024-12-02T09:00:00Z",
  "financeStatus": "APPROVE_FINANCE",
  "financedBy": "finance@citadel.com",
  "financeUpdatedAt": "2024-12-02T14:30:00Z",
  "approverStatus": "APPROVE_APPROVER",
  "approvedBy": "approver@citadel.com",
  "approverUpdatedAt": "2024-12-02T16:00:00Z",
  "agreementName": "ICHT3-IND2024-12-0003",
  "agreementDate": "2025-01-01",
  "startTenure": "2025-01-01",
  "endTenure": "2027-12-31"
}
```

#### Field Descriptions

| Field                          | Type   | Description                                                                        |
|--------------------------------|--------|------------------------------------------------------------------------------------|
| capstarReferenceNumber         | String | Original reference/agreement number from CAPSTAR                                   |
| citadelOrderReferenceNumber    | String | Original Citadel order reference (Format: ORDO{YYYYMMDD}{ID})                     |
| newCitadelOrderReferenceNumber | String | New Citadel order reference created for reallocation (Format: ORDO{YYYYMMDD}{ID}) |
| clientIdentityCardNumber       | String | Client IC/Passport number                                                          |
| originalProductCode            | String | Original product code (CCREL, CCFLX, ICHT3, etc.)                                  |
| newProductCode                 | String | New product code for reallocation (CCREL, CCFLX, ICHT3, etc.)                      |
| reallocationAmount             | String | Amount reallocated in MYR (decimal format)                                         |
| remainingAmount                | String | Remaining amount sent to redemption (0.00 for full reallocation)                   |
| reallocationStatus             | String | Reallocation history status (IN_REVIEW, APPROVED, REJECTED, SUCCESS)               |
| newOrderStatus                 | String | New product order status (DRAFT, IN_REVIEW, PENDING_PAYMENT, PENDING_ACTIVATION, ACTIVE) |
| checkerStatus                  | String | Checker approval status for new order (PENDING_CHECKER, APPROVE_CHECKER, REJECT_CHECKER) |
| checkedBy                      | String | Checker email/username                                                             |
| checkerUpdatedAt               | String | ISO 8601 timestamp of checker action                                               |
| financeStatus                  | String | Finance approval status for new order (PENDING_FINANCE, APPROVE_FINANCE, REJECT_FINANCE) |
| financedBy                     | String | Finance officer email/username                                                     |
| financeUpdatedAt               | String | ISO 8601 timestamp of finance action                                               |
| approverStatus                 | String | Approver approval status for new order (PENDING_APPROVER, APPROVE_APPROVER, REJECT_APPROVER) |
| approvedBy                     | String | Approver email/username                                                            |
| approverUpdatedAt              | String | ISO 8601 timestamp of approver action                                              |
| agreementName                  | String | Generated agreement name for new order                                             |
| agreementDate                  | String | Agreement effective date (Format: YYYY-MM-DD)                                      |
| startTenure                    | String | New investment period start date (Format: YYYY-MM-DD)                              |
| endTenure                      | String | New investment period end date (Format: YYYY-MM-DD)                                |

---

## Error Codes and Handling

### HTTP Status Codes

| Status Code               | Description                                       |
|---------------------------|---------------------------------------------------|
| 200 OK                    | Callback processed successfully                   |
| 400 Bad Request           | Invalid request format or missing required fields |
| 401 Unauthorized          | Invalid or missing API key                        |
| 404 Not Found             | Resource not found (agreement, dividend record)   |
| 409 Conflict              | Duplicate callback or data conflict               |
| 422 Unprocessable Entity  | Validation errors in data                         |
| 500 Internal Server Error | CAPSTAR server error during processing            |
| 503 Service Unavailable   | CAPSTAR service temporarily unavailable           |

### Application Error Codes

| Error Code                | Description                           | Resolution                                      |
|---------------------------|---------------------------------------|-------------------------------------------------|
| INVALID_API_KEY           | API key is invalid or expired         | Check API key configuration                     |
| AGREEMENT_NOT_FOUND       | Agreement number not found in CAPSTAR | Verify agreement was migrated successfully      |
| DIVIDEND_NOT_FOUND        | Dividend record not found             | Verify dividend calculation was sent previously |
| DUPLICATE_CALLBACK        | Callback already processed            | Check idempotency - may be safe to ignore       |
| VALIDATION_ERROR          | Field validation failed               | Check field formats and required fields         |
| INVALID_STATUS_TRANSITION | Invalid status change                 | Check status workflow rules                     |
| DATA_MISMATCH             | Data doesn't match CAPSTAR records    | Verify data consistency between systems         |

---

## Retry and Idempotency

### Idempotency

All callbacks are idempotent using `citadelReferenceNumber` as the unique identifier:

- CAPSTAR should check if `citadelReferenceNumber` already exists
- If exists and data matches: Return success (ignore duplicate)
- If exists but data differs: Return 409 Conflict error
- If not exists: Process normally

---

## API & Callback Summary Table

### CAPSTAR → Citadel API Endpoints (Inbound)

| API Type                    | Endpoint                                            | Called By | Purpose                                        | Key Data                                            |
|-----------------------------|-----------------------------------------------------|-----------|------------------------------------------------|-----------------------------------------------------|
| New Product Order Request   | `POST /api/capstar/product-order-request`           | CAPSTAR   | Create new product order in Citadel            | Client details, product code, amount, beneficiaries |
| Early Redemption Request    | `POST /api/external-agency/early-redemption-request`| CAPSTAR   | Initiate early withdrawal before maturity      | Order reference, withdrawal amount, client IC       |
| Full Redemption Request     | `POST /api/external-agency/full-redemption-request` | CAPSTAR   | Initiate full redemption at maturity           | Order reference, client IC                          |
| Rollover Request            | `POST /api/external-agency/rollover-request`        | CAPSTAR   | Reinvest matured amount to same product        | Order reference, rollover amount, client IC         |
| Reallocation Request        | `POST /api/external-agency/reallocation-request`    | CAPSTAR   | Reinvest matured amount to different product   | Order reference, new product code, amount, client IC|

### Citadel → CAPSTAR Callbacks (Outbound)

| Callback Type             | Endpoint                                | Trigger Events                             | Key Data                                        |
|---------------------------|-----------------------------------------|--------------------------------------------|-------------------------------------------------|
| Product Order Status      | `/callback/product-order-update`        | Checker/Finance/Approver approval workflow | Order status, approval chain, agreement details |
| Dividend Calculation      | `/callback/dividend-calculation`        | Dividend calculation completed             | Dividend amount, trustee fees, period details   |
| Early Redemption Status   | `/callback/early-redemption-status`     | Early withdrawal status changes            | Penalty details, approval status                |
| Full Redemption Status    | `/callback/full-redemption-status`      | Full redemption status changes             | Redemption amount, approval status, payment     |
| Rollover Status           | `/callback/rollover-status`             | Rollover status and new order changes      | New order reference, approval status, agreement |
| Reallocation Status       | `/callback/reallocation-status`         | Reallocation status and new order changes  | New order reference, new product, approval      |

---

**End of Document**
