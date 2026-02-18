import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/elss_home_widget.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/functionality_card.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';

void main() {
  group('ElssHomeWidget', () {
    Widget buildTestWidget({bool isLoginFromQC = false}) {
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
            child: ElssHomeWidget(isLoginFromQC: isLoginFromQC),
          ),
        ),
      );
    }

    testWidgets('renders without error for QC login', (tester) async {
      await tester.pumpWidget(buildTestWidget(isLoginFromQC: true));
      await tester.pump();

      expect(find.byType(ElssHomeWidget), findsOneWidget);
    });

    testWidgets('renders without error for TRC login', (tester) async {
      await tester.pumpWidget(buildTestWidget(isLoginFromQC: false));
      await tester.pump();

      expect(find.byType(ElssHomeWidget), findsOneWidget);
    });

    testWidgets('contains Stack widget', (tester) async {
      await tester.pumpWidget(buildTestWidget(isLoginFromQC: true));
      await tester.pump();

      expect(find.byType(Stack), findsWidgets);
    });

    testWidgets('contains Padding widget', (tester) async {
      await tester.pumpWidget(buildTestWidget(isLoginFromQC: true));
      await tester.pump();

      expect(find.byType(Padding), findsWidgets);
    });

    testWidgets('contains Column widget', (tester) async {
      await tester.pumpWidget(buildTestWidget(isLoginFromQC: true));
      await tester.pump();

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('shows Quality Check card when QC login', (tester) async {
      await tester.pumpWidget(buildTestWidget(isLoginFromQC: true));
      await tester.pump();

      expect(find.text('Quality Check'), findsOneWidget);
    });

    testWidgets('shows Tech Refurbishment Center card when TRC login',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(isLoginFromQC: false));
      await tester.pump();

      expect(find.text('Tech Refurbishment Center'), findsOneWidget);
    });

    testWidgets('contains FunctionalityCard', (tester) async {
      await tester.pumpWidget(buildTestWidget(isLoginFromQC: true));
      await tester.pump();

      expect(find.byType(FunctionalityCard), findsOneWidget);
    });

    testWidgets('contains user details card', (tester) async {
      await tester.pumpWidget(buildTestWidget(isLoginFromQC: true));
      await tester.pump();

      // Check for Name and Employee Id labels
      expect(find.textContaining('Name:'), findsOneWidget);
      expect(find.textContaining('Employee Id:'), findsOneWidget);
    });

    testWidgets('has colored sheet decoration', (tester) async {
      await tester.pumpWidget(buildTestWidget(isLoginFromQC: true));
      await tester.pump();

      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('contains SizedBox for spacing', (tester) async {
      await tester.pumpWidget(buildTestWidget(isLoginFromQC: true));
      await tester.pump();

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('contains Row widget for user details layout', (tester) async {
      await tester.pumpWidget(buildTestWidget(isLoginFromQC: true));
      await tester.pump();

      expect(find.byType(Row), findsWidgets);
    });
  });
}
