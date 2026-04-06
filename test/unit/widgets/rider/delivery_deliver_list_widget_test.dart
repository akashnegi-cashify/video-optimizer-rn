import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:core_widgets/src/theme/theme_change.provider.dart';

import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/widgets/delivery_deliver_list_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/providers/delivery_deliver_provider.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/models/delivery_response.dart';

class MockDeliveryDeliverProvider extends Mock
    implements DeliveryDeliverProvider {}

void main() {
  late MockDeliveryDeliverProvider mockDeliveryDeliverProvider;

  Widget buildTestWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
        ChangeNotifierProvider<DeliveryDeliverProvider>.value(
            value: mockDeliveryDeliverProvider),
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

  EngineerDetail createEngineerDetail({
    int id = 1,
    String? name,
    String? location,
  }) {
    return EngineerDetail.fromJson({
      'id': id,
      'n': name,
      'lc': location,
    });
  }

  setUp(() {
    mockDeliveryDeliverProvider = MockDeliveryDeliverProvider();
  });

  group('DeliveryDeliverListWidget', () {
    testWidgets('renders without error when displayList is empty',
        (tester) async {
      when(() => mockDeliveryDeliverProvider.displayList).thenReturn([]);

      await tester
          .pumpWidget(buildTestWidget(const DeliveryDeliverListWidget()));
      await tester.pump();

      expect(find.byType(DeliveryDeliverListWidget), findsOneWidget);
    });

    testWidgets('renders without error when displayList is null',
        (tester) async {
      when(() => mockDeliveryDeliverProvider.displayList).thenReturn(null);

      await tester
          .pumpWidget(buildTestWidget(const DeliveryDeliverListWidget()));
      await tester.pump();

      expect(find.byType(DeliveryDeliverListWidget), findsOneWidget);
      // Should show empty widget when list is null
      expect(find.byType(SizedBox), findsAtLeastNWidgets(1));
    });

    testWidgets('uses Consumer for DeliveryDeliverProvider', (tester) async {
      when(() => mockDeliveryDeliverProvider.displayList).thenReturn(null);

      await tester
          .pumpWidget(buildTestWidget(const DeliveryDeliverListWidget()));
      await tester.pump();

      expect(find.byType(Consumer<DeliveryDeliverProvider>), findsOneWidget);
    });

    testWidgets('displays CshList when data is available', (tester) async {
      final engineers = [
        createEngineerDetail(id: 1, name: 'John', location: 'Mumbai'),
        createEngineerDetail(id: 2, name: 'Jane', location: 'Delhi'),
      ];
      when(() => mockDeliveryDeliverProvider.displayList).thenReturn(engineers);
      when(() => mockDeliveryDeliverProvider.getData()).thenReturn(null);

      await tester
          .pumpWidget(buildTestWidget(const DeliveryDeliverListWidget()));
      await tester.pump();

      expect(find.byType(CshList<EngineerDetail>), findsOneWidget);
    });

    testWidgets('shows SizedBox.shrink when list is null', (tester) async {
      when(() => mockDeliveryDeliverProvider.displayList).thenReturn(null);

      await tester
          .pumpWidget(buildTestWidget(const DeliveryDeliverListWidget()));
      await tester.pump();

      // The widget tree contains SizedBox.shrink when list is null
      expect(find.byType(SizedBox), findsAtLeastNWidgets(1));
    });
  });
}
