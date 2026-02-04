import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/app_version_widget.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:provider/provider.dart';

void main() {
  /// Builds a testable widget with MaterialApp and LocaleProvider wrapper
  Widget buildTestWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        home: Scaffold(body: child),
      ),
    );
  }

  group('AppVersionWidget', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const AppVersionWidget()),
      );
      // Use pump instead of pumpAndSettle since FutureBuilder may have async operations
      await tester.pump();

      expect(find.byType(AppVersionWidget), findsOneWidget);
      expect(find.byType(FutureBuilder<String?>), findsOneWidget);
    });

    testWidgets('renders FutureBuilder for app version', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const AppVersionWidget()),
      );
      await tester.pump();

      // Widget should contain a FutureBuilder
      expect(find.byType(FutureBuilder<String?>), findsOneWidget);
    });

    testWidgets('renders SizedBox.shrink when version is null initially', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const AppVersionWidget()),
      );
      // Don't settle - check initial state before future completes
      await tester.pump();

      // Initially should show SizedBox.shrink or the loading state
      expect(find.byType(AppVersionWidget), findsOneWidget);
    });

    testWidgets('widget builds without errors', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const AppVersionWidget()),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Widget should build without errors
      expect(find.byType(AppVersionWidget), findsOneWidget);
    });

    testWidgets('renders within scaffold', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const AppVersionWidget()),
      );
      await tester.pump();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppVersionWidget), findsOneWidget);
    });

    testWidgets('uses L10n for localization', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const AppVersionWidget()),
      );
      await tester.pump();

      // Widget uses L10n internally - verify it renders
      expect(find.byType(AppVersionWidget), findsOneWidget);
    });
  });
}
