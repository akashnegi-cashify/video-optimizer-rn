import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/elss_device_details_widget.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_device_details_response.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';

void main() {
  group('ElssDeviceDetailsWidget', () {
    Widget buildTestWidget({DeviceDetailsData? dataModel}) {
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
            child: SingleChildScrollView(
              child: ElssDeviceDetailsWidget(dataModel: dataModel),
            ),
          ),
        ),
      );
    }

    testWidgets('renders without error with null data', (tester) async {
      await tester.pumpWidget(buildTestWidget(dataModel: null));
      await tester.pump();

      expect(find.byType(ElssDeviceDetailsWidget), findsOneWidget);
    });

    testWidgets('renders CshCard', (tester) async {
      await tester.pumpWidget(buildTestWidget(dataModel: null));
      await tester.pump();

      expect(find.byType(CshCard), findsOneWidget);
    });

    testWidgets('displays device name when provided', (tester) async {
      final dataModel = DeviceDetailsData(
        deviceName: 'iPhone 12',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('iPhone 12'), findsOneWidget);
    });

    testWidgets('displays device barcode when provided', (tester) async {
      final dataModel = DeviceDetailsData(
        deviceBarcode: 'BC123456',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('BC123456'), findsOneWidget);
    });

    testWidgets('displays repair type when provided', (tester) async {
      final dataModel = DeviceDetailsData(
        deviceRepairType: 'Screen Repair',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('Screen Repair'), findsOneWidget);
    });

    testWidgets('displays device color when provided', (tester) async {
      final dataModel = DeviceDetailsData(
        deviceColor: 'Black',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('Black'), findsOneWidget);
    });

    testWidgets('displays IMEI when provided', (tester) async {
      final dataModel = DeviceDetailsData(
        imei: '123456789012345',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('123456789012345'), findsOneWidget);
    });

    testWidgets('displays serial number when provided', (tester) async {
      final dataModel = DeviceDetailsData(
        serialNumber: 'SN123456',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('SN123456'), findsOneWidget);
    });

    testWidgets('displays device grade when provided', (tester) async {
      final dataModel = DeviceDetailsData(
        deviceGrade: 'A',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('A'), findsOneWidget);
    });

    testWidgets('displays suggested grade when provided', (tester) async {
      final dataModel = DeviceDetailsData(
        suggestedGrade: 'B',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('B'), findsOneWidget);
    });

    testWidgets('displays suggested channel when provided', (tester) async {
      final dataModel = DeviceDetailsData(
        suggestedChannel: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('Online'), findsOneWidget);
    });

    testWidgets('displays stock tags when provided', (tester) async {
      final dataModel = DeviceDetailsData(
        stockTags: ['Tag1', 'Tag2'],
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('Tag1 | Tag2'), findsOneWidget);
    });

    testWidgets('displays repair priority when provided', (tester) async {
      final dataModel = DeviceDetailsData(
        repairPriority: 'High',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('High'), findsOneWidget);
    });

    testWidgets('contains GridView for layout', (tester) async {
      final dataModel = DeviceDetailsData(
        deviceName: 'iPhone 12',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('displays all fields when all provided', (tester) async {
      final dataModel = DeviceDetailsData(
        deviceName: 'iPhone 12',
        deviceRepairType: 'Screen Repair',
        deviceBarcode: 'BC123456',
        deviceColor: 'Black',
        imei: '123456789012345',
        deviceGrade: 'A',
        suggestedGrade: 'B',
        suggestedChannel: 'Online',
        serialNumber: 'SN123456',
        repairPriority: 'High',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('iPhone 12'), findsOneWidget);
      expect(find.text('Screen Repair'), findsOneWidget);
    });
  });
}
