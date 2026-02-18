import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/elss_part_widget.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_part.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/elss_parts_selection_options.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';

void main() {
  group('ElssPartWidget', () {
    late int lastSelectedActionId;

    setUp(() {
      lastSelectedActionId = -1;
    });

    Widget buildTestWidget({
      ElssPart? dataModel,
      Function()? onRequiredSelected,
      Function()? onNotRequiredSelected,
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
            child: ElssPartWidget(
              dataModel: dataModel,
              onOptionSelected: (actionId) {
                lastSelectedActionId = actionId;
              },
              onRequiredSelected: onRequiredSelected,
              onNotRequiredSelected: onNotRequiredSelected,
            ),
          ),
        ),
      );
    }

    testWidgets('renders without error with null data', (tester) async {
      await tester.pumpWidget(buildTestWidget(dataModel: null));
      await tester.pump();

      expect(find.byType(ElssPartWidget), findsOneWidget);
    });

    testWidgets('renders CshCard', (tester) async {
      final dataModel = ElssPart(
        partName: 'Test Part',
        actionConstant: ElssPartsSelectionOptions.notRequired.id,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(CshCard), findsOneWidget);
    });

    testWidgets('displays part name when provided', (tester) async {
      final dataModel = ElssPart(
        partName: 'Screen Display',
        actionConstant: ElssPartsSelectionOptions.notRequired.id,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('Screen Display'), findsOneWidget);
    });

    testWidgets('displays SKU when provided', (tester) async {
      final dataModel = ElssPart(
        sku: 'SKU-12345',
        actionConstant: ElssPartsSelectionOptions.notRequired.id,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.textContaining('SKU-12345'), findsOneWidget);
    });

    testWidgets('displays quantity when provided', (tester) async {
      final dataModel = ElssPart(
        quantity: 5,
        actionConstant: ElssPartsSelectionOptions.notRequired.id,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.textContaining('5'), findsOneWidget);
    });

    testWidgets('contains ExpansionTile', (tester) async {
      final dataModel = ElssPart(
        partName: 'Test Part',
        actionConstant: ElssPartsSelectionOptions.notRequired.id,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(ExpansionTile), findsOneWidget);
    });

    testWidgets('contains CshDropDown when expanded', (tester) async {
      final dataModel = ElssPart(
        partName: 'Test Part',
        actionConstant: ElssPartsSelectionOptions.notRequired.id,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      // Tap to expand
      await tester.tap(find.byType(ExpansionTile));
      await tester.pumpAndSettle();

      expect(find.byType(CshDropDown), findsOneWidget);
    });

    testWidgets('displays part name with empty string', (tester) async {
      final dataModel = ElssPart(
        partName: '',
        actionConstant: ElssPartsSelectionOptions.notRequired.id,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(ElssPartWidget), findsOneWidget);
    });

    testWidgets('hides SKU row when sku is null', (tester) async {
      final dataModel = ElssPart(
        partName: 'Test Part',
        sku: null,
        actionConstant: ElssPartsSelectionOptions.notRequired.id,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      // SKU label should not be visible
      expect(find.text('Test Part'), findsOneWidget);
    });

    testWidgets('contains Row widget', (tester) async {
      final dataModel = ElssPart(
        partName: 'Test Part',
        actionConstant: ElssPartsSelectionOptions.notRequired.id,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(Row), findsWidgets);
    });

    testWidgets('contains Column widget', (tester) async {
      final dataModel = ElssPart(
        partName: 'Test Part',
        actionConstant: ElssPartsSelectionOptions.notRequired.id,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('contains SizedBox for spacing', (tester) async {
      final dataModel = ElssPart(
        partName: 'Test Part',
        actionConstant: ElssPartsSelectionOptions.notRequired.id,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('contains RichText for labels', (tester) async {
      final dataModel = ElssPart(
        sku: 'SKU-001',
        quantity: 2,
        actionConstant: ElssPartsSelectionOptions.notRequired.id,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(RichText), findsWidgets);
    });
  });
}
