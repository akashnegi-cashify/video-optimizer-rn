import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/discard_modal_widget.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';

void main() {
  group('DiscardModalWidget', () {
    late bool onRejectCallbackCalled;
    late bool onRetestCallbackCalled;

    setUp(() {
      onRejectCallbackCalled = false;
      onRetestCallbackCalled = false;
    });

    Widget buildTestWidget({
      Function()? onRejectCallback,
      Function()? onRetestCallback,
    }) {
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
            child: DiscardModalWidget(
              onRejectCallback: onRejectCallback,
              onRetestCallback: onRetestCallback,
            ),
          ),
        ),
      );
    }

    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(DiscardModalWidget), findsOneWidget);
    });

    testWidgets('displays Discard Parts title', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Discard Parts'), findsOneWidget);
    });

    testWidgets('displays confirmation message', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(
        find.text('Are you sure you want to remove these selected parts?'),
        findsOneWidget,
      );
    });

    testWidgets('contains close icon', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(CshIcon), findsOneWidget);
    });

    testWidgets('contains ComboButton', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(ComboButton), findsOneWidget);
    });

    testWidgets('displays Reject button', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Reject'), findsOneWidget);
    });

    testWidgets('displays Retest button', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Retest'), findsOneWidget);
    });

    testWidgets('contains GestureDetector for close', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(GestureDetector), findsWidgets);
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

    testWidgets('contains Row widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Row), findsWidgets);
    });

    testWidgets('contains SizedBox for spacing', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('contains Expanded widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Expanded), findsWidgets);
    });
  });
}
