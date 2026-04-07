# Citadel Super App — Project Overview

## The Three Projects

| Folder | Type | Purpose |
|--------|------|---------|
| `citadel_super_app` | Flutter Mobile App (iOS/Android) | Client-facing mobile app for investors to sign up, invest, manage portfolios, and track transactions |
| `citadel_backend` | Spring Boot 3.3.1 (Java 17) | Core REST API — handles authentication, client onboarding, product management, commission/dividend calculations, PDF agreement generation |
| `citadel_CMS` | Laravel 8 + Voyager | Admin portal — CMS staff manage clients, agents, products, orders, agreements, and view reports |

---

## System Architecture

```
[Flutter Mobile App] ──────► [Spring Boot Backend API] ──────► [MySQL Database]
        │                            │                              │
        │                            ├──► [Redis (caching)]         │
        │                            ├──► [AWS S3 / DigitalOcean Spaces (files)]
        │                            └───► [Laravel CMS Portal]
        │                                     │
        │                                     └───► [Same MySQL Database]
        ▼
[OneSignal (push notifications)]
[Microblink (ID scanning)]
[NexID (identity verification)]
```

**Financial flow:** Client signs up in mobile app → data stored via backend API into MySQL → CMS staff verify and approve → dividends/commissions calculated by backend CRON jobs → payouts processed via bank files.

---

## 1. Citadel Super App (Mobile App)

**Path:** `C:\Users\FooFangKhai\Downloads\Super APP Migration\citadel_super_app`

Flutter mobile application for iOS and Android. Also has limited web support.

### Login Credentials

| Environment | Email | Password | Notes |
|------------|-------|----------|-------|
| **Staging / UAT** | `ramona@appxtream.com` | `Password1234@` | Test account |

### App URLs

| Environment | API Base URL |
|------------|-------------|
| **Production** | `https://app.citadelgroup.com.my/citadelBackend` |
| **Staging / UAT** | `https://api.citadel.nexstream.com.my/citadelBackend` |
| **Dev** | `https://api.citadel.nexstream.com.my/citadelBackend` |

### Tech Stack
- Flutter 3.22.2 / Dart 3.4.3+
- State management: Riverpod + Hooks
- Repository pattern
- Firebase Crashlytics
- OneSignal (push notifications)
- Microblink (ID document scanning)
- NexID (identity verification)
- Version: `1.1.1+83`

### Key Features
- Client signup with KYC
- Investment product purchase/redemption/rollover
- Portfolio management
- Agent dashboard (for agent users)
- Corporate client support
- NIU (National Investment Unit) financing
- Inbox / notifications
- Profile management

---

## 2. Citadel Backend (API)

**Path:** `C:\Users\FooFangKhai\Downloads\Super APP Migration\citadel_backend`

Spring Boot REST API that powers both the mobile app and CMS portal.

### API Documentation (Swagger UI)

| Environment | URL | Username | Password |
|------------|-----|----------|----------|
| **Staging** | `https://api.citadel.nexstream.com.my/citadelBackend/swagger-ui.html` | `docuser` | `nexdoc` |
| **Production** | `https://app.citadelgroup.com.my/citadelBackend/swagger-ui.html` | `docuser` | `nexdoc` |

### API Base URL

| Environment | URL |
|------------|-----|
| **Staging** | `https://api.citadel.nexstream.com.my/citadelBackend` |
| **Production** | `https://app.citadelgroup.com.my/citadelBackend` |

### Tech Stack
- Spring Boot 3.3.1 / Java 17
- MySQL 8.0
- Redis (caching + rate limiting with Bucket4j)
- AWS S3 / DigitalOcean Spaces (file storage)
- FreeMarker + Thymeleaf (PDF agreement generation)
- OpenAPI 3 / Swagger documentation
- BCrypt password hashing
- JWT authentication (JJWT library)
- Apache Tomcat (WAR deployment)

### Key Business Logic
- **3 PM cutoff**: Submissions before 3 PM processed same day
- **6 PM approval cutoff**: Approvals after 6 PM move to next business day
- **Fixed products**: Maturity on 1st of next month
- **Flexible products**: Maturity on 15th or month-end
- **All financial calculations**: MYR (Malaysian Ringgit)
- **Timezone**: GMT+8 (Asia/Kuala_Lumpur)
- **Corporate shareholdings**: Must total exactly 100%

### Database Credentials

| Environment | Host | Database | Username | Password |
|------------|------|---------|---------|---------|
| **Local** | `localhost:3306` | `citadel` | `root` | `root` |
| **Staging** | `localhost:3306` | `citadel` | `appxtream` | `password` |
| **Production** | `private-citadel-super-app-do-user-17612574-0.l.db.ondigitalocean.com:25060` | `citadel` | `citadel` | `AVNS_EEmIlG9fPfL-5mwndfL` |

### Redis Credentials

| Environment | Host | Password |
|------------|------|---------|
| **Local** | `127.0.0.1` | _(none)_ |
| **Production** | `10.104.0.5` | `Xu2XbX3GLjaBzi0CosL6` |

### S3 / DigitalOcean Spaces

| Environment | Bucket | Endpoint |
|------------|--------|---------|
| **Dev/Staging** | `nexstream-dev` | `https://sgp1.digitaloceanspaces.com` |
| **Production** | `citadel-super-app` | `https://sgp1.digitaloceanspaces.com` |

### Key API Modules

| Module | Path | Description |
|--------|------|-------------|
| Login | `/api/login` | Authentication, password reset, sessions |
| Sign Up | `/api/sign-up` | Client/agent registration, KYC, PEP screening, document upload |
| Agent | `/api/agent` | Agent profiles, downline management, commission reports |
| Client | `/api/client` | Client operations, beneficiary management |
| Product | `/api/product` | Product listing, purchase, validation, orders |
| Agreement | `/api/agreement` | Onboarding agreements, trust fund agreements, early redemption |
| Backend | `/api/backend` | CRON jobs, CMS approvals, PDF template management |

---

## 3. Citadel CMS (Admin Portal)

**Path:** `C:\Users\FooFangKhai\Downloads\Super APP Migration\citadel_CMS`

Laravel 8 admin panel using TCG Voyager. Used by internal staff to manage clients, agents, products, and view reports.

### Login Credentials

| Environment | URL | Username | Password |
|------------|-----|---------|---------|
| **Staging** | `https://admin.citadel.nexstream.com.my/admin/login` | `admin@admin.com` | `password` |
| **Production** | `https://cims.citadelgroup.com.my/admin/login` | `admin@admin.com` | `password` |

### Tech Stack
- Laravel 8.75+
- TCG Voyager 1.7 (admin panel)
- PHP 7.3+ / 7.4+
- MySQL
- Laravel Sanctum (API auth)
- Barryvdh/laravel-dompdf (PDF generation)
- Firebase/php-jwt
- Redis (cache/queue)
- AWS S3 / DigitalOcean Spaces

### What CMS Staff Can Do
- Browse, Read, Edit, Add, Delete(\_BREAD) operations on all entities
- Manage client accounts and KYC documents
- Manage agent hierarchy and commission structures
- Manage investment products and pricing
- View and process product orders
- Generate and manage agreements
- View dividend and commission reports
- Send push notifications

### CMS Access URL
- Staging Admin: `https://admin.citadel.nexstream.com.my/admin`
- Production Admin: `https://cims.citadelgroup.com.my/admin`

---

## 4. Metabase (BI Dashboard)

Business intelligence dashboard for reports and analytics.

| Environment | URL | Username | Password |
|------------|-----|---------|---------|
| **Staging** | `https://bi.citadel.nexstream.com.my` | `admin@appxtream.com` | `Nexstream@1234` |
| **Production** | `https://dashboard.citadelgroup.com.my` | `admin@appxtream.com` | `Nexstream@1234` |

---

## 5. SSH Access (Server Infrastructure)

### Staging
| Server | Command |
|--------|---------|
| Main Staging | `ssh root@188.166.179.190` |

### Production
| Server | Command |
|--------|---------|
| App Server | `ssh root@128.199.123.171` |
| CMS / Metabase Server | `ssh root@167.71.208.233` |
| Load Balancer | `ssh root@178.128.31.203` |

---

## 6. Database — Where Signup Data Lives

The Citadel backend stores signup and client data in the **`citadel`** MySQL database. Here are the key tables:

| Table | Purpose |
|-------|---------|
| `app_users` | Login accounts — `email_address`, `password`, `role` (client/agent/admin) |
| `client` | Individual client profile, linked to `app_users` via `app_user_id` |
| `corporate_client` | Corporate client profiles |
| `sign_up_history` | Staging table for signup form data |
| `individual_guardian` | Guardian info for individual clients |
| `individual_beneficiaries` | Beneficiary assignments |
| `employment_details` | Employment information |
| `individual_pep_info` | PEP (Politically Exposed Person) screening |
| `product_order` | Investment orders placed by clients |
| `product_agreement` | Trust fund agreements |
| `agent` | Agent profiles and hierarchy |
| `agency` | Agency/company profiles |
| `product` | Investment products |
| `payment_transaction` | Payment and transaction records |
| `agent_commission_history` | Agent commission payout records |
| `product_dividend_history` | Dividend/distribution records |

**To access the database locally:**

phpMyAdmin (if Apache is running):
```
http://localhost/phpmyadmin
```
> Note: If you get a "Forbidden" error, try opening in an **Incognito/Private window** or clearing browser cache.

MySQL CLI (via XAMPP PHP):
```bash
/c/xampp/php/php.exe -r "new mysqli('127.0.0.1:3306', 'root', '', 'citadel');"
```

---

## 7. Quick Reference — All Login Credentials

| System | Environment | URL | Username | Password |
|--------|------------|-----|---------|---------|
| **Mobile App** | Staging | _(Flutter app)_ | `ramona@appxtream.com` | `Password1234@` |
| **Backend API Docs** | Staging | `https://api.citadel.nexstream.com.my/citadelBackend/swagger-ui.html` | `docuser` | `nexdoc` |
| **Backend API Docs** | Production | `https://app.citadelgroup.com.my/citadelBackend/swagger-ui.html` | `docuser` | `nexdoc` |
| **CMS Portal** | Staging | `https://admin.citadel.nexstream.com.my/admin/login` | `admin@admin.com` | `password` |
| **CMS Portal** | Production | `https://cims.citadelgroup.com.my/admin/login` | `admin@admin.com` | `password` |
| **Metabase** | Staging | `https://bi.citadel.nexstream.com.my` | `admin@appxtream.com` | `Nexstream@1234` |
| **Metabase** | Production | `https://dashboard.citadelgroup.com.my` | `admin@appxtream.com` | `Nexstream@1234` |
| **MySQL (Local)** | — | `localhost:3306` | `root` | `root` |

---

## 8. Environment Summary

| Environment | Backend API | Mobile App | CMS Portal | Metabase |
|------------|-------------|-----------|-----------|---------|
| **Local Dev** | `http://localhost:8080/citadelBackend` | Use staging account | `http://localhost/citadel_CMS/public/admin` | — |
| **Staging** | `https://api.citadel.nexstream.com.my/citadelBackend` | `ramona@appxtream.com` | `https://admin.citadel.nexstream.com.my` | `https://bi.citadel.nexstream.com.my` |
| **Production** | `https://app.citadelgroup.com.my/citadelBackend` | _(App Store)_ | `https://cims.citadelgroup.com.my` | `https://dashboard.citadelgroup.com.my` |
