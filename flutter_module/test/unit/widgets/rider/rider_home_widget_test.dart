import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:core_widgets/src/theme/theme_change.provider.dart';

import 'package:flutter_trc/src/modules/rider/rider_home_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/pending_delivery_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/pending_pickup_widget.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
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
      expect(find.byType(TabBarView), findsAtLeastNWidgets(1));
    });

    testWidgets('displays two tabs for Pending Delivery and Pending Pickup',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(const RiderWidget()));
      await tester.pump();

      // Verify tabs exist (child widgets may also contain CshTabBar/CshTab)
      expect(find.byType(CshTabBar), findsAtLeastNWidgets(1));
      expect(find.byType(CshTab), findsAtLeastNWidgets(2));
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

      // Find tabs (child widgets may also contain CshTab)
      final tabFinder = find.byType(CshTab);
      expect(tabFinder, findsAtLeastNWidgets(2));

      // Tap on the second tab (index 1 of the RiderWidget's tabs)
      await tester.tap(tabFinder.at(1));
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

      expect(find.byType(SafeArea), findsAtLeastNWidgets(1));
    });

    testWidgets('displays Column layout', (tester) async {
      await tester.pumpWidget(buildTestWidget(const RiderWidget()));
      await tester.pump();

      expect(find.byType(Column), findsAtLeastNWidgets(1));
    });
  });
}
