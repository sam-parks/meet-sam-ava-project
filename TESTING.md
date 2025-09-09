# Testing Framework Documentation

This document outlines the comprehensive testing strategy implemented for the Meet Sam Ava Flutter application.

## Overview

The testing framework follows a multi-layered approach covering:

- **Unit Tests**: Individual component testing (view models, repositories, services)
- **Integration Tests**: Component interaction testing
- **UI Tests**: Widget and interface testing
- **Error State Testing**: Failure scenario validation

## Test Structure

```bash
test/
├── helpers/
│   └── test_helpers.dart          # Reusable test utilities
├── unit/
│   ├── features/
│   │   ├── home/
│   │   │   ├── vm/                # View model tests
│   │   │   └── repositories/      # Repository tests
│   │   └── employment_info/
│   │       └── vm/                # View model tests
│   └── core/                      # Core functionality tests (placeholder)
├── integration/                   # Integration tests (placeholder)
└── mocks/                         # Mock data and factories (placeholder)
```

## Dependencies

The following testing packages are included:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
  mockito: ^5.4.4
  mocktail: ^1.0.4
  fake_async: ^1.3.1
  patrol: ^3.12.0
```

## Test Categories

### 1. Unit Tests - View Models

**Location**: `test/unit/features/*/vm/`

**Coverage**:

- State initialization and management
- Input validation with Formz
- Business logic operations
- Error handling
- State transitions

**Example**:

```dart
test('should calculate utilization percentage correctly', () {
  final state = HomeState.initial().copyWith(
    accountDetails: right(AccountDetails(...)),
  );
  expect(state.utilizationPercentage, equals(20.0));
});
```

### 2. Unit Tests - Repositories

**Location**: `test/unit/features/*/repositories/`

**Coverage**:

- Data fetching operations
- Error scenarios
- Network delay simulation
- Data consistency
- Success/failure states

**Example**:

```dart
test('should return successful credit score data', () async {
  final result = await repository.getCreditScore();
  expect(result.isRight(), isTrue);
  result.fold(
    (_) => fail('Expected right side'),
    (creditScore) => expect(creditScore.score, equals(720)),
  );
});
```

### 3. Integration Tests

**Location**: `test/integration/`

**Coverage**:

- App initialization
- Provider state management
- Basic navigation flow
- Memory leak prevention
- Exception handling

**Example**:

```dart
testWidgets('should build app without critical errors', (tester) async {
  await tester.pumpWidget(const ProviderScope(child: MyApp()));
  expect(find.byType(MaterialApp), findsOneWidget);
  expect(tester.takeException(), isNull);
});
```

### 4. UI Tests

**Location**: `test/ui/`

**Coverage**:

- Widget rendering
- Theme application
- Error state handling
- Component interaction

## Test Utilities

### TestHelpers Class

**Location**: `test/helpers/test_helpers.dart`

Provides common utilities:

- `createTestableWidget()`: Wraps widgets with necessary providers
- `findTextAnywhere()`: Finds text in complex widget trees
- `pumpAndSettle()`: Handles async operations in tests

## Running Tests

### All Tests

```bash
flutter test
```

### Specific Categories

```bash
# Unit tests only
flutter test test/unit/

# Integration tests only  
flutter test test/integration/

# UI tests only
flutter test test/ui/

# Specific file
flutter test test/unit/features/home/vm/home_view_model_test.dart
```

### With Coverage

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## Test Results Summary

### ✅ Working Tests (23 tests passing)

**Unit Tests - View Models**:

- HomeViewModel state management ✅
- EmploymentInfoViewModel form validation ✅
- Input validation with Formz ✅
- State transitions ✅

**Unit Tests - Repositories**:

- MockCreditScoreRepository data fetching ✅
- Network delay simulation ✅
- Error handling ✅
- Data consistency ✅

### ⚠️ Known Issues

**Integration Tests**:

- Timer management with mock services causes test flakiness
- Complex UI animations interfere with test execution
- Requires refinement for production use

**UI Tests**:

- Layout overflow issues in animated components
- Theme-dependent sizing causes test failures
- Need component-specific test isolation

## Best Practices

### 1. Test Isolation

- Each test should be independent
- Use proper setup/teardown
- Clean provider state between tests

### 2. Mock Data

- Use realistic test data
- Simulate various scenarios (success, error, edge cases)
- Test both valid and invalid inputs

### 3. Async Testing

- Properly handle async operations
- Use `pumpAndSettle()` for complex animations
- Account for network delays in mock services

### 4. Error State Testing

```dart
test('should handle validation errors', () {
  const invalidInput = EmploymentTypeInput.dirty('');
  expect(invalidInput.isValid, isFalse);
  expect(invalidInput.error, equals(EmploymentTypeValidationError.empty));
});
```

### 5. State Testing

```dart
test('should transition states correctly', () {
  final initialState = HomeState.initial();
  final newState = initialState.copyWith(
    creditScore: right(testCreditScore),
  );
  expect(newState.creditScore.isRight(), isTrue);
});
```

## Architecture Testing Strategy

### MVVM Pattern Validation

- **Models**: Data integrity and validation
- **Views**: Widget rendering and user interaction  
- **ViewModels**: State management and business logic

### Riverpod Integration

- Provider state management
- Dependency injection
- State consistency across rebuilds

### Form Validation (Formz)

- Input validation rules
- Error message handling
- Form state management

## Continuous Integration

For CI/CD pipelines, run:

```bash
flutter test --reporter=json > test_results.json
```

## Contributing

When adding new features:

1. **Write tests first** (TDD approach)
2. **Test both happy and error paths**
3. **Include edge case scenarios**
4. **Follow existing naming conventions**
5. **Update this documentation**

## Test Coverage Goals

- **Unit Tests**: >90% coverage for business logic
- **Integration Tests**: Critical user flows
- **UI Tests**: Core widget functionality
- **Error States**: All failure scenarios

## Future Improvements

1. **Golden Tests** for UI regression testing
2. **Performance Tests** for memory and speed
3. **Accessibility Tests** for inclusive design
4. **API Integration Tests** with real endpoints
5. **E2E Tests** with full user scenarios

---

This testing framework provides a solid foundation for maintaining code quality and preventing regressions as the application evolves.
