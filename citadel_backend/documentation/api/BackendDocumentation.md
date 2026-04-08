# Backend Controller Business Process Documentation

## Overview

The `BackendController` serves as the central administrative and automated processing hub for the Citadel backend system. This controller is uniquely designed to handle Content Management System (CMS) operations, automated CRON job executions for dividend and commission calculations, and critical backend processes that support the entire financial ecosystem. Unlike other controllers that primarily serve client-facing operations, the BackendController focuses on internal system administration, financial calculations, and automated business processes.

## Architecture

- **Controller**: `BackendController` - Administrative and CRON endpoint management
- **Primary Service**: `BackendService` - Core backend business logic implementation
- **Financial Services**: `DividendService`, `CommissionService` - Specialized calculation engines
- **Supporting Services**: `ProductService`, `PdfService`, `EmailService`, `ExcelService`
- **Database**: Product orders, dividend histories, commission histories, agreement entities
- **External Integration**: AWS S3, Email systems, Banking file generation

---

## API Endpoints Documentation

### 1. CMS Administrative Operations

#### 1.1 Product Order Status Management
**Endpoint**: `POST /api/backend/cms/product-order/approval`
**Parameters**:
- `referenceNumber` (required): Product order reference number
**Request Body**: `CmsAdminPOStatusUpdateReqVo`

**Business Logic**:
The most complex administrative operation in the system, handling two distinct approval workflows:

**Finance Admin Approval Process**:
- Validates product order existence and retrieves dividend schedule configuration
- Sets `payoutFrequency` and `structureType` from dividend schedule
- Calculates critical dates using sophisticated agreement date logic:
  - **Time-Based Cutoffs**: 3 PM submission cutoff, 6 PM approval cutoff with next-day adjustments
  - **Schedule Lookup**: Uses `ProductAgreementSchedule` for precise agreement date calculation
  - **Fallback Logic**: Fixed products default to 1st of next month, flexible products use 15th or month-end
- **Tenure Calculations**:
  - Start tenure matches agreement date
  - End tenure = start date + investment months - 1 day (e.g., 2-year product from Jan 1, 2025 ends Dec 31, 2026)
- **Period Management**: Calculates initial dividend period dates based on structure type
- **Document Generation**: Creates agreement filename using `DigitalIDUtil` and generates PDF via `PdfService`
- **Profit Sharing Schedule**: Calls `dividendService.generateProfitSharingSchedule()` for dividend planning

**Approver Admin Process**:
- Sets status to ACTIVE and initializes signature workflow
- Prevents duplicate approvals with status validation
- Updates agreement signature status to PENDING for client and witness
- Regenerates and stores agreement files

**Agreement Date Calculation Deep Dive** (`getProductAgreementDate`):
```java
// Time-based adjustments
if (submissionTime.isAfter(threePM)) submissionDate = submissionDate.plusDays(1);
if (approvalTime.isAfter(sixPM)) approvalDate = approvalDate.plusDays(1);

// Schedule-based lookup with fallback mechanisms
List<ProductAgreementSchedule> schedules = findSchedulesByProductTypeV2(productTypeId, submissionDate, approvalDate);
```

#### 1.2 File Generation Operations
**Endpoints**:
- `GET /api/backend/cms/dividend/generate-bank-file`
- `GET /api/backend/cms/commission/generate-bank-file`
- `GET /api/backend/cms/product-redemption/generate-bank-file`
- `GET /api/backend/cms/product-early-redemption/generate-bank-file`

**Business Logic**:
These endpoints delegate to specialized services for generating banking files required for financial transactions. Each generates standardized banking format files (likely SWIFT or local banking format) for:
- **Dividend Payouts**: Client dividend payments
- **Commission Payments**: Agent and agency commission disbursements
- **Redemption Payments**: Product maturity and early redemption proceeds

#### 1.3 Payment Record Updates
**Endpoints**:
- `GET /api/backend/cms/dividend/update-dividend-payment`
- `GET /api/backend/cms/commission/update-commission-payment`
- `GET /api/backend/cms/product-redemption/update-redemption-payment`
- `GET /api/backend/cms/product-early-redemption/update-early-redemption-payment`

**Business Logic**:
Updates payment status records after successful banking file processing, typically called after bank confirms payment execution.

#### 1.4 Excel Operations
**Endpoints**:
- `GET /api/backend/cms/dividend/update-dividend-excel`
- `GET /api/backend/cms/commission/update-commission-excel`

**Business Logic**:
Generates and updates Excel reports for administrative review and compliance reporting.

#### 1.5 Reallocation and Rollover Management
**Endpoint**: `GET /api/backend/cms/product-order/activate/reallocation-rollover-redemption`
**Parameters**: `id` (Product Order ID)

**Business Logic**:
Activates pending rollover and reallocation orders when parent products mature, enabling seamless product transitions for clients.

---

### 2. Document and Template Management

#### 2.1 PDF Template Generation
**Endpoint**: `POST /api/backend/cms/pdfTemplate`
**Parameters**:
- `id` (required): Product agreement ID
- `content` (optional): HTML content for PDF generation

**Business Logic**:
- Generates preview PDFs for agreement templates
- Uses provided HTML content or retrieves from `ProductAgreement.documentEditor`
- Uploads to S3 with cache-busting query parameters
- Returns signed download URL for immediate preview

#### 2.2 Unsigned Product Agreement Generation
**Endpoint**: `GET /api/backend/cms/unsigned-product-agreement/generate`
**Parameters**: `id` (Product Order ID)

**Business Logic**:
- Generates unsigned PDF agreements for product orders
- Prevents duplicate generation with existing file validation
- Uses `pdfService.generateTrustProductAgreementPdf()` for document creation
- Stores in S3 using structured path: `S3_PRODUCT_ORDER_PATH + orderReferenceNumber`

#### 2.3 Agreement Template System Update
**Endpoint**: `GET /api/backend/internal/agreement/update-file-content`

**Business Logic**:
Internal system maintenance endpoint that:
- Synchronizes agreement templates from classpath resources to database
- Implements sophisticated template matching logic (exact, partial, cleaned names)
- Uploads templates to S3 for CMS access
- Updates `ProductAgreement` entities with S3 keys

**Template Matching Algorithm**:
```java
// 1. Exact match (case insensitive)
// 2. Partial match (contains)
// 3. Cleaned match (removing suffixes like "agreement", "template")
```

---

### 3. CRON Job Endpoints - Financial Calculation Engine

The BackendController contains the most critical automated financial processes in the system. These CRON endpoints handle billions in financial calculations and must execute with perfect accuracy.

### 3.1 Fixed Dividend Calculation System

#### Monthly Fixed Dividend Calculation
**Endpoint**: `GET /api/backend/cron/dividend/fixed/monthly`
**CRON Schedule**: `1st, 16th, and last day of each month or depending on agreement date configuration`

**Business Logic**:
- Calls `dividendService.processFixedDividendCalculation(LocalDate.now(), MONTHLY)`
- Processes all active product orders with monthly dividend schedules
- Uses **FIXED structure type** calculations with predetermined dividend periods

#### Quarterly Fixed Dividend Calculation
**Endpoint**: `GET /api/backend/cron/dividend/fixed/quarterly`
**CRON Schedule**: `1st day of every 3 months`

**Business Logic**:
- Processes quarterly dividend calculations for fixed structure products
- Calculates dividends for Q1 (Jan-Mar), Q2 (Apr-Jun), Q3 (Jul-Sep), Q4 (Oct-Dec)
- Critical for products with quarterly dividend distribution schedules

#### Annual Fixed Dividend Calculation
**Endpoint**: `GET /api/backend/cron/dividend/fixed/annually`
**CRON Schedule**: `1st day of each year`

**Business Logic**:
- Processes annual dividend calculations for fixed structure products
- Handles products with once-yearly dividend distributions
- Essential for long-term investment products

#### Final Fixed Dividend Processing
**Endpoint**: `GET /api/backend/cron/dividend/final`
**CRON Schedule**: `1st, 2nd, and 16th of each month or depending on agreement date configuration`

**Business Logic**:
- Processes final dividend calculations for maturing fixed structure products
- Calls `dividendService.processFinalFixedDividendCalculation()`
- Handles product maturity and final profit distributions
- **Critical Impact**: This determines final client returns and product closure

**Dividend Calculation Formula Deep Dive**:
```java
// Core Formula: Dividend = fundAmount × periodicRate × proratedFactor
double dividendPayoutAmount = fundAmount * (periodicRate / 100.00) * proratedFactor;

// Prorated Factor Calculation (by months for precise calculation):
double proratedFactor = (double) holdingMonths / (double) monthsInPeriod;

// Period Calculations for Fixed Structure:
LocalDate periodStart = calculateFixedPeriodStartingDate(agreementDate, payoutFrequency);
LocalDate periodEnd = calculateFixedPeriodEndingDate(periodStart, payoutFrequency);
```

### 3.2 Flexible Dividend Calculation System

#### Monthly Flexible Dividend Calculation
**Endpoint**: `GET /api/backend/cron/dividend/flexible/monthly`
**CRON Schedule**: `1st, 16th, and last day of each month or depending on agreement date configuration`

#### Quarterly Flexible Dividend Calculation
**Endpoint**: `GET /api/backend/cron/dividend/flexible/quarterly`
**CRON Schedule**: `1st, 16th, and last day of each month or depending on agreement date configuration`

#### Annual Flexible Dividend Calculation
**Endpoint**: `GET /api/backend/cron/dividend/flexible/annually`
**CRON Schedule**: `1st, 16th, and last day of each month or depending on agreement date configuration`

**Business Logic for Flexible Structure**:
- **Key Difference**: Flexible structure uses agreement date as period starting point
- **Dynamic Period Calculation**: Period ending date calculated using `calculateFlexiblePeriodEndingDate()`
- **Closing Date Logic**: For flexible periods ending after 17th, closing date set to month-end
- **Prorated Calculations**: More complex proration based on actual holding periods

**Flexible vs Fixed Structure Differences**:
```java
// FIXED: Periods align with calendar (Jan 1-31, Feb 1-28, etc.)
periodStartingDate = calculateFixedPeriodStartingDate(agreementDate, payoutFrequency);

// FLEXIBLE: Periods based on individual agreement dates
periodStartingDate = productOrder.getAgreementDate();
periodEndingDate = calculateFlexiblePeriodEndingDate(periodStartingDate, payoutFrequency);
```

### 3.3 Commission Calculation System

#### Commission Excel Generation
**Endpoint**: `GET /api/backend/cron/commission/generate-excel`
**CRON Schedule**: Not specified in comments (likely monthly)

**Business Logic**:
- Calls `commissionService.generateCommissionExcel()`
- Creates comprehensive Excel reports for commission tracking
- Essential for commission payment processing and regulatory reporting

#### Agent Commission Calculations
**Endpoints**:
- `GET /api/backend/cron/commission/agent-monthly` - Monthly agent commission calculation
- `GET /api/backend/cron/commission/agent-yearly` - Yearly agent commission calculation
**CRON Schedule**: `1st, 16th, and last day of each month or depending on agreement date configuration`

**Business Logic**:
- **Monthly Calculations**: `agentCommissionService.processAgentMonthlyCommission()`
- **Yearly Calculations**: `agentCommissionService.processAgentYearlyCommission()`
- Processes individual agent commission based on sales performance and hierarchy

#### Agency Commission Calculations
**Endpoints**:
- `GET /api/backend/cron/commission/agency-monthly` - Monthly agency commission calculation
- `GET /api/backend/cron/commission/agency-yearly` - Yearly agency commission calculation
**CRON Schedule**: `1st, 16th, and last day of each month or depending on agreement date configuration`

**Business Logic**:
- **Agency-Level Processing**: `agencyCommissionService.processAgencyMonthlyCommission()` and yearly variant
- Calculates commission at agency level, affecting multiple agents under each agency
- **Hierarchical Impact**: Agency commission affects downstream agent commission calculations

**Commission Calculation Algorithm** (from CommissionService analysis):
```java
// Threshold-based Commission Calculation
if (totalSales > thresholdAmount && baseCommission < commissionAboveThreshold) {
    // Split calculation: below threshold + above threshold rates
    double salesBelowThreshold = Math.max(thresholdAmount - previousTotalSales, 0);
    double salesAboveThreshold = currentTotalSales - salesBelowThreshold;

    // Different rates applied to different sales tiers
    commissionBelowThreshold = salesBelowThreshold * baseCommission;
    commissionAboveThreshold = salesAboveThreshold * commissionAboveThreshold;
}
```

---

### 4. Automated Notification System

#### Physical Trust Deed Reminder
**Endpoint**: `GET /api/backend/cron/reminder/physical-trust-deed`
**CRON Schedule**: `Every day or every business day`

**Business Logic**:
- Calls `backendService.cronPhysicalTrustDeedReminder()`
- Identifies product orders requiring physical trust deed submission
- Uses 7 business day cutoff calculation with `DateUtil.subtractBusinessDays()`
- Sends reminder emails via `emailService.sendPhysicalTrustDeedReminderEmail()`
- Updates reminder sent status to prevent duplicate notifications

**Business Day Calculation**:
```java
LocalDate cutoffDate = DateUtil.subtractBusinessDays(now, 7);
List<PhysicalTrustDeedReminderInterfaceVo> reminders =
    productOrderDao.findProductOrdersForPhysicalTrustDeedReminder(cutoffDate);
```

---

## Critical CRON Timing Analysis and Business Impact

### 1. Multi-Day Execution Strategy
The system uses a sophisticated **multi-day execution strategy** for most dividend and commission calculations:
- **1st of month**: Primary calculation day for most operations
- **16th of month**: Mid-month catch-up and validation
- **Last day of month**: Final calculations and month-end reconciliation

**Why This Matters**:
- **Fault Tolerance**: If 1st-day execution fails, 16th provides backup
- **Period Alignment**: Different products may have different period start dates
- **Agreement Date Dependency**: Some calculations depend on specific agreement dates falling within the month

### 2. Agreement Date Configuration Impact
The phrase "**or depending on agreement date configuration**" is crucial:
- Products may have **custom calculation dates** based on agreement terms
- **ProductAgreementSchedule** table stores product-specific timing overrides
- Some products trigger calculations on **anniversary dates** rather than calendar dates

### 3. Commission Calculation Timing Dependencies

**Sequential Processing Requirements**:
1. **Product Orders** must be approved (Finance → Approver workflow)
2. **Dividend Calculations** execute first (provide base for commission calculations)
3. **Commission Calculations** then execute (depend on dividend calculation results)
4. **Excel Generation** occurs after calculations complete

**Time Sensitivity**:
- **Monthly Commission**: Depends on month-to-date sales data
- **Yearly Commission**: Requires full year-to-date calculations
- **Threshold Calculations**: Sales amounts must be current before commission calculation

### 4. Financial Calculation Accuracy Safeguards

**Double Processing Protection**:
The multi-day execution strategy prevents financial errors:
- **Idempotent Operations**: Calculations check for existing records before creating duplicates
- **Date-Based Filtering**: Only processes orders within specific date ranges
- **Status Validation**: Only processes orders in appropriate status states

**Prorated Factor Precision**:
```java
// Month-based calculation for higher precision than day-based
double proratedFactor = (double) holdingMonths / (double) monthsInPeriod;

// Handles partial months and leap years correctly
long holdingMonths = Math.max(0, ChronoUnit.MONTHS.between(effectiveStartDate, endTenure.plusDays(1)));
```

---

## Key Business Rules and Financial Logic

### Commission Threshold System
- **Base Commission Rate**: Applied to sales below threshold
- **Enhanced Commission Rate**: Applied to sales above threshold
- **Year-to-Date Tracking**: Cumulative sales determine applicable rates
- **Tier Qualification**: Previous year performance affects current year rates

### Dividend Structure Types
- **FIXED**: Calendar-based periods (Jan-Mar, Apr-Jun, etc.)
- **FLEXIBLE**: Agreement-date-based periods (custom anniversaries)
- **Prorated Calculations**: Precise month-based calculations for partial periods

### Document Generation Workflow
- **Unsigned Agreements**: Generated for client review
- **Signed Agreements**: Created after signature completion
- **Template Updates**: Synchronized from resources to database
- **S3 Storage**: Centralized document repository with signed URLs

### Payment Processing Integration
- **Bank File Generation**: Creates banking system compatible files
- **Payment Status Tracking**: Updates records after bank confirmation
- **Excel Reporting**: Generates reports for manual review
- **Email Notifications**: Automated stakeholder communication

---

## Error Handling and Data Integrity

### Transaction Management
- `@Transactional` annotations ensure data consistency
- **Atomic Operations**: Complex approval workflows complete entirely or roll back
- **Status Validation**: Prevents invalid state transitions

### Exception Handling Strategy
- **Granular Error Logging**: Each CRON job logs execution details
- **Graceful Failure**: Print stack trace but continue system operation
- **Error Propagation**: CMS operations return structured error responses

### Data Validation
- **Product Order Existence**: Validates orders before processing
- **Status Checks**: Ensures proper workflow state before operations
- **Date Range Validation**: Prevents processing outside valid periods

---

## Performance and Scalability Considerations

### Bulk Processing Optimization
- **Date Range Queries**: Efficient filtering of orders for processing
- **Batch Operations**: Process multiple orders in single transactions
- **Async File Generation**: PDF and Excel generation doesn't block processing

### Caching Strategy
- **S3 Pre-signed URLs**: Reduce database load for document access
- **Template Caching**: Agreement templates cached in S3
- **Calculation Results**: Stored in history tables for audit and performance

### Database Optimization
- **Indexed Queries**: Date and status-based filtering optimized
- **History Tables**: Separate tables for calculation results prevent main table bloat
- **Reference Number Generation**: Time-based prefixes enable efficient sorting

---

## Integration Points and Dependencies

### External Systems
- **AWS S3**: Document storage and retrieval
- **Banking Systems**: File format compatibility for payments
- **Email Service**: Notification delivery
- **PDF Generation**: Document creation engine

### Internal Dependencies
- **DividendService**: Core dividend calculation engine
- **CommissionService**: Multi-level commission calculation
- **ProductService**: Product lifecycle management
- **PdfService**: Document generation
- **EmailService**: Communication management

---

## Security and Compliance Features

### Administrative Access Control
- **CMS-Only Endpoints**: No client-facing operations
- **Admin Type Validation**: Finance vs Approver role enforcement
- **Audit Trails**: Comprehensive logging of all operations

### Data Protection
- **Secure File Storage**: S3 with proper access controls
- **Document Integrity**: PDF generation with validation
- **Financial Data Accuracy**: Multiple validation points in calculations

### Regulatory Compliance
- **Calculation History**: Complete audit trail of all calculations
- **Document Retention**: Permanent storage of agreements and reports
- **Payment Tracking**: End-to-end payment process documentation

---

## Development and Maintenance Guidelines

### CRON Job Monitoring
- **Execution Logging**: Monitor all CRON job executions
- **Error Alerting**: Implement monitoring for failed calculations
- **Performance Tracking**: Monitor execution times for optimization

### Testing Requirements
- **Date Simulation**: Test CRON jobs with various date scenarios
- **Calculation Verification**: Validate financial calculation accuracy
- **Document Generation**: Verify PDF and Excel output integrity

### Deployment Considerations
- **CRON Schedule Configuration**: External scheduler must trigger endpoints appropriately
- **Database Migrations**: History tables must maintain data integrity
- **S3 Bucket Setup**: Proper permissions for document operations

This documentation provides comprehensive coverage of the BackendController's sophisticated financial calculation engine, administrative operations, and automated processes that form the backbone of the Citadel investment management system.