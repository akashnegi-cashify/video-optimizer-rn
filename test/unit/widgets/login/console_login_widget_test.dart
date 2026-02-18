import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/login/widgets/console_login_widget.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';

void main() {
  group('ConsoleLoginWidget', () {
    Widget buildTestWidget(LoginTypes loginType) {
      return MaterialApp(
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
          extensions: [CustomColors.light()],
        ),
        home: Scaffold(
          body: ChangeNotifierProvider(
            create: (_) => LocaleProvider(),
            child: ConsoleLoginWidget(loginType),
          ),
        ),
      );
    }

    testWidgets('renders without error for TRC login type', (tester) async {
      await tester.pumpWidget(buildTestWidget(LoginTypes.trcLogin));
      await tester.pump();

      expect(find.byType(ConsoleLoginWidget), findsOneWidget);
    });

    testWidgets('renders without error for QC login type', (tester) async {
      await tester.pumpWidget(buildTestWidget(LoginTypes.qcLogin));
      await tester.pump();

      expect(find.byType(ConsoleLoginWidget), findsOneWidget);
    });

    testWidgets('renders without error for Shipex login type', (tester) async {
      await tester.pumpWidget(buildTestWidget(LoginTypes.shipexLogin));
      await tester.pump();

      expect(find.byType(ConsoleLoginWidget), findsOneWidget);
    });

    testWidgets('renders without error for RMS login type', (tester) async {
      await tester.pumpWidget(buildTestWidget(LoginTypes.rmsLogin));
      await tester.pump();

      expect(find.byType(ConsoleLoginWidget), findsOneWidget);
    });

    testWidgets('contains Padding widget', (tester) async {
      await tester.pumpWidget(buildTestWidget(LoginTypes.trcLogin));
      await tester.pump();

      expect(find.byType(Padding), findsWidgets);
    });

    testWidgets('contains ChangeNotifierProvider', (tester) async {
      await tester.pumpWidget(buildTestWidget(LoginTypes.trcLogin));
      await tester.pump();

      expect(find.byType(ChangeNotifierProvider), findsWidgets);
    });
  });
}
