import 'package:builder_project/builder_project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/pre_dispatch/screens/pre_dispatch_screen.dart';
import 'package:flutter_trc/qc/modules/pre_dispatch/screens/pre_dispatch_lot_screen.dart';
import 'package:flutter_trc/qc/modules/pre_dispatch/models/index.dart';

void main() {
  group('PreDispatchScreen', () {
    test('has correct pageKey', () {
      expect(PreDispatchScreen.pageKey, 'QC_qc_pre_dispatch');
    });

    test('has correct route', () {
      expect(PreDispatchScreen.route, '/pre-dispatch');
    });

    test('can be instantiated', () {
      const screen = PreDispatchScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const key = Key('test');
      const screen = PreDispatchScreen(key: key);
      expect(screen.key, equals(key));
    });

    test('buildView method exists', () {
      const screen = PreDispatchScreen();
      expect(screen.buildView, isNotNull);
    });

    test('navigate static method exists', () {
      expect(PreDispatchScreen.navigate, isNotNull);
    });

    testWidgets('buildView returns PageWidget', (tester) async {
      Widget? builtWidget;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          const screen = PreDispatchScreen();
          builtWidget = screen.buildView(context);
          return const SizedBox();
        }),
      ));
      await tester.pump();
      expect(builtWidget, isA<PageWidget>());
    });
  });

  group('PreDispatchScreenArgs', () {
    test('creates arguments with all fields', () {
      bool callbackCalled = false;
      final args = PreDispatchScreenArgs(
        PreDispatchScreen.pageKey,
        'LOT_GROUP_123',
        456,
        () => callbackCalled = true,
      );
      expect(args.lotGroupName, 'LOT_GROUP_123');
      expect(args.lotId, 456);
      expect(args.allScanDoneCallback, isNotNull);
      args.allScanDoneCallback!();
      expect(callbackCalled, isTrue);
    });

    test('creates arguments with null lotGroupName', () {
      final args = PreDispatchScreenArgs(
        PreDispatchScreen.pageKey,
        null,
        789,
        null,
      );
      expect(args.lotGroupName, isNull);
      expect(args.lotId, 789);
    });

    test('creates arguments with null lotId', () {
      final args = PreDispatchScreenArgs(
        PreDispatchScreen.pageKey,
        'LOT_GROUP',
        null,
        null,
      );
      expect(args.lotGroupName, 'LOT_GROUP');
      expect(args.lotId, isNull);
    });

    test('creates arguments with null callback', () {
      final args = PreDispatchScreenArgs(
        PreDispatchScreen.pageKey,
        'LOT_GROUP',
        123,
        null,
      );
      expect(args.allScanDoneCallback, isNull);
    });

    test('creates arguments with all nulls', () {
      final args = PreDispatchScreenArgs(
        PreDispatchScreen.pageKey,
        null,
        null,
        null,
      );
      expect(args.lotGroupName, isNull);
      expect(args.lotId, isNull);
      expect(args.allScanDoneCallback, isNull);
    });

    test('toJson returns correct map with lotGroupName', () {
      final args = PreDispatchScreenArgs(
        PreDispatchScreen.pageKey,
        'JSON_LOT_GROUP',
        100,
        null,
      );
      final json = args.toJson();
      expect(json[PreDispatchCompParamKeys.lotGroupName.value], 'JSON_LOT_GROUP');
    });

    test('toJson returns correct map with lotId', () {
      final args = PreDispatchScreenArgs(
        PreDispatchScreen.pageKey,
        'TEST',
        200,
        null,
      );
      final json = args.toJson();
      expect(json[PreDispatchCompParamKeys.lotId.value], 200);
    });

    test('toJson returns correct map with callback', () {
      bool called = false;
      final callback = () => called = true;
      final args = PreDispatchScreenArgs(
        PreDispatchScreen.pageKey,
        'TEST',
        300,
        callback,
      );
      final json = args.toJson();
      expect(json[PreDispatchCompParamKeys.allScanDoneCallback.value], isNotNull);
      final retrievedCallback = json[PreDispatchCompParamKeys.allScanDoneCallback.value] as VoidCallback;
      retrievedCallback();
      expect(called, isTrue);
    });

    test('toJson returns map with three keys', () {
      final args = PreDispatchScreenArgs(
        PreDispatchScreen.pageKey,
        'LOT',
        400,
        () {},
      );
      final json = args.toJson();
      expect(json.length, 3);
      expect(json.containsKey(PreDispatchCompParamKeys.lotGroupName.value), isTrue);
      expect(json.containsKey(PreDispatchCompParamKeys.lotId.value), isTrue);
      expect(json.containsKey(PreDispatchCompParamKeys.allScanDoneCallback.value), isTrue);
    });

    test('multiple args instances are independent', () {
      final args1 = PreDispatchScreenArgs(
        PreDispatchScreen.pageKey,
        'LOT_1',
        100,
        null,
      );
      final args2 = PreDispatchScreenArgs(
        PreDispatchScreen.pageKey,
        'LOT_2',
        200,
        null,
      );
      expect(args1.lotGroupName, isNot(args2.lotGroupName));
      expect(args1.lotId, isNot(args2.lotId));
    });
  });

  group('PreDispatchCompParamKeys', () {
    test('lotGroupName has correct value', () {
      expect(PreDispatchCompParamKeys.lotGroupName.value, 'lgn');
    });

    test('lotId has correct value', () {
      expect(PreDispatchCompParamKeys.lotId.value, 'lid');
    });

    test('allScanDoneCallback has correct value', () {
      expect(PreDispatchCompParamKeys.allScanDoneCallback.value, 'allScanDoneCallback');
    });

    test('contains all expected keys', () {
      expect(PreDispatchCompParamKeys.values.length, 3);
      expect(PreDispatchCompParamKeys.values, contains(PreDispatchCompParamKeys.lotGroupName));
      expect(PreDispatchCompParamKeys.values, contains(PreDispatchCompParamKeys.lotId));
      expect(PreDispatchCompParamKeys.values, contains(PreDispatchCompParamKeys.allScanDoneCallback));
    });
  });

  group('PreDispatchLotScreen', () {
    test('has correct pageKey', () {
      expect(PreDispatchLotScreen.pageKey, 'QC_qc_pre_dispatch_lot');
    });

    test('has correct route', () {
      expect(PreDispatchLotScreen.route, '/pre-dispatch-lot');
    });

    test('can be instantiated', () {
      const screen = PreDispatchLotScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const key = Key('lot_test');
      const screen = PreDispatchLotScreen(key: key);
      expect(screen.key, equals(key));
    });

    test('buildView method exists', () {
      const screen = PreDispatchLotScreen();
      expect(screen.buildView, isNotNull);
    });

    testWidgets('buildView returns PageWidget', (tester) async {
      Widget? builtWidget;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          const screen = PreDispatchLotScreen();
          builtWidget = screen.buildView(context);
          return const SizedBox();
        }),
      ));
      await tester.pump();
      expect(builtWidget, isA<PageWidget>());
    });

    testWidgets('buildView returns const PageWidget', (tester) async {
      Widget? builtWidget;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          const screen = PreDispatchLotScreen();
          builtWidget = screen.buildView(context);
          return const SizedBox();
        }),
      ));
      await tester.pump();
      final pageWidget = builtWidget as PageWidget;
      expect(pageWidget.pageKey, PreDispatchLotScreen.pageKey);
    });
  });

  group('PreDispatchScreen.navigate', () {
    testWidgets('navigates with all arguments', (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;
      bool callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == PreDispatchScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Pre Dispatch')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      PreDispatchScreen.navigate(
                        context,
                        'NAV_LOT_GROUP',
                        999,
                        () => callbackCalled = true,
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

      expect(pushedRoute, PreDispatchScreen.route);
      expect(pushedArguments, isA<PreDispatchScreenArgs>());
      final args = pushedArguments as PreDispatchScreenArgs;
      expect(args.lotGroupName, 'NAV_LOT_GROUP');
      expect(args.lotId, 999);
      expect(args.allScanDoneCallback, isNotNull);
      args.allScanDoneCallback!();
      expect(callbackCalled, isTrue);
    });

    testWidgets('navigates with null lotGroupName', (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == PreDispatchScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Pre Dispatch')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      PreDispatchScreen.navigate(
                        context,
                        null,
                        888,
                        null,
                      );
                    },
                    child: const Text('Navigate Null Name'),
                  ),
                ),
              ),
            );
          },
        ),
      );

      await tester.tap(find.text('Navigate Null Name'));
      await tester.pumpAndSettle();

      expect(pushedRoute, PreDispatchScreen.route);
      expect(pushedArguments, isA<PreDispatchScreenArgs>());
      final args = pushedArguments as PreDispatchScreenArgs;
      expect(args.lotGroupName, isNull);
      expect(args.lotId, 888);
    });

    testWidgets('navigates with null lotId', (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == PreDispatchScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Pre Dispatch')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      PreDispatchScreen.navigate(
                        context,
                        'LOT_GROUP_ONLY',
                        null,
                        null,
                      );
                    },
                    child: const Text('Navigate Null Id'),
                  ),
                ),
              ),
            );
          },
        ),
      );

      await tester.tap(find.text('Navigate Null Id'));
      await tester.pumpAndSettle();

      expect(pushedRoute, PreDispatchScreen.route);
      expect(pushedArguments, isA<PreDispatchScreenArgs>());
      final args = pushedArguments as PreDispatchScreenArgs;
      expect(args.lotGroupName, 'LOT_GROUP_ONLY');
      expect(args.lotId, isNull);
    });

    testWidgets('navigates with all nulls', (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == PreDispatchScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Pre Dispatch')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      PreDispatchScreen.navigate(
                        context,
                        null,
                        null,
                        null,
                      );
                    },
                    child: const Text('Navigate All Null'),
                  ),
                ),
              ),
            );
          },
        ),
      );

      await tester.tap(find.text('Navigate All Null'));
      await tester.pumpAndSettle();

      expect(pushedRoute, PreDispatchScreen.route);
      expect(pushedArguments, isA<PreDispatchScreenArgs>());
      final args = pushedArguments as PreDispatchScreenArgs;
      expect(args.lotGroupName, isNull);
      expect(args.lotId, isNull);
      expect(args.allScanDoneCallback, isNull);
    });
  });

  group('PreDispatchLotScreen navigation', () {
    testWidgets('can navigate to PreDispatchLotScreen', (WidgetTester tester) async {
      String? pushedRoute;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == PreDispatchLotScreen.route) {
              pushedRoute = settings.name;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Pre Dispatch Lot')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, PreDispatchLotScreen.route);
                    },
                    child: const Text('Go to Pre Dispatch Lot'),
                  ),
                ),
              ),
            );
          },
        ),
      );

      await tester.tap(find.text('Go to Pre Dispatch Lot'));
      await tester.pumpAndSettle();

      expect(pushedRoute, PreDispatchLotScreen.route);
    });
  });

  group('PreDispatchCompParam', () {
    test('can be created with all fields', () {
      final param = PreDispatchCompParam(
        lotGroupName: 'TEST_GROUP',
        lotId: 123,
        allScanDoneCallback: () {},
      );
      expect(param.lotGroupName, 'TEST_GROUP');
      expect(param.lotId, 123);
      expect(param.allScanDoneCallback, isNotNull);
    });

    test('can be created with null fields', () {
      final param = PreDispatchCompParam();
      expect(param.lotGroupName, isNull);
      expect(param.lotId, isNull);
      expect(param.allScanDoneCallback, isNull);
    });

    test('can be created with partial fields', () {
      final param = PreDispatchCompParam(
        lotGroupName: 'PARTIAL_GROUP',
      );
      expect(param.lotGroupName, 'PARTIAL_GROUP');
      expect(param.lotId, isNull);
      expect(param.allScanDoneCallback, isNull);
    });
  });
}
