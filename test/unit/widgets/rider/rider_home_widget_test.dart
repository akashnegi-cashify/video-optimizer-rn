import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:core_widgets/core_widgets.dart';

import 'package:flutter_trc/src/modules/rider/rider_home_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/pending_delivery_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/pending_pickup_widget.dart';

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

  group('RiderWidget', () {
    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(buildTestWidget(const RiderWidget()));
      await tester.pump();

      // Verify the widget is rendered
      expect(find.byType(RiderWidget), findsOneWidget);
    });

    testWidgets('displays TabBarView with tabs', (tester) async {
      await tester.pumpWidget(buildTestWidget(const RiderWidget()));
      await tester.pump();

      // Verify TabBarView is present
      expect(find.byType(TabBarView), findsOneWidget);
    });

    testWidgets('displays two tabs for Pending Delivery and Pending Pickup',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(const RiderWidget()));
      await tester.pump();

      // Verify both tabs exist
      expect(find.byType(CshTabBar), findsOneWidget);
      expect(find.byType(CshTab), findsNWidgets(2));
    });

    testWidgets('first tab shows PendingDeliveryWidget', (tester) async {
      await tester.pumpWidget(buildTestWidget(const RiderWidget()));
      await tester.pump();

      // PendingDeliveryWidget should be shown by default (first tab)
      expect(find.byType(PendingDeliveryWidget), findsOneWidget);
    });

    testWidgets('can switch to second tab (Pending Pickup)', (tester) async {
      await tester.pumpWidget(buildTestWidget(const RiderWidget()));
      await tester.pump();

      // Find the second tab and tap it
      final tabFinder = find.byType(CshTab);
      expect(tabFinder, findsNWidgets(2));

      // Tap on the second tab
      await tester.tap(tabFinder.last);
      await tester.pumpAndSettle();

      // PendingPickupWidget should now be visible
      expect(find.byType(PendingPickupWidget), findsOneWidget);
    });

    testWidgets('Scaffold is present', (tester) async {
      await tester.pumpWidget(buildTestWidget(const RiderWidget()));
      await tester.pump();

      expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
    });

    testWidgets('contains SafeArea', (tester) async {
      await tester.pumpWidget(buildTestWidget(const RiderWidget()));
      await tester.pump();

      expect(find.byType(SafeArea), findsOneWidget);
    });

    testWidgets('uses FutureBuilder for app name', (tester) async {
      await tester.pumpWidget(buildTestWidget(const RiderWidget()));
      await tester.pump();

      expect(find.byType(FutureBuilder<String>), findsOneWidget);
    });
  });
}
