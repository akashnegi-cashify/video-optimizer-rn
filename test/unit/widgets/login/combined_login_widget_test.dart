import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/login/widgets/combined_login_widget.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/modules/login/widgets/console_login_widget.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';

import '../../../helpers/widget_test_helpers.dart';

void main() {
  group('CombinedLoginWidget', () {
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
            child: CombinedLoginWidget(loginType: loginType),
          ),
        ),
      );
    }

    testWidgets('renders without error for TRC login type', (tester) async {
      await tester.pumpWidget(buildTestWidget(LoginTypes.trcLogin));
      await tester.pump();

      expect(find.byType(CombinedLoginWidget), findsOneWidget);
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('renders without error for QC login type', (tester) async {
      await tester.pumpWidget(buildTestWidget(LoginTypes.qcLogin));
      await tester.pump();

      expect(find.byType(CombinedLoginWidget), findsOneWidget);
    });

    testWidgets('renders without error for Shipex login type', (tester) async {
      await tester.pumpWidget(buildTestWidget(LoginTypes.shipexLogin));
      await tester.pump();

      expect(find.byType(CombinedLoginWidget), findsOneWidget);
    });

    testWidgets('renders without error for RMS login type', (tester) async {
      await tester.pumpWidget(buildTestWidget(LoginTypes.rmsLogin));
      await tester.pump();

      expect(find.byType(CombinedLoginWidget), findsOneWidget);
    });

    testWidgets('contains ConsoleLoginWidget', (tester) async {
      await tester.pumpWidget(buildTestWidget(LoginTypes.trcLogin));
      await tester.pump();

      // ConsoleLoginWidget should be present in the widget tree
      expect(find.byType(ConsoleLoginWidget), findsOneWidget);
    });

    testWidgets('contains Column with children', (tester) async {
      await tester.pumpWidget(buildTestWidget(LoginTypes.trcLogin));
      await tester.pump();

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('has SizedBox spacing', (tester) async {
      await tester.pumpWidget(buildTestWidget(LoginTypes.trcLogin));
      await tester.pump();

      expect(find.byType(SizedBox), findsWidgets);
    });
  });
}
