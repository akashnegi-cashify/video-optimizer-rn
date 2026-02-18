<!-- Document Information -->
<!-- Generated: 2026-02-18 -->
<!-- Version: 6.0.0+83 -->
<!-- Commit: 9ea0c658 -->

# Testing

## Table of Contents

- [Overview](#overview)
- [Test Framework](#test-framework)
- [Test Directory Structure](#test-directory-structure)
- [Current Test Coverage](#current-test-coverage)
- [Testing Patterns](#testing-patterns)
- [Recommended Testing Strategy](#recommended-testing-strategy)
- [Related Documents](#related-documents)

## Overview

Flutter TRC uses `flutter_test` as its testing framework. The current test suite is minimal with basic smoke tests and unit tests. The project has the foundation for testing but test coverage is limited.

## Test Framework

| Tool | Package | Purpose |
|------|---------|---------|
| flutter_test | Flutter SDK | Widget and unit testing |
| WidgetTester | flutter_test | Widget interaction testing |

## Test Directory Structure

```
test/
├── widget_test.dart           # Basic widget smoke test
├── unit_test.dart             # Unit tests
└── coverage_helper_test.dart  # Coverage helper
```

## Current Test Coverage

| Test File | Type | Description |
|-----------|------|-------------|
| `widget_test.dart` | Widget | Smoke test — pumps `CashifyApp` and runs basic assertion |
| `unit_test.dart` | Unit | Basic unit test skeleton |
| `coverage_helper_test.dart` | Helper | Coverage collection helper |

### Widget Test Example

```dart
testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  await tester.pumpWidget(const CashifyApp('Test Demo'));
  expect(1 + 1, 2);
});
```

## Testing Patterns

### Provider Testing Pattern

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyProvider', () {
    late MyProvider provider;

    setUp(() {
      provider = MyProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    test('initial state is correct', () {
      expect(provider.isLoading, false);
      expect(provider.data, isNull);
    });

    test('loadData updates state', () async {
      // Mock service calls and test state changes
    });
  });
}
```

### Widget Testing Pattern

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('MyWidget displays data', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => MyProvider(),
          child: MyWidget(),
        ),
      ),
    );

    expect(find.text('Expected Text'), findsOneWidget);
  });
}
```

### Service Testing Pattern

```dart
void main() {
  group('MyService', () {
    test('fetchData returns expected response', () async {
      // Mock HTTP client and verify service behavior
    });
  });
}
```

## Recommended Testing Strategy

### Test Priorities

| Priority | Area | Reason |
|----------|------|--------|
| High | Provider state management | Core business logic lives in providers |
| High | Service API calls | Critical for data integrity |
| Medium | Widget rendering | Ensures UI correctness |
| Medium | Interceptor behavior | Security-critical (session, auth) |
| Low | Model serialization | Generated code is generally reliable |

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html
```

## Related Documents

- [Local Setup](./Local%20Setup.md) — Setting up the test environment
- [State Management](./State%20Management.md) — Provider patterns to test
- [Api Services](./Api%20Services.md) — Service patterns to test
