### Local Development Setup

### Prerequisite
1. PHP 7.4 (for CMS)
2. Node.js 14 (for CMS assets)
3. Redis
4. Copy environment file `.env.example` into a new file `.env`
5. Generate application key : `php artisan key:generate`

### Setting up MySQL database :
1. Add your database username and password in `.env`
      ```bash
      # Create database
      DB_USERNAME={your mysql username}
      DB_PASSWORD={your mysql password}
      ```

### Setting up Redis :
1. Connect redis : Add redis host url in `.env`
      ```bash
      REDIS_HOST=127.0.0.1
      REDIS_PASSWORD=null
      REDIS_PORT=6379
      ```

### Build & Run

### CMS Setup (`citadelcms/`)

#### 1. Dependencies Installation
```bash
# Install PHP dependencies
composer install

# Install Node.js dependencies
npm install
```

#### 2. Run Application
```bash
# Start Laravel development server
php artisan serve

# Admin Panel: http://localhost:8000/admin
# Admin email: admin@admin.com
# Admin password: password
```

### CMS Issues

**Issue**: BREAD changes not visible
```bash
Solution:
1. Export BREAD: php artisan export:bread {slug}
2. Export Voyager: php artisan export:voyager
3. Run seeders: php artisan db:seed
4. Clear caches: php artisan cache:clear
```

**Issue**: File uploads failing
```bash
Solution:
1. Check file permissions: chmod -R 775 storage/
2. Verify S3 credentials in .env file
3. Check PHP upload limits in php.ini
4. Test S3 connectivity
```

**Issue**: Voyager admin panel not accessible
```bash
Solution:
1. Run: php artisan voyager:install
2. Create admin user: php artisan voyager:admin your@email.com
3. Import Voyager settings: mysql -uroot -proot citadel < sql/voyager_settings.sql
```
