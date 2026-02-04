import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:mocktail/mocktail.dart';

/// Wraps a widget with MaterialApp and optional providers for testing.
///
/// Example usage:
/// ```dart
/// await tester.pumpWidget(buildTestableWidget(
///   const MyWidget(),
///   providers: [
///     ChangeNotifierProvider<MyProvider>.value(value: mockProvider),
///   ],
/// ));
/// ```
Widget buildTestableWidget(
  Widget child, {
  List<SingleChildWidget>? providers,
  NavigatorObserver? navigatorObserver,
  ThemeData? theme,
  GlobalKey<NavigatorState>? navigatorKey,
}) {
  Widget result = child;

  if (providers != null && providers.isNotEmpty) {
    result = MultiProvider(providers: providers, child: result);
  }

  return MaterialApp(
    theme: theme,
    navigatorKey: navigatorKey,
    home: Scaffold(body: result),
    navigatorObservers: navigatorObserver != null ? [navigatorObserver] : [],
  );
}

/// Wraps a widget with a single ChangeNotifierProvider for simpler test cases.
///
/// Example usage:
/// ```dart
/// await tester.pumpWidget(buildTestableWidgetWithProvider<MyProvider>(
///   const MyWidget(),
///   mockProvider,
/// ));
/// ```
Widget buildTestableWidgetWithProvider<T extends ChangeNotifier>(
  Widget child,
  T provider,
) {
  return MaterialApp(
    home: ChangeNotifierProvider<T>.value(
      value: provider,
      child: Scaffold(body: child),
    ),
  );
}

/// Wraps a widget with multiple providers for complex test cases.
///
/// Example usage:
/// ```dart
/// await tester.pumpWidget(buildTestableWidgetWithProviders(
///   const MyWidget(),
///   [
///     ChangeNotifierProvider<Provider1>.value(value: mock1),
///     ChangeNotifierProvider<Provider2>.value(value: mock2),
///   ],
/// ));
/// ```
Widget buildTestableWidgetWithProviders(
  Widget child,
  List<SingleChildWidget> providers,
) {
  return MaterialApp(
    home: MultiProvider(
      providers: providers,
      child: Scaffold(body: child),
    ),
  );
}

/// Helper to test screen route and pageKey constants.
///
/// Example usage:
/// ```dart
/// group('MyScreen', () {
///   testScreenConstants(
///     expectedRoute: 'my/route/path',
///     expectedPageKey: 'MY_PAGE_KEY',
///     actualRoute: MyScreen.route,
///     actualPageKey: MyScreen.pageKey,
///   );
/// });
/// ```
void testScreenConstants({
  required String expectedRoute,
  required String expectedPageKey,
  required String actualRoute,
  required String actualPageKey,
}) {
  test('has correct route constant', () {
    expect(actualRoute, expectedRoute);
  });

  test('has correct pageKey', () {
    expect(actualPageKey, expectedPageKey);
  });
}

/// Helper to test component constants.
///
/// Example usage:
/// ```dart
/// testComponentConstants(
///   expectedCompKey: 'MY_COMP_KEY',
///   actualCompKey: MyComponent.COMP_KEY,
/// );
/// ```
void testComponentConstants({
  required String expectedCompKey,
  required String actualCompKey,
}) {
  test('has correct component key', () {
    expect(actualCompKey, expectedCompKey);
  });
}

/// Mock NavigatorObserver for testing navigation.
///
/// Example usage:
/// ```dart
/// final mockObserver = MockNavigatorObserver();
/// await tester.pumpWidget(buildTestableWidget(
///   const MyWidget(),
///   navigatorObserver: mockObserver,
/// ));
/// ```
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

/// Extension for common widget test operations.
///
/// Provides convenience methods for common testing patterns.
extension WidgetTesterExtensions on WidgetTester {
  /// Tap and pump in one call.
  ///
  /// Example:
  /// ```dart
  /// await tester.pumpAndTap(find.byType(ElevatedButton));
  /// ```
  Future<void> pumpAndTap(Finder finder) async {
    await tap(finder);
    await pump();
  }

  /// Tap, pump, and settle in one call.
  ///
  /// Example:
  /// ```dart
  /// await tester.tapAndSettle(find.byType(ElevatedButton));
  /// ```
  Future<void> tapAndSettle(Finder finder) async {
    await tap(finder);
    await pumpAndSettle();
  }

  /// Enter text and submit.
  ///
  /// Example:
  /// ```dart
  /// await tester.enterTextAndSubmit(find.byType(TextField), 'test input');
  /// ```
  Future<void> enterTextAndSubmit(Finder finder, String text) async {
    await enterText(finder, text);
    await testTextInput.receiveAction(TextInputAction.done);
    await pump();
  }

  /// Find widget by key string.
  ///
  /// Example:
  /// ```dart
  /// final finder = tester.findByKeyString('my_widget_key');
  /// ```
  Finder findByKeyString(String key) => find.byKey(Key(key));

  /// Scroll until a widget is visible.
  ///
  /// Example:
  /// ```dart
  /// await tester.scrollUntilVisible(
  ///   find.text('Hidden Item'),
  ///   scrollable: find.byType(ListView),
  /// );
  /// ```
  Future<void> scrollUntilVisible(
    Finder finder, {
    Finder? scrollable,
    double delta = 100.0,
    int maxScrolls = 50,
  }) async {
    final scrollableFinder = scrollable ?? find.byType(Scrollable).first;
    int scrollCount = 0;

    while (finder.evaluate().isEmpty && scrollCount < maxScrolls) {
      await drag(scrollableFinder, Offset(0, -delta));
      await pump();
      scrollCount++;
    }
  }
}

/// Extension for common Finder operations.
extension FinderExtensions on CommonFinders {
  /// Find by semantic label.
  Finder bySemanticsLabel(String label) => find.bySemanticsLabel(label);

  /// Find descendant widget.
  Finder descendantOf(Finder of, Finder matching) =>
      find.descendant(of: of, matching: matching);

  /// Find ancestor widget.
  Finder ancestorOf(Finder of, Finder matching) =>
      find.ancestor(of: of, matching: matching);
}

/// Helper class for testing dialogs.
class DialogTestHelper {
  /// Shows a dialog and returns the dialog widget finder.
  ///
  /// Example:
  /// ```dart
  /// final dialogFinder = await DialogTestHelper.showDialog(
  ///   tester,
  ///   () => showMyDialog(context),
  /// );
  /// expect(dialogFinder, findsOneWidget);
  /// ```
  static Future<Finder> showDialogAndVerify(
    WidgetTester tester,
    Finder triggerFinder,
  ) async {
    await tester.tap(triggerFinder);
    await tester.pumpAndSettle();
    return find.byType(AlertDialog);
  }

  /// Dismisses a dialog by tapping a button.
  static Future<void> dismissDialog(
    WidgetTester tester,
    Finder buttonFinder,
  ) async {
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();
  }
}

/// Helper class for testing forms.
class FormTestHelper {
  /// Fills a form field and validates.
  static Future<void> fillFormField(
    WidgetTester tester, {
    required Finder fieldFinder,
    required String value,
  }) async {
    await tester.enterText(fieldFinder, value);
    await tester.pump();
  }

  /// Submits a form.
  static Future<void> submitForm(
    WidgetTester tester,
    Finder submitButtonFinder,
  ) async {
    await tester.tap(submitButtonFinder);
    await tester.pumpAndSettle();
  }
}

/// Helper for testing loading states.
class LoadingStateHelper {
  /// Verifies loading indicator is shown.
  static void expectLoading(WidgetTester tester) {
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  }

  /// Verifies loading indicator is not shown.
  static void expectNotLoading(WidgetTester tester) {
    expect(find.byType(CircularProgressIndicator), findsNothing);
  }
}

/// Helper for testing error states.
class ErrorStateHelper {
  /// Verifies error message is shown.
  static void expectError(WidgetTester tester, String errorMessage) {
    expect(find.text(errorMessage), findsOneWidget);
  }

  /// Verifies no error is shown.
  static void expectNoError(WidgetTester tester, String errorMessage) {
    expect(find.text(errorMessage), findsNothing);
  }
}

/// Helper for testing snackbars.
class SnackBarTestHelper {
  /// Verifies snackbar is shown with message.
  static void expectSnackBar(WidgetTester tester, String message) {
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(message), findsOneWidget);
  }

  /// Dismisses snackbar.
  static Future<void> dismissSnackBar(WidgetTester tester) async {
    await tester.pumpAndSettle(const Duration(seconds: 4));
  }
}
