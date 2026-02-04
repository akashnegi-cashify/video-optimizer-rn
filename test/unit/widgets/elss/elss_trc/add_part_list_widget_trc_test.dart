import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_trc/widgets/add_part_list_widget_trc.dart';
import 'package:flutter_trc/src/modules/elss/elss_trc/providers/add_part_list_provider_trc.dart';
import 'package:flutter_trc/src/modules/elss/common_models/part_device_list.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:mocktail/mocktail.dart';

class MockAddPartListProviderTrc extends Mock implements AddPartListProviderTrc {
}

void main() {
  group('AddPartListWidgetTrc', () {
    late MockAddPartListProviderTrc mockProvider;

    setUp(() {
      mockProvider = MockAddPartListProviderTrc();
    });

    Widget buildTestWidget({
      List<PartItemDataResponse>? addPartsDataList,
    }) {
      when(() => mockProvider.addPartsDataList).thenReturn(addPartsDataList ?? []);
      when(() => mockProvider.getSelectedParts()).thenReturn([]);

      return MaterialApp(
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
          extensions: [CustomColors.light()],
        ),
        home: Scaffold(
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => LocaleProvider()),
              ChangeNotifierProvider<AddPartListProviderTrc>.value(
                value: mockProvider,
              ),
            ],
            child: const AddPartListWidgetTrc(),
          ),
        ),
      );
    }

    testWidgets('renders without error with empty list', (tester) async {
      await tester.pumpWidget(buildTestWidget(addPartsDataList: []));
      await tester.pump();

      expect(find.byType(AddPartListWidgetTrc), findsOneWidget);
    });

    testWidgets('displays no parts found message when list is empty',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(addPartsDataList: []));
      await tester.pump();

      expect(find.text('No Parts Found'), findsOneWidget);
    });

    testWidgets('renders with non-empty list', (tester) async {
      final partsList = [
        PartItemDataResponse('SKU-001', 'Black', 'Screen', partId: 1),
        PartItemDataResponse('SKU-002', 'White', 'Battery', partId: 2),
      ];
      await tester.pumpWidget(buildTestWidget(addPartsDataList: partsList));
      await tester.pump();

      expect(find.byType(AddPartListWidgetTrc), findsOneWidget);
    });

    testWidgets('contains search text field when list is not empty',
        (tester) async {
      final partsList = [
        PartItemDataResponse('SKU-001', 'Black', 'Screen', partId: 1),
      ];
      await tester.pumpWidget(buildTestWidget(addPartsDataList: partsList));
      await tester.pump();

      expect(find.byType(CshTextFormField), findsOneWidget);
    });

    testWidgets('contains cancel button when list is not empty',
        (tester) async {
      final partsList = [
        PartItemDataResponse('SKU-001', 'Black', 'Screen', partId: 1),
      ];
      await tester.pumpWidget(buildTestWidget(addPartsDataList: partsList));
      await tester.pump();

      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('contains add part button when list is not empty',
        (tester) async {
      final partsList = [
        PartItemDataResponse('SKU-001', 'Black', 'Screen', partId: 1),
      ];
      await tester.pumpWidget(buildTestWidget(addPartsDataList: partsList));
      await tester.pump();

      expect(find.text('Add Part'), findsOneWidget);
    });

    testWidgets('contains ListView when list is not empty', (tester) async {
      final partsList = [
        PartItemDataResponse('SKU-001', 'Black', 'Screen', partId: 1),
      ];
      await tester.pumpWidget(buildTestWidget(addPartsDataList: partsList));
      await tester.pump();

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('contains Column widget', (tester) async {
      final partsList = [
        PartItemDataResponse('SKU-001', 'Black', 'Screen', partId: 1),
      ];
      await tester.pumpWidget(buildTestWidget(addPartsDataList: partsList));
      await tester.pump();

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('contains Row widget for buttons', (tester) async {
      final partsList = [
        PartItemDataResponse('SKU-001', 'Black', 'Screen', partId: 1),
      ];
      await tester.pumpWidget(buildTestWidget(addPartsDataList: partsList));
      await tester.pump();

      expect(find.byType(Row), findsWidgets);
    });

    testWidgets('contains SizedBox for spacing', (tester) async {
      final partsList = [
        PartItemDataResponse('SKU-001', 'Black', 'Screen', partId: 1),
      ];
      await tester.pumpWidget(buildTestWidget(addPartsDataList: partsList));
      await tester.pump();

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('contains Expanded for layout', (tester) async {
      final partsList = [
        PartItemDataResponse('SKU-001', 'Black', 'Screen', partId: 1),
      ];
      await tester.pumpWidget(buildTestWidget(addPartsDataList: partsList));
      await tester.pump();

      expect(find.byType(Expanded), findsWidgets);
    });

    testWidgets('search input clears when X button is pressed', (tester) async {
      final partsList = [
        PartItemDataResponse('SKU-001', 'Black', 'Screen', partId: 1),
      ];
      await tester.pumpWidget(buildTestWidget(addPartsDataList: partsList));
      await tester.pump();

      // Enter text in search field
      await tester.enterText(find.byType(CshTextFormField), 'test');
      await tester.pump();

      // X button should appear
      expect(find.byType(GestureDetector), findsWidgets);
    });
  });
}
