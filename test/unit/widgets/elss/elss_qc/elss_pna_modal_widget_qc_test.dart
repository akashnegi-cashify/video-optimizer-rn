import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/elss_pna_modal_widget_qc.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_part.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';

void main() {
  group('ElssPnaModalWidgetQC', () {
    late List<ElssPart> submittedParts;
    late bool onAddPartButtonClickedCalled;

    setUp(() {
      submittedParts = [];
      onAddPartButtonClickedCalled = false;
    });

    Widget buildTestWidget({
      required List<ElssPart> listOfSelectedParts,
      Function(int, bool)? onCardSelectedCallback,
      Function(List<ElssPart>)? onSubmitCallback,
      VoidCallback? onAddPartButtonClicked,
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
            child: ElssPnaModalWidgetQC(
              listOfSelectedParts: listOfSelectedParts,
              onCardSelectedCallback: onCardSelectedCallback,
              onSubmitCallback: onSubmitCallback,
              onAddPartButtonClicked: onAddPartButtonClicked,
            ),
          ),
        ),
      );
    }

    testWidgets('renders without error with empty list', (tester) async {
      await tester.pumpWidget(buildTestWidget(listOfSelectedParts: []));
      await tester.pump();

      expect(find.byType(ElssPnaModalWidgetQC), findsOneWidget);
    });

    testWidgets('displays "No Parts added for PNA" when list is empty',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(listOfSelectedParts: []));
      await tester.pump();

      expect(find.text('No Parts added for PNA'), findsOneWidget);
    });

    testWidgets('displays "Select Parts for PNA" when list is not empty',
        (tester) async {
      final parts = [
        ElssPart(sku: 'SKU-001', partName: 'Screen'),
      ];
      await tester.pumpWidget(buildTestWidget(listOfSelectedParts: parts));
      await tester.pump();

      expect(find.text('Select Parts for PNA'), findsOneWidget);
    });

    testWidgets('displays "Select Parts" button when list is empty',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(listOfSelectedParts: []));
      await tester.pump();

      expect(find.text('Select Parts'), findsOneWidget);
    });

    testWidgets('displays "Submit" button when list is not empty',
        (tester) async {
      final parts = [
        ElssPart(sku: 'SKU-001', partName: 'Screen'),
      ];
      await tester.pumpWidget(buildTestWidget(listOfSelectedParts: parts));
      await tester.pump();

      expect(find.text('Submit'), findsOneWidget);
    });

    testWidgets('contains ComboButton', (tester) async {
      await tester.pumpWidget(buildTestWidget(listOfSelectedParts: []));
      await tester.pump();

      expect(find.byType(ComboButton), findsOneWidget);
    });

    testWidgets('displays Cancel button', (tester) async {
      await tester.pumpWidget(buildTestWidget(listOfSelectedParts: []));
      await tester.pump();

      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('contains ListView when list is not empty', (tester) async {
      final parts = [
        ElssPart(sku: 'SKU-001', partName: 'Screen'),
        ElssPart(sku: 'SKU-002', partName: 'Battery'),
      ];
      await tester.pumpWidget(buildTestWidget(listOfSelectedParts: parts));
      await tester.pump();

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('contains Padding widget', (tester) async {
      await tester.pumpWidget(buildTestWidget(listOfSelectedParts: []));
      await tester.pump();

      expect(find.byType(Padding), findsWidgets);
    });

    testWidgets('contains Column widget', (tester) async {
      await tester.pumpWidget(buildTestWidget(listOfSelectedParts: []));
      await tester.pump();

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('contains SizedBox for layout', (tester) async {
      await tester.pumpWidget(buildTestWidget(listOfSelectedParts: []));
      await tester.pump();

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('onAddPartButtonClicked is called when list is empty',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(
        listOfSelectedParts: [],
        onAddPartButtonClicked: () {
          onAddPartButtonClickedCalled = true;
        },
      ));
      await tester.pump();

      // Find and tap the Select Parts button
      await tester.tap(find.text('Select Parts'));
      await tester.pump();

      expect(onAddPartButtonClickedCalled, true);
    });
  });
}
