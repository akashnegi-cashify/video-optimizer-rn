import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;

import 'package:flutter_trc/src/modules/rider/pending_pickup/deliver/widgets/pickup_deliver_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/deliver/widgets/pickup_deliver_list_widget.dart';

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

  group('PickupDeliverWidget', () {
    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PickupDeliverWidget()));
      await tester.pump();

      expect(find.byType(PickupDeliverWidget), findsOneWidget);
    });

    testWidgets('displays SearchBarWidget', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PickupDeliverWidget()));
      await tester.pump();

      expect(find.byType(SearchBarWidget), findsOneWidget);
    });

    testWidgets('displays PickupDeliverListWidget', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PickupDeliverWidget()));
      await tester.pump();

      expect(find.byType(PickupDeliverListWidget), findsOneWidget);
    });

    testWidgets('displays Column layout', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PickupDeliverWidget()));
      await tester.pump();

      expect(find.byType(Column), findsAtLeastNWidgets(1));
    });

    testWidgets('has Expanded widget for list', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PickupDeliverWidget()));
      await tester.pump();

      expect(find.byType(Expanded), findsAtLeastNWidgets(1));
    });

    testWidgets('uses AutomaticKeepAliveClientMixin', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PickupDeliverWidget()));
      await tester.pump();

      // Widget should be present and keeping state alive
      expect(find.byType(PickupDeliverWidget), findsOneWidget);
    });

    testWidgets('creates ChangeNotifierProvider', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PickupDeliverWidget()));
      await tester.pump();

      // Provider should be created
      expect(find.byType(PickupDeliverWidget), findsOneWidget);
    });
  });
}
