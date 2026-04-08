### Local Development Setup

### Prerequisite
1. JAVA version 17.0 or more
2. MySQL 8.0
3. Redis

### Setting up MySQL database :
1. MySQL version 8.0
2. Create a schema `citadel`
3. Import the database_dump.sql into the schema
      ```bash
      # Create database
      mysql -uroot -proot -e "CREATE DATABASE citadel;"

      # Import schema
      mysql -uroot -proot citadel < {your database dump.sql file path}
      ```

4. Add your database username and password in `application.properties`
   ```bash
   spring.datasource.username={your mysql username}
   spring.datasource.password={your mysql password}
    ```

### Setting up Redis :
1. Connect redis : Add redis host url in `application.properties`
      ```bash
      redis.host=127.0.0.1
      ```

### Build & Run

##### Option A: Command Line
```bash
# Clean build
./mvnw clean compile

# Run with local profile
./mvnw spring-boot:run -Dspring-boot.run.profiles=local
```

##### Option B: IntelliJ IDEA Setup
```bash
# 1. Open IntelliJ IDEA and import project
File → Open → Select citadel_backend folder → Open as Maven project

# 2. Wait for Maven dependencies to download and index
# Check bottom-right corner for indexing progress

# 3. Configure JDK
File → Project Structure → Project Settings → Project
- Set Project SDK to Java 17
- Set Project language level to 17

# 4. Set up Run Configuration
Run → Edit Configurations → Add New → Spring Boot
- Name: Citadel Backend Local
- Main class: com.citadel.backend.CitadelBackendApplication
- Active profiles: local
- VM options (if needed): -Xmx2g -Dspring.profiles.active=local
- Working directory: $MODULE_WORKING_DIR$
- Environment variables: (set any required env vars)

# 5. Configure application-local.properties
# Copy application.properties to application-local.properties
# Update database, Redis, and other service connections

# 6. Run the application
Click the green play button or Run → Run 'Citadel Backend Local'
```

##### IntelliJ Configuration Tips
```bash
# Enable auto-import for Maven dependencies
File → Settings → Build → Build Tools → Maven → Importing
- Check "Import Maven projects automatically"

# Set up code style (optional)
File → Settings → Editor → Code Style → Java
- Import code style from project if available

# Enable annotation processing (for Lombok)
File → Settings → Build → Compiler → Annotation Processors
- Check "Enable annotation processing"

# Configure database connection in IntelliJ
View → Tool Windows → Database
- Add MySQL data source with citadel database
- Test connection with root/root credentials
```

#### 4. Verify Setup
- **API Base**: http://localhost:8080/citadelBackend
- **Swagger UI**: http://localhost:8080/citadelBackend/swagger-ui.html
- **Health Check**: http://localhost:8080/citadelBackend/actuator/health