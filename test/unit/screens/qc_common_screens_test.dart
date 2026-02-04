import 'package:builder_project/builder_project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/qc_common/video_tester/video_tester_screen.dart';
import 'package:flutter_trc/qc/qc_common/lot_type_filters/screens/store_out_lot_filter_screen.dart';
import 'package:flutter_trc/qc/qc_common/lot_type_filters/models/lot_type_list_comp_params.dart';

void main() {
  group('VideoTesterScreen', () {
    test('can be instantiated', () {
      const screen = VideoTesterScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const key = Key('test');
      const screen = VideoTesterScreen(key: key);
      expect(screen.key, equals(key));
    });

    test('build method exists', () {
      const screen = VideoTesterScreen();
      expect(screen.build, isNotNull);
    });

    // Note: Widget tests for VideoTesterScreen are skipped because it uses
    // platform-specific APIs (CshVideoPicker uses native video picker
    // functionality that cannot be tested in unit tests without platform mocks)
  });

  group('StoreOutLotFilterScreen', () {
    test('has correct pageKey', () {
      expect(StoreOutLotFilterScreen.pageKey, 'QC_qc_store_out_lot_filter');
    });

    test('has correct route', () {
      expect(StoreOutLotFilterScreen.route, '/store-out-lot-filter');
    });

    test('can be instantiated', () {
      const screen = StoreOutLotFilterScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const key = Key('test');
      const screen = StoreOutLotFilterScreen(key: key);
      expect(screen.key, equals(key));
    });

    test('buildView method exists', () {
      const screen = StoreOutLotFilterScreen();
      expect(screen.buildView, isNotNull);
    });

    test('navigate static method exists', () {
      expect(StoreOutLotFilterScreen.navigate, isNotNull);
    });

    testWidgets('buildView returns PageWidget', (tester) async {
      Widget? builtWidget;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              const screen = StoreOutLotFilterScreen();
              builtWidget = screen.buildView(context);
              return const SizedBox();
            },
          ),
        ),
      );
      await tester.pump();
      expect(builtWidget, isA<PageWidget>());
    });

    testWidgets('PageWidget has correct pageKey', (tester) async {
      PageWidget? capturedWidget;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              const screen = StoreOutLotFilterScreen();
              final widget = screen.buildView(context);
              capturedWidget = widget is PageWidget ? widget : null;
              return const SizedBox();
            },
          ),
        ),
      );

      await tester.pump();
      expect(capturedWidget, isNotNull);
      expect(capturedWidget!.pageKey, equals(StoreOutLotFilterScreen.pageKey));
    });

    testWidgets('PageWidget has initialValue from arguments', (tester) async {
      PageWidget? capturedWidget;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              settings: RouteSettings(
                arguments: StoreOutLotFilterScreenArguments([1, 2, 3]),
              ),
              builder: (context) {
                const screen = StoreOutLotFilterScreen();
                final widget = screen.buildView(context);
                capturedWidget = widget is PageWidget ? widget : null;
                return const SizedBox();
              },
            );
          },
          initialRoute: '/',
        ),
      );

      await tester.pump();
      expect(capturedWidget, isNotNull);
      expect(capturedWidget!.initialValue, isNotNull);
      expect(capturedWidget!.initialValue![LotTypeListCompParamKeys.lotType.value], [1, 2, 3]);
    });

    testWidgets('PageWidget has no initialValue when no arguments', (tester) async {
      PageWidget? capturedWidget;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              const screen = StoreOutLotFilterScreen();
              final widget = screen.buildView(context);
              capturedWidget = widget is PageWidget ? widget : null;
              return const SizedBox();
            },
          ),
        ),
      );

      await tester.pump();
      expect(capturedWidget, isNotNull);
      expect(capturedWidget!.initialValue, isNull);
    });
  });

  group('StoreOutLotFilterScreenArguments', () {
    test('creates arguments with selectedLotType', () {
      final args = StoreOutLotFilterScreenArguments([1, 2, 3]);
      expect(args.selectedLotType, [1, 2, 3]);
      expect(args.header, 'Lot Type');
    });

    test('creates arguments with null selectedLotType', () {
      final args = StoreOutLotFilterScreenArguments(null);
      expect(args.selectedLotType, isNull);
      expect(args.header, 'Lot Type');
    });

    test('creates arguments with custom header', () {
      final args = StoreOutLotFilterScreenArguments([5, 6], header: 'Custom Header');
      expect(args.selectedLotType, [5, 6]);
      expect(args.header, 'Custom Header');
    });

    test('creates arguments with empty list', () {
      final args = StoreOutLotFilterScreenArguments([]);
      expect(args.selectedLotType, isEmpty);
      expect(args.header, 'Lot Type');
    });

    test('toJson returns correct map with selectedLotType', () {
      final args = StoreOutLotFilterScreenArguments([10, 20, 30]);
      final json = args.toJson();
      expect(json, isNotNull);
      expect(json![LotTypeListCompParamKeys.lotType.value], [10, 20, 30]);
      expect(json[LotTypeListCompParamKeys.header.value], 'Lot Type');
    });

    test('toJson returns correct map with null selectedLotType', () {
      final args = StoreOutLotFilterScreenArguments(null);
      final json = args.toJson();
      expect(json, isNotNull);
      expect(json![LotTypeListCompParamKeys.lotType.value], isNull);
      expect(json[LotTypeListCompParamKeys.header.value], 'Lot Type');
    });

    test('toJson returns correct map with custom header', () {
      final args = StoreOutLotFilterScreenArguments([1], header: 'My Custom Header');
      final json = args.toJson();
      expect(json, isNotNull);
      expect(json![LotTypeListCompParamKeys.lotType.value], [1]);
      expect(json[LotTypeListCompParamKeys.header.value], 'My Custom Header');
    });

    test('toJson returns map with two keys', () {
      final args = StoreOutLotFilterScreenArguments([1, 2, 3]);
      final json = args.toJson();
      expect(json, isNotNull);
      expect(json!.length, 2);
      expect(json.containsKey(LotTypeListCompParamKeys.lotType.value), isTrue);
      expect(json.containsKey(LotTypeListCompParamKeys.header.value), isTrue);
    });

    test('multiple args instances are independent', () {
      final args1 = StoreOutLotFilterScreenArguments([1, 2]);
      final args2 = StoreOutLotFilterScreenArguments([3, 4]);
      expect(args1.selectedLotType, isNot(args2.selectedLotType));
      expect(args1.selectedLotType, [1, 2]);
      expect(args2.selectedLotType, [3, 4]);
    });

    test('arguments have correct pageKey', () {
      final args = StoreOutLotFilterScreenArguments([1]);
      expect(args.pageKey, StoreOutLotFilterScreen.pageKey);
    });
  });

  group('StoreOutLotFilterScreen.navigate', () {
    testWidgets('navigates with selectedLotType', (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == StoreOutLotFilterScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Store Out Lot Filter')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      StoreOutLotFilterScreen.navigate(context, selectedLotType: [1, 2, 3]);
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

      expect(pushedRoute, StoreOutLotFilterScreen.route);
      expect(pushedArguments, isA<StoreOutLotFilterScreenArguments>());
      final args = pushedArguments as StoreOutLotFilterScreenArguments;
      expect(args.selectedLotType, [1, 2, 3]);
      expect(args.header, 'Lot Type');
    });

    testWidgets('navigates with null selectedLotType', (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == StoreOutLotFilterScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Store Out Lot Filter')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      StoreOutLotFilterScreen.navigate(context, selectedLotType: null);
                    },
                    child: const Text('Navigate Null'),
                  ),
                ),
              ),
            );
          },
        ),
      );

      await tester.tap(find.text('Navigate Null'));
      await tester.pumpAndSettle();

      expect(pushedRoute, StoreOutLotFilterScreen.route);
      expect(pushedArguments, isA<StoreOutLotFilterScreenArguments>());
      final args = pushedArguments as StoreOutLotFilterScreenArguments;
      expect(args.selectedLotType, isNull);
      expect(args.header, 'Lot Type');
    });

    testWidgets('navigates with empty list', (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == StoreOutLotFilterScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Store Out Lot Filter')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      StoreOutLotFilterScreen.navigate(context, selectedLotType: []);
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

      expect(pushedRoute, StoreOutLotFilterScreen.route);
      expect(pushedArguments, isA<StoreOutLotFilterScreenArguments>());
      final args = pushedArguments as StoreOutLotFilterScreenArguments;
      expect(args.selectedLotType, isEmpty);
    });
  });

  group('LotTypeListCompParamKeys', () {
    test('header has correct value', () {
      expect(LotTypeListCompParamKeys.header.value, 'h');
    });

    test('lotType has correct value', () {
      expect(LotTypeListCompParamKeys.lotType.value, 'lt');
    });

    test('contains all expected keys', () {
      expect(LotTypeListCompParamKeys.values.length, 2);
      expect(LotTypeListCompParamKeys.values, contains(LotTypeListCompParamKeys.header));
      expect(LotTypeListCompParamKeys.values, contains(LotTypeListCompParamKeys.lotType));
    });
  });
}
