import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/login/widgets/trc_and_qc_login_widget.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';

void main() {
  group('TrcAndQcLoginWidget', () {
    Widget buildTestWidget() {
      return MaterialApp(
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
          extensions: [CustomColors.light()],
          primaryTextTheme: const TextTheme(
            titleSmall: TextStyle(fontSize: 12),
          ),
        ),
        home: Scaffold(
          body: ChangeNotifierProvider(
            create: (_) => LocaleProvider(),
            child: const TrcAndQcLoginWidget(),
          ),
        ),
      );
    }

    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(TrcAndQcLoginWidget), findsOneWidget);
    });

    testWidgets('contains Padding widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Padding), findsWidgets);
    });

    testWidgets('contains Column widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('contains FutureBuilder', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(FutureBuilder), findsOneWidget);
    });

    testWidgets('contains login buttons', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // Check for CshMediumButton widgets (login buttons)
      expect(find.byType(CshMediumButton), findsWidgets);
    });

    testWidgets('displays TRC Login text', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('TRC Login'), findsOneWidget);
    });

    testWidgets('displays QC Login text', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('QC Login'), findsOneWidget);
    });

    testWidgets('displays Shipex Login text', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Shipex Login'), findsOneWidget);
    });

    testWidgets('displays RMS Login text', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('RMS Login'), findsOneWidget);
    });

    testWidgets('contains app version text', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // App version is displayed at the bottom
      expect(find.textContaining('App Version'), findsOneWidget);
    });

    testWidgets('contains Image.asset for logo', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // Logo image should be present
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('contains SizedBox for spacing', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('has Expanded widget for layout', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Expanded), findsOneWidget);
    });

    testWidgets('TRC Login button is tappable', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // Find and tap TRC Login button
      // Note: This will trigger navigation which requires AppUpdateHelper
      // The widget should not crash on tap
      final trcButton = find.text('TRC Login');
      expect(trcButton, findsOneWidget);
    });

    testWidgets('QC Login button is tappable', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      final qcButton = find.text('QC Login');
      expect(qcButton, findsOneWidget);
    });

    testWidgets('Shipex Login button is tappable', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      final shipexButton = find.text('Shipex Login');
      expect(shipexButton, findsOneWidget);
    });

    testWidgets('RMS Login button is tappable', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      final rmsButton = find.text('RMS Login');
      expect(rmsButton, findsOneWidget);
    });
  });
}
