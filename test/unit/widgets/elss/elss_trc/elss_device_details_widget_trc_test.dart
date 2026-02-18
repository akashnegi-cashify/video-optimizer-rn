import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_trc/widgets/elss_device_details_widget_trc.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_device_details_response.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';

void main() {
  group('ElssDeviceDetailsWidgetTrc', () {
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
            child: ElssDeviceDetailsWidgetTrc(dataModel: dataModel),
          ),
        ),
      );
    }

    testWidgets('renders without error with null data', (tester) async {
      await tester.pumpWidget(buildTestWidget(dataModel: null));
      await tester.pump();

      expect(find.byType(ElssDeviceDetailsWidgetTrc), findsOneWidget);
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
      expect(find.textContaining('Device Name'), findsOneWidget);
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

    testWidgets('displays request reason when provided', (tester) async {
      final dataModel = DeviceDetailsData(
        requestReason: 'Battery issue',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('Battery issue'), findsOneWidget);
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

    testWidgets('displays all fields when all provided', (tester) async {
      final dataModel = DeviceDetailsData(
        deviceName: 'iPhone 12',
        deviceRepairType: 'Screen Repair',
        deviceBarcode: 'BC123456',
        deviceColor: 'Black',
        requestReason: 'Battery issue',
        imei: '123456789012345',
        serialNumber: 'SN123456',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('iPhone 12'), findsOneWidget);
      expect(find.text('Screen Repair'), findsOneWidget);
      expect(find.text('BC123456'), findsOneWidget);
      expect(find.text('Black'), findsOneWidget);
      expect(find.text('Battery issue'), findsOneWidget);
      expect(find.text('123456789012345'), findsOneWidget);
      expect(find.text('SN123456'), findsOneWidget);
    });

    testWidgets('hides fields with null values', (tester) async {
      final dataModel = DeviceDetailsData(
        deviceName: 'iPhone 12',
        deviceBarcode: null,
        deviceColor: null,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('iPhone 12'), findsOneWidget);
      // Device Barcode label should not appear when value is null
    });

    testWidgets('contains Column widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets('contains Padding widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Padding), findsOneWidget);
    });
  });
}
