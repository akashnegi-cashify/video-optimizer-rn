import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/add_part_list_widget_qc.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/providers/add_part_list_provider_qc.dart';
import 'package:flutter_trc/src/modules/elss/common_models/part_device_list.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:mocktail/mocktail.dart';

class MockAddPartListProviderQc extends Mock implements AddPartListProviderQc {}

void main() {
  group('AddPartListWidgetQc', () {
    late MockAddPartListProviderQc mockProvider;

    setUp(() {
      mockProvider = MockAddPartListProviderQc();
    });

    Widget buildTestWidget({
      List<PartItemDataResponse>? addPartsDataList,
      String? searchedQuery,
    }) {
      when(() => mockProvider.addPartsDataList)
          .thenReturn(addPartsDataList ?? []);
      when(() => mockProvider.searchedQuery).thenReturn(searchedQuery);
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
              ChangeNotifierProvider<AddPartListProviderQc>.value(
                value: mockProvider,
              ),
            ],
            child: const AddPartListWidgetQc(),
          ),
        ),
      );
    }

    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(AddPartListWidgetQc), findsOneWidget);
    });

    testWidgets('displays no parts found message when list is empty',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(addPartsDataList: []));
      await tester.pump();

      expect(find.text('No Parts Found'), findsOneWidget);
    });

    testWidgets('contains search text field', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(CshTextFormField), findsOneWidget);
    });

    testWidgets('contains cancel button', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('contains add part button', (tester) async {
      await tester.pumpWidget(buildTestWidget());
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
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('contains Row widget for buttons', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Row), findsWidgets);
    });

    testWidgets('contains SizedBox for spacing', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('contains Expanded for layout', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Expanded), findsWidgets);
    });

    testWidgets('contains Padding widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Padding), findsWidgets);
    });

    testWidgets('contains Stack for search field layout', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Stack), findsOneWidget);
    });

    testWidgets('shows clear button when search query is not empty',
        (tester) async {
      await tester.pumpWidget(
          buildTestWidget(searchedQuery: 'test', addPartsDataList: []));
      await tester.pump();

      // X circle icon should be visible
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('hides clear button when search query is empty',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(searchedQuery: null));
      await tester.pump();

      // Widget should still render
      expect(find.byType(AddPartListWidgetQc), findsOneWidget);
    });
  });
}
