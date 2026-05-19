import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:core_widgets/core_widgets.dart';

/// Initialize Flutter test binding for tests that use platform services.
/// Call this at the start of main() for tests that need GetStorage, SharedPreferences, etc.
void ensureTestBinding() {
  TestWidgetsFlutterBinding.ensureInitialized();
}

/// Simple listener tracker for testing ChangeNotifier implementations.
/// Usage:
/// ```dart
/// final tracker = ListenerTracker();
/// provider.addListener(tracker.listener);
/// provider.someMethod();
/// expect(tracker.callCount, 1);
/// ```
class ListenerTracker {
  int _callCount = 0;

  /// Number of times the listener was called
  int get callCount => _callCount;

  /// Reset the call count
  void reset() => _callCount = 0;

  /// Listener function to attach to providers
  void listener() => _callCount++;
}

/// Base class for testing providers that depend on services.
///
/// Provides a structured way to set up and tear down provider tests
/// with proper mocking of service dependencies.
///
/// Example usage:
/// ```dart
/// class ReQcListProviderTest extends ProviderTestHelper<ReQcListProvider> {
///   late MockReQcService mockService;
///
///   @override
///   void setupMocks() {
///     mockService = MockReQcService();
///   }
///
///   @override
///   ReQcListProvider createProvider() {
///     return ReQcListProvider();
///   }
/// }
/// ```
abstract class ProviderTestHelper<T extends ChangeNotifier> {
  late T provider;

  /// Set up mock dependencies before creating the provider
  void setupMocks();

  /// Create the actual provider instance
  T createProvider();

  /// Called before each test
  void setUp() {
    setupMocks();
    provider = createProvider();
  }

  /// Called after each test
  void tearDown() {
    provider.dispose();
  }
}

/// Helper class to test provider state changes.
///
/// Tracks notifyListeners calls and state transitions.
///
/// Usage:
/// ```dart
/// final tracker = ProviderStateTracker(provider);
/// provider.someMethod();
/// expect(tracker.notifyCount, 1);
/// ```
class ProviderStateTracker<T extends ChangeNotifier> {
  final T provider;
  int _notifyCount = 0;
  final List<DateTime> _notifyTimestamps = [];

  ProviderStateTracker(this.provider) {
    provider.addListener(_onNotify);
  }

  void _onNotify() {
    _notifyCount++;
    _notifyTimestamps.add(DateTime.now());
  }

  /// Number of times notifyListeners was called
  int get notifyCount => _notifyCount;

  /// Timestamps of all notifyListeners calls
  List<DateTime> get notifyTimestamps => List.unmodifiable(_notifyTimestamps);

  /// Reset tracking state
  void reset() {
    _notifyCount = 0;
    _notifyTimestamps.clear();
  }

  /// Dispose the tracker
  void dispose() {
    provider.removeListener(_onNotify);
  }
}

/// Extension for testing providers with async operations.
extension ProviderAsyncTestExtension<T extends ChangeNotifier> on T {
  /// Waits for a notifyListeners call with timeout.
  Future<void> waitForNotify({
    Duration timeout = const Duration(seconds: 5),
  }) async {
    final completer = Completer<void>();
    void listener() {
      if (!completer.isCompleted) {
        completer.complete();
      }
    }

    addListener(listener);
    try {
      await completer.future.timeout(timeout);
    } finally {
      removeListener(listener);
    }
  }

  /// Waits for multiple notifyListeners calls.
  Future<void> waitForNotifications(
    int count, {
    Duration timeout = const Duration(seconds: 5),
  }) async {
    int received = 0;
    final completer = Completer<void>();

    void listener() {
      received++;
      if (received >= count && !completer.isCompleted) {
        completer.complete();
      }
    }

    addListener(listener);
    try {
      await completer.future.timeout(timeout);
    } finally {
      removeListener(listener);
    }
  }
}

/// Mock for CshChangeNotifier base class.
class MockCshChangeNotifier extends Mock implements CshChangeNotifier {}

/// Helper to create a provider context for testing.
///
/// Usage:
/// ```dart
/// final context = createTestProviderContext(
///   providers: [
///     ChangeNotifierProvider<MyProvider>.value(value: mockProvider),
///   ],
/// );
/// ```
Widget createTestProviderContext({
  required List<SingleChildWidget> providers,
  Widget? child,
}) {
  return MaterialApp(
    home: MultiProvider(
      providers: providers,
      child: child ?? const Scaffold(body: SizedBox()),
    ),
  );
}

/// Helper to test providers that call services and return Futures.
///
/// Usage:
/// ```dart
/// await testProviderServiceCall<MyProvider, String>(
///   provider: myProvider,
///   setupMock: () => when(() => mockService.getData()).thenAnswer(
///     (_) => Stream.value(MockResponse()),
///   ),
///   action: (p) => p.getData(),
///   expectedResult: 'expected result',
/// );
/// ```
Future<void> testProviderServiceCall<P extends ChangeNotifier, R>({
  required P provider,
  required void Function() setupMock,
  required Future<R> Function(P) action,
  R? expectedResult,
  bool expectError = false,
  String? expectedErrorMessage,
}) async {
  setupMock();

  if (expectError) {
    expect(
      () => action(provider),
      throwsA(expectedErrorMessage != null
          ? predicate<dynamic>((e) => e.toString().contains(expectedErrorMessage))
          : anything),
    );
  } else {
    final result = await action(provider);
    if (expectedResult != null) {
      expect(result, expectedResult);
    }
  }
}

/// Helper to verify provider state after an action.
///
/// Usage:
/// ```dart
/// verifyProviderState(
///   provider: myProvider,
///   action: () => provider.setFilter([1, 2, 3]),
///   verifications: [
///     () => expect(provider.filters, [1, 2, 3]),
///     () => expect(provider.hasFilters, true),
///   ],
/// );
/// ```
void verifyProviderState<P extends ChangeNotifier>({
  required P provider,
  required void Function() action,
  required List<void Function()> verifications,
}) {
  action();
  for (final verification in verifications) {
    verification();
  }
}

/// Test helper for provider loading states.
///
/// Verifies that a provider correctly handles:
/// - Initial loading state
/// - Loading completion
/// - Error states
class LoadingStateTestHelper<T extends ChangeNotifier> {
  final T provider;
  final bool Function(T) isLoadingGetter;
  final Object? Function(T)? errorGetter;

  LoadingStateTestHelper({
    required this.provider,
    required this.isLoadingGetter,
    this.errorGetter,
  });

  /// Verifies the provider starts in a non-loading state
  void verifyInitialState() {
    expect(isLoadingGetter(provider), false);
    if (errorGetter != null) {
      expect(errorGetter!(provider), isNull);
    }
  }

  /// Verifies the provider is in loading state
  void verifyLoadingState() {
    expect(isLoadingGetter(provider), true);
  }

  /// Verifies the provider completed loading successfully
  void verifyCompletedState() {
    expect(isLoadingGetter(provider), false);
    if (errorGetter != null) {
      expect(errorGetter!(provider), isNull);
    }
  }

  /// Verifies the provider is in error state
  void verifyErrorState([dynamic expectedError]) {
    expect(isLoadingGetter(provider), false);
    if (errorGetter != null) {
      expect(errorGetter!(provider), isNotNull);
      if (expectedError != null) {
        expect(errorGetter!(provider), expectedError);
      }
    }
  }
}

/// Helper to create mock stream responses for service methods.
///
/// Usage:
/// ```dart
/// when(() => mockService.getData()).thenAnswer(
///   (_) => createMockServiceStream(MockResponse()),
/// );
/// ```
Stream<T?> createMockServiceStream<T>(T value) => Stream.value(value);

/// Helper to create mock error streams for service methods.
Stream<T> createMockErrorStream<T>(Object error) => Stream.error(error);

/// Extension to easily stub stream-returning methods.
extension MockStreamStubbing on Mock {
  /// Stubs a method to return a successful stream
  void stubStreamSuccess<T>(Stream<T?> Function() method, T value) {
    when(method).thenAnswer((_) => Stream.value(value));
  }

  /// Stubs a method to return an error stream
  void stubStreamError<T>(Stream<T> Function() method, Object error) {
    when(method).thenAnswer((_) => Stream.error(error));
  }
}

/// Common matchers for provider testing.

/// Matcher for checking provider notification count.
class NotifiedAtLeast extends Matcher {
  final int expectedCount;

  NotifiedAtLeast(this.expectedCount);

  @override
  bool matches(dynamic item, Map matchState) {
    if (item is ProviderStateTracker) {
      return item.notifyCount >= expectedCount;
    }
    return false;
  }

  @override
  Description describe(Description description) {
    return description.add('notified at least $expectedCount times');
  }
}

Matcher notifiedAtLeast(int count) => NotifiedAtLeast(count);

/// Matcher for checking if a provider has specific state.
class HasState<T extends ChangeNotifier, S> extends Matcher {
  final S Function(T) stateGetter;
  final S expectedState;

  HasState(this.stateGetter, this.expectedState);

  @override
  bool matches(dynamic item, Map matchState) {
    if (item is T) {
      return stateGetter(item) == expectedState;
    }
    return false;
  }

  @override
  Description describe(Description description) {
    return description.add('has state $expectedState');
  }
}

/// Creates a matcher for provider state.
Matcher hasState<T extends ChangeNotifier, S>(S Function(T) getter, S expected) =>
    HasState<T, S>(getter, expected);

/// Helper class to run provider tests with automatic setup/teardown.
///
/// Usage:
/// ```dart
/// void main() {
///   final runner = ProviderTestRunner<MyProvider>(
///     createProvider: () => MyProvider(),
///     setupAll: () {
///       registerFallbackValue(FakeUri());
///     },
///   );
///
///   runner.runTests(() {
///     test('should do something', () {
///       // Test code
///     });
///   });
/// }
/// ```
class ProviderTestRunner<T extends ChangeNotifier> {
  final T Function() createProvider;
  final void Function()? setupAll;
  final void Function()? tearDownAll;
  final void Function(T provider)? onSetUp;
  final void Function(T provider)? onTearDown;

  late T provider;

  ProviderTestRunner({
    required this.createProvider,
    this.setupAll,
    this.tearDownAll,
    this.onSetUp,
    this.onTearDown,
  });

  void runTests(void Function() tests) {
    if (setupAll != null) {
      setUpAll(setupAll!);
    }

    setUp(() {
      provider = createProvider();
      onSetUp?.call(provider);
    });

    tearDown(() {
      onTearDown?.call(provider);
      provider.dispose();
    });

    if (tearDownAll != null) {
      tearDownAll!();
    }

    tests();
  }
}
