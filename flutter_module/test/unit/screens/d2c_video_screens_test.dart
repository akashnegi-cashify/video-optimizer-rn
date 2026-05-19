import 'package:builder_project/builder_project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/d2c_video/screens/d2c_video_screen.dart';
import 'package:flutter_trc/qc/modules/d2c_video/screens/d2c_video_home_screen.dart';
import 'package:flutter_trc/qc/modules/d2c_video/screens/d2c_lot_listing_screen.dart';
import 'package:flutter_trc/qc/modules/d2c_video/screens/d2c_lot_device_listing_screen.dart';

void main() {
  group('D2CVideoScreen', () {
    test('has correct pageKey', () {
      expect(D2CVideoScreen.pageKey, 'QC_d2c_video_page_key');
    });

    test('has correct route', () {
      expect(D2CVideoScreen.route, '/qc/d2c-video');
    });

    test('can be instantiated', () {
      const screen = D2CVideoScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const key = Key('d2c_video_screen_key');
      const screen = D2CVideoScreen(key: key);
      expect(screen.key, equals(key));
    });

    test('pageKey is not empty', () {
      expect(D2CVideoScreen.pageKey.isNotEmpty, isTrue);
    });

    test('route starts with forward slash', () {
      expect(D2CVideoScreen.route.startsWith('/'), isTrue);
    });

    test('route contains expected path segment', () {
      expect(D2CVideoScreen.route.contains('d2c-video'), isTrue);
    });

    test('pageKey contains QC prefix', () {
      expect(D2CVideoScreen.pageKey.contains('QC'), isTrue);
    });

    test('multiple instances are equal with same key', () {
      const key = Key('same_key');
      const screen1 = D2CVideoScreen(key: key);
      const screen2 = D2CVideoScreen(key: key);
      expect(screen1.key, equals(screen2.key));
    });
  });

  group('D2cVideoHomeScreen', () {
    test('has correct pageKey', () {
      expect(D2cVideoHomeScreen.pageKey, 'QC_d2c_video_home_screen');
    });

    test('has correct route', () {
      expect(D2cVideoHomeScreen.route, '/d2c_video_home');
    });

    test('can be instantiated', () {
      const screen = D2cVideoHomeScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const key = Key('d2c_video_home_screen_key');
      const screen = D2cVideoHomeScreen(key: key);
      expect(screen.key, equals(key));
    });

    test('pageKey is not empty', () {
      expect(D2cVideoHomeScreen.pageKey.isNotEmpty, isTrue);
    });

    test('route starts with forward slash', () {
      expect(D2cVideoHomeScreen.route.startsWith('/'), isTrue);
    });

    test('route contains home identifier', () {
      expect(D2cVideoHomeScreen.route.contains('home'), isTrue);
    });

    test('pageKey contains QC prefix', () {
      expect(D2cVideoHomeScreen.pageKey.contains('QC'), isTrue);
    });

    test('pageKey contains video identifier', () {
      expect(D2cVideoHomeScreen.pageKey.contains('video'), isTrue);
    });

    group('buildView', () {
      test('buildView method exists and is callable', () {
        const screen = D2cVideoHomeScreen();
        expect(screen.buildView, isNotNull);
      });

      testWidgets('buildView returns PageWidget', (tester) async {
        Widget? builtWidget;

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                const screen = D2cVideoHomeScreen();
                builtWidget = screen.buildView(context);
                return const SizedBox(); // Return placeholder
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
                const screen = D2cVideoHomeScreen();
                final widget = screen.buildView(context);
                capturedWidget = widget is PageWidget ? widget : null;
                return const SizedBox();
              },
            ),
          ),
        );

        await tester.pump();
        expect(capturedWidget, isNotNull);
        expect(capturedWidget!.pageKey, equals(D2cVideoHomeScreen.pageKey));
      });

      testWidgets('PageWidget has no initialValue', (tester) async {
        PageWidget? capturedWidget;

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                const screen = D2cVideoHomeScreen();
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
  });

  group('D2cLotListingScreen', () {
    test('has correct route', () {
      expect(D2cLotListingScreen.route, '/d2c-lot-listing');
    });

    test('can be instantiated', () {
      const screen = D2cLotListingScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const key = Key('d2c_lot_listing_screen_key');
      const screen = D2cLotListingScreen(key: key);
      expect(screen.key, equals(key));
    });

    test('route starts with forward slash', () {
      expect(D2cLotListingScreen.route.startsWith('/'), isTrue);
    });

    test('route contains lot identifier', () {
      expect(D2cLotListingScreen.route.contains('lot'), isTrue);
    });

    test('route contains listing identifier', () {
      expect(D2cLotListingScreen.route.contains('listing'), isTrue);
    });

    test('is a StatelessWidget', () {
      const screen = D2cLotListingScreen();
      expect(screen, isA<StatelessWidget>());
    });

    test('route is final and consistent', () {
      final route1 = D2cLotListingScreen.route;
      final route2 = D2cLotListingScreen.route;
      expect(route1, equals(route2));
    });
  });

  group('D2cLotDeviceListingScreen', () {
    test('has correct route', () {
      expect(D2cLotDeviceListingScreen.route, '/d2c-lot-device-listing');
    });

    test('can be instantiated with null params', () {
      const screen = D2cLotDeviceListingScreen();
      expect(screen, isNotNull);
      expect(screen.lotId, isNull);
      expect(screen.groupLotName, isNull);
    });

    test('can be instantiated with params', () {
      const screen = D2cLotDeviceListingScreen(lotId: 1, groupLotName: 'TestLot');
      expect(screen, isNotNull);
      expect(screen.lotId, 1);
      expect(screen.groupLotName, 'TestLot');
    });

    test('can be instantiated with key', () {
      const key = Key('d2c_lot_device_listing_screen_key');
      const screen = D2cLotDeviceListingScreen(key: key);
      expect(screen.key, equals(key));
    });

    test('can be instantiated with key and params', () {
      const key = Key('d2c_lot_device_listing_screen_key');
      const screen = D2cLotDeviceListingScreen(
        key: key,
        lotId: 123,
        groupLotName: 'TestGroupLot',
      );
      expect(screen.key, equals(key));
      expect(screen.lotId, equals(123));
      expect(screen.groupLotName, equals('TestGroupLot'));
    });

    test('route starts with forward slash', () {
      expect(D2cLotDeviceListingScreen.route.startsWith('/'), isTrue);
    });

    test('route contains device identifier', () {
      expect(D2cLotDeviceListingScreen.route.contains('device'), isTrue);
    });

    test('lotId can be zero', () {
      const screen = D2cLotDeviceListingScreen(lotId: 0);
      expect(screen.lotId, equals(0));
    });

    test('lotId can be negative', () {
      const screen = D2cLotDeviceListingScreen(lotId: -1);
      expect(screen.lotId, equals(-1));
    });

    test('groupLotName can be empty string', () {
      const screen = D2cLotDeviceListingScreen(groupLotName: '');
      expect(screen.groupLotName, equals(''));
    });

    test('groupLotName preserves whitespace', () {
      const screen = D2cLotDeviceListingScreen(groupLotName: '  Test Lot  ');
      expect(screen.groupLotName, equals('  Test Lot  '));
    });

    test('is a StatelessWidget', () {
      const screen = D2cLotDeviceListingScreen();
      expect(screen, isA<StatelessWidget>());
    });

    test('route is final and consistent', () {
      final route1 = D2cLotDeviceListingScreen.route;
      final route2 = D2cLotDeviceListingScreen.route;
      expect(route1, equals(route2));
    });

    test('lotId and groupLotName are independent', () {
      const screen1 = D2cLotDeviceListingScreen(lotId: 1);
      const screen2 = D2cLotDeviceListingScreen(groupLotName: 'Test');
      expect(screen1.lotId, equals(1));
      expect(screen1.groupLotName, isNull);
      expect(screen2.lotId, isNull);
      expect(screen2.groupLotName, equals('Test'));
    });
  });

  group('D2CVideoArguments', () {
    test('creates arguments with barcode', () {
      final args = D2CVideoArguments('TEST_BARCODE');
      expect(args.barcode, 'TEST_BARCODE');
    });

    test('toJson returns correct map with dbr key', () {
      final args = D2CVideoArguments('TEST_BARCODE');
      final json = args.toJson();
      // The key is 'dbr' (DeviceBarcodeParamKeys.deviceBarcode.value)
      expect(json['dbr'], 'TEST_BARCODE');
    });

    test('creates arguments with null barcode', () {
      final args = D2CVideoArguments(null);
      expect(args.barcode, isNull);
    });

    test('toJson handles null barcode', () {
      final args = D2CVideoArguments(null);
      final json = args.toJson();
      expect(json['dbr'], isNull);
    });

    test('creates arguments with empty string barcode', () {
      final args = D2CVideoArguments('');
      expect(args.barcode, equals(''));
    });

    test('toJson handles empty string barcode', () {
      final args = D2CVideoArguments('');
      final json = args.toJson();
      expect(json['dbr'], equals(''));
    });

    test('preserves barcode with special characters', () {
      final args = D2CVideoArguments('TEST-123_ABC/456');
      expect(args.barcode, equals('TEST-123_ABC/456'));
    });

    test('toJson preserves barcode with special characters', () {
      final args = D2CVideoArguments('TEST-123_ABC/456');
      final json = args.toJson();
      expect(json['dbr'], equals('TEST-123_ABC/456'));
    });

    test('preserves barcode with unicode characters', () {
      final args = D2CVideoArguments('テスト_バーコード');
      expect(args.barcode, equals('テスト_バーコード'));
    });

    test('toJson returns map with single key', () {
      final args = D2CVideoArguments('TEST');
      final json = args.toJson();
      expect(json.length, equals(1));
      expect(json.containsKey('dbr'), isTrue);
    });

    test('multiple arguments with same barcode are distinct objects', () {
      final args1 = D2CVideoArguments('TEST');
      final args2 = D2CVideoArguments('TEST');
      expect(args1, isNot(same(args2)));
      expect(args1.barcode, equals(args2.barcode));
    });

    test('arguments with different barcodes have different toJson', () {
      final args1 = D2CVideoArguments('BARCODE1');
      final args2 = D2CVideoArguments('BARCODE2');
      expect(args1.toJson()['dbr'], isNot(equals(args2.toJson()['dbr'])));
    });

    test('preserves barcode with whitespace', () {
      final args = D2CVideoArguments('  BARCODE WITH SPACES  ');
      expect(args.barcode, equals('  BARCODE WITH SPACES  '));
    });

    test('preserves very long barcode', () {
      final longBarcode = 'A' * 1000;
      final args = D2CVideoArguments(longBarcode);
      expect(args.barcode, equals(longBarcode));
      expect(args.barcode!.length, equals(1000));
    });
  });
}
