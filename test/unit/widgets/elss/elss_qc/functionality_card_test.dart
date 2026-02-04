import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/functionality_card.dart';
import 'package:core_widgets/core_widgets.dart';

void main() {
  group('FunctionalityCard', () {
    late bool onTapCalled;

    setUp(() {
      onTapCalled = false;
    });

    Widget buildTestWidget({
      String cardLabel = 'Test Label',
      String cardIconPath = 'assets/images/ic_qc.png',
      Function()? onTap,
    }) {
      return MaterialApp(
        theme: ThemeData(
          extensions: [CustomColors.light()],
        ),
        home: Scaffold(
          body: FunctionalityCard(
            cardLabel: cardLabel,
            cardIconPath: cardIconPath,
            onTap: onTap,
          ),
        ),
      );
    }

    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(FunctionalityCard), findsOneWidget);
    });

    testWidgets('displays card label', (tester) async {
      await tester.pumpWidget(buildTestWidget(cardLabel: 'Quality Check'));
      await tester.pump();

      expect(find.text('Quality Check'), findsOneWidget);
    });

    testWidgets('contains CshCard', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(CshCard), findsOneWidget);
    });

    testWidgets('contains GestureDetector', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets('contains Image.asset', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('contains CshIcon for arrow', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(CshIcon), findsOneWidget);
    });

    testWidgets('contains Row widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Row), findsWidgets);
    });

    testWidgets('contains Expanded widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Expanded), findsWidgets);
    });

    testWidgets('contains SizedBox for spacing', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('onTap callback is triggered when tapped', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        onTap: () {
          onTapCalled = true;
        },
      ));
      await tester.pump();

      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      expect(onTapCalled, true);
    });

    testWidgets('onTap does not crash when null', (tester) async {
      await tester.pumpWidget(buildTestWidget(onTap: null));
      await tester.pump();

      // Should not throw an error
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      expect(find.byType(FunctionalityCard), findsOneWidget);
    });

    testWidgets('label text has ellipsis overflow', (tester) async {
      // Test with a very long label
      await tester.pumpWidget(buildTestWidget(
        cardLabel: 'This is a very long card label that should overflow',
      ));
      await tester.pump();

      final textWidget = tester.widget<Text>(find.byType(Text).first);
      expect(textWidget.overflow, TextOverflow.ellipsis);
      expect(textWidget.maxLines, 1);
    });
  });
}
