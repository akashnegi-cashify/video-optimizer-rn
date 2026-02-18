import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/part_selection_widget.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/providers/elss_provider_qc.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_device_details_response.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_part.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/elss_parts_selection_options.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:mocktail/mocktail.dart';

class MockELssProviderQc extends Mock implements ELssProviderQc {}

void main() {
  group('PartSelectionWidget', () {
    late MockELssProviderQc mockProvider;

    setUp(() {
      mockProvider = MockELssProviderQc();
    });

    Widget buildTestWidget({
      String barcode = 'TEST_BARCODE',
    }) {
      when(() => mockProvider.elssDeviceDetails).thenReturn(null);
      when(() => mockProvider.elssPartList).thenReturn([]);
      when(() => mockProvider.rubbingOrGlassChangeDropdown).thenReturn([]);
      when(() => mockProvider.selectedRubbingOrGlassChangeValue)
          .thenReturn(null);
      when(() => mockProvider.isNonRepairTypeDevice()).thenReturn(false);
      when(() => mockProvider.isRepairTypeDevice()).thenReturn(false);
      when(() => mockProvider.isElssPartsSelectedForRepair()).thenReturn(false);

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
              ChangeNotifierProvider<ELssProviderQc>.value(
                value: mockProvider,
              ),
            ],
            child: PartSelectionWidget(barcode: barcode),
          ),
        ),
      );
    }

    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(PartSelectionWidget), findsOneWidget);
    });

    testWidgets('contains Column widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('contains Expanded widget for layout', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Expanded), findsWidgets);
    });

    testWidgets('contains SingleChildScrollView', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
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

      expect(find.byType(PartSelectionWidget), findsOneWidget);
    });

    testWidgets('contains CshCard for rubbing/glass change', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(CshCard), findsWidgets);
    });

    testWidgets('displays Rubbing/Glass Change text', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Rubbing/Glass Change'), findsOneWidget);
    });

    testWidgets('contains CshDropDown', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(CshDropDown), findsOneWidget);
    });

    testWidgets('shows Add parts button when part addition is allowed',
        (tester) async {
      when(() => mockProvider.elssDeviceDetails).thenReturn(
        ElssDeviceDetailsResponse(
          deviceDetailsData: DeviceDetailsData(
            partAdditionAllowed: true,
          ),
        ),
      );
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Add parts'), findsOneWidget);
    });

    testWidgets('hides Add parts button when part addition is not allowed',
        (tester) async {
      when(() => mockProvider.elssDeviceDetails).thenReturn(
        ElssDeviceDetailsResponse(
          deviceDetailsData: DeviceDetailsData(
            partAdditionAllowed: false,
          ),
        ),
      );
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Add parts'), findsNothing);
    });

    testWidgets('displays Device Parts text when part list is not empty',
        (tester) async {
      when(() => mockProvider.elssPartList).thenReturn([
        ElssPart(
          partName: 'Test Part',
          sku: 'SKU-001',
          actionConstant: ElssPartsSelectionOptions.notRequired.id,
        ),
      ]);
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Device Parts'), findsOneWidget);
    });

    testWidgets('contains ListView when part list is not empty',
        (tester) async {
      when(() => mockProvider.elssPartList).thenReturn([
        ElssPart(
          partName: 'Test Part',
          sku: 'SKU-001',
          actionConstant: ElssPartsSelectionOptions.notRequired.id,
        ),
      ]);
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('contains bottom buttons', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Retest'), findsOneWidget);
      expect(find.text('Submit'), findsOneWidget);
    });

    testWidgets('Submit button is disabled when conditions are not met',
        (tester) async {
      when(() => mockProvider.isNonRepairTypeDevice()).thenReturn(false);
      when(() => mockProvider.isRepairTypeDevice()).thenReturn(false);
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      final submitButton = tester.widget<CshMediumButton>(
        find.widgetWithText(CshMediumButton, 'Submit'),
      );
      expect(submitButton.onPressed, isNull);
    });

    testWidgets('Submit button is enabled for non-repair type device',
        (tester) async {
      when(() => mockProvider.isNonRepairTypeDevice()).thenReturn(true);
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      final submitButton = tester.widget<CshMediumButton>(
        find.widgetWithText(CshMediumButton, 'Submit'),
      );
      expect(submitButton.onPressed, isNotNull);
    });

    testWidgets('contains Padding widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Padding), findsWidgets);
    });

    testWidgets('contains SizedBox for spacing', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(SizedBox), findsWidgets);
    });
  });
}
