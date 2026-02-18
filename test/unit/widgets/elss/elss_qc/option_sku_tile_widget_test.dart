import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/option_sku_tile_widget.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_part.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';

void main() {
  group('OptionSkuTileWidget', () {
    Widget buildTestWidget({
      int indexing = 1,
      ElssPart? dataModel,
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
            child: OptionSkuTileWidget(
              indexing,
              dataModel: dataModel,
            ),
          ),
        ),
      );
    }

    testWidgets('renders without error with null data', (tester) async {
      await tester.pumpWidget(buildTestWidget(dataModel: null));
      await tester.pump();

      expect(find.byType(OptionSkuTileWidget), findsOneWidget);
    });

    testWidgets('displays index number', (tester) async {
      await tester.pumpWidget(buildTestWidget(indexing: 5));
      await tester.pump();

      expect(find.text('5. '), findsOneWidget);
    });

    testWidgets('displays part name when provided', (tester) async {
      final dataModel = ElssPart(
        partName: 'Screen Display',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('Screen Display'), findsOneWidget);
    });

    testWidgets('displays price when provided', (tester) async {
      final dataModel = ElssPart(
        price: 500.0,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.textContaining('Price'), findsOneWidget);
    });

    testWidgets('displays quantity when provided', (tester) async {
      final dataModel = ElssPart(
        quantity: 3,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.textContaining('Qty. 3'), findsOneWidget);
    });

    testWidgets('hides quantity when null', (tester) async {
      final dataModel = ElssPart(
        quantity: null,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.textContaining('Qty.'), findsNothing);
    });

    testWidgets('contains Container widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('contains Row widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Row), findsWidgets);
    });

    testWidgets('contains Column widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('contains Expanded widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Expanded), findsOneWidget);
    });

    testWidgets('contains SizedBox for spacing', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('displays empty string when part name is null', (tester) async {
      final dataModel = ElssPart(
        partName: null,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(OptionSkuTileWidget), findsOneWidget);
    });
  });
}
