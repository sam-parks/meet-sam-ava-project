# Meet Sam Ava - Flutter MVVM Architecture Guidelines

A comprehensive Flutter application implementing **MVVM** pattern with **Riverpod 3**, **AutoRoute**, **Formz**, and **design system tokens**.

## 🏗️ Architecture Overview

### MVVM + Clean Architecture Pattern

The project follows a **Model-View-ViewModel (MVVM)** architecture combined with **Clean Architecture** principles:

```bash
📦 lib/
├── 🎯 core/                    # Core utilities & infrastructure
├── 🔧 features/               # Feature modules (MVVM structure)
└── 🌍 shared/                 # Shared components & models
```

#### Core Layers

- **Model**: Data classes, input validation, business entities
- **View**: UI components, pages, widgets (StatelessWidget/StatefulWidget)
- **ViewModel**: Business logic, state management (Riverpod providers)
- **Repository**: Data access abstraction layer
- **Service**: Infrastructure services (cache, network, etc.)

## 📁 Project Structure

### Feature-Based Organization

Each feature follows a consistent structure:

```bash
features/
└── feature_name/
    ├── model/                 # Data models & form inputs
    │   ├── feature_data.dart  # Pure data models
    │   └── feature_inputs.dart # Formz validation inputs
    ├── view/                  # UI layer
    │   ├── feature_page.dart  # Main page (@RoutePage)
    │   └── widgets/           # Feature-specific widgets
    ├── vm/                    # ViewModels & state
    │   └── feature_view_model.dart # Riverpod providers
    ├── repositories/          # Data access layer
    │   ├── interfaces/        # Abstract contracts
    │   ├── implementations/   # Concrete implementations
    │   └── providers/         # Riverpod repository providers
    └── services/              # Infrastructure services
        ├── interfaces/        # Service contracts
        ├── implementations/   # Service implementations
        └── providers/         # Riverpod service providers
```

### Core Structure

```bash
core/
├── failures/                 # Error handling
├── theme/                    # Design system
│   ├── tokens/              # Design tokens (colors, typography, spacing)
│   ├── extensions/          # Theme extensions
│   └── providers/           # Theme providers
```

### Shared Structure

```bash
shared/
├── models/                  # Common data models
└── widgets/                 # Reusable UI components
```

## 🎨 Design System & Theming

### Design Tokens Architecture

The application implements a comprehensive **design token system**:

#### Color Tokens (`lib/core/theme/tokens/color_tokens.dart`)

```dart
class ColorTokens {
  static const Color primary = Color(0xFF1976D2);
  static const Color background = Color(0xFFFFFFFF);
  // ... comprehensive color palette
}
```

#### Typography Tokens (`lib/core/theme/tokens/typography_tokens.dart`)

- Consistent font families (At Hauss, At Slam Cnd)
- Standardized text styles for all UI elements
- Material 3 compliant typography scale

#### Spacing Tokens (`lib/core/theme/tokens/spacing_tokens.dart`)

- Standardized spacing values (`space1` through `space28`)
- Consistent layout spacing across the application

### Theme Implementation

```dart
@riverpod
ThemeData appTheme(Ref ref) {
  // Comprehensive theme configuration using design tokens
}
```

**Note**: The application uses **light mode only** for consistent branding.

## 🔄 State Management with Riverpod 3

### Provider Architecture

The application uses **Riverpod 3** with code generation for type-safe, performant state management.

#### ViewModel Pattern

```dart
@riverpod
class FeatureViewModel extends _$FeatureViewModel {
  @override
  FutureOr<FeatureState> build() async {
    // Initialize state
    return loadInitialData();
  }

  // State mutations
  void updateField(String value) {
    state.whenData((currentState) {
      state = AsyncData(currentState.copyWith(field: value));
    });
  }

  // Async operations
  Future<bool> submit() async {
    return await state.maybeWhen(
      data: (currentState) async {
        // Handle submission logic
      },
      orElse: () async => false,
    );
  }
}
```

#### State Management Best Practices

1. **Immutable State**: All state classes use `copyWith` methods
2. **AsyncValue Handling**: Proper loading, error, and success states
3. **Code Generation**: Automatic provider generation with `@riverpod`
4. **Keep Alive**: Strategic use of `keepAlive: true` for persistent data

## 📝 Form Handling with Formz

### Input Validation Classes

Each form field has a dedicated validation class:

```dart
enum EmployerValidationError { empty }

class EmployerInput extends FormzInput<String, EmployerValidationError> {
  const EmployerInput.pure() : super.pure('');
  const EmployerInput.dirty([super.value = '']) : super.dirty();

  @override
  EmployerValidationError? validator(String value) {
    return value.isEmpty ? EmployerValidationError.empty : null;
  }
}
```

### Form State Management

```dart
class EmploymentInfoState {
  final EmployerInput employer;
  final JobTitleInput jobTitle;
  final FormzSubmissionStatus status;

  bool get isValid => Formz.validate([employer, jobTitle, ...]);

  EmploymentInfoState copyWith({...}) => EmploymentInfoState(...);
}
```

## 🛣️ Navigation with AutoRoute

### Router Configuration

```dart
@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/', page: HomeRoute.page, initial: true),
    AutoRoute(path: '/employment-info', page: EmploymentInfoRoute.page),
    AutoRoute(path: '*', page: HomeRoute.page), // Wildcard for unknown paths
  ];
}
```

### Web-Friendly Navigation

**Path-based navigation** (recommended for web):

```dart
context.router.pushPath('/employment-info');
```

**Generated route navigation** (type-safe alternative):

```dart
context.router.push(const EmploymentInfoRoute());
```

### Page Annotation

```dart
@RoutePage()
class FeaturePage extends ConsumerWidget {
  const FeaturePage({super.key});
  // ...
}
```

## 🏛️ Repository & Service Patterns

### Repository Pattern

**Interface-based design** for testability and flexibility:

```dart
// Interface
abstract class IFeatureRepository {
  Future<Either<String, FeatureData>> getData();
  Future<Either<String, void>> saveData(FeatureData data);
}

// Implementation
class MockFeatureRepository implements IFeatureRepository {
  @override
  Future<Either<String, FeatureData>> getData() async {
    // Implementation logic
  }
}

// Provider
@Riverpod(keepAlive: true)
IFeatureRepository featureRepository(Ref ref) {
  return MockFeatureRepository();
}
```

### Service Layer

**Separation of concerns** between business logic and infrastructure:

#### Web-Compatible Storage Service

```dart
// SharedPreferences works on web (uses localStorage)
class FeatureCacheService implements IFeatureCacheService {
  static const String _storageKey = 'feature_data';

  @override
  Future<FeatureData?> get() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    return jsonString != null
        ? FeatureData.fromJson(jsonDecode(jsonString))
        : null;
  }
}

// Alternative: Direct web storage
class WebFeatureCacheService implements IFeatureCacheService {
  @override
  Future<FeatureData?> get() async {
    final jsonString = html.window.localStorage[_storageKey];
    return jsonString != null
        ? FeatureData.fromJson(jsonDecode(jsonString))
        : null;
  }
}
```

### Error Handling

**Comprehensive failure types** for robust error handling:

```dart
abstract class Failure {
  final String message;
  final String? code;
  final dynamic originalError;
}

class NetworkFailure extends Failure { /* ... */ }
class CacheFailure extends Failure { /* ... */ }
class ValidationFailure extends Failure { /* ... */ }
```

## 🎯 Widget Architecture

### Widget Creation Standards

**❌ NEVER create widgets using functions:**

```dart
// DON'T DO THIS
Widget _buildSection() {
  return Container(/* ... */);
}
```

**✅ ALWAYS create proper widget classes:**

```dart
// DO THIS
class CustomSection extends StatelessWidget {
  const CustomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(/* ... */);
  }
}
```

### Animated Widgets

**Custom animated widgets** for smooth transitions:

```dart
class AnimatedFieldWidget extends StatelessWidget {
  final String label;
  final String value;
  final bool isEditMode;
  final Widget editWidget;
  final Widget? displayWidget;

  const AnimatedFieldWidget({
    required this.label,
    required this.value,
    required this.isEditMode,
    required this.editWidget,
    this.displayWidget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      crossFadeState: isEditMode
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      firstChild: displayWidget ?? Text(value),
      secondChild: editWidget,
    );
  }
}
```

## 🔧 Development Workflow

### Code Generation

Always run code generation after creating/modifying providers:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Import Organization

**Consistent import patterns** for maintainability:

```dart
// Framework imports first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Third party packages
import 'package:auto_route/auto_route.dart';
import 'package:formz/formz.dart';

// Local imports using full package paths
import 'package:meet_sam_ava/features/feature_name/model/feature_model.dart';
import 'package:meet_sam_ava/features/feature_name/vm/feature_view_model.dart';
```

### File Naming Conventions

- **Files**: snake_case (e.g., `employment_info_page.dart`)
- **Classes**: PascalCase (e.g., `EmploymentInfoPage`)
- **Variables**: camelCase (e.g., `employmentType`)
- **Constants**: camelCase (e.g., `const maxRetries = 3`)

## 🚀 Key Dependencies

### Core Dependencies

```yaml
dependencies:
  flutter_riverpod: ^3.0.0-dev.17 # State management
  riverpod_annotation: ^3.0.0-dev.17 # Code generation
  auto_route: ^10.1.2 # Navigation
  formz: ^0.8.0 # Form validation
  dartz: ^0.10.1 # Functional programming
  shared_preferences: ^2.2.2 # Local storage (web compatible)

dev_dependencies:
  build_runner: ^2.4.11 # Code generation
  riverpod_generator: ^3.0.0-dev.17 # Provider generation
  auto_route_generator: ^10.2.4 # Route generation
  riverpod_lint: ^3.0.0-dev.17 # Linting rules
```

### Additional Features

- **Charts**: `fl_chart` for data visualization
- **Animations**: Custom animated widgets with `visibility_detector`
- **Internationalization**: `intl` for date/time formatting

## ✅ Best Practices Summary

### Architecture

- ✅ Follow MVVM pattern with clear separation of concerns
- ✅ Use interface-based repository pattern for testability
- ✅ Implement service layer for infrastructure concerns
- ✅ Apply Clean Architecture principles

### State Management

- ✅ Use Riverpod 3 with code generation
- ✅ Implement immutable state with `copyWith` methods
- ✅ Handle async states properly (loading, error, success)
- ✅ Use `keepAlive` strategically for persistent data

### UI/UX

- ✅ Create proper widget classes, not functions
- ✅ Use design tokens for consistent theming
- ✅ Implement smooth animations for state transitions
- ✅ Follow Material 3 design guidelines
- ✅ Light mode only for consistent branding

### Web Compatibility

- ✅ Use path-based navigation with AutoRoute
- ✅ Implement web-compatible storage solutions
- ✅ Ensure proper URL handling and deep linking
- ✅ Test on web platform regularly

### Form Handling

- ✅ Use Formz for comprehensive form validation
- ✅ Create dedicated input validation classes
- ✅ Implement proper form state management
- ✅ Handle submission states and error feedback

### Code Quality

- ✅ Follow consistent naming conventions
- ✅ Use proper import organization
- ✅ Implement comprehensive error handling
- ✅ Write type-safe, maintainable code

## 🎯 Development Guidelines

### Feature Development Checklist

When creating a new feature:

1. ✅ Create folder structure: `/model/`, `/view/`, `/vm/`, `/repositories/`, `/services/`
2. ✅ Define data models with proper constructors and JSON serialization
3. ✅ Create Formz input validation classes
4. ✅ Implement repository interfaces and mock implementations
5. ✅ Create service interfaces for infrastructure concerns
6. ✅ Implement view model with Riverpod providers
7. ✅ Create view pages with proper routing annotations
8. ✅ Update router configuration with web-friendly paths
9. ✅ Run code generation
10. ✅ Follow widget creation guidelines
11. ✅ Use consistent import patterns
12. ✅ Implement proper error handling and loading states
13. ✅ Apply design tokens for consistent theming
14. ✅ Add comprehensive form validation
15. ✅ Test with different screen sizes and orientations
16. ✅ Verify web functionality and URL routing

### Code Review Criteria

- **Architecture**: Proper MVVM implementation
- **State Management**: Correct Riverpod usage
- **UI/UX**: Consistent design system usage
- **Error Handling**: Comprehensive failure management
- **Performance**: Efficient state updates and widget rebuilds
- **Web Compatibility**: Proper routing and storage
- **Maintainability**: Clear code structure and documentation

This architecture ensures **scalability**, **maintainability**, **testability**, and **web compatibility** while providing a smooth development experience with modern Flutter best practices.
