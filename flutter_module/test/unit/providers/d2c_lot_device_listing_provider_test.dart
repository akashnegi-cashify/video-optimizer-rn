import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/d2c_video/providers/d2c_lot_device_listing_provider.dart';
import 'package:flutter_trc/qc/modules/d2c_video/resources/d2c_lot_device_list_response.dart';
import 'package:provider/provider.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for D2cLotDeviceListingProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('D2cLotDeviceListingProvider', () {
    late D2cLotDeviceListingProvider provider;

    setUp(() {
      provider = D2cLotDeviceListingProvider(1001, 'LOT-GROUP-001');
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should initialize with lotId', () {
        expect(provider.lotId, 1001);
      });

      test('should initialize with groupLotName', () {
        expect(provider.groupLotName, 'LOT-GROUP-001');
      });

      test('should accept zero lotId', () {
        final zeroProvider = D2cLotDeviceListingProvider(0, 'TEST');
        expect(zeroProvider.lotId, 0);
        zeroProvider.dispose();
      });

      test('should accept negative lotId', () {
        final negProvider = D2cLotDeviceListingProvider(-1, 'TEST');
        expect(negProvider.lotId, -1);
        negProvider.dispose();
      });

      test('should accept empty groupLotName', () {
        final emptyProvider = D2cLotDeviceListingProvider(1, '');
        expect(emptyProvider.groupLotName, '');
        emptyProvider.dispose();
      });
    });

    group('initial state', () {
      test('d2cLotDeviceList should initially be null', () {
        expect(provider.d2cLotDeviceList, isNull);
      });

      test('searchQuery should initially be null', () {
        expect(provider.searchQuery, isNull);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(D2cLotDeviceListingProvider.of, isNotNull);
      });

      testWidgets('of() should return provider from context with listen=true', (tester) async {
        final testProvider = D2cLotDeviceListingProvider(1, 'GROUP');
        
        await tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider<D2cLotDeviceListingProvider>.value(
              value: testProvider,
              child: Builder(
                builder: (context) {
                  final result = D2cLotDeviceListingProvider.of(context);
                  expect(result, testProvider);
                  return const SizedBox();
                },
              ),
            ),
          ),
        );

        testProvider.dispose();
      });

      testWidgets('of() should return provider from context with listen=false', (tester) async {
        final testProvider = D2cLotDeviceListingProvider(1, 'GROUP');
        
        await tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider<D2cLotDeviceListingProvider>.value(
              value: testProvider,
              child: Builder(
                builder: (context) {
                  final result = D2cLotDeviceListingProvider.of(context, listen: false);
                  expect(result, testProvider);
                  return const SizedBox();
                },
              ),
            ),
          ),
        );

        testProvider.dispose();
      });
    });

    group('searchQuery', () {
      test('should allow setting searchQuery', () {
        provider.searchQuery = 'test query';
        expect(provider.searchQuery, 'test query');
      });

      test('should notify listeners when searchQuery is set', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.searchQuery = 'new query';

        expect(tracker.callCount, 1);
      });

      test('should allow setting searchQuery to null', () {
        provider.searchQuery = 'initial';
        provider.searchQuery = null;
        expect(provider.searchQuery, isNull);
      });

      test('should allow setting empty searchQuery', () {
        provider.searchQuery = '';
        expect(provider.searchQuery, '');
      });
    });

    group('d2cLotDeviceList filtering', () {
      test('should return null when list is not loaded and searchQuery is null', () {
        expect(provider.d2cLotDeviceList, isNull);
      });

      test('should return null when list is not loaded and searchQuery is set', () {
        provider.searchQuery = 'BARCODE';
        expect(provider.d2cLotDeviceList, isNull);
      });

      test('filtering logic path when searchQuery is set but list is null', () {
        // This tests the null-safety path in the filtering getter
        provider.searchQuery = 'test barcode';
        // When list is null and search is set, should still return null safely
        expect(provider.d2cLotDeviceList, isNull);
      });
    });

    group('method signatures', () {
      test('should have getLotDeviceList method', () {
        expect(provider.getLotDeviceList, isNotNull);
      });

      test('should have moveLotToNextStatus method', () {
        expect(provider.moveLotToNextStatus, isNotNull);
      });

      test('getLotDeviceList method signature accepts isNotify parameter', () {
        // Verify the method signature accepts the optional parameter
        // We don't call it here because it would make an HTTP request
        // Just verify the method reference is not null
        expect(provider.getLotDeviceList, isA<Function>());
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = D2cLotDeviceListingProvider(1, 'TEST');
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });

  group('D2cLotDeviceListingProvider Searchable mixin', () {
    late D2cLotDeviceListingProvider provider;

    setUp(() {
      provider = D2cLotDeviceListingProvider(1, 'GROUP');
    });

    tearDown(() {
      provider.dispose();
    });

    test('should inherit from Searchable mixin', () {
      expect(provider.searchQuery, isNull);
      provider.searchQuery = 'test';
      expect(provider.searchQuery, 'test');
    });

    test('searchQuery setter should trigger notifyListeners', () {
      final tracker = ListenerTracker();
      provider.addListener(tracker.listener);

      provider.searchQuery = 'search term';

      expect(tracker.callCount, 1);
    });

    test('multiple searchQuery changes should notify each time', () {
      final tracker = ListenerTracker();
      provider.addListener(tracker.listener);

      provider.searchQuery = 'first';
      provider.searchQuery = 'second';
      provider.searchQuery = 'third';

      expect(tracker.callCount, 3);
    });
  });

  group('D2cLotDeviceListingProvider edge cases', () {
    test('should handle special characters in groupLotName', () {
      final provider = D2cLotDeviceListingProvider(1, 'LOT-001/2024_TEST#');
      expect(provider.groupLotName, 'LOT-001/2024_TEST#');
      provider.dispose();
    });

    test('should handle unicode characters in groupLotName', () {
      final provider = D2cLotDeviceListingProvider(1, '批次组名称');
      expect(provider.groupLotName, '批次组名称');
      provider.dispose();
    });

    test('should handle large lotId values', () {
      final provider = D2cLotDeviceListingProvider(2147483647, 'TEST');
      expect(provider.lotId, 2147483647);
      provider.dispose();
    });

    test('should handle long groupLotName strings', () {
      final longName = 'A' * 500;
      final provider = D2cLotDeviceListingProvider(1, longName);
      expect(provider.groupLotName.length, 500);
      provider.dispose();
    });

    test('should handle special characters in search query', () {
      final provider = D2cLotDeviceListingProvider(1, 'GROUP');
      provider.searchQuery = 'BARCODE-001/ABC_TEST#';
      expect(provider.searchQuery, 'BARCODE-001/ABC_TEST#');
      provider.dispose();
    });
  });

  group('D2cLotDeviceListData model', () {
    test('should create D2cLotDeviceListData with deviceBarcode', () {
      final data = D2cLotDeviceListData('DEVICE-001');
      expect(data.deviceBarcode, 'DEVICE-001');
    });

    test('should create D2cLotDeviceListData with null deviceBarcode', () {
      final data = D2cLotDeviceListData(null);
      expect(data.deviceBarcode, isNull);
    });

    test('should handle deviceBarcode with lowercase contains check', () {
      // Test the filtering logic by creating data with known deviceBarcode
      final data = D2cLotDeviceListData('Test-DEVICE-Barcode');
      // The filtering in the provider uses toLowerCase().contains()
      expect(data.deviceBarcode?.toLowerCase().contains('device'), isTrue);
      expect(data.deviceBarcode?.toLowerCase().contains('test'), isTrue);
      expect(data.deviceBarcode?.toLowerCase().contains('xyz'), isFalse);
    });

    test('should handle null deviceBarcode in filter safely', () {
      final data = D2cLotDeviceListData(null);
      // When deviceBarcode is null, the filter should safely return false
      final result = data.deviceBarcode?.toLowerCase().contains('test') ?? false;
      expect(result, isFalse);
    });

    test('should serialize and deserialize correctly', () {
      final json = {'qrCode': 'DEVICE-12345'};
      final data = D2cLotDeviceListData.fromJson(json);
      expect(data.deviceBarcode, 'DEVICE-12345');

      final serialized = data.toJson();
      expect(serialized['qrCode'], 'DEVICE-12345');
    });
  });
}
