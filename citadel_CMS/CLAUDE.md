# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

CitadelCMS is a Laravel 8-based content management system built on the TCG Voyager admin panel framework. It manages financial products, client relationships, and commission structures for investment management operations. The system handles product orders, agreements, payments, and regulatory compliance tracking.

## Key Technologies

- **Laravel 8.75+** - Primary PHP framework
- **TCG Voyager 1.7** - Admin panel and BREAD (Browse, Read, Edit, Add, Delete) interface
- **Laravel Mix** - Asset compilation with Webpack
- **S3/Digital Ocean Spaces** - File storage backend
- **MySQL** - Primary database
- **PHP 7.4+** - Minimum PHP requirement

## Development Commands

### Database & Voyager Management

```bash
# Import initial database (first time setup)
mysql -uroot -proot citadel < sql/first_time_citadel.sql

# Import Voyager settings (run when starting development)
mysql -uroot -proot citadel < sql/voyager_settings.sql

# Dump Voyager settings (run after making BREAD changes)
mysqldump -uroot -proot citadel data_types data_rows menus menu_items permissions roles permission_role translations > sql/voyager_settings.sql

# Run database seeders
php artisan db:seed

# Export specific BREAD configuration
php artisan export:bread {slug}

# Export all Voyager configurations (menus, permissions, roles)
php artisan export:voyager
```

### Laravel Development

```bash
# Start development server
php artisan serve

# Install PHP dependencies
composer install

# Generate application key
php artisan key:generate

# Run database migrations
php artisan migrate

# Clear application cache
php artisan cache:clear
php artisan config:clear
php artisan view:clear
```

### Frontend Assets

```bash
# Install Node.js dependencies
npm install

# Development build with file watching
npm run dev
npm run watch

# Production build
npm run prod
```

### Testing

```bash
# Run PHPUnit tests
./vendor/bin/phpunit

# Run specific test
./vendor/bin/phpunit tests/Feature/ExampleTest.php
```

## Architecture Overview

### Core Business Models

The system centers around financial product management:

- **Products** (`app/Models/Product.php`) - Investment products with commission structures
- **Clients** (`app/Models/Client.php`, `app/Models/CorporateClient.php`) - Individual and corporate investors
- **ProductOrder** (`app/Models/ProductOrder.php`) - Investment orders and transactions
- **Agencies/Agents** (`app/Models/Agency.php`, `app/Models/Agent.php`) - Sales organization hierarchy
- **ProductAgreement** (`app/Models/ProductAgreement.php`) - Legal agreements and documentation

### Controller Architecture

Controllers extend Voyager's base classes for admin functionality:

- **VoyagerBaseController** (`app/Http/Controllers/VoyagerBaseController.php`) - Custom base with CitadelCMS-specific logic
- **CustomVoyagerBaseController** (`app/Http/Controllers/Custom/CustomVoyagerBaseController.php`) - Extended functionality
- Most business controllers extend these bases for consistent admin behavior

### Database Management

The project uses a sophisticated seeder system for Voyager BREAD configurations:

- **BREAD Seeders** (`database/seeders/bread/`) - Auto-generated configuration exports
- **Custom Commands** - `export:bread` and `export:voyager` for configuration management
- Version control of admin panel configurations through SQL dumps

### File Storage

- **Storage Backend**: S3-compatible (Digital Ocean Spaces)
- **Media Management**: Through Voyager's media manager
- **Document Handling**: Product agreements, receipts, and client documents

### Key Business Workflows

1. **Client Onboarding** - KYC, documentation, bank details
2. **Product Management** - Investment products with commission structures  
3. **Order Processing** - Product orders, payments, and receipt management
4. **Agreement Management** - Digital and physical document handling
5. **Commission Tracking** - Agent and agency commission calculations

## Custom Functionality

### Custom Form Fields

- **MultipleFileHandler** (`app/FormFields/MultipleFileHandler.php`) - Enhanced file upload handling

### Custom Actions

- **CustomAction** and **CustomEditAction** (`app/Actions/`) - Extended Voyager action capabilities

### Helper Functions

- **Global Helpers** (`app/Helpers/helpers.php`) - Utility functions autoloaded via Composer

### Widgets

Dashboard widgets for business intelligence:
- **ClientsNationalityWidget** - Client demographic breakdown
- **NewClientsWidget** - Recent client registrations  
- **TrustFundBalanceWidget** - Fund balance reporting

## Development Workflow

1. **BREAD Changes**: After modifying any Voyager BREAD configuration, run `php artisan export:bread {slug}` and `php artisan export:voyager`
2. **Database Changes**: Import latest settings with Voyager seeder commands before development
3. **Asset Compilation**: Use `npm run watch` during development for automatic asset recompilation
4. **Testing**: Run PHPUnit tests before commits to ensure functionality

## Configuration Notes

- **Voyager Storage**: Configured to use S3 backend (`config/voyager.php:58`)
- **Models Namespace**: `App\Models\` for all Voyager BREAD models
- **Custom Assets**: Additional CSS/JS loaded via Voyager config (`css/custom.css`, `js/custom.js`)
- **Environment**: Requires `.env` configuration for database, S3, and other services