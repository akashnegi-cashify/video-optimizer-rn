import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;

import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/widgets/item_delivery_deliver_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/models/delivery_response.dart';
import 'package:flutter_trc/src/modules/rider/engineer_card_widget.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockNavigatorObserver mockNavigatorObserver;

  setUpAll(() {
    registerFallbackValue(MaterialPageRoute<dynamic>(builder: (_) => const SizedBox()));
  });

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
        navigatorObservers: [mockNavigatorObserver],
        home: Scaffold(body: child),
        routes: {
          'qc/rider/delivery/deliver/engineer/parts': (context) =>
              const Scaffold(body: Text('Parts Screen')),
        },
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
    mockNavigatorObserver = MockNavigatorObserver();
  });

  group('ItemDeliveryDeliverWidget', () {
    testWidgets('renders without error', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John Doe',
        location: 'Mumbai',
      );

      await tester.pumpWidget(buildTestWidget(
        ItemDeliveryDeliverWidget(item: detail),
      ));
      await tester.pump();

      expect(find.byType(ItemDeliveryDeliverWidget), findsOneWidget);
    });

    testWidgets('displays EngineerCardWidget', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John Doe',
        location: 'Mumbai',
      );

      await tester.pumpWidget(buildTestWidget(
        ItemDeliveryDeliverWidget(item: detail),
      ));
      await tester.pump();

      expect(find.byType(EngineerCardWidget), findsOneWidget);
    });

    testWidgets('wraps EngineerCardWidget with GestureDetector',
        (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John Doe',
        location: 'Mumbai',
      );

      await tester.pumpWidget(buildTestWidget(
        ItemDeliveryDeliverWidget(item: detail),
      ));
      await tester.pump();

      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets('displays engineer name via EngineerCardWidget',
        (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'Jane Smith',
        location: 'Delhi',
      );

      await tester.pumpWidget(buildTestWidget(
        ItemDeliveryDeliverWidget(item: detail),
      ));
      await tester.pump();

      expect(find.text('Jane Smith'), findsOneWidget);
    });

    testWidgets('displays engineer location via EngineerCardWidget',
        (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'Jane Smith',
        location: 'Chennai',
      );

      await tester.pumpWidget(buildTestWidget(
        ItemDeliveryDeliverWidget(item: detail),
      ));
      await tester.pump();

      expect(find.text('Chennai'), findsOneWidget);
    });

    testWidgets('handles null name gracefully', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: null,
        location: 'Mumbai',
      );

      await tester.pumpWidget(buildTestWidget(
        ItemDeliveryDeliverWidget(item: detail),
      ));
      await tester.pump();

      expect(find.byType(ItemDeliveryDeliverWidget), findsOneWidget);
    });

    testWidgets('handles null location gracefully', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John',
        location: null,
      );

      await tester.pumpWidget(buildTestWidget(
        ItemDeliveryDeliverWidget(item: detail),
      ));
      await tester.pump();

      expect(find.byType(ItemDeliveryDeliverWidget), findsOneWidget);
    });
  });
}
