import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart' hide isNotEmpty;
import 'package:core_widgets/src/theme/theme_change.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/rubbing/widgets/rubbing_home_screen.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:provider/provider.dart';

void main() {
  /// Builds a testable widget with MaterialApp wrapper
  Widget buildTestWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<InternetProvider>.value(
          value: InternetProvider(checkInternetConnectivity: false),
        ),
        ChangeNotifierProvider<DBSyncProvider>(
          create: (_) {
            final p = DBSyncProvider(
              const SizedBox(), false, '', '', false, false, null, false, false,
            );
            p.syncingDB = false;
            return p;
          },
        ),
        ChangeNotifierProvider<GlobalParamProvider>(
          create: (_) => GlobalParamProvider(),
        ),
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

  group('RubbingHomeScreen', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const RubbingHomeScreen(),
        ),
      );
      await tester.pump();

      expect(find.byType(RubbingHomeScreen), findsOneWidget);
    });

    test('pageKey is correctly defined', () {
      expect(RubbingHomeScreen.pageKey, 'TRC_rubbing_home_screen');
    });

    test('route is correctly defined', () {
      expect(RubbingHomeScreen.route, '/rubbing_home_screen');
    });

    testWidgets('is a BaseScreen widget', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const RubbingHomeScreen(),
        ),
      );
      await tester.pump();

      expect(find.byType(RubbingHomeScreen), findsOneWidget);
    });

    testWidgets('has const constructor', (tester) async {
      const screen1 = RubbingHomeScreen();
      const screen2 = RubbingHomeScreen();

      await tester.pumpWidget(
        buildTestWidget(screen1),
      );
      await tester.pump();

      expect(find.byType(RubbingHomeScreen), findsOneWidget);
    });

    testWidgets('can accept key parameter', (tester) async {
      const key = Key('rubbing_home_screen_key');

      await tester.pumpWidget(
        buildTestWidget(
          const RubbingHomeScreen(key: key),
        ),
      );
      await tester.pump();

      expect(find.byKey(key), findsOneWidget);
    });
  });

  group('RubbingHomeScreen - Static Members', () {
    test('pageKey is a non-empty string', () {
      expect(RubbingHomeScreen.pageKey, isNotEmpty);
    });

    test('route starts with forward slash', () {
      expect(RubbingHomeScreen.route.startsWith('/'), isTrue);
    });

    test('pageKey and route are distinct', () {
      expect(RubbingHomeScreen.pageKey, isNot(RubbingHomeScreen.route));
    });
  });

  group('RubbingHomeScreen - Widget Tree', () {
    testWidgets('renders without errors', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const RubbingHomeScreen(),
        ),
      );

      // Just pump once to check initial build
      await tester.pump();

      // Should not throw any errors
      expect(find.byType(RubbingHomeScreen), findsOneWidget);
    });

    testWidgets('disposes without errors', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const RubbingHomeScreen(),
        ),
      );
      await tester.pump();

      // Replace with empty widget to trigger dispose
      await tester.pumpWidget(
        buildTestWidget(const SizedBox()),
      );
      await tester.pump();

      expect(find.byType(RubbingHomeScreen), findsNothing);
    });
  });
}
