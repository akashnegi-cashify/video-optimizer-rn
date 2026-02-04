import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;

import 'package:flutter_trc/src/modules/rider/pending_pickup/receive/widgets/pickup_receive_barcode_scanner_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/receive/models/receive_response_model.dart';
import 'package:flutter_trc/src/common/widgets/key_value_row_widget.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          extensions: [
            CustomColors(
              successColor: Colors.green,
              warnColor: Colors.orange,
              inputStrokeColor: Colors.grey,
              searchShadow: Colors.grey.withAlpha(50),
              shadows: const {},
            ),
          ],
        ),
        home: child,
      ),
    );
  }

  Part createPart({
    String partName = 'Test Part',
    String partBarcode = 'TEST123',
    String partSku = 'SKU001',
    String partColor = 'Black',
  }) {
    return Part.fromJson({
      'pn': partName,
      'pbr': partBarcode,
      'sku': partSku,
      'dna': 'Test Device',
      'pc': partColor,
      'dbr': 'DEV123',
      'prid': 1,
      'isUrgent': false,
      'im': 'Manager',
    });
  }

  group('PickupReceiveBarcodeScannerWidget', () {
    testWidgets('renders without error', (tester) async {
      final part = createPart();
      String? receivedBarcode;

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveBarcodeScannerWidget(
          onPartReceive: (result) => receivedBarcode = result,
          part: part,
        ),
      ));
      await tester.pump();

      expect(find.byType(PickupReceiveBarcodeScannerWidget), findsOneWidget);
    });

    testWidgets('displays Scaffold', (tester) async {
      final part = createPart();

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveBarcodeScannerWidget(
          onPartReceive: (_) {},
          part: part,
        ),
      ));
      await tester.pump();

      expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
    });

    testWidgets('displays part name', (tester) async {
      final part = createPart(partName: 'My Test Part');

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveBarcodeScannerWidget(
          onPartReceive: (_) {},
          part: part,
        ),
      ));
      await tester.pump();

      expect(find.text('My Test Part'), findsOneWidget);
    });

    testWidgets('displays part SKU', (tester) async {
      final part = createPart(partSku: 'SKU12345');

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveBarcodeScannerWidget(
          onPartReceive: (_) {},
          part: part,
        ),
      ));
      await tester.pump();

      expect(find.text('SKU12345'), findsOneWidget);
    });

    testWidgets('displays part color', (tester) async {
      final part = createPart(partColor: 'Red');

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveBarcodeScannerWidget(
          onPartReceive: (_) {},
          part: part,
        ),
      ));
      await tester.pump();

      expect(find.text('Red'), findsOneWidget);
    });

    testWidgets('displays CshCard with part details', (tester) async {
      final part = createPart();

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveBarcodeScannerWidget(
          onPartReceive: (_) {},
          part: part,
        ),
      ));
      await tester.pump();

      expect(find.byType(CshCard), findsOneWidget);
    });

    testWidgets('displays 3 KeyValueRowWidgets', (tester) async {
      final part = createPart();

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveBarcodeScannerWidget(
          onPartReceive: (_) {},
          part: part,
        ),
      ));
      await tester.pump();

      // partName, partSku, partColor
      expect(find.byType(KeyValueRowWidget), findsNWidgets(3));
    });

    testWidgets('displays BarCodeScannerWidget', (tester) async {
      final part = createPart();

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveBarcodeScannerWidget(
          onPartReceive: (_) {},
          part: part,
        ),
      ));
      await tester.pump();

      expect(find.byType(BarCodeScannerWidget), findsOneWidget);
    });

    testWidgets('displays OR text', (tester) async {
      final part = createPart();

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveBarcodeScannerWidget(
          onPartReceive: (_) {},
          part: part,
        ),
      ));
      await tester.pump();

      expect(find.text('OR'), findsOneWidget);
    });

    testWidgets('displays text input field', (tester) async {
      final part = createPart();

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveBarcodeScannerWidget(
          onPartReceive: (_) {},
          part: part,
        ),
      ));
      await tester.pump();

      expect(find.byType(CshTextFormField), findsOneWidget);
    });

    testWidgets('displays Submit button', (tester) async {
      final part = createPart();

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveBarcodeScannerWidget(
          onPartReceive: (_) {},
          part: part,
        ),
      ));
      await tester.pump();

      expect(find.byType(CshBigButton), findsOneWidget);
    });

    testWidgets('submit button calls onPartReceive with text input',
        (tester) async {
      final part = createPart();
      String? receivedBarcode;

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveBarcodeScannerWidget(
          onPartReceive: (result) => receivedBarcode = result,
          part: part,
        ),
      ));
      await tester.pump();

      // Enter barcode text
      final textField = find.byType(CshTextFormField);
      await tester.enterText(textField, 'MANUAL123');
      await tester.pump();

      // Tap submit button
      final submitButton = find.byType(CshBigButton);
      await tester.tap(submitButton);
      await tester.pump();

      expect(receivedBarcode, 'MANUAL123');
    });

    testWidgets('displays Column layout', (tester) async {
      final part = createPart();

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveBarcodeScannerWidget(
          onPartReceive: (_) {},
          part: part,
        ),
      ));
      await tester.pump();

      expect(find.byType(Column), findsAtLeastNWidgets(1));
    });

    testWidgets('has Expanded widget for scanner area', (tester) async {
      final part = createPart();

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveBarcodeScannerWidget(
          onPartReceive: (_) {},
          part: part,
        ),
      ));
      await tester.pump();

      expect(find.byType(Expanded), findsAtLeastNWidgets(1));
    });
  });
}
