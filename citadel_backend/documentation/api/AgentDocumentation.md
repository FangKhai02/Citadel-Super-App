# Agent Controller Business Process Documentation

## Overview

The `AgentController` serves as the main REST API controller for agent-related operations in the Citadel backend system. It handles agent profile management, client relationships, sales tracking, commission calculations, secure tag operations, and product purchases through agents.

## Architecture

- **Controller**: `AgentController` - REST endpoints with proper validation and error handling
- **Service**: `AgentService` - Business logic implementation
- **Additional Services**: `ProductService` for purchase operations
- **Database**: Agent, Client, Product, Commission, and related entities
- **Security**: API key-based authentication with session validation

---

## API Endpoints Documentation

### 1. Agent Management APIs

#### 1.1 Get Agents by Agency Code
**Endpoint**: `GET /api/agent/agents`
**Parameters**:
- `agencyId` (required): Agency identifier

**Business Logic**:
- Validates agency exists by `agencyId`
- Retrieves only ACTIVE agents from the specified agency
- Converts Agent entities to AgencyAgentVo DTOs
- Returns list of agents under the agency

**Key Implementation Details**:
- Uses `AgentDao.findAllByAgencyAndStatus()` with ACTIVE status filter
- Error handling with `GeneralException` for invalid agency ID
- DTO conversion using `Agent.agentToAgentVo()` method

#### 1.2 Get Agent Profile
**Endpoint**: `GET /api/agent/profile`
**Authentication**: API Key required

**Business Logic**:
- Validates API key and retrieves authenticated user session
- Finds active agent associated with the authenticated user
- Returns agent personal details and agent-specific details
- Throws exception if agent profile is terminated

**Key Implementation Details**:
- Uses `validateApiKey()` for authentication
- Retrieves agent using `AgentDao.findByAppUserAndStatus()` with ACTIVE status
- Returns combined personal and agent details in `AgentProfileRespVo`

#### 1.3 Edit Agent Profile
**Endpoint**: `POST /api/agent/profile/edit`
**Authentication**: API Key required
**Request Body**: `AgentProfileEditReqVo`

**Business Logic**:
- Validates API key and finds active agent
- Performs validation on mobile number and email if provided
- Updates UserDetail entity fields (address, postcode, city, state, country, mobile, email)
- Uses Optional.ofNullable() pattern for safe updates
- Capitalizes text fields using `StringUtil.capitalizeEachWord()`

**Validation Rules**:
- Mobile number format validation using `ValidatorUtil.validMobileNumber()`
- Email format validation using `ValidatorUtil.validEmail()`
- Returns validation errors in JSONArray format

#### 1.4 Update Agent Profile Image
**Endpoint**: `POST /api/agent/profile-image/edit`
**Authentication**: API Key required
**Request Body**: `AgentProfileImageAddEditReqVo`

**Business Logic**:
- Handles base64 image upload to AWS S3
- Deletes existing profile image if new one is null
- Uses `AwsS3Util` for S3 operations
- Stores S3 key in UserDetail entity

**File Handling**:
- Checks if image is base64 or HTTP URL
- Uploads to S3 path: `S3_AGENT_PATH + agentIdentityCardNumber`
- Filename: "profilePictureImage"

---

### 2. Agent Sales & Performance APIs

#### 2.1 Get Agent Total Sales
**Endpoint**: `GET /api/agent/personal-sales/total-sales`
**Authentication**: API Key required
**Parameters**:
- `agentId` (optional): Specific agent ID to query

**Business Logic**:
- Calculates current quarter sales using `DateUtil.getQuarter()`
- Compares with previous quarter for percentage difference
- Counts total products sold in current quarter
- Retrieves payment method from bank details

**Calculation Logic**:
```java
double percentageDifference = (previousQuarterTotalSalesAmount == 0) ?
    (Math.signum(currentQuarterTotalSalesAmount) * 100) :
    ((currentQuarterTotalSalesAmount - previousQuarterTotalSalesAmount) / previousQuarterTotalSalesAmount) * 100;
```

**Data Sources**:
- `ProductOrderDao.findTotalSalesByAgentAndByPeriod()` for sales amounts
- `ProductOrderDao.findTotalProductsSoldByAgentByDateRange()` for product counts
- `BankDetailsDao.findBankNameByAppUserAndIsDeletedFalse()` for payment info

#### 2.2 Get Agent Sales Details
**Endpoint**: `GET /api/agent/personal-sales/sales-details`
**Authentication**: API Key required
**Parameters**:
- `agentId` (optional): Target agent ID
- `month` (optional): Month to query (defaults to current)
- `year` (optional): Year to query (defaults to current)

**Business Logic**:
- Handles both personal sales and downline sales queries
- Determines if query is peer-to-peer (P2P) between managers
- Shows commission details only for Citadel agency agents
- Masks client information for P2P queries

**Commission Logic**:
- Personal commission: Uses `AgentCommissionHistory.CommissionType.PERSONAL`
- Overriding commission: Uses `AgentCommissionHistory.CommissionType.OVERRIDING`
- P2P detection: Both agents have MGR role
- Client masking: Sets clientId and clientName to null for P2P

#### 2.3 Get Agent Earnings
**Endpoint**: `GET /api/agent/earning`
**Authentication**: API Key required
**Parameters**:
- `agentId` (optional): Specific agent ID

**Business Logic**:
- Returns empty response for non-Citadel agencies
- Retrieves all successful commission payments
- Groups earnings by product and payment date
- Implements Redis caching (commented for production)

**Data Processing**:
- Maps `AgentCommissionHistory` to `AgentEarningVo`
- Includes product code, agreement number, transaction details
- Caches response for ONE_DAY duration

---

### 3. Agent Hierarchy & Downline APIs

#### 3.1 Get Agent Downline Details
**Endpoint**: `GET /api/agent/downline`
**Authentication**: API Key required
**Parameters**:
- `agentId` (optional): Specific agent ID

**Business Logic**:
- Recursively builds agent hierarchy using `buildAgentDownLine()`
- Counts total subordinates and new recruits this month
- Uses HashSet to track unique subordinate IDs

**Recursive Algorithm**:
```java
public AgentDownLineVo buildAgentDownLine(Long id, Set<Long> allSubordinateIds, Set<Long> newRecruitIds) {
    // Creates tree structure of agent hierarchy
    // Tracks new recruits using DateUtil.isCurrentMonthAndYear()
    // Returns null for non-existent agents
}
```

#### 3.2 Get Agent Downline Commission
**Endpoint**: `GET /api/agent/commission-overriding`
**Authentication**: API Key required
**Parameters**:
- `month` (optional): Target month
- `year` (optional): Target year

**Business Logic**:
- Returns empty for non-Citadel agencies
- Queries overriding commission history for date range
- Groups commissions by product ID
- Implements Redis caching

**Commission Types Included**:
- OVERRIDING commissions only
- Status: SUCCESS only
- Groups by product and shows commission details per downline agent

#### 3.3 Get Agent Downline List
**Endpoint**: `GET /api/agent/downline/list`
**Authentication**: API Key required

**Business Logic**:
- Uses breadth-first search (BFS) to collect all subordinates
- Flattens hierarchical structure into simple list
- Returns agent details for all downline members

**BFS Implementation**:
```java
Queue<Long> queue = new LinkedList<>();
queue.add(agent.getId());
while (!queue.isEmpty()) {
    Long currentId = queue.poll();
    // Process subordinates and add to queue
}
```

---

### 4. Client Management APIs

#### 4.1 Get Agent Clients
**Endpoint**: `GET /api/agent/clients`
**Authentication**: API Key required
**Parameters**:
- `agentId` (optional): Specific agent ID to query

**Business Logic**:
- MGR role agents can only view their own clients
- Combines individual and corporate clients
- Counts new clients acquired this month
- Returns comprehensive client list with statistics

**Access Control**:
- MGR agents: Can only query their own clients (`agentId` parameter ignored)
- Higher roles: Can query any agent's clients
- Corporate clients handled separately via `CorporateClientDao`

#### 4.2 Get Client Portfolio under Agent
**Endpoint**: `GET /api/agent/client/portfolio`
**Authentication**: API Key required
**Parameters**:
- `clientId` (required): Target client ID
- `agentId` (optional): Specific agent ID

**Business Logic**:
- Validates client belongs to the agent
- Delegates to `ClientService.getClientPortfolioByClient()`
- Returns portfolio details for the specific client

#### 4.3 Get Client Transactions under Agent
**Endpoint**: `GET /api/agent/client/transactions`
**Authentication**: API Key required
**Parameters**:
- `clientId` (required): Target client ID
- `agentId` (optional): Specific agent ID

**Business Logic**:
- Validates client-agent relationship
- Delegates to `ProductService.getProductTransaction()`
- Returns transaction history for the client

---

### 5. Secure Tag Management APIs

#### 5.1 Get Secure Tag Status
**Endpoint**: `GET /api/agent/secure-tag/{clientId}`
**Authentication**: API Key required
**Path Parameters**:
- `clientId`: Client identifier (ends with 'I' for individual, 'C' for corporate)

**Business Logic**:
- Determines client type by clientId suffix ('I' or 'C')
- Retrieves latest unread secure tag for agent-client pair
- Handles expiration logic automatically
- Marks tag as read when status is final

**Status Handling**:
- EXPIRED: Automatically set if expiredAt < current time
- APPROVED: Returns token and marks as read
- CANCELLED/REJECTED/EXPIRED: Marks as read
- PENDING_APPROVAL: Remains unread

#### 5.2 Create Client Secure Tag
**Endpoint**: `POST /api/agent/secure-tag/{clientId}`
**Authentication**: API Key required
**Path Parameters**:
- `clientId`: Target client identifier

**Business Logic**:
- Checks for existing pending secure tag
- Creates new secure tag with 30-minute expiration
- Sends push notification to client
- Uses UUID for secure token generation

**Secure Tag Creation**:
```java
secureTag.setToken(UUID.randomUUID().toString());
secureTag.setExpiredAt(DateUtil.addMinutes(new Date(), 30));
secureTag.setStatus(SecureTagStatus.PENDING_APPROVAL);
```

**Push Notification**:
- Title: "Secure Tag Request"
- Message: Includes agent name and referral code
- Action: Client can approve/reject the request

#### 5.3 Cancel Client Secure Tag
**Endpoint**: `DELETE /api/agent/secure-tag/{clientId}`
**Authentication**: API Key required
**Path Parameters**:
- `clientId`: Target client identifier

**Business Logic**:
- Only allows cancellation if status is PENDING_APPROVAL
- Sets status to CANCELLED and marks as read
- Returns error for invalid requests

---

### 6. Agent PIN Management API

#### 6.1 Agent PIN Operations
**Endpoint**: `POST /api/agent/pin`
**Authentication**: API Key required
**Request Body**: `AgentPinReqVo`

**Business Logic Scenarios**:

**PIN Registration** (newPin only):
- Validates agent doesn't have existing PIN
- Validates PIN format using `validPinFormat()`
- Stores new PIN for agent

**PIN Validation** (oldPin only):
- Validates provided PIN matches stored PIN
- Returns success/error based on validation

**PIN Update** (both oldPin and newPin):
- Validates current PIN first
- If valid, registers new PIN
- Atomic operation ensuring consistency

**Validation Rules**:
- PIN must pass `validPinFormat()` check (implementation not shown)
- Old PIN must match exactly for updates
- Empty/null PIN values handled appropriately

---

### 7. Product Purchase API

#### 7.1 Purchase Product
**Endpoint**: `POST /api/agent/purchase`
**Authentication**: API Key required
**Parameters**:
- `referenceNumber` (optional): For updating existing draft
**Request Body**: `ProductPurchaseReqVo`

**Business Logic**:
- Delegates to `ProductService.createProductOrder()`
- Handles both new purchases and draft updates
- Validates product purchase amount every time
- Beneficiary validation done separately

**Required Fields for Draft**:
1. `ProductPurchaseProductDetailsVo.productId`
2. `ProductPurchaseProductDetailsVo.amount`
3. `ProductPurchaseProductDetailsVo.dividend`
4. `ProductPurchaseProductDetailsVo.investmentTenureMonth`

**Validation Strategy**:
- Purchase amount: Validated on every draft save
- Beneficiary distribution: Validated separately
- Reference number: Required for existing draft updates

---

### 8. Agreement & Commission APIs

#### 8.1 Get Pending Agreement Signatures
**Endpoint**: `GET /api/agent/pending-agreement`
**Authentication**: API Key required

**Business Logic**:
- Finds product orders pending agent signature
- Client signature must be completed (SUCCESS)
- Agent signature must be pending (PENDING)
- Includes both regular orders and early redemptions
- Orders by client signature date (newest first)

**Two Types of Pending Agreements**:
1. **Product Orders**: Regular product purchases requiring witness signature
2. **Early Redemptions**: Early redemption requests requiring witness signature

#### 8.2 Get Agent Commission Monthly Report
**Endpoint**: `GET /api/agent/commission-report`
**Authentication**: API Key required
**Parameters**:
- `agentId` (optional): Specific agent ID
- `month` (optional): Target month
- `year` (optional): Target year

**Business Logic**:
- Generates comprehensive PDF commission report
- Includes both personal and overriding commissions
- Groups data by product for clear presentation
- Uploads report to S3 and returns download link

**Report Structure**:
- Agent information (name, designation, dates)
- Personal sales records per product
- Overriding commission records per product
- Product totals and grand total
- Formatted using FreeMarker templates

**S3 Storage**:
- Path: `S3_AGENT_PATH + agentId + "/reports"`
- Filename: `commission_report_V2_{agentId}_{month}_{year}.pdf`
- Returns pre-signed download URL

---

## Key Business Rules

### Agent Status Management
- Only ACTIVE agents can perform operations
- TERMINATED/SUSPENDED agents are rejected
- Status changes affect all dependent operations

### Commission Calculations
- Only Citadel agency agents receive commission details
- Personal vs Overriding commission based on relationship
- P2P queries mask sensitive client information
- Commission payments require SUCCESS status

### Secure Tag Security
- 30-minute expiration for all secure tags
- UUID-based tokens for security
- Automatic expiration handling
- Push notifications for approval requests

### Access Control
- MGR role agents limited to own data
- Higher roles can access downline data
- API key validation for all operations
- Client-agent relationship validation

### Data Integrity
- Atomic PIN operations
- Draft purchase validation
- Beneficiary distribution checks
- Agreement signature workflows

---

## Error Handling

### Common Error Scenarios
- `AGENT_PROFILE_TERMINATED`: Agent status not ACTIVE
- `USER_NOT_FOUND`: Invalid agent authentication
- `INVALID_AGENCY_ID`: Agency doesn't exist
- `CLIENT_NOT_FOUND`: Client-agent relationship invalid
- `SECURE_TAG_ALREADY_CREATED`: Duplicate secure tag request
- `INVALID_OLD_PIN`/`INVALID_NEW_PIN`: PIN validation failures

### Error Response Format
- Uses `ErrorResp` class for consistent error responses
- Returns appropriate HTTP status codes
- Includes descriptive error messages
- Validation errors in JSONArray format

---

## Performance Considerations

### Caching Strategy
- Redis caching for earnings and commission reports
- Cache keys include agent ID and date parameters
- ONE_DAY cache duration for most data
- Commented out for production (TODO)

### Database Optimization
- Eager/lazy loading strategies for entities
- Indexed queries for agent-client relationships
- Batch processing for commission calculations
- Pagination not implemented (consider for large datasets)

### File Operations
- AWS S3 for profile images and reports
- Base64 image processing
- PDF generation using FreeMarker templates
- Pre-signed URLs for secure downloads

---

## Integration Points

### External Services
- **AWS S3**: File storage and retrieval
- **Push Notifications**: Client communication
- **Email Service**: Agreement notifications
- **Redis**: Caching layer
- **PDF Service**: Report generation

### Internal Dependencies
- **ClientService**: Portfolio and client operations
- **ProductService**: Purchase and transaction operations
- **ValidatorService**: Data validation
- **PdfService**: Document generation
- **EmailService**: Communication

---

## Security Features

### Authentication & Authorization
- API key-based authentication
- Session validation for all operations
- Role-based access control
- Client-agent relationship validation

### Data Protection
- Client information masking for P2P queries
- Secure token generation using UUID
- PIN validation with format checks
- File upload security via S3

### Audit Trail
- Operation logging with function names
- Error tracking and stack traces
- Commission calculation history
- Agreement signature tracking

---

## Development Notes

### Testing Considerations
- Mock external services (S3, Redis, Push notifications)
- Test role-based access control scenarios
- Validate commission calculation algorithms
- Test concurrent secure tag operations

### Deployment Requirements
- Redis configuration for caching
- AWS S3 bucket setup with proper permissions
- FreeMarker template deployment
- Push notification service configuration

### Monitoring Requirements
- Commission calculation accuracy
- File upload/download performance
- API response times for complex queries
- Cache hit/miss ratios

This documentation provides a comprehensive overview of the AgentController's business logic and should help the new development team understand and maintain the system effectively.