import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:core_widgets/src/theme/theme_change.provider.dart';

import 'package:flutter_trc/src/modules/rider/pending_delivery/receive/widgets/item_delivery_receive_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/receive/models/receive_response_model.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/receive/providers/delivery_receive_provider.dart';
import 'package:flutter_trc/src/common/widgets/key_value_row_widget.dart';

class MockDeliveryReceiveProvider extends Mock
    implements DeliveryReceiveProvider {}

void main() {
  late MockDeliveryReceiveProvider mockDeliveryReceiveProvider;

  Widget buildTestWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
        ChangeNotifierProvider<DeliveryReceiveProvider>.value(
            value: mockDeliveryReceiveProvider),
        ChangeNotifierProvider<ThemeChangeProvider>(create: (_) => ThemeChangeProvider(false)),
      ],
      child: MaterialApp(
        theme: ThemeData(
          extensions: [
            CustomColors(
              successColor: Colors.green,
              warnColor: Colors.orange,
              inputStrokeColor: Colors.grey,
              searchShadow: Colors.grey.withAlpha(50),
              shadows: {
                10: const BoxShadow(color: Colors.black12, blurRadius: 10),
                15: const BoxShadow(color: Colors.black12, blurRadius: 15),
                20: const BoxShadow(color: Colors.black12, blurRadius: 20),
              },
            ),
          ],
        ),
        home: Scaffold(body: child),
      ),
    );
  }

  Part createPart({
    String partName = 'Test Part',
    String partBarcode = 'TEST123',
    String partSku = 'SKU001',
    String? partVariantName,
    String inventoryManageName = 'Manager',
    int partId = 1,
  }) {
    return Part.fromJson({
      'pn': partName,
      'pbr': partBarcode,
      'sku': partSku,
      'pvn': partVariantName,
      'dna': 'Test Device',
      'pc': 'Black',
      'dbr': 'DEV123',
      'prid': partId,
      'isUrgent': false,
      'im': inventoryManageName,
    });
  }

  setUp(() {
    mockDeliveryReceiveProvider = MockDeliveryReceiveProvider();
  });

  group('ItemDeliveryReceiveWidget', () {
    testWidgets('renders without error', (tester) async {
      final part = createPart();
      var callbackCalled = false;

      await tester.pumpWidget(buildTestWidget(
        ItemDeliveryReceiveWidget(
          item: part,
          onReceiveConfirm: () => callbackCalled = true,
        ),
      ));
      await tester.pump();

      expect(find.byType(ItemDeliveryReceiveWidget), findsOneWidget);
    });

    testWidgets('displays part name', (tester) async {
      final part = createPart(partName: 'My Test Part');

      await tester.pumpWidget(buildTestWidget(
        ItemDeliveryReceiveWidget(
          item: part,
          onReceiveConfirm: () {},
        ),
      ));
      await tester.pump();

      expect(find.text('My Test Part'), findsOneWidget);
    });

    testWidgets('displays part barcode', (tester) async {
      final part = createPart(partBarcode: 'BARCODE123');

      await tester.pumpWidget(buildTestWidget(
        ItemDeliveryReceiveWidget(
          item: part,
          onReceiveConfirm: () {},
        ),
      ));
      await tester.pump();

      expect(find.text('BARCODE123'), findsOneWidget);
    });

    testWidgets('displays part SKU', (tester) async {
      final part = createPart(partSku: 'SKU12345');

      await tester.pumpWidget(buildTestWidget(
        ItemDeliveryReceiveWidget(
          item: part,
          onReceiveConfirm: () {},
        ),
      ));
      await tester.pump();

      expect(find.text('SKU12345'), findsOneWidget);
    });

    testWidgets('displays inventory manager name', (tester) async {
      final part = createPart(inventoryManageName: 'John Manager');

      await tester.pumpWidget(buildTestWidget(
        ItemDeliveryReceiveWidget(
          item: part,
          onReceiveConfirm: () {},
        ),
      ));
      await tester.pump();

      expect(find.text('John Manager'), findsOneWidget);
    });

    testWidgets('displays variant name when not null', (tester) async {
      final part = createPart(partVariantName: 'Variant A');

      await tester.pumpWidget(buildTestWidget(
        ItemDeliveryReceiveWidget(
          item: part,
          onReceiveConfirm: () {},
        ),
      ));
      await tester.pump();

      expect(find.text('Variant A'), findsOneWidget);
    });

    testWidgets('does not display variant name when null', (tester) async {
      final part = createPart(partVariantName: null);

      await tester.pumpWidget(buildTestWidget(
        ItemDeliveryReceiveWidget(
          item: part,
          onReceiveConfirm: () {},
        ),
      ));
      await tester.pump();

      // Should have 4 KeyValueRowWidgets (without variant)
      // partName, partBarcode, partSku, pickFrom
      expect(find.byType(KeyValueRowWidget), findsNWidgets(4));
    });

    testWidgets('displays 5 KeyValueRowWidgets when variant name present',
        (tester) async {
      final part = createPart(partVariantName: 'Variant X');

      await tester.pumpWidget(buildTestWidget(
        ItemDeliveryReceiveWidget(
          item: part,
          onReceiveConfirm: () {},
        ),
      ));
      await tester.pump();

      // Should have 5 KeyValueRowWidgets (with variant)
      expect(find.byType(KeyValueRowWidget), findsNWidgets(5));
    });

    testWidgets('displays RECEIVE button', (tester) async {
      final part = createPart();

      await tester.pumpWidget(buildTestWidget(
        ItemDeliveryReceiveWidget(
          item: part,
          onReceiveConfirm: () {},
        ),
      ));
      await tester.pump();

      expect(find.byType(CshMediumOutlineButton), findsOneWidget);
    });

    testWidgets('displays CshCard wrapper', (tester) async {
      final part = createPart();

      await tester.pumpWidget(buildTestWidget(
        ItemDeliveryReceiveWidget(
          item: part,
          onReceiveConfirm: () {},
        ),
      ));
      await tester.pump();

      expect(find.byType(CshCard), findsOneWidget);
    });

    testWidgets('displays Padding wrapper', (tester) async {
      final part = createPart();

      await tester.pumpWidget(buildTestWidget(
        ItemDeliveryReceiveWidget(
          item: part,
          onReceiveConfirm: () {},
        ),
      ));
      await tester.pump();

      expect(find.byType(Padding), findsAtLeastNWidgets(1));
    });

    testWidgets('receive button shows confirmation dialog when tapped',
        (tester) async {
      final part = createPart();

      await tester.pumpWidget(buildTestWidget(
        ItemDeliveryReceiveWidget(
          item: part,
          onReceiveConfirm: () {},
        ),
      ));
      await tester.pump();

      // Tap the receive button
      final button = find.byType(CshMediumOutlineButton);
      await tester.tap(button);
      await tester.pump();

      // CshAlertPopup should be shown (creates Dialog internally)
      expect(find.byType(Dialog), findsOneWidget);
    });
  });
}
