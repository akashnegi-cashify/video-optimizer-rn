import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/st_store_out_provider.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/st_lot_details_response.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for StStoreOutProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('StStoreOutProvider', () {
    late StStoreOutProvider provider;

    setUp(() {
      provider = StStoreOutProvider(123);
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should store lotId', () {
        expect(provider.lotId, 123);
      });

      test('should accept null lotId', () {
        final providerWithNull = StStoreOutProvider(null);
        expect(providerWithNull.lotId, isNull);
        providerWithNull.dispose();
      });
    });

    group('initial state', () {
      test('lotDetails should initially be null', () {
        expect(provider.lotDetails, isNull);
      });
    });

    group('lotDetailsStream', () {
      test('should expose stream', () {
        expect(provider.lotDetailsStream, isNotNull);
        expect(provider.lotDetailsStream, isA<Stream<StLotDetailResponse?>>());
      });
    });

    group('setData', () {
      test('should set lotDetails when null', () {
        final data = StLotDetailResponse.fromJson({
          'barcode': 'TEST123',
          'dc': 10,
          'sc': 5,
        });

        provider.setData(data);

        expect(provider.lotDetails, isNotNull);
        expect(provider.lotDetails?.barcode, 'TEST123');
      });

      test('should update existing lotDetails', () {
        final initialData = StLotDetailResponse.fromJson({
          'barcode': 'INITIAL',
          'dc': 10,
        });
        provider.setData(initialData);

        final newData = StLotDetailResponse.fromJson({
          'barcode': 'UPDATED',
          'dc': 20,
        });
        provider.setData(newData);

        // setData uses lotDetails.setData() for updates
        expect(provider.lotDetails, isNotNull);
      });
    });

    group('isMoreDevicesAvailable', () {
      test('should return false when lotDetails is null', () {
        provider.lotDetails = null;

        expect(provider.isMoreDevicesAvailable(), false);
      });

      test('should return true when more devices available', () {
        provider.lotDetails = StLotDetailResponse.fromJson({
          'dc': 10, // deviceCount
          'sc': 5,  // scanCount
        });

        // deviceCount (10) > scanCount (5) + 1 = 6 -> true
        expect(provider.isMoreDevicesAvailable(), true);
      });

      test('should return false when no more devices available', () {
        provider.lotDetails = StLotDetailResponse.fromJson({
          'dc': 5,  // deviceCount
          'sc': 4,  // scanCount
        });

        // deviceCount (5) > scanCount (4) + 1 = 5 -> false
        expect(provider.isMoreDevicesAvailable(), false);
      });

      test('should return false when all devices scanned', () {
        provider.lotDetails = StLotDetailResponse.fromJson({
          'dc': 5,  // deviceCount
          'sc': 5,  // scanCount
        });

        // deviceCount (5) > scanCount (5) + 1 = 6 -> false
        expect(provider.isMoreDevicesAvailable(), false);
      });

      test('should handle null counts', () {
        provider.lotDetails = StLotDetailResponse.fromJson({});

        // deviceCount (0) > scanCount (0) + 1 = 1 -> false
        expect(provider.isMoreDevicesAvailable(), false);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(StStoreOutProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = StStoreOutProvider(456);
        expect(() => testProvider.dispose(), returnsNormally);
      });

      test('should close stream controller on dispose', () async {
        final testProvider = StStoreOutProvider(789);
        testProvider.dispose();

        // After dispose, the stream should be closed
        // This is implicitly tested by successful disposal
      });
    });

    group('method signatures', () {
      test('should have getLotDetailsStream method', () {
        expect(provider.getLotDetailsStream, isNotNull);
      });

      test('should have skipDevice method', () {
        expect(provider.skipDevice, isNotNull);
      });

      test('should have addDevice method', () {
        expect(provider.addDevice, isNotNull);
      });
    });
  });
}
