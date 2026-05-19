import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/screens/lob_device_scanner_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/screens/color_selection_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/screens/product_list_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/screens/variant_list_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';

void main() {
  group('LobDeviceScannerScreen', () {
    test('has correct pageKey', () {
      expect(LobDeviceScannerScreen.pageKey, 'QC_lob_device_scanner_screen');
    });

    test('has correct route', () {
      expect(LobDeviceScannerScreen.route, '/QC_lob_device_scanner_screen');
    });

    test('can be instantiated', () {
      const screen = LobDeviceScannerScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const testKey = Key('lob_device_scanner_test_key');
      const screen = LobDeviceScannerScreen(key: testKey);
      expect(screen.key, testKey);
    });
  });

  group('LobDeviceScannerScreenArg', () {
    test('creates arguments with barcode', () {
      final args = LobDeviceScannerScreenArg(barcode: 'TEST123');
      expect(args.barcode, 'TEST123');
    });

    test('creates arguments with null barcode', () {
      final args = LobDeviceScannerScreenArg(barcode: null);
      expect(args.barcode, isNull);
    });

    test('creates arguments without barcode parameter', () {
      final args = LobDeviceScannerScreenArg();
      expect(args.barcode, isNull);
    });

    test('toJson returns correct map with dbr key', () {
      final args = LobDeviceScannerScreenArg(barcode: 'BARCODE456');
      final json = args.toJson();
      // The key is 'dbr' (DeviceBarcodeParamKeys.deviceBarcode.value)
      expect(json['dbr'], 'BARCODE456');
    });

    test('toJson returns correct map with null barcode', () {
      final args = LobDeviceScannerScreenArg(barcode: null);
      final json = args.toJson();
      expect(json['dbr'], isNull);
    });

    test('toJson returns map with single key', () {
      final args = LobDeviceScannerScreenArg(barcode: 'TEST');
      final json = args.toJson();
      expect(json.length, 1);
      expect(json.containsKey('dbr'), isTrue);
    });

    test('multiple args instances are independent', () {
      final args1 = LobDeviceScannerScreenArg(barcode: 'BARCODE_A');
      final args2 = LobDeviceScannerScreenArg(barcode: 'BARCODE_B');
      expect(args1.barcode, isNot(args2.barcode));
    });
  });

  group('ColorSelectionScreen', () {
    test('has correct pageKey', () {
      expect(ColorSelectionScreen.pageKey, 'QC_color_selection_screen');
    });

    test('has correct route', () {
      expect(ColorSelectionScreen.route, '/qc-tester/color-selection');
    });

    test('can be instantiated', () {
      const screen = ColorSelectionScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const testKey = Key('color_selection_test_key');
      const screen = ColorSelectionScreen(key: testKey);
      expect(screen.key, testKey);
    });
  });

  group('ColorSelectionScreenArguments', () {
    test('creates arguments with all fields', () {
      String? selectedColor;
      String? selectedStrapColor;
      final args = ColorSelectionScreenArguments(
        100,
        'DEVICE123',
        (color, strapColor) {
          selectedColor = color;
          selectedStrapColor = strapColor;
        },
      );
      expect(args.productId, 100);
      expect(args.deviceBarcode, 'DEVICE123');
      expect(args.onColorSelected, isNotNull);

      // Test the callback works
      args.onColorSelected!('Red', 'Black');
      expect(selectedColor, 'Red');
      expect(selectedStrapColor, 'Black');
    });

    test('creates arguments with null values', () {
      final args = ColorSelectionScreenArguments(null, null, null);
      expect(args.productId, isNull);
      expect(args.deviceBarcode, isNull);
      expect(args.onColorSelected, isNull);
    });

    test('toMap returns correct map with proper keys', () {
      final args = ColorSelectionScreenArguments(
        200,
        'BARCODE789',
        (color, strapColor) {},
      );
      final map = args.toMap();
      // Keys: bid (productId), dbr (deviceBarcode), ocs (onColorSelected)
      expect(map['bid'], 200);
      expect(map['dbr'], 'BARCODE789');
      expect(map['ocs'], isNotNull);
    });

    test('toMap returns correct map with null values', () {
      final args = ColorSelectionScreenArguments(null, null, null);
      final map = args.toMap();
      expect(map['bid'], isNull);
      expect(map['dbr'], isNull);
      expect(map['ocs'], isNull);
    });

    test('toMap returns map with three keys', () {
      final args = ColorSelectionScreenArguments(1, 'test', null);
      final map = args.toMap();
      expect(map.length, 3);
      expect(map.containsKey('bid'), isTrue);
      expect(map.containsKey('dbr'), isTrue);
      expect(map.containsKey('ocs'), isTrue);
    });

    test('onColorSelected callback receives correct parameters', () {
      String? capturedColor;
      String? capturedStrapColor;
      final args = ColorSelectionScreenArguments(
        1,
        'test',
        (color, strapColor) {
          capturedColor = color;
          capturedStrapColor = strapColor;
        },
      );
      args.onColorSelected!('Blue', 'Silver');
      expect(capturedColor, 'Blue');
      expect(capturedStrapColor, 'Silver');
    });

    test('onColorSelected callback handles null strapColor', () {
      String? capturedColor;
      String? capturedStrapColor;
      final args = ColorSelectionScreenArguments(
        1,
        'test',
        (color, strapColor) {
          capturedColor = color;
          capturedStrapColor = strapColor;
        },
      );
      args.onColorSelected!('Green', null);
      expect(capturedColor, 'Green');
      expect(capturedStrapColor, isNull);
    });
  });

  group('ColorSelectionScreen.navigateTo', () {
    testWidgets('navigateTo pushes route with arguments',
        (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == ColorSelectionScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) =>
                    const Scaffold(body: Text('Color Selection Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      ColorSelectionScreen.navigateTo(
                        context,
                        123,
                        'BARCODE_TEST',
                        (color, strapColor) {},
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

      expect(pushedRoute, ColorSelectionScreen.route);
      expect(pushedArguments, isA<ColorSelectionScreenArguments>());
      expect(
        (pushedArguments as ColorSelectionScreenArguments).productId,
        123,
      );
      expect(
        (pushedArguments as ColorSelectionScreenArguments).deviceBarcode,
        'BARCODE_TEST',
      );
    });
  });

  group('ProductListScreen', () {
    test('has correct pageKey', () {
      expect(ProductListScreen.pageKey, 'QC_product_list_screen');
    });

    test('has correct route', () {
      expect(ProductListScreen.route, '/qc-tester/lob-devices/product-list');
    });

    test('can be instantiated', () {
      const screen = ProductListScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const testKey = Key('product_list_test_key');
      const screen = ProductListScreen(key: testKey);
      expect(screen.key, testKey);
    });
  });

  group('ProductListScreenArg', () {
    test('creates arguments with required fields', () {
      final args = ProductListScreenArg(
        deviceBarcode: 'DEVICE001',
        categoryId: 10,
        brandId: 20,
        categoryList: [],
        onProductSelected: (productItem, variantItem) {},
      );
      expect(args.deviceBarcode, 'DEVICE001');
      expect(args.categoryId, 10);
      expect(args.brandId, 20);
      expect(args.categoryList, isEmpty);
      expect(args.imei, isNull);
    });

    test('creates arguments with all fields including optional imei', () {
      final args = ProductListScreenArg(
        deviceBarcode: 'DEVICE002',
        categoryId: 15,
        brandId: 25,
        categoryList: [],
        imei: 'IMEI123456',
        onProductSelected: (productItem, variantItem) {},
      );
      expect(args.deviceBarcode, 'DEVICE002');
      expect(args.categoryId, 15);
      expect(args.brandId, 25);
      expect(args.imei, 'IMEI123456');
    });

    test('toJson returns correct map with proper keys', () {
      final args = ProductListScreenArg(
        deviceBarcode: 'BARCODE_JSON',
        categoryId: 5,
        brandId: 10,
        categoryList: [],
        imei: 'IMEI_JSON',
        onProductSelected: (productItem, variantItem) {},
      );
      final json = args.toJson();
      // Keys: dbr (deviceBarcode), cid (categoryId), bid (brandId), 
      // cat (categoryList), ops (onProductSelected), imei
      expect(json['dbr'], 'BARCODE_JSON');
      expect(json['cid'], 5);
      expect(json['bid'], 10);
      expect(json['cat'], isEmpty);
      expect(json['ops'], isNotNull);
      expect(json['imei'], 'IMEI_JSON');
    });

    test('toJson returns map with six keys', () {
      final args = ProductListScreenArg(
        deviceBarcode: 'TEST',
        categoryId: 1,
        brandId: 2,
        categoryList: [],
        onProductSelected: (productItem, variantItem) {},
      );
      final json = args.toJson();
      expect(json.length, 6);
      expect(json.containsKey('dbr'), isTrue);
      expect(json.containsKey('cid'), isTrue);
      expect(json.containsKey('bid'), isTrue);
      expect(json.containsKey('cat'), isTrue);
      expect(json.containsKey('ops'), isTrue);
      expect(json.containsKey('imei'), isTrue);
    });

    test('onProductSelected callback can be invoked', () {
      bool callbackInvoked = false;
      final args = ProductListScreenArg(
        deviceBarcode: 'TEST',
        categoryId: 1,
        brandId: 2,
        categoryList: [],
        onProductSelected: (productItem, variantItem) {
          callbackInvoked = true;
        },
      );
      // Create a minimal mock product data (positional params: productId, name, brandId, brand, productMasterId)
      final mockProduct = LobProductListData(1, 'Test Product', 10, 'Test Brand', 100);
      args.onProductSelected(mockProduct, null);
      expect(callbackInvoked, isTrue);
    });

    test('multiple args instances are independent', () {
      final args1 = ProductListScreenArg(
        deviceBarcode: 'DEVICE_A',
        categoryId: 1,
        brandId: 2,
        categoryList: [],
        onProductSelected: (productItem, variantItem) {},
      );
      final args2 = ProductListScreenArg(
        deviceBarcode: 'DEVICE_B',
        categoryId: 3,
        brandId: 4,
        categoryList: [],
        onProductSelected: (productItem, variantItem) {},
      );
      expect(args1.deviceBarcode, isNot(args2.deviceBarcode));
      expect(args1.categoryId, isNot(args2.categoryId));
      expect(args1.brandId, isNot(args2.brandId));
    });
  });

  group('VariantListScreen', () {
    test('can be instantiated', () {
      final screen = VariantListScreen(
        onVariantSelected: (variantItem) {},
      );
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const testKey = Key('variant_list_test_key');
      final screen = VariantListScreen(
        key: testKey,
        onVariantSelected: (variantItem) {},
      );
      expect(screen.key, testKey);
    });

    test('can be instantiated with isFromTrc flag', () {
      final screen = VariantListScreen(
        onVariantSelected: (variantItem) {},
        isFromTrc: true,
      );
      expect(screen.isFromTrc, isTrue);
    });

    test('isFromTrc defaults to false', () {
      final screen = VariantListScreen(
        onVariantSelected: (variantItem) {},
      );
      expect(screen.isFromTrc, isFalse);
    });

    test('onVariantSelected callback can be invoked', () {
      bool callbackInvoked = false;
      VariantListData? capturedVariant;
      final screen = VariantListScreen(
        onVariantSelected: (variantItem) {
          callbackInvoked = true;
          capturedVariant = variantItem;
        },
      );
      // Invoke the callback with a mock variant (positional params: id, name, commonName, screenSize, processor)
      final mockVariant = VariantListData(1, 'Test Variant', 'Common Name', '6.5"', 'Snapdragon');
      screen.onVariantSelected(mockVariant);
      expect(callbackInvoked, isTrue);
      expect(capturedVariant, isNotNull);
      expect(capturedVariant?.id, 1);
    });

    test('onVariantSelected callback can receive null', () {
      bool callbackInvoked = false;
      VariantListData? capturedVariant;
      final screen = VariantListScreen(
        onVariantSelected: (variantItem) {
          callbackInvoked = true;
          capturedVariant = variantItem;
        },
      );
      screen.onVariantSelected(null);
      expect(callbackInvoked, isTrue);
      expect(capturedVariant, isNull);
    });
  });

  group('LobDevices navigation routes', () {
    testWidgets('LobDeviceScannerScreen route can be pushed',
        (WidgetTester tester) async {
      String? pushedRoute;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == LobDeviceScannerScreen.route) {
              pushedRoute = settings.name;
              return MaterialPageRoute(
                builder: (_) =>
                    const Scaffold(body: Text('Lob Device Scanner Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LobDeviceScannerScreen.route);
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

      expect(pushedRoute, LobDeviceScannerScreen.route);
    });

    testWidgets('ColorSelectionScreen route can be pushed',
        (WidgetTester tester) async {
      String? pushedRoute;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == ColorSelectionScreen.route) {
              pushedRoute = settings.name;
              return MaterialPageRoute(
                builder: (_) =>
                    const Scaffold(body: Text('Color Selection Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ColorSelectionScreen.route);
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

      expect(pushedRoute, ColorSelectionScreen.route);
    });

    testWidgets('ProductListScreen route can be pushed',
        (WidgetTester tester) async {
      String? pushedRoute;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == ProductListScreen.route) {
              pushedRoute = settings.name;
              return MaterialPageRoute(
                builder: (_) =>
                    const Scaffold(body: Text('Product List Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ProductListScreen.route);
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

      expect(pushedRoute, ProductListScreen.route);
    });
  });
}
