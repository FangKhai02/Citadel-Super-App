# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Citadel is a financial investment management platform built for Malaysian financial services. This Spring Boot backend manages investment products, client onboarding (individual & corporate), agent hierarchies, commission calculations, and regulatory compliance.

**Tech Stack**: Spring Boot 3.3.1, Java 17, MySQL 8.0, Redis, AWS S3 (DigitalOcean Spaces), Thymeleaf/FreeMarker for PDF generation

## Common Commands

### Build & Run

```bash
# Clean build
./mvnw clean compile

# Run with local profile
./mvnw spring-boot:run -Dspring-boot.run.profiles=local

# Run with specific profile (dev/prod)
./mvnw spring-boot:run -Dspring-boot.run.profiles=dev

# Package for deployment
./mvnw clean package -Dspring.profiles.active=prod
```

### Testing

```bash
# Run all tests
./mvnw test

# Run specific test class
./mvnw test -Dtest=JuiceWorksBackendApplicationTests

# Run with coverage
./mvnw test jacoco:report
```

### Maven Profiles

- **local** (default): Development with local database
- **dev**: Staging environment at api.citadel.nexstream.com.my
- **prod**: Production environment at app.citadelgroup.com.my

### IntelliJ IDEA Setup

1. **Run Configuration**:
   - Main class: `com.citadel.backend.CitadelBackendApplication`
   - Active profiles: `local`
   - VM options: `-Xmx2g -Dspring.profiles.active=local`
   - Working directory: `$MODULE_WORKING_DIR$`

2. **Enable Annotation Processing** (for Lombok):
   - File → Settings → Build → Compiler → Annotation Processors
   - Check "Enable annotation processing"

3. **Database Tool**:
   - Host: localhost, Port: 3307, Database: citadel
   - Default credentials: root/root (update per local setup)

### Local Development Prerequisites

- MySQL 8.0 running on port 3307
- Redis running on 127.0.0.1
- Database schema `citadel` created and migrated (sql/mysql/)
- Configure `application.properties` with local database credentials

## Architecture

### Layer Structure

```
controller/    → REST endpoints (OpenAPI/Swagger documented)
service/       → Business logic layer
dao/           → Data Access Objects (repositories)
entity/        → JPA entities (database models)
vo/            → Value Objects (DTOs for request/response)
utils/         → Utility classes (AWS, PDF, validation)
config/        → Spring configuration (Security, Redis, Swagger)
```

### Key Design Patterns

- **Service Layer Pattern**: Business logic isolated in service classes
- **DTO Pattern**: Request/Response handled via Value Objects (vo/)
- **Repository Pattern**: DAO classes extend JpaRepository
- **Template Pattern**: FreeMarker/Thymeleaf for PDF agreement generation

### Important Services

- **BackendService**: CRON jobs, CMS operations, dividend/commission calculations
- **ProductService**: Investment product management and order processing
- **ClientService**: Individual client onboarding and KYC
- **CorporateService**: Corporate client registration and compliance
- **CommissionService**: Agent commission calculations with hierarchy support
- **DividendService**: Dividend calculation and profit sharing schedules
- **PdfService**: Agreement and document generation from templates
- **EmailService**: Notification system for client communications

## Business Logic Flows

### Investment Process

1. Client browses products → Product selection
2. Investment amount input → Beneficiary assignment
3. Agreement generation (PdfService with templates/)
4. Payment upload → Order creation (ProductOrder entity)
5. Admin verification → Commission calculation
6. Investment confirmed → Receipt generation

### Commission Calculation

- Agent hierarchy lookup (Agent entity with parent relationships)
- Multi-level commission rates from configuration
- Commission records created in ProductCommissionHistory
- Supports both agent direct commission and agency override

### Agreement Date Logic (Critical)

- **3 PM cutoff**: Submissions before 3 PM for same-day processing
- **6 PM approval cutoff**: Approvals after 6 PM move to next business day
- **Schedule-based**: Uses ProductAgreementSchedule for precise dates
- **Fallback logic**: Fixed products → 1st of next month, Flexible → 15th or month-end
- **Tenure**: End date = Start date + investment months - 1 day

### Corporate Onboarding

- Company details + Directors/Shareholders information
- Corporate documents (SSM, MOA, etc.) uploaded to S3
- Compliance verification for PEP status
- Share holdings validation (must total 100%)
- Authorized person details for account operations

## Configuration & Properties

### Profile-Specific Properties

- `application.properties`: Default/local configuration
- `application-dev.properties`: Staging environment
- `application-prod.properties`: Production environment

### Key Configuration Areas

- **Database**: JPA/Hibernate with MySQL (port 3307 for local)
- **Redis**: Caching and rate limiting (Bucket4j)
- **S3**: DigitalOcean Spaces for file storage
- **Security**: Spring Security with JWT (JJWT library)
- **Swagger**: OpenAPI 3 documentation at `/swagger-ui.html`
- **Actuator**: Health checks at `/actuator/health`, Prometheus metrics enabled

### Context Path

All endpoints are prefixed with `/citadelBackend` (e.g., `http://localhost:8080/citadelBackend/api/...`)

## API Documentation

Swagger UI available at:
- Local: http://localhost:8080/citadelBackend/swagger-ui.html
- Staging: https://api.citadel.nexstream.com.my/citadelBackend/swagger-ui.html
- Production: https://app.citadelgroup.com.my/citadelBackend/swagger-ui.html

Credentials: `docuser` / `nexdoc`

Detailed API documentation in `documentation/api/`:
- AgentDocumentation.md
- AgreementDocumentation.md
- BackendDocumentation.md
- LoginDocumentation.md
- ProductDocumentation.md
- SignUpDocumentation.md

## Template System

Templates located in `src/main/resources/templates/`:
- Agreement templates: `{PRODUCT_CODE}-TD-DOT-LATEST-{CLIENT_TYPE}.html`
- Profit sharing schedules: `FIXED/FLEXIBLE-PROFIT-SHARING-SCHEDULE.html`
- Uses Thymeleaf syntax for variable interpolation
- PDF generation via OpenHTMLToPDF library

## Database Migrations

SQL scripts in `sql/mysql/`:
- Import database dump for local setup: `mysql -uroot -proot citadel < {dump_file}.sql`
- Schema name: `citadel`
- Naming strategy: Uses standard JPA (no snake_case conversion)

## Testing & Quality

- Test location: `src/test/java/com/citadel/backend/`
- JUnit 5 with Spring Boot Test
- Integration tests use `@SpringBootTest`
- Test database configuration in test profile

## Deployment

### Build Output

- WAR file: `target/citadelBackend.war`
- Deployed to Apache Tomcat 10
- Uses Tomcat Maven plugin for deployment

### Environment URLs

- **Staging API**: https://api.citadel.nexstream.com.my/citadelBackend
- **Production API**: https://app.citadelgroup.com.my/citadelBackend
- **CMS Portal**: Admin interface (Laravel) - see README.md

## Related Systems

This backend integrates with:
- **Mobile App**: Flutter application for client operations
- **CMS Portal**: Laravel admin panel at citadelcms/ (separate repository)
- **Metabase**: Business intelligence dashboard
- **Email Service**: Notification delivery system
- **Banking Systems**: File generation for bank transfers

## Development Workflow

1. Update `application.properties` with local database/Redis credentials
2. Import database schema from sql/mysql/
3. Enable Lombok annotation processing in IDE
4. Run with `local` profile for development
5. Access Swagger UI for API testing
6. Check actuator health endpoint for service status
7. Templates modified in resources/templates/ require app restart

## Important Notes

- All financial calculations are in MYR (Malaysian Ringgit)
- Timezone: GMT+8 (Asia/Kuala_Lumpur)
- BCrypt used for password hashing
- JWT tokens for authentication
- Redis required for caching and rate limiting
- Face ID validation for client verification
- OTP verification via SMS service
- PEP (Politically Exposed Person) compliance checks mandatory
- Corporate shareholdings must total exactly 100%