import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;

import 'package:flutter_trc/src/modules/rider/pending_pickup/deliver/widgets/pickup_deliver_list_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/deliver/providers/pickup_deliver_provider.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/receive/models/receive_response_model.dart';

class MockPickupDeliverProvider extends Mock implements PickupDeliverProvider {}

void main() {
  late MockPickupDeliverProvider mockPickupDeliverProvider;

  Widget buildTestWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
        ChangeNotifierProvider<PickupDeliverProvider>.value(
            value: mockPickupDeliverProvider),
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
        home: Scaffold(body: child),
      ),
    );
  }

  Part createPart({
    String partName = 'Test Part',
    String partBarcode = 'TEST123',
    String partSku = 'SKU001',
    String? partVariantName,
  }) {
    return Part.fromJson({
      'pn': partName,
      'pbr': partBarcode,
      'sku': partSku,
      'pvn': partVariantName,
      'dna': 'Test Device',
      'pc': 'Black',
      'dbr': 'DEV123',
      'prid': 1,
      'isUrgent': false,
      'im': 'Manager',
    });
  }

  setUp(() {
    mockPickupDeliverProvider = MockPickupDeliverProvider();

    // Mock provider listener
    when(() => mockPickupDeliverProvider.addListener(any())).thenReturn(null);
    when(() => mockPickupDeliverProvider.removeListener(any())).thenReturn(null);
  });

  group('PickupDeliverListWidget', () {
    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PickupDeliverListWidget()));
      await tester.pump();

      expect(find.byType(PickupDeliverListWidget), findsOneWidget);
    });

    testWidgets('uses CshApiList for rendering', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PickupDeliverListWidget()));
      await tester.pump();

      // CshApiList should be used for the list
      expect(find.byType(CshApiList<Part>), findsOneWidget);
    });

    testWidgets('listens to provider changes', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PickupDeliverListWidget()));
      await tester.pump();

      verify(() => mockPickupDeliverProvider.addListener(any())).called(1);
    });
  });
}
