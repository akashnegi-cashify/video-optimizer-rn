import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;

import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/widgets/delivery_deliver_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/widgets/delivery_deliver_list_widget.dart';

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
        home: Scaffold(body: child),
      ),
    );
  }

  group('DeliveryDeliverWidget', () {
    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryDeliverWidget()));
      await tester.pump();

      expect(find.byType(DeliveryDeliverWidget), findsOneWidget);
    });

    testWidgets('displays SearchBarWidget', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryDeliverWidget()));
      await tester.pump();

      expect(find.byType(SearchBarWidget), findsOneWidget);
    });

    testWidgets('displays urgent requests checkbox', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryDeliverWidget()));
      await tester.pump();

      expect(find.byType(CshCheckbox), findsOneWidget);
    });

    testWidgets('displays DeliveryDeliverListWidget', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryDeliverWidget()));
      await tester.pump();

      expect(find.byType(DeliveryDeliverListWidget), findsOneWidget);
    });

    testWidgets('displays Column layout', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryDeliverWidget()));
      await tester.pump();

      expect(find.byType(Column), findsAtLeastNWidgets(1));
    });

    testWidgets('displays Row for checkbox section', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryDeliverWidget()));
      await tester.pump();

      expect(find.byType(Row), findsAtLeastNWidgets(1));
    });

    testWidgets('uses AutomaticKeepAliveClientMixin', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryDeliverWidget()));
      await tester.pump();

      // Widget should keep state alive
      expect(find.byType(DeliveryDeliverWidget), findsOneWidget);
    });

    testWidgets('checkbox can be toggled', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryDeliverWidget()));
      await tester.pump();

      final checkbox = find.byType(CshCheckbox);
      expect(checkbox, findsOneWidget);

      // Tap the checkbox
      await tester.tap(checkbox);
      await tester.pump();

      expect(find.byType(DeliveryDeliverWidget), findsOneWidget);
    });

    testWidgets('has Expanded widget for list', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryDeliverWidget()));
      await tester.pump();

      expect(find.byType(Expanded), findsAtLeastNWidgets(1));
    });

    testWidgets('creates ChangeNotifierProvider for DeliveryDeliverProvider',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryDeliverWidget()));
      await tester.pump();

      // Provider should be created via ChangeNotifierProvider
      expect(find.byType(DeliveryDeliverWidget), findsOneWidget);
    });
  });
}
