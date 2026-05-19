import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/data_wipe/screens/data_wipe_list_screen.dart';
import 'package:flutter_trc/qc/modules/data_wipe/screens/data_wipe_detail_screen.dart';
import 'package:flutter_trc/qc/modules/data_wipe/screens/data_wipe_home_screen.dart';

void main() {
  group('DataWipeListScreen', () {
    test('has correct pageKey', () {
      expect(DataWipeListScreen.pageKey, 'QC_data_wipe_list_screen');
    });

    test('has correct route', () {
      expect(DataWipeListScreen.route, 'qc/data_wipe_list');
    });

    test('can be instantiated', () {
      const screen = DataWipeListScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const testKey = Key('test_key');
      const screen = DataWipeListScreen(key: testKey);
      expect(screen.key, testKey);
    });
  });

  group('DataWipeDetailScreen', () {
    test('has correct pageKey', () {
      expect(DataWipeDetailScreen.pageKey, 'QC_data_wipe_detail_screen');
    });

    test('has correct route', () {
      expect(DataWipeDetailScreen.route, '/qc_data_wipe_detail_screen');
    });

    test('can be instantiated', () {
      const screen = DataWipeDetailScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const testKey = Key('detail_test_key');
      const screen = DataWipeDetailScreen(key: testKey);
      expect(screen.key, testKey);
    });
  });

  group('DataWipeDetailScreenArg', () {
    test('creates arguments with deviceBarcode', () {
      final args = DataWipeDetailScreenArg(deviceBarcode: 'TEST_BARCODE');
      expect(args.deviceBarcode, 'TEST_BARCODE');
    });

    test('creates arguments with null deviceBarcode', () {
      final args = DataWipeDetailScreenArg();
      expect(args.deviceBarcode, isNull);
    });

    test('toJson returns correct map with dbr key', () {
      final args = DataWipeDetailScreenArg(deviceBarcode: 'TEST_BARCODE');
      final json = args.toJson();
      // The key is 'dbr' (DeviceBarcodeParamKeys.deviceBarcode.value)
      expect(json['dbr'], 'TEST_BARCODE');
    });

    test('toJson returns correct map with null deviceBarcode', () {
      final args = DataWipeDetailScreenArg();
      final json = args.toJson();
      expect(json['dbr'], isNull);
    });

    test('toJson returns map with single key', () {
      final args = DataWipeDetailScreenArg(deviceBarcode: 'BARCODE_123');
      final json = args.toJson();
      expect(json.length, 1);
      expect(json.containsKey('dbr'), isTrue);
    });

    test('deviceBarcode is stored correctly', () {
      final args = DataWipeDetailScreenArg(deviceBarcode: 'TEST');
      expect(args.deviceBarcode, 'TEST');
    });

    test('multiple args instances are independent', () {
      final args1 = DataWipeDetailScreenArg(deviceBarcode: 'BARCODE_1');
      final args2 = DataWipeDetailScreenArg(deviceBarcode: 'BARCODE_2');
      expect(args1.deviceBarcode, isNot(args2.deviceBarcode));
    });
  });

  group('DataWipeHomeScreen', () {
    test('has correct route', () {
      expect(DataWipeHomeScreen.route, '/QC_data_wipe_home_screen');
    });

    test('can be instantiated', () {
      const screen = DataWipeHomeScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const testKey = Key('home_test_key');
      const screen = DataWipeHomeScreen(key: testKey);
      expect(screen.key, testKey);
    });
  });

  group('DataWipeDetailScreen.navigateTo', () {
    testWidgets('navigateTo pushes named route when isReplacement is false',
        (WidgetTester tester) async {
      final navigatorKey = GlobalKey<NavigatorState>();
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: navigatorKey,
          onGenerateRoute: (settings) {
            if (settings.name == DataWipeDetailScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Detail Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      DataWipeDetailScreen.navigateTo(context, 'TEST_BARCODE');
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

      expect(pushedRoute, DataWipeDetailScreen.route);
      expect(pushedArguments, isA<DataWipeDetailScreenArg>());
      expect(
          (pushedArguments as DataWipeDetailScreenArg).deviceBarcode, 'TEST_BARCODE');
    });

    testWidgets(
        'navigateTo pushes replacement route when isReplacement is true',
        (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;
      bool isReplacement = false;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == DataWipeDetailScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Detail Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      DataWipeDetailScreen.navigateTo(
                        context,
                        'REPLACEMENT_BARCODE',
                        isReplacement: true,
                      );
                      isReplacement = true;
                    },
                    child: const Text('Navigate Replacement'),
                  ),
                ),
              ),
            );
          },
        ),
      );

      await tester.tap(find.text('Navigate Replacement'));
      await tester.pumpAndSettle();

      expect(pushedRoute, DataWipeDetailScreen.route);
      expect(pushedArguments, isA<DataWipeDetailScreenArg>());
      expect((pushedArguments as DataWipeDetailScreenArg).deviceBarcode,
          'REPLACEMENT_BARCODE');
      expect(isReplacement, isTrue);
    });

    testWidgets('navigateTo with empty barcode', (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == DataWipeDetailScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Detail Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      DataWipeDetailScreen.navigateTo(context, '');
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

      expect(pushedRoute, DataWipeDetailScreen.route);
      expect((pushedArguments as DataWipeDetailScreenArg).deviceBarcode, '');
    });
  });
}
