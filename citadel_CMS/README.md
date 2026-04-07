## About CitadelCMS

CitadelCMS is built on the Laravel framework, which is a web application framework with expressive, elegant syntax. We believe development must be an enjoyable and creative experience to be truly fulfilling. Laravel takes the pain out of development by easing common tasks used in many web projects, such as:

- [Simple, fast routing engine](https://laravel.com/docs/routing).
- [Powerful dependency injection container](https://laravel.com/docs/container).
- Multiple back-ends for [session](https://laravel.com/docs/session) and [cache](https://laravel.com/docs/cache) storage.
- Expressive, intuitive [database ORM](https://laravel.com/docs/eloquent).
- Database agnostic [schema migrations](https://laravel.com/docs/migrations).
- [Robust background job processing](https://laravel.com/docs/queues).
- [Real-time event broadcasting](https://laravel.com/docs/broadcasting).

Laravel is accessible, powerful, and provides tools required for large, robust applications.

## PHP Version

This project requires PHP version **7.4** or higher.


## Installation

To install CitadelCMS, follow these steps:

1. **Clone the Project:**
   ```bash
   git clone https://gitlab.com/nexstream-backend/citadelcms.git
   cd citadelcms
   ```
2. **Install Dependencies:** Ensure you have Composer installed, then run:
   ```bash
    composer install
    ```
3. **Set Up Environment Configuration:** Copy the example environment file:
    ```bash
    cp .env.example .env
    ```
4. **Generate Application Key:** Run the following command to generate the application key:
    ```bash
    php artisan key:generate
    ```
5. **Import the Database (If Citadel DB Is Not Available):** Before running the application, import the database SQL file:
    ```bash
    mysql -uroot -proot citadel < {database dump.sql file path}
    ```
6. **Run the Application:** Start the development server with:
    ```bash
    php artisan serve
    ```
## First time setup
    mysqldump -uroot -proot citadel data_types data_rows menus menu_items permissions roles permission_role translations users user_roles password_resets settings > [PROJECT_ROOT]/sql/voyager/first_time_voyager_settings.sql

## Dump Local Voyager Settings (Run this command every time you make changes to Voyager BREAD settings to save the updated configuration)
    mysqldump -uroot -proot citadel data_types data_rows menus menu_items permissions roles permission_role translations > sql/voyager_settings.sql

## Import Voyager Settings (Run this command every time you start the CMS app to apply the latest Voyager changes)
    mysql -uroot -proot citadel < sql/voyager_settings.sql



# Bread and Voyager Seeder Management

## Guideline for Managing BREAD and Voyager Components

### Updating Existing BREAD

To update an existing BREAD:

```bash
php artisan export:bread agents
```

> *Example: Updating the BREAD configuration for agents*

### Creating a New BREAD

When creating a new BREAD:

```bash
php artisan export:bread agents
php artisan export:voyager
```

> *Example: Creating a new BREAD for agents and exporting Voyager configurations*

### Updating Menu, Roles, or Permissions

To update menus, roles, or permissions:

```bash
php artisan export:voyager
```

### Importing the Latest Changes

To apply the latest database changes:

```bash
php artisan db:seed
```

## Notes

- Always run the appropriate commands after any BREAD, menu, role, or permission update to ensure changes are properly exported.
- Use `db:seed` to import the latest configurations as needed.
- Exclude `settings` table from the `export:voyager` command to avoid overwriting the settings table in staging/production environment with your local settings value.

## Increase file upload limit

Use this command to find the location of php.ini file
```bash
php -i | grep "Loaded Configuration File"
```
Example : Loaded Configuration File => /etc/php/8.2/cli/php.ini

Open php.ini file
```bash
nano /etc/php/8.3/fpm/php.ini
```

You need to set the value of upload_max_filesize and post_max_size in your php.ini :

; Maximum allowed size for uploaded files.<br>
```
upload_max_filesize = 40M
```

; Must be greater than or equal to upload_max_filesize<br>
```
post_max_size = 40M
```

Restart the server


