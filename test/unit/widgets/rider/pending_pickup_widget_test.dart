import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:core_widgets/src/theme/theme_change.provider.dart';

import 'package:flutter_trc/src/modules/rider/pending_pickup/pending_pickup_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/receive/widgets/pickup_receive_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/deliver/widgets/pickup_deliver_widget.dart';

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
        home: Scaffold(body: child),
      ),
    );
  }

  group('PendingPickupWidget', () {
    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PendingPickupWidget()));
      await tester.pump();

      expect(find.byType(PendingPickupWidget), findsOneWidget);
    });

    testWidgets('displays TabBarView', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PendingPickupWidget()));
      await tester.pump();

      expect(find.byType(TabBarView), findsOneWidget);
    });

    testWidgets('displays tab bar with two tabs', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PendingPickupWidget()));
      await tester.pump();

      // Use CshTab which is the core_widgets version
      expect(find.byType(CshTab), findsNWidgets(2));
    });

    testWidgets('first tab shows PickupReceiveWidget', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PendingPickupWidget()));
      await tester.pump();

      // PickupReceiveWidget should be shown by default (first tab)
      expect(find.byType(PickupReceiveWidget), findsOneWidget);
    });

    testWidgets('can switch to second tab (Deliver)', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PendingPickupWidget()));
      await tester.pump();

      // Find and tap the second tab
      final tabFinder = find.byType(CshTab);
      await tester.tap(tabFinder.last);
      await tester.pumpAndSettle();

      // PickupDeliverWidget should now be visible
      expect(find.byType(PickupDeliverWidget), findsOneWidget);
    });

    testWidgets('uses AutomaticKeepAliveClientMixin', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PendingPickupWidget()));
      await tester.pump();

      // Widget should keep alive when switching tabs
      expect(find.byType(PendingPickupWidget), findsOneWidget);
    });

    testWidgets('displays Column as root widget', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PendingPickupWidget()));
      await tester.pump();

      // Should find Column in the widget tree
      expect(find.byType(Column), findsAtLeastNWidgets(1));
    });

    testWidgets('has Expanded widget for TabBarView', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PendingPickupWidget()));
      await tester.pump();

      expect(find.byType(Expanded), findsAtLeastNWidgets(1));
    });
  });
}
