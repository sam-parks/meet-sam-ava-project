# Ava meet Sam! 👋

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.24.0 or higher)
- Dart SDK (3.6.0 or higher)
- Xcode (for iOS development)
- Chrome (for web development)
- VS Code or Android Studio with Flutter plugins

### Installation

1. Clone the repository
2. Install dependencies
3. Generate code for Riverpod and AutoRoute:

```bash
git clone <repository-url>
cd meet-sam-ava-project
```

```bash
flutter pub get
```

```bash
dart run build_runner build --delete-conflicting-outputs
```

## 📱 Running on iOS

### Simulator

```bash
flutter run -d ios
```

### Physical Device

1. Connect your iOS device
2. Trust the computer on your device
3. Run:

```bash
flutter run -d <device-id>
```

### Building for Release

```bash
flutter build ios --release
```

The iOS app will be available at `build/ios/iphoneos/Runner.app`

### iOS-Specific Setup

- Minimum iOS version: 12.0
- Ensure you have valid provisioning profiles for physical device testing
- CocoaPods must be installed: `sudo gem install cocoapods`

## 🌐 Running on Web

### Development Server

```bash
flutter run -d chrome
```

### Building for Production

```bash
flutter build web --release
```

The web build will be available in `build/web/`

### Serving the Web Build

```bash
cd build/web
python3 -m http.server 8000
# Visit http://localhost:8000
```

## 📁 Project Structure

```bash
lib/
├── core/
│   ├── failures/          # Error handling and failure types
│   └── theme/
│       ├── tokens/        # Design tokens (colors, typography, spacing)
│       ├── providers/     # Theme providers with Riverpod
│       └── extensions/    # Theme extensions
│
├── features/
│   ├── home/
│   │   ├── model/        # Data models and domain entities
│   │   ├── view/         # UI pages and widgets
│   │   ├── vm/           # View models (Riverpod providers)
│   │   ├── repositories/ # Data layer interfaces and implementations
│   │   └── services/     # Business logic and external services
│   │
│   ├── employment_info/
│   │   ├── model/        # Employment data models and validation
│   │   ├── view/         # Employment form UI
│   │   ├── vm/           # Employment state management
│   │   └── repositories/ # Employment data persistence
│   │
│   └── feedback/
│       ├── model/        # Feedback data structures
│       ├── view/         # Feedback UI components
│       └── vm/           # Feedback state management
│
├── shared/
│   ├── models/           # Shared data models
│   └── widgets/          # Reusable UI components
│
├── app_router.dart       # AutoRoute navigation configuration
└── main.dart            # Application entry point
```

## 🏗️ Architecture

This project follows the **MVVM (Model-View-ViewModel)** pattern with clean architecture principles:

- **Model**: Data classes, domain entities, and business logic
- **View**: Flutter widgets and UI components
- **ViewModel**: State management with Riverpod, bridging the View and Model

### Key Technologies

- **State Management**: Riverpod 3 with code generation
- **Navigation**: AutoRoute for declarative, type-safe routing
- **Form Validation**: Formz for reusable input validation
- **Data Handling**: Dartz for functional programming patterns
- **Charts**: FL Chart for data visualization
- **Persistence**: SharedPreferences for local storage

## 🎨 Features

### Home Dashboard

- Credit score visualization with animated circular indicator
- Credit history chart with trend analysis
- Credit factors breakdown
- Account details and utilization metrics
- Credit card accounts overview

### Employment Information

- Comprehensive employment data form
- Input validation with real-time feedback
- Persistent storage of employment details
- Animated field transitions between view/edit modes
- Custom date and time pickers

### UI/UX Highlights

- Smooth animations and transitions
- Responsive layout for various screen sizes
- Material 3 design principles
- Light theme with custom color tokens
- Accessibility considerations

## 🧪 Testing

### Comprehensive Test Suite

The project includes a complete testing framework with 46+ tests covering all aspects of the application:

Run all tests:

```bash
flutter test
```

Run specific test categories:

```bash
# Unit tests (32 tests) - View models, repositories, business logic
flutter test test/unit/

# Integration tests (7 tests) - Full app functionality and provider state management  
flutter test test/integration/

# UI/Widget tests (8+ tests) - UI components, error states, user interactions
flutter test test/ui/
```

### Detailed Test Categories

```bash
# View model tests - State management and business logic
flutter test test/unit/features/*/vm/

# Repository tests - Data layer with network delays and error handling
flutter test test/unit/features/*/repositories/

# Widget tests - UI components with success/error states
flutter test test/ui/widgets/

# Error state tests - Comprehensive error handling scenarios
flutter test test/ui/features/*/
```

### Test Coverage

- **View Models**: HomeViewModel, EmploymentInfoViewModel with state management
- **Repositories**: MockCreditScoreRepository with network simulation and data consistency
- **UI Components**: AnimatedCircularIndicator with animations, layouts, and edge cases  
- **Error States**: HomePage with error/success scenarios and mixed states
- **Integration**: Full app lifecycle, provider management, and memory leak prevention

All tests pass reliably with proper async handling, timer management, and layout overflow prevention.

## 🛠️ Development

### Code Generation

After modifying Riverpod providers or AutoRoute pages:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Watch mode for automatic rebuilds:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

### Linting

Run the analyzer:

```bash
flutter analyze
```

Format code:

```bash
dart format lib/
```

### Project Guidelines

For detailed coding standards and best practices, see [CLAUDE.md](CLAUDE.md)

## 📝 General Notes

### Performance Considerations

- Lazy loading of heavy components
- Efficient state management with Riverpod
- Optimized animations with visibility detection
- Minimal rebuilds through proper widget composition

### Browser Compatibility (Web)

- Chrome (recommended)
- Safari
- Firefox
- Edge

### Known Limitations

- Web version uses SharedPreferences (limited to 5MB storage)
- Some animations may vary between platforms
- iOS requires Xcode for building and deployment

### Environment Setup

- Today's date is dynamically displayed in the app
- Mock data service provides realistic test scenarios
- All financial calculations use proper decimal precision

## 🤝 Contributing

1. Follow the MVVM architecture pattern
2. Use Riverpod for state management
3. Implement proper error handling
4. Write tests for new features
5. Follow the existing code style

## 📄 License

This project is proprietary and confidential.

---

Built with ❤️ using Flutter
