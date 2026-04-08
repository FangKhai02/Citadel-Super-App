# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter mobile application for Citadel Super App - a financial services platform for investment fund management, client onboarding, and agent operations. The app supports multiple user types (agents, clients, corporate clients) with comprehensive portfolio management features.

## Development Commands

### Building and Code Generation
```bash
# Generate assets and build runner files (required after model changes)
dart run build_runner build --delete-conflicting-outputs

# Generate assets only (using script)
./script/asset_gen.sh

# Mason code generation (for API/JSON models)
mason make swaggerAPI2dart
mason make json2dart
```

### Flutter Commands
```bash
# Clean and get dependencies
flutter clean && flutter pub get

# Run the app
flutter run

# Run with specific flavor/environment
flutter run --dart-define=ENVIRONMENT=dev
flutter run --dart-define=ENVIRONMENT=uat
flutter run --dart-define=ENVIRONMENT=prod

# Build for production
flutter build apk --release
flutter build ios --release

# Run tests
flutter test

# Run specific test file
flutter test test/path/to/test_file.dart

# Analyze code (lint)
flutter analyze
```

### Fastlane Deployment
```bash
# Deploy to beta (requires environment variables)
fastlane beta platform:android type:beta version:x.x.x prefix:"[Release]"
fastlane beta platform:ios type:beta version:x.x.x prefix:"[Release]"

# Or use the script for both platforms
./script/fastlane-deploy-both.sh
```

## Architecture & Key Technologies

### State Management
- **Riverpod** with Hooks for reactive state management
- State classes in `lib/data/state/` directory
- Repository pattern for data layer abstraction

### Data Layer Structure
- **Models**: `lib/data/model/` - Data entities with Freezed for immutability
- **Repositories**: `lib/data/repository/` - Data access layer
- **Requests/Responses**: `lib/data/request/` and `lib/data/response/` - API DTOs
- **Services**: `lib/service/` - Platform services and utilities

### Key Services
- **BaseWebService**: HTTP client wrapper using Dio
- **SessionService**: User authentication and session management
- **MicroblinkService**: ID document scanning integration
- **NexIDService**: Identity verification
- **OneSignalService**: Push notifications
- **SecureStorageService**: Encrypted local storage

### UI Architecture
- **Screen-based routing**: Custom router in `lib/custom_router.dart`
- **Component structure**: Reusable widgets in component subdirectories
- **Responsive design**: ScreenUtil for adaptive layouts
- **Multi-platform**: Separate iOS/Android native code integration

### Environment Configuration
- Multiple environment support (dev, UAT, production) through `app_constant.dart`
- Environment switching available in app settings during development
- Firebase integration for crashlytics and core services

## Key Directories

- `lib/screen/`: All UI screens organized by feature area
- `lib/data/`: Data models, repositories, and API communication
- `lib/service/`: Platform services and utilities
- `lib/app_folder/`: App-wide configuration (colors, themes, constants)
- `assets/`: Static resources (images, fonts, JSON data)
- `android/` & `ios/`: Platform-specific native code

## Code Generation Notes

- Models use **Freezed** for immutability and **JsonAnnotation** for serialization
- Asset generation via `flutter_gen` creates `lib/generated/assets.gen.dart`
- Mason templates handle API client generation from Swagger specs (from GitLab repo)
- Build runner handles all code generation: `dart run build_runner build --delete-conflicting-outputs`
- Always run build_runner after adding new models or changing existing ones

## Naming Conventions

- **Files**: snake_case (e.g., `agent_client_state.dart`)
- **Classes**: PascalCase (e.g., `AgentClientState`)
- **Variables/Functions**: camelCase (e.g., `agentClientList`)
- **Constants**: SCREAMING_SNAKE_CASE (e.g., `API_BASE_URL`)
- **Response/Request VOs**: End with `_vo.dart` (e.g., `login_response_vo.dart`)
- **Freezed models**: Include `.freezed.dart` and `.g.dart` generated files

## Key Architectural Patterns

### Error Handling
- Custom exceptions: `BaseException`, `ApiException`, `ServerError`
- Server maintenance detection via `ServerUnderMaintenance`
- Consistent error logging through `LogService`

### Navigation
- Custom router with named routes in `lib/custom_router.dart`
- Screen-based organization: each major feature has dedicated screen directory
- Deep linking support via `app_links` package

### Authentication & Security
- JWT-based authentication through `SessionService`
- Encrypted local storage via `SecureStorageService`
- PIN-based app security for sensitive operations
- Microblink integration for ID document verification

### Multi-Environment Support
- Environment switching in `AppConstant` (dev/uat/production)
- Different API endpoints and keys per environment
- Runtime environment selection available in debug builds

## Common Issues & Solutions

### Play Store Rejection - READ_MEDIA Permissions
**Problem**: APK contains unwanted `READ_MEDIA_IMAGES`, `READ_MEDIA_VIDEO`, `READ_MEDIA_AUDIO` permissions causing Play Store rejection.

**Root Cause**: The `open_filex` plugin (v4.7.0) automatically adds these permissions.

**Solution Applied**:
1. **AndroidManifest.xml**: Added comprehensive permission removal with `tools:node="remove"`
2. **Gradle Configuration**: Added packaging options for thorough cleanup
3. **Alternative Libraries**: Consider replacing `open_filex` if file opening isn't critical

**Verification**: 
```bash
# After building APK, check permissions with:
aapt dump permissions build/app/outputs/flutter-apk/app-release.apk
# OR analyze APK in Android Studio → Build → Analyze APK
```

**Affected Libraries Analysis**:
- ✅ `image_picker`: Clean (no READ_MEDIA permissions)
- ✅ `file_picker`: Clean (only READ_EXTERNAL_STORAGE with maxSdkVersion="32")  
- ✅ `image_cropper`: Clean (empty manifest)
- ❌ `open_filex`: Contains the problematic permissions

## Testing Account (Staging)
- Email: ramona@appxtream.com  
- Password: Password1234@