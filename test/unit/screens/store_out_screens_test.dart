import 'package:builder_project/builder_project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_out/screens/store_out_screen.dart';
import 'package:flutter_trc/qc/modules/store_out/screens/lot_items_scan_screen.dart';
import 'package:flutter_trc/qc/modules/store_out/models/index.dart';

void main() {
  group('StoreOutScreen', () {
    test('has correct pageKey', () {
      expect(StoreOutScreen.pageKey, 'QC_qc_store_out');
    });

    test('has correct route', () {
      expect(StoreOutScreen.route, '/qc-store-out');
    });

    test('can be instantiated', () {
      const screen = StoreOutScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const key = Key('test');
      const screen = StoreOutScreen(key: key);
      expect(screen.key, equals(key));
    });

    test('buildView method exists', () {
      const screen = StoreOutScreen();
      expect(screen.buildView, isNotNull);
    });

    testWidgets('buildView returns PageWidget', (tester) async {
      Widget? builtWidget;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          const screen = StoreOutScreen();
          builtWidget = screen.buildView(context);
          return const SizedBox();
        }),
      ));
      await tester.pump();
      expect(builtWidget, isA<PageWidget>());
    });
  });

  group('LotItemsScanScreen', () {
    test('has correct pageKey', () {
      expect(LotItemsScanScreen.pageKey, 'QC_qc_lot_items_scan');
    });

    test('has correct route', () {
      expect(LotItemsScanScreen.route, '/lot-items-scan');
    });

    test('can be instantiated', () {
      const screen = LotItemsScanScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const key = Key('lot_items_test');
      const screen = LotItemsScanScreen(key: key);
      expect(screen.key, equals(key));
    });

    test('buildView method exists', () {
      const screen = LotItemsScanScreen();
      expect(screen.buildView, isNotNull);
    });

    test('navigate static method exists', () {
      expect(LotItemsScanScreen.navigate, isNotNull);
    });

    testWidgets('buildView returns PageWidget', (tester) async {
      Widget? builtWidget;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          const screen = LotItemsScanScreen();
          builtWidget = screen.buildView(context);
          return const SizedBox();
        }),
      ));
      await tester.pump();
      expect(builtWidget, isA<PageWidget>());
    });
  });

  group('LotItemsScanScreenArgs', () {
    test('creates arguments with all fields', () {
      final args = LotItemsScanScreenArgs(
        LotItemsScanScreen.pageKey,
        lotType: 1,
        lotName: 'TEST_LOT',
        lotId: 123,
      );
      expect(args.lotType, 1);
      expect(args.lotName, 'TEST_LOT');
      expect(args.lotId, 123);
    });

    test('creates arguments with pageKey', () {
      final args = LotItemsScanScreenArgs(LotItemsScanScreen.pageKey);
      expect(args, isNotNull);
    });

    test('creates arguments with null lotType', () {
      final args = LotItemsScanScreenArgs(
        LotItemsScanScreen.pageKey,
        lotName: 'LOT_NAME',
        lotId: 456,
      );
      expect(args.lotType, isNull);
      expect(args.lotName, 'LOT_NAME');
      expect(args.lotId, 456);
    });

    test('creates arguments with null lotName', () {
      final args = LotItemsScanScreenArgs(
        LotItemsScanScreen.pageKey,
        lotType: 2,
        lotId: 789,
      );
      expect(args.lotType, 2);
      expect(args.lotName, isNull);
      expect(args.lotId, 789);
    });

    test('creates arguments with null lotId', () {
      final args = LotItemsScanScreenArgs(
        LotItemsScanScreen.pageKey,
        lotType: 3,
        lotName: 'ANOTHER_LOT',
      );
      expect(args.lotType, 3);
      expect(args.lotName, 'ANOTHER_LOT');
      expect(args.lotId, isNull);
    });

    test('creates arguments with all nulls', () {
      final args = LotItemsScanScreenArgs(LotItemsScanScreen.pageKey);
      expect(args.lotType, isNull);
      expect(args.lotName, isNull);
      expect(args.lotId, isNull);
    });

    test('multiple args instances are independent', () {
      final args1 = LotItemsScanScreenArgs(
        LotItemsScanScreen.pageKey,
        lotType: 1,
        lotName: 'LOT_1',
        lotId: 100,
      );
      final args2 = LotItemsScanScreenArgs(
        LotItemsScanScreen.pageKey,
        lotType: 2,
        lotName: 'LOT_2',
        lotId: 200,
      );
      expect(args1.lotType, isNot(args2.lotType));
      expect(args1.lotName, isNot(args2.lotName));
      expect(args1.lotId, isNot(args2.lotId));
    });
  });

  group('LotItemsScanCompParamKeys', () {
    test('header has correct value', () {
      expect(LotItemsScanCompParamKeys.header.value, 'h');
    });

    test('lotName has correct value', () {
      expect(LotItemsScanCompParamKeys.lotName.value, 'ln');
    });

    test('lotId has correct value', () {
      expect(LotItemsScanCompParamKeys.lotId.value, 'lid');
    });

    test('lotType has correct value', () {
      expect(LotItemsScanCompParamKeys.lotType.value, 'lt');
    });

    test('contains all expected keys', () {
      expect(LotItemsScanCompParamKeys.values.length, 4);
      expect(LotItemsScanCompParamKeys.values, contains(LotItemsScanCompParamKeys.header));
      expect(LotItemsScanCompParamKeys.values, contains(LotItemsScanCompParamKeys.lotName));
      expect(LotItemsScanCompParamKeys.values, contains(LotItemsScanCompParamKeys.lotId));
      expect(LotItemsScanCompParamKeys.values, contains(LotItemsScanCompParamKeys.lotType));
    });
  });

  group('LotItemsScanScreen.navigate', () {
    testWidgets('navigates with all arguments', (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == LotItemsScanScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Lot Items Scan')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      LotItemsScanScreen.navigate(
                        context,
                        lotType: 1,
                        lotName: 'NAV_LOT',
                        lotId: 999,
                      );
                    },
                    child: const Text('Navigate'),
                  ),
                ),
              ),
            );
          },
        ),
      );

      await tester.tap(find.text('Navigate'));
      await tester.pumpAndSettle();

      expect(pushedRoute, LotItemsScanScreen.route);
      expect(pushedArguments, isA<LotItemsScanScreenArgs>());
      final args = pushedArguments as LotItemsScanScreenArgs;
      expect(args.lotType, 1);
      expect(args.lotName, 'NAV_LOT');
      expect(args.lotId, 999);
    });

    testWidgets('navigates with partial arguments', (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == LotItemsScanScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Lot Items Scan')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      LotItemsScanScreen.navigate(
                        context,
                        lotName: 'PARTIAL_LOT',
                      );
                    },
                    child: const Text('Navigate Partial'),
                  ),
                ),
              ),
            );
          },
        ),
      );

      await tester.tap(find.text('Navigate Partial'));
      await tester.pumpAndSettle();

      expect(pushedRoute, LotItemsScanScreen.route);
      expect(pushedArguments, isA<LotItemsScanScreenArgs>());
      final args = pushedArguments as LotItemsScanScreenArgs;
      expect(args.lotType, isNull);
      expect(args.lotName, 'PARTIAL_LOT');
      expect(args.lotId, isNull);
    });

    testWidgets('navigates with no arguments', (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == LotItemsScanScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Lot Items Scan')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      LotItemsScanScreen.navigate(context);
                    },
                    child: const Text('Navigate Empty'),
                  ),
                ),
              ),
            );
          },
        ),
      );

      await tester.tap(find.text('Navigate Empty'));
      await tester.pumpAndSettle();

      expect(pushedRoute, LotItemsScanScreen.route);
      expect(pushedArguments, isA<LotItemsScanScreenArgs>());
      final args = pushedArguments as LotItemsScanScreenArgs;
      expect(args.lotType, isNull);
      expect(args.lotName, isNull);
      expect(args.lotId, isNull);
    });
  });

  group('StoreOutScreen navigation', () {
    testWidgets('can navigate to StoreOutScreen', (WidgetTester tester) async {
      String? pushedRoute;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == StoreOutScreen.route) {
              pushedRoute = settings.name;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Store Out')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, StoreOutScreen.route);
                    },
                    child: const Text('Go to Store Out'),
                  ),
                ),
              ),
            );
          },
        ),
      );

      await tester.tap(find.text('Go to Store Out'));
      await tester.pumpAndSettle();

      expect(pushedRoute, StoreOutScreen.route);
    });
  });
}
