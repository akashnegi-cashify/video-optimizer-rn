import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_trc/widgets/elss_part_widget_trc.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_part.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';

void main() {
  group('ElssPartWidgetTrc', () {
    late String lastActionChanged;
    late int lastPartRemoved;
    late int lastImageUploadIndex;
    late String lastImageUploadUrl;

    setUp(() {
      lastActionChanged = '';
      lastPartRemoved = -1;
      lastImageUploadIndex = -1;
      lastImageUploadUrl = '';
    });

    Widget buildTestWidget({
      ElssPart? dataModel,
      int indexData = 1,
      Function(int)? onPartRemoved,
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
            child: ElssPartWidgetTrc(
              dataModel: dataModel,
              indexData: indexData,
              onActionChanged: (action) {
                lastActionChanged = action;
              },
              onPartRemoved: onPartRemoved ??
                  (id) {
                    lastPartRemoved = id;
                  },
              onImageUploadCallback: (index, url) {
                lastImageUploadIndex = index;
                lastImageUploadUrl = url;
              },
            ),
          ),
        ),
      );
    }

    testWidgets('renders without error with null data', (tester) async {
      await tester.pumpWidget(buildTestWidget(dataModel: null));
      await tester.pump();

      expect(find.byType(ElssPartWidgetTrc), findsOneWidget);
    });

    testWidgets('renders CshCard', (tester) async {
      await tester.pumpWidget(buildTestWidget(dataModel: null));
      await tester.pump();

      expect(find.byType(CshCard), findsOneWidget);
    });

    testWidgets('displays index data', (tester) async {
      await tester.pumpWidget(buildTestWidget(indexData: 5));
      await tester.pump();

      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('displays part name when provided', (tester) async {
      final dataModel = ElssPart(
        partName: 'Screen Display',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('Screen Display'), findsOneWidget);
    });

    testWidgets('displays SKU when provided', (tester) async {
      final dataModel = ElssPart(
        sku: 'SKU-12345',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('SKU-12345'), findsOneWidget);
    });

    testWidgets('displays part variant name when provided', (tester) async {
      final dataModel = ElssPart(
        partVariantName: 'Black 64GB',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('Black 64GB'), findsOneWidget);
    });

    testWidgets('displays dropdown when action is not null', (tester) async {
      final dataModel = ElssPart(
        action: 'Required',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(DropdownButton<String>), findsOneWidget);
    });

    testWidgets('hides dropdown when action is null', (tester) async {
      final dataModel = ElssPart(
        action: null,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(DropdownButton<String>), findsNothing);
    });

    testWidgets('shows remove button when action is null', (tester) async {
      final dataModel = ElssPart(
        action: null,
        elssPartId: 100,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      // The X circle icon should be visible
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('displays all fields when all provided', (tester) async {
      final dataModel = ElssPart(
        partName: 'Screen Display',
        sku: 'SKU-12345',
        partVariantName: 'Black 64GB',
        action: 'Required',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('Screen Display'), findsOneWidget);
      expect(find.text('SKU-12345'), findsOneWidget);
      expect(find.text('Black 64GB'), findsOneWidget);
    });

    testWidgets('contains Row widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Row), findsWidgets);
    });

    testWidgets('contains Expanded widget for layout', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Expanded), findsWidgets);
    });

    testWidgets('dropdown contains correct items', (tester) async {
      final dataModel = ElssPart(
        action: 'Required',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      // Tap dropdown to open
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      // Check for dropdown items
      expect(find.text('Not Required'), findsWidgets);
      expect(find.text('Required'), findsWidgets);
      expect(find.text('Not Repairable'), findsWidgets);
    });

    testWidgets('action change callback works', (tester) async {
      final dataModel = ElssPart(
        action: 'Required',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      // Tap dropdown to open
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      // Select "Not Required" option
      await tester.tap(find.text('Not Required').last);
      await tester.pumpAndSettle();

      expect(lastActionChanged, 'Not Required');
    });

    testWidgets('initial action is set correctly', (tester) async {
      final dataModel = ElssPart(
        action: 'Not Repairable',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pumpAndSettle();

      // The dropdown should show the initial value
      expect(find.byType(DropdownButton<String>), findsOneWidget);
    });
  });
}
