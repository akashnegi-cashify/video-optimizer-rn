import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/home/screens/qc_tester_home_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/disputed_image_capture/screens/disputed_image_capture_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/disputed_image_capture/screens/disputed_image_capture_barcode_scanner_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator_media_capture/calculator_media_capture_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator_media_capture/resources/journey_type.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  group('QcTesterHomeScreen', () {
    test('has correct pageKey', () {
      expect(QcTesterHomeScreen.pageKey, 'QC_qc_tester_home_screen');
    });

    test('has correct route', () {
      expect(QcTesterHomeScreen.route, '/qc_tester_home');
    });

    test('can be instantiated', () {
      const screen = QcTesterHomeScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const testKey = Key('qc_tester_home_test_key');
      const screen = QcTesterHomeScreen(key: testKey);
      expect(screen.key, testKey);
    });
  });

  group('DisputedImageCaptureScreen', () {
    test('has correct pageKey', () {
      expect(DisputedImageCaptureScreen.pageKey, 'disputed_image_capture_screen');
    });

    test('has correct route', () {
      expect(DisputedImageCaptureScreen.route, '/disputed_image_capture_screen');
    });

    test('can be instantiated', () {
      const screen = DisputedImageCaptureScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const testKey = Key('disputed_image_capture_test_key');
      const screen = DisputedImageCaptureScreen(key: testKey);
      expect(screen.key, testKey);
    });
  });

  group('DisputedImageCaptureScreenArguments', () {
    test('creates arguments with barcode', () {
      final args = DisputedImageCaptureScreenArguments(barcode: 'BARCODE123');
      expect(args.barcode, 'BARCODE123');
    });

    test('creates arguments with null barcode', () {
      final args = DisputedImageCaptureScreenArguments(barcode: null);
      expect(args.barcode, isNull);
    });

    test('creates arguments without barcode parameter', () {
      final args = DisputedImageCaptureScreenArguments();
      expect(args.barcode, isNull);
    });

    test('toJson returns correct map with bc key', () {
      final args = DisputedImageCaptureScreenArguments(barcode: 'TEST_BARCODE');
      final json = args.toJson();
      // The key is 'bc' (DisputedImageCaptureScreenParamKeys.barcode.value)
      expect(json['bc'], 'TEST_BARCODE');
    });

    test('toJson returns correct map with null barcode', () {
      final args = DisputedImageCaptureScreenArguments(barcode: null);
      final json = args.toJson();
      expect(json['bc'], isNull);
    });

    test('toJson returns map with single key', () {
      final args = DisputedImageCaptureScreenArguments(barcode: 'TEST');
      final json = args.toJson();
      expect(json.length, 1);
      expect(json.containsKey('bc'), isTrue);
    });

    test('multiple args instances are independent', () {
      final args1 = DisputedImageCaptureScreenArguments(barcode: 'BARCODE_A');
      final args2 = DisputedImageCaptureScreenArguments(barcode: 'BARCODE_B');
      expect(args1.barcode, isNot(args2.barcode));
    });
  });

  group('DisputedImageCaptureBarcodeScanner', () {
    test('has correct pageKey', () {
      expect(DisputedImageCaptureBarcodeScanner.pageKey,
          'disputed_image_capture_barcode_screen');
    });

    test('has correct route', () {
      expect(DisputedImageCaptureBarcodeScanner.route,
          '/disputed_image_capture_barcode_screen');
    });

    test('can be instantiated', () {
      const screen = DisputedImageCaptureBarcodeScanner();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const testKey = Key('disputed_image_barcode_scanner_test_key');
      const screen = DisputedImageCaptureBarcodeScanner(key: testKey);
      expect(screen.key, testKey);
    });
  });

  group('DisputedImageCaptureBarcodeScannerArguments', () {
    test('creates arguments with all fields', () {
      final args = DisputedImageCaptureBarcodeScannerArguments(
        onScanDetected: (data, controller, {bool? isManualEntry}) {},
        header: 'Scan Header',
        hintText: 'Please scan barcode',
        scanFormatList: [BarcodeFormat.qrCode, BarcodeFormat.code128],
        bottomView: const Text('Bottom'),
        resetController: (resetController) {},
      );
      expect(args.header, 'Scan Header');
      expect(args.hintText, 'Please scan barcode');
      expect(args.scanFormatList, isNotNull);
      expect(args.scanFormatList?.length, 2);
      expect(args.bottomView, isNotNull);
      expect(args.onScanDetected, isNotNull);
      expect(args.resetController, isNotNull);
    });

    test('creates arguments with null values', () {
      final args = DisputedImageCaptureBarcodeScannerArguments(
        onScanDetected: null,
        header: null,
        hintText: null,
        scanFormatList: null,
        bottomView: null,
        resetController: null,
      );
      expect(args.header, isNull);
      expect(args.hintText, isNull);
      expect(args.scanFormatList, isNull);
      expect(args.bottomView, isNull);
      expect(args.onScanDetected, isNull);
      expect(args.resetController, isNull);
    });

    test('creates arguments with default values', () {
      final args = DisputedImageCaptureBarcodeScannerArguments();
      expect(args.header, isNull);
      expect(args.hintText, isNull);
      expect(args.scanFormatList, isNull);
      expect(args.bottomView, isNull);
      expect(args.onScanDetected, isNull);
      expect(args.resetController, isNull);
    });

    test('toJson returns correct map with proper keys', () {
      final args = DisputedImageCaptureBarcodeScannerArguments(
        header: 'Test Header',
        hintText: 'Test Hint',
        scanFormatList: [BarcodeFormat.qrCode],
        onScanDetected: (data, controller, {bool? isManualEntry}) {},
      );
      final json = args.toJson();
      // Keys: sc (scannerCallback), h (header), ht (hintText), sf (scanFormats), bv (bottomView), rc (resetController)
      expect(json['h'], 'Test Header');
      expect(json['ht'], 'Test Hint');
      expect(json['sf'], isNotNull);
      expect(json['sc'], isNotNull);
    });

    test('toJson returns map with six keys', () {
      final args = DisputedImageCaptureBarcodeScannerArguments(
        header: 'Header',
        hintText: 'Hint',
        scanFormatList: [],
        onScanDetected: (data, controller, {bool? isManualEntry}) {},
        bottomView: const SizedBox(),
        resetController: (controller) {},
      );
      final json = args.toJson();
      expect(json.length, 6);
      expect(json.containsKey('sc'), isTrue);
      expect(json.containsKey('h'), isTrue);
      expect(json.containsKey('ht'), isTrue);
      expect(json.containsKey('sf'), isTrue);
      expect(json.containsKey('bv'), isTrue);
      expect(json.containsKey('rc'), isTrue);
    });

    test('onScanDetected callback receives correct parameters', () {
      String? capturedData;
      bool? capturedIsManualEntry;
      final args = DisputedImageCaptureBarcodeScannerArguments(
        onScanDetected: (data, controller, {bool? isManualEntry}) {
          capturedData = data;
          capturedIsManualEntry = isManualEntry;
        },
      );
      args.onScanDetected!('SCANNED_DATA', null, isManualEntry: true);
      expect(capturedData, 'SCANNED_DATA');
      expect(capturedIsManualEntry, isTrue);
    });

    test('onScanDetected callback handles manual entry flag', () {
      bool? capturedIsManualEntry;
      final args = DisputedImageCaptureBarcodeScannerArguments(
        onScanDetected: (data, controller, {bool? isManualEntry}) {
          capturedIsManualEntry = isManualEntry;
        },
      );
      args.onScanDetected!('DATA', null, isManualEntry: false);
      expect(capturedIsManualEntry, isFalse);
    });

    test('scanFormatList can contain multiple formats', () {
      final args = DisputedImageCaptureBarcodeScannerArguments(
        scanFormatList: [
          BarcodeFormat.qrCode,
          BarcodeFormat.code128,
          BarcodeFormat.ean13,
          BarcodeFormat.dataMatrix,
        ],
      );
      expect(args.scanFormatList?.length, 4);
      expect(args.scanFormatList?.contains(BarcodeFormat.qrCode), isTrue);
      expect(args.scanFormatList?.contains(BarcodeFormat.code128), isTrue);
    });
  });

  group('CalculatorMediaCaptureScreen', () {
    test('has correct pageKey', () {
      expect(CalculatorMediaCaptureScreen.pageKey, 'calculator_media_capture');
    });

    test('has correct route', () {
      expect(CalculatorMediaCaptureScreen.route, '/calculator_media_capture_screen');
    });

    test('can be instantiated', () {
      const screen = CalculatorMediaCaptureScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const testKey = Key('calculator_media_capture_test_key');
      const screen = CalculatorMediaCaptureScreen(key: testKey);
      expect(screen.key, testKey);
    });
  });

  group('CalculatorMediaCaptureScreenArg', () {
    test('creates arguments with required fields', () {
      final args = CalculatorMediaCaptureScreenArg(
        'DEVICE123',
        journeyType: JourneyType.generic,
      );
      expect(args.deviceBarcode, 'DEVICE123');
      expect(args.journeyType, JourneyType.generic);
      expect(args.categoryId, isNull);
      expect(args.onMediaListUpdated, isNull);
    });

    test('creates arguments with all fields', () {
      final args = CalculatorMediaCaptureScreenArg(
        'DEVICE456',
        journeyType: JourneyType.testing,
        categoryId: 100,
        onMediaListUpdated: (mediaList) {},
      );
      expect(args.deviceBarcode, 'DEVICE456');
      expect(args.journeyType, JourneyType.testing);
      expect(args.categoryId, 100);
      expect(args.onMediaListUpdated, isNotNull);
    });

    test('creates arguments with audit journey type', () {
      final args = CalculatorMediaCaptureScreenArg(
        'DEVICE789',
        journeyType: JourneyType.audit,
      );
      expect(args.journeyType, JourneyType.audit);
    });

    test('toJson returns correct map with proper keys', () {
      final args = CalculatorMediaCaptureScreenArg(
        'BARCODE_TEST',
        journeyType: JourneyType.testing,
        categoryId: 50,
        onMediaListUpdated: (mediaList) {},
      );
      final json = args.toJson();
      // Keys: icfcj (journeyType), dbr (deviceBarcode), cid (categoryId), omlu (onMediaListUpdated)
      expect(json['icfcj'], JourneyType.testing);
      expect(json['dbr'], 'BARCODE_TEST');
      expect(json['cid'], 50);
      expect(json['omlu'], isNotNull);
    });

    test('toJson returns map with four keys', () {
      final args = CalculatorMediaCaptureScreenArg(
        'TEST',
        journeyType: JourneyType.generic,
      );
      final json = args.toJson();
      expect(json.length, 4);
      expect(json.containsKey('icfcj'), isTrue);
      expect(json.containsKey('dbr'), isTrue);
      expect(json.containsKey('cid'), isTrue);
      expect(json.containsKey('omlu'), isTrue);
    });

    test('toJson with null optional fields', () {
      final args = CalculatorMediaCaptureScreenArg(
        'DEVICE',
        journeyType: JourneyType.generic,
      );
      final json = args.toJson();
      expect(json['cid'], isNull);
      expect(json['omlu'], isNull);
    });

    test('multiple args instances are independent', () {
      final args1 = CalculatorMediaCaptureScreenArg(
        'DEVICE_A',
        journeyType: JourneyType.generic,
        categoryId: 1,
      );
      final args2 = CalculatorMediaCaptureScreenArg(
        'DEVICE_B',
        journeyType: JourneyType.testing,
        categoryId: 2,
      );
      expect(args1.deviceBarcode, isNot(args2.deviceBarcode));
      expect(args1.journeyType, isNot(args2.journeyType));
      expect(args1.categoryId, isNot(args2.categoryId));
    });
  });

  group('JourneyType', () {
    test('has generic value', () {
      expect(JourneyType.generic, isNotNull);
    });

    test('has testing value', () {
      expect(JourneyType.testing, isNotNull);
    });

    test('has audit value', () {
      expect(JourneyType.audit, isNotNull);
    });

    test('isTesting returns correct value', () {
      expect(JourneyType.testing.isTesting, isTrue);
      expect(JourneyType.generic.isTesting, isFalse);
      expect(JourneyType.audit.isTesting, isFalse);
    });

    test('isAudit returns correct value', () {
      expect(JourneyType.audit.isAudit, isTrue);
      expect(JourneyType.generic.isAudit, isFalse);
      expect(JourneyType.testing.isAudit, isFalse);
    });

    test('isGeneric returns correct value', () {
      expect(JourneyType.generic.isGeneric, isTrue);
      expect(JourneyType.testing.isGeneric, isFalse);
      expect(JourneyType.audit.isGeneric, isFalse);
    });

    test('all journey types are distinct', () {
      expect(JourneyType.generic, isNot(JourneyType.testing));
      expect(JourneyType.generic, isNot(JourneyType.audit));
      expect(JourneyType.testing, isNot(JourneyType.audit));
    });
  });

  group('CalculatorMediaCaptureScreen.navigateTo', () {
    testWidgets('navigateTo pushes route with required arguments',
        (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == CalculatorMediaCaptureScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) =>
                    const Scaffold(body: Text('Calculator Media Capture Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      CalculatorMediaCaptureScreen.navigateTo(
                        context,
                        'TEST_BARCODE',
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

      expect(pushedRoute, CalculatorMediaCaptureScreen.route);
      expect(pushedArguments, isA<CalculatorMediaCaptureScreenArg>());
      expect(
        (pushedArguments as CalculatorMediaCaptureScreenArg).deviceBarcode,
        'TEST_BARCODE',
      );
      expect(
        (pushedArguments as CalculatorMediaCaptureScreenArg).journeyType,
        JourneyType.generic,
      );
    });

    testWidgets('navigateTo pushes route with all arguments',
        (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == CalculatorMediaCaptureScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) =>
                    const Scaffold(body: Text('Calculator Media Capture Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      CalculatorMediaCaptureScreen.navigateTo(
                        context,
                        'FULL_BARCODE',
                        journeyType: JourneyType.testing,
                        categoryId: 25,
                        onMediaListUpdated: (mediaList) {},
                      );
                    },
                    child: const Text('Navigate Full'),
                  ),
                ),
              ),
            );
          },
        ),
      );

      await tester.tap(find.text('Navigate Full'));
      await tester.pumpAndSettle();

      expect(pushedRoute, CalculatorMediaCaptureScreen.route);
      expect(pushedArguments, isA<CalculatorMediaCaptureScreenArg>());
      final args = pushedArguments as CalculatorMediaCaptureScreenArg;
      expect(args.deviceBarcode, 'FULL_BARCODE');
      expect(args.journeyType, JourneyType.testing);
      expect(args.categoryId, 25);
      expect(args.onMediaListUpdated, isNotNull);
    });

    testWidgets('navigateTo with audit journey type',
        (WidgetTester tester) async {
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == CalculatorMediaCaptureScreen.route) {
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) =>
                    const Scaffold(body: Text('Calculator Media Capture Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      CalculatorMediaCaptureScreen.navigateTo(
                        context,
                        'AUDIT_BARCODE',
                        journeyType: JourneyType.audit,
                      );
                    },
                    child: const Text('Navigate Audit'),
                  ),
                ),
              ),
            );
          },
        ),
      );

      await tester.tap(find.text('Navigate Audit'));
      await tester.pumpAndSettle();

      expect(pushedArguments, isA<CalculatorMediaCaptureScreenArg>());
      expect(
        (pushedArguments as CalculatorMediaCaptureScreenArg).journeyType,
        JourneyType.audit,
      );
    });
  });

  group('QcTester navigation routes', () {
    testWidgets('QcTesterHomeScreen route can be pushed',
        (WidgetTester tester) async {
      String? pushedRoute;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == QcTesterHomeScreen.route) {
              pushedRoute = settings.name;
              return MaterialPageRoute(
                builder: (_) =>
                    const Scaffold(body: Text('QC Tester Home Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, QcTesterHomeScreen.route);
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

      expect(pushedRoute, QcTesterHomeScreen.route);
    });

    testWidgets('DisputedImageCaptureScreen route can be pushed',
        (WidgetTester tester) async {
      String? pushedRoute;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == DisputedImageCaptureScreen.route) {
              pushedRoute = settings.name;
              return MaterialPageRoute(
                builder: (_) =>
                    const Scaffold(body: Text('Disputed Image Capture Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, DisputedImageCaptureScreen.route);
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

      expect(pushedRoute, DisputedImageCaptureScreen.route);
    });

    testWidgets('DisputedImageCaptureBarcodeScanner route can be pushed',
        (WidgetTester tester) async {
      String? pushedRoute;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == DisputedImageCaptureBarcodeScanner.route) {
              pushedRoute = settings.name;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(
                    body: Text('Disputed Image Capture Barcode Scanner')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, DisputedImageCaptureBarcodeScanner.route);
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

      expect(pushedRoute, DisputedImageCaptureBarcodeScanner.route);
    });

    testWidgets('CalculatorMediaCaptureScreen route can be pushed',
        (WidgetTester tester) async {
      String? pushedRoute;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == CalculatorMediaCaptureScreen.route) {
              pushedRoute = settings.name;
              return MaterialPageRoute(
                builder: (_) =>
                    const Scaffold(body: Text('Calculator Media Capture Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, CalculatorMediaCaptureScreen.route);
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

      expect(pushedRoute, CalculatorMediaCaptureScreen.route);
    });
  });
}
