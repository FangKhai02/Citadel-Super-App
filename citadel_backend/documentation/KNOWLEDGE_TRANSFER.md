# Citadel Investment Management Platform - Knowledge Transfer Documentation

## Table of Contents
1. [System Overview](#system-overview)
2. [Architecture & Components](#architecture--components)
3. [Local Development Setup](#local-development-setup)
4. [Core Business Logic Flows](#core-business-logic-flows)
5. [Key Technical Concepts](#key-technical-concepts)
6. [Database Schema](#database-schema)
7. [API Documentation](#api-documentation)
8. [Deployment & Environments](#deployment--environments)
9. [Security & Authentication](#security--authentication)
10. [Troubleshooting Guide](#troubleshooting-guide)

---

## System Overview

Citadel is a comprehensive financial investment management platform designed for Malaysian financial services. The system manages investment products, client onboarding, agent hierarchies, commission calculations, and regulatory compliance.

### Business Domain
- **Industry**: Financial Services / Investment Management
- **Primary Market**: Malaysia
- **Regulation**: Complies with Malaysian financial regulations
- **Core Functions**:
  - Investment product management
  - Client relationship management (Individual & Corporate)
  - Agent/Agency commission tracking
  - Regulatory compliance & documentation

### System Components
```
┌─────────────────┬─────────────────┐
│   Mobile App    │   Admin CMS     │
│   (Flutter)     │   (Laravel)     │
└─────────────────┴─────────────────┴
                   │
          ┌─────────────────┐
          │   REST API      │
          │  (Spring Boot)  │
          └─────────────────┘
                   │
          ┌─────────────────┐
          │     MySQL       │
          │   Database      │
          └─────────────────┘
```

---

## Architecture & Components

### Backend API (`citadel_backend/`)
- **Framework**: Spring Boot 3.3.1
- **Language**: Java 17
- **Database**: MySQL with JPA/Hibernate
- **Security**: Spring Security
- **Cache**: Redis with Redisson
- **Storage**: AWS S3 (DigitalOcean Spaces)
- **Documentation**: OpenAPI 3 (Swagger UI)
- **Templates**: FreeMarker for PDF generation

### CMS Frontend (`citadelcms/`)
- **Framework**: Laravel 8.75+
- **Admin Panel**: TCG Voyager 1.7
- **Frontend**: Laravel Mix + Webpack
- **PHP Version**: 7.4+
- **Storage**: S3/Digital Ocean Spaces
- **Database**: Shared MySQL with backend

### Key Directories Structure
```
Citadel/
├── citadel_backend/
│   ├── src/main/java/com/citadel/backend/
│   │   ├── controller/          # REST API endpoints
│   │   ├── service/            # Business logic layer
│   │   ├── dao/               # Data access objects
│   │   ├── entity/            # JPA entities
│   │   ├── vo/                # Value objects (DTOs)
│   │   ├── config/            # Spring configuration
│   │   └── utils/             # Utility classes
│   ├── src/main/resources/
│   │   ├── templates/         # Thymeleaf templates
│   │   └── application*.properties
│   └── sql/mysql/            # Database scripts
│
└── citadelcms/
    ├── app/
    │   ├── Models/            # Eloquent models
    │   ├── Http/Controllers/  # Laravel controllers
    │   └── Helpers/           # Helper functions
    ├── database/seeders/      # Database seeders
    ├── resources/views/       # Blade templates
    └── sql/                   # SQL dump files
```

---

## Local Development Setup

### Prerequisites
- **Java 17** (for backend)
- **Maven 3.6+** (for backend)
- **PHP 7.4+** (for CMS)
- **Composer** (for CMS)
- **Node.js 14+** (for CMS assets)
- **MySQL 8.0+**
- **Redis** (for backend caching)


## Core Business Logic Flows

### 1. Client Onboarding Flow

#### Individual Client Registration
```
Mobile App Registration
    ↓
Personal Details Collection (citadel_backend/service/SignUpService.java:120)
    ↓
Identity Verification (NRIC/Passport)
    ↓
Employment & Wealth Source Details
    ↓
Bank Details Collection (citadel_backend/service/BankService.java:45)
    ↓
PEP Declaration (Politically Exposed Person)
    ↓
Document Upload (IC, Bank Statement, etc.)
    ↓
Face ID Verification (citadel_backend/entity/FaceIdImageValidate.java)
    ↓
OTP Verification (citadel_backend/service/OtpService.java:67)
    ↓
Account Activation
    ↓
Client Profile Created (citadel_backend/entity/Client.java)
```

#### Corporate Client Registration
```
Corporate Registration Request
    ↓
Company Details Collection (citadel_backend/entity/Corporate/CorporateClient.java)
    ↓
Directors & Shareholders Information
    ↓
Corporate Documents Upload (SSM, MOA, etc.)
    ↓
Authorized Person Details
    ↓
Corporate Bank Details
    ↓
Compliance Verification
    ↓
Account Approval
    ↓
Corporate Client Profile Created
```

### 2. Product Investment Flow

#### Investment Process
```
Client Login (citadel_backend/service/LoginService.java:89)
    ↓
Browse Products (citadel_backend/service/ProductService.java:156)
    ↓
Product Selection & Details Review
    ↓
Investment Amount Input
    ↓
Beneficiary Assignment (citadelcms/app/Models/ProductBeneficiaries.php)
    ↓
Agreement Generation (citadel_backend/service/PdfService.java:234)
    ↓
Payment Upload (citadel_backend/controller/ProductController.java:125)
    ↓
Order Creation (citadel_backend/entity/Products/ProductOrder.java)
    ↓
Admin Verification (citadelcms/app/Http/Controllers/ProductOrderController.php:180)
    ↓
Commission Calculation (citadel_backend/service/CommissionService.java:78)
    ↓
Investment Confirmed
    ↓
Receipt Generation
```

### 3. Agent Commission Flow

#### Commission Structure
```
Product Sale Completed
    ↓
Agent Hierarchy Lookup (citadel_backend/entity/Agent.java:47)
    ↓
Commission Rates Calculation
    ├── Agent Direct Commission (citadelcms/app/Models/AgentCommissionConfiguration.php)
    ├── Agency Override Commission (citadelcms/app/Models/AgencyCommissionConfiguration.php)
    └── Upline Commission Distribution
    ↓
Commission Records Creation (citadelcms/app/Models/ProductCommissionHistory.php:25)
    ↓
Payment Processing
    ↓
Commission Distribution
```

### 4. Document Management Flow

#### Agreement Generation
```
Product Order Finalization
    ↓
Client Data Collection
    ↓
Product Terms Assembly
    ↓
Template Selection (citadel_backend/src/main/resources/templates/)
    ↓
Thymeleaf Template Processing (citadel_backend/service/PdfService.java:156)
    ↓
PDF Generation (OpenHTMLToPDF)
    ↓
S3 Storage Upload (citadel_backend/utils/AwsS3Util.java:45)
    ↓
Agreement Record Creation (citadelcms/app/Models/ProductAgreement.php)
    ↓
Client Notification
```

### 5. Redemption & Withdrawal Flow

#### Early Redemption Process
```
Client Redemption Request
    ↓
Investment Eligibility Check
    ↓
Penalty Calculation (if applicable)
    ↓
Bank Details Verification
    ↓
Redemption Amount Calculation
    ↓
Admin Approval (citadelcms/app/Http/Controllers/ProductEarlyRedemptionHistoryController.php:125)
    ↓
Commission Reversal (if required)
    ↓
Payment Processing
    ↓
Investment Closure
    ↓
Tax Documentation
```

---

## Deployment & Environments

### Environment Configuration

#### Staging Environment
- **Backend API**: https://api.citadel.nexstream.com.my/citadelBackend
- **CMS Portal**: https://admin.citadel.nexstream.com.my/admin
- **Database**: Staging MySQL instance
- **File Storage**: DigitalOcean Spaces (staging bucket)

#### Production Environment
- **Backend API**: https://app.citadelgroup.com.my/citadelBackend
- **CMS Portal**: https://cims.citadelgroup.com.my/admin
- **Database**: Production MySQL cluster
- **File Storage**: DigitalOcean Spaces (production bucket)

### Deployment Process

#### Backend Deployment
```bash
# Build application
./mvnw clean package -Dspring.profiles.active=prod

# Deploy WAR file to server
scp target/citadel-backend.war root@server:/opt/tomcat/webapps/

# Restart application server
systemctl restart tomcat
```

### Server Requirements

#### Backend Server
- **OS**: Ubuntu 20.04 LTS
- **Java**: OpenJDK 17
- **Application Server**: Apache Tomcat 10
- **Memory**: 4GB RAM minimum
- **Storage**: 100GB SSD

#### CMS Server
- **OS**: Ubuntu 20.04 LTS
- **PHP**: 7.4+ with extensions (mysql, gd, curl, zip)
- **Web Server**: Apache 2.4 or Nginx
- **Memory**: 2GB RAM minimum

#### Database Server
- **MySQL**: 8.0+
- **Memory**: 8GB RAM minimum
- **Storage**: 500GB SSD with regular backups

---

## Troubleshooting Guide
### Common Development Issues
#### Backend Issues

**Issue**: Application fails to start with database connection error
```bash
Solution:
1. Check MySQL is running: systemctl status mysql
2. Verify database exists: mysql -u root -p -e "SHOW DATABASES;"
3. Check connection settings in application-local.properties
4. Ensure database user has proper privileges
```

**Issue**: Swagger UI shows 401 Unauthorized
```bash
Solution:
1. Check swagger.basic.auth.username/password in application.properties
2. Verify Spring Security configuration allows swagger endpoints
3. Clear browser cache and retry
```

**Issue**: Redis connection errors
```bash
Solution:
1. Install and start Redis: apt install redis-server
2. Test connection: redis-cli ping
3. Check Redis configuration in application.properties
4. Verify firewall settings
```

#### IntelliJ IDEA Specific Issues

**Issue**: Maven dependencies not resolving
```bash
Solution:
1. File → Invalidate Caches and Restart → Invalidate and Restart
2. Right-click on pom.xml → Maven → Reload project
3. File → Settings → Build → Build Tools → Maven
   - Check "Use plugin registry" and "Download sources"
4. Delete .m2/repository folder and re-import project
```

**Issue**: Spring Boot run configuration not working
```bash
Solution:
1. Verify Main class is set correctly:
   com.citadel.backend.CitadelBackendApplication
2. Check Active profiles is set to: local
3. Ensure Working directory is: $MODULE_WORKING_DIR$
4. If still failing, try creating new Run Configuration from scratch
```

**Issue**: Database connection fails in IntelliJ Database tool
```bash
Solution:
1. Install MySQL driver if prompted
2. Use correct connection details:
   - Host: localhost
   - Port: 3306
   - Database: citadel
   - User: root
   - Password: root
3. Test connection before applying
4. If connection times out, check MySQL is running locally
```

**Issue**: Hot reload not working during development
```bash
Solution:
1. Add Spring Boot DevTools dependency to pom.xml:
   <dependency>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-devtools</artifactId>
       <scope>runtime</scope>
   </dependency>
2. File → Settings → Build → Compiler
   - Check "Build project automatically"
3. Help → Find Action → Registry
   - Enable "compiler.automake.allow.when.app.running"
4. Restart IntelliJ after making these changes
```

### Monitoring & Logging

#### Application Logs Location
- **Backend**: `/opt/tomcat/logs/catalina.out`
- **CMS**: `/var/www/citadelcms/storage/logs/laravel.log`

---

## Knowledge Transfer Checklist

### For Backend Developer
- [ ] Set up IntelliJ IDEA with Spring Boot project
- [ ] Configure run configuration with local profile
- [ ] Understand Spring Boot project structure
- [ ] Review entity relationships and JPA mappings
- [ ] Study service layer business logic
- [ ] Test API endpoints using Swagger UI
- [ ] Review security configuration
- [ ] Understand PDF generation process
- [ ] Practice deployment process
- [ ] Configure IntelliJ Database tool for MySQL connection
- [ ] Set up hot reload with Spring Boot DevTools

### For CMS Developer
- [ ] Understand Laravel + Voyager architecture
- [ ] Learn BREAD export/import process
- [ ] Review model relationships
- [ ] Understand role-based access control
- [ ] Practice Voyager admin panel usage
- [ ] Test file upload functionality
- [ ] Review database seeding process

### For Full-Stack Developer
- [ ] Set up both applications locally
- [ ] Understand data flow between components
- [ ] Review shared database schema
- [ ] Test end-to-end business processes
- [ ] Understand deployment pipeline
- [ ] Review monitoring and logging setup

---