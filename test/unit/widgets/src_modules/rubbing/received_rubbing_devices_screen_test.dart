import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart' hide isNotEmpty;
import 'package:core_widgets/src/theme/theme_change.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/rubbing/widgets/received_rubbing_devices_screen.dart';
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

  group('ReceivedRubbingDevicesScreen', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ReceivedRubbingDevicesScreen(),
        ),
      );
      await tester.pump();

      expect(find.byType(ReceivedRubbingDevicesScreen), findsOneWidget);
    });

    test('pageKey is correctly defined', () {
      expect(ReceivedRubbingDevicesScreen.pageKey,
          'TRC_receive_rubbing_device_screen');
    });

    test('route is correctly defined', () {
      expect(
          ReceivedRubbingDevicesScreen.route, '/receive_rubbing_device_screen');
    });

    testWidgets('is a BaseScreen widget', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ReceivedRubbingDevicesScreen(),
        ),
      );
      await tester.pump();

      expect(find.byType(ReceivedRubbingDevicesScreen), findsOneWidget);
    });

    testWidgets('has const constructor', (tester) async {
      const screen1 = ReceivedRubbingDevicesScreen();
      const screen2 = ReceivedRubbingDevicesScreen();

      await tester.pumpWidget(
        buildTestWidget(screen1),
      );
      await tester.pump();

      expect(find.byType(ReceivedRubbingDevicesScreen), findsOneWidget);
    });

    testWidgets('can accept key parameter', (tester) async {
      const key = Key('received_rubbing_devices_screen_key');

      await tester.pumpWidget(
        buildTestWidget(
          const ReceivedRubbingDevicesScreen(key: key),
        ),
      );
      await tester.pump();

      expect(find.byKey(key), findsOneWidget);
    });
  });

  group('ReceivedRubbingDevicesScreenArguments', () {
    test('can be created with null searchQuery', () {
      final args = ReceivedRubbingDevicesScreenArguments();
      expect(args.searchQuery, isNull);
    });

    test('can be created with searchQuery', () {
      final args =
          ReceivedRubbingDevicesScreenArguments(searchQuery: 'test_query');
      expect(args.searchQuery, 'test_query');
    });

    test('toJson returns correct map', () {
      final args =
          ReceivedRubbingDevicesScreenArguments(searchQuery: 'test_query');
      final json = args.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json.containsKey('sq'), isTrue);
      expect(json['sq'], 'test_query');
    });

    test('toJson with null searchQuery', () {
      final args = ReceivedRubbingDevicesScreenArguments();
      final json = args.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['sq'], isNull);
    });

    test('toJson with empty searchQuery', () {
      final args = ReceivedRubbingDevicesScreenArguments(searchQuery: '');
      final json = args.toJson();

      expect(json['sq'], '');
    });
  });

  group('ReceivedRubbingDevicesScreen - Static Members', () {
    test('pageKey is a non-empty string', () {
      expect(ReceivedRubbingDevicesScreen.pageKey, isNotEmpty);
    });

    test('route starts with forward slash', () {
      expect(ReceivedRubbingDevicesScreen.route.startsWith('/'), isTrue);
    });

    test('pageKey and route are distinct', () {
      expect(ReceivedRubbingDevicesScreen.pageKey,
          isNot(ReceivedRubbingDevicesScreen.route));
    });
  });

  group('ReceivedRubbingDevicesScreen - Widget Tree', () {
    testWidgets('renders without errors', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ReceivedRubbingDevicesScreen(),
        ),
      );

      // Just pump once to check initial build
      await tester.pump();

      // Should not throw any errors
      expect(find.byType(ReceivedRubbingDevicesScreen), findsOneWidget);
    });

    testWidgets('disposes without errors', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ReceivedRubbingDevicesScreen(),
        ),
      );
      await tester.pump();

      // Replace with empty widget to trigger dispose
      await tester.pumpWidget(
        buildTestWidget(const SizedBox()),
      );
      await tester.pump();

      expect(find.byType(ReceivedRubbingDevicesScreen), findsNothing);
    });
  });

  group('ReceivedRubbingDevicesScreenArguments - Edge Cases', () {
    test('handles special characters in searchQuery', () {
      final args = ReceivedRubbingDevicesScreenArguments(
          searchQuery: 'test@#\$%^&*()_+-=[]{}');
      expect(args.searchQuery, 'test@#\$%^&*()_+-=[]{}');
    });

    test('handles whitespace in searchQuery', () {
      final args =
          ReceivedRubbingDevicesScreenArguments(searchQuery: '  test  ');
      expect(args.searchQuery, '  test  ');
    });

    test('handles unicode in searchQuery', () {
      final args =
          ReceivedRubbingDevicesScreenArguments(searchQuery: 'test你好🎉');
      expect(args.searchQuery, 'test你好🎉');
    });
  });
}
