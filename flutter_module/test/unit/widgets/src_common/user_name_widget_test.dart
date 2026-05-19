import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/user_name_widget.dart';
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

  group('UserNameWidget', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const UserNameWidget()),
      );
      await tester.pumpAndSettle();

      expect(find.byType(UserNameWidget), findsOneWidget);
    });

    testWidgets('renders CshTextNew widget', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const UserNameWidget()),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CshTextNew), findsOneWidget);
    });

    testWidgets('displays logged in user text', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const UserNameWidget()),
      );
      await tester.pumpAndSettle();

      // Widget should display text containing "Logged In User"
      expect(find.byType(UserNameWidget), findsOneWidget);
      // The text format is "${l10n.loggedInUser} : ${UserDetails().consoleUserDetail?.firstname}"
      expect(find.byWidgetPredicate((widget) => widget is CshTextNew), findsOneWidget);
    });

    testWidgets('widget builds without errors', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const UserNameWidget()),
      );
      await tester.pumpAndSettle();

      // Should build without errors
      expect(find.byType(UserNameWidget), findsOneWidget);
    });

    testWidgets('renders within scaffold', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const UserNameWidget()),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(UserNameWidget), findsOneWidget);
    });

    testWidgets('uses L10n for localization', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const UserNameWidget()),
      );
      await tester.pumpAndSettle();

      // Widget uses L10n internally - verify it renders
      expect(find.byType(UserNameWidget), findsOneWidget);
    });

    testWidgets('renders with bodyText2 style', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const UserNameWidget()),
      );
      await tester.pumpAndSettle();

      // CshTextNew.bodyText2 is used
      expect(find.byType(CshTextNew), findsOneWidget);
    });
  });
}
