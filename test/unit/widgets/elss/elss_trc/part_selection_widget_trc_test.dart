import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_trc/widgets/part_selection_widget_trc.dart';
import 'package:flutter_trc/src/modules/elss/elss_trc/providers/elss_provider_trc.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_device_details_response.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_part.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_option_response.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:mocktail/mocktail.dart';

class MockELssProviderTrc extends Mock implements ELssProviderTrc {}

void main() {
  group('PartSelectionWidgetTrc', () {
    late MockELssProviderTrc mockProvider;

    setUp(() {
      mockProvider = MockELssProviderTrc();
    });

    Widget buildTestWidget({
      String barcode = 'TEST_BARCODE',
    }) {
      when(() => mockProvider.elssDeviceDetails).thenReturn(null);
      when(() => mockProvider.elssPartList).thenReturn([]);
      when(() => mockProvider.searchedElssPartList).thenReturn([]);
      when(() => mockProvider.isElssOptionsLoading).thenReturn(false);
      when(() => mockProvider.elssOptionResponse).thenReturn(null);
      when(() => mockProvider.productOptionList).thenReturn([]);
      when(() => mockProvider.selectedOptionKey).thenReturn(-1);
      when(() => mockProvider.submitButtonName).thenReturn('Submit');

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
              ChangeNotifierProvider<ELssProviderTrc>.value(
                value: mockProvider,
              ),
            ],
            child: PartSelectionWidgetTrc(barcode: barcode),
          ),
        ),
      );
    }

    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(PartSelectionWidgetTrc), findsOneWidget);
    });

    testWidgets('contains Column widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('displays device details widget', (tester) async {
      when(() => mockProvider.elssDeviceDetails).thenReturn(
        ElssDeviceDetailsResponse(
          deviceDetailsData: DeviceDetailsData(
            deviceName: 'Test Device',
          ),
        ),
      );
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(PartSelectionWidgetTrc), findsOneWidget);
    });

    testWidgets('shows search field when part list is not empty',
        (tester) async {
      when(() => mockProvider.elssPartList).thenReturn([
        ElssPart(partName: 'Test Part', sku: 'SKU-001'),
      ]);
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(CshTextFormField), findsOneWidget);
    });

    testWidgets('hides search field when part list is empty', (tester) async {
      when(() => mockProvider.elssPartList).thenReturn([]);
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // Search field should not be visible
      expect(find.byType(CshTextFormField), findsNothing);
    });

    testWidgets('contains Add Part button', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Add Part'), findsOneWidget);
    });

    testWidgets('shows loading indicator when options are loading',
        (tester) async {
      when(() => mockProvider.isElssOptionsLoading).thenReturn(true);
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('hides loading indicator when options are not loading',
        (tester) async {
      when(() => mockProvider.isElssOptionsLoading).thenReturn(false);
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('shows swipe up container when options are available',
        (tester) async {
      when(() => mockProvider.elssOptionResponse).thenReturn(
        ElssOptionsResponse(
          optionList: [
            OptionResponse(optionName: 'Option 1'),
          ],
        ),
      );
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Swipe up to open'), findsOneWidget);
    });

    testWidgets('hides swipe up container when options are null',
        (tester) async {
      when(() => mockProvider.elssOptionResponse).thenReturn(null);
      when(() => mockProvider.isElssOptionsLoading).thenReturn(false);
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Swipe up to open'), findsNothing);
    });

    testWidgets('contains ListView when part list is not empty',
        (tester) async {
      when(() => mockProvider.elssPartList).thenReturn([
        ElssPart(partName: 'Test Part', sku: 'SKU-001'),
      ]);
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('contains Expanded widget for layout', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Expanded), findsWidgets);
    });

    testWidgets('contains Padding widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Padding), findsWidgets);
    });

    testWidgets('contains GestureDetector for add part', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('contains Row widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Row), findsWidgets);
    });
  });
}
