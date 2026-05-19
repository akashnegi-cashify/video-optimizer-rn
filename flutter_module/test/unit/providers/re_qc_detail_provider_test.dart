import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/re_qc/providers/re_qc_detail_provider.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/re_qc_list_response.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/lot_device_list_response.dart';
import '../../helpers/provider_test_helpers.dart';

/// Testable subclass that doesn't make API calls in constructor
class TestableReQcDetailProvider extends ReQcDetailProvider {
  TestableReQcDetailProvider(super.reQcListData);
  
  @override
  Future<bool> getDeviceList() async {
    // Skip API call in tests
    return true;
  }
}

/// Tests for ReQcDetailProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('ReQcDetailProvider', () {
    late TestableReQcDetailProvider provider;
    late ReQcListData mockReQcListData;

    setUp(() {
      // Create test data with correct JSON keys
      mockReQcListData = ReQcListData.fromJson({
        'id': 123,
        'lotGroupName': 'Test Lot Group',
        'lotCount': 10,
      });
      provider = TestableReQcDetailProvider(mockReQcListData);
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor and initial state', () {
      test('should store reQcListData', () {
        expect(provider.reQcListData, mockReQcListData);
      });

      test('isLoading should initially be true', () {
        expect(provider.isLoading, true);
      });

      test('deviceList should initially be null', () {
        expect(provider.deviceList, isNull);
      });

      test('errorMessage should initially be null', () {
        expect(provider.errorMessage, isNull);
      });

      test('scannedDeviceBarcode should initially be null', () {
        expect(provider.scannedDeviceBarcode, isNull);
      });

      test('deviceReportList should initially be null', () {
        expect(provider.deviceReportList, isNull);
      });
    });

    group('lotName getter', () {
      test('should return lotGroupName from reQcListData', () {
        expect(provider.lotName, 'Test Lot Group');
      });

      test('should return empty string when lotGroupName is null', () {
        final providerWithNull = TestableReQcDetailProvider(
          ReQcListData.fromJson({'id': 123}),
        );
        expect(providerWithNull.lotName, '');
        providerWithNull.dispose();
      });
    });

    group('lotId getter', () {
      test('should return lotId from reQcListData', () {
        expect(provider.lotId, 123);
      });

      test('should return null when lotId is not set', () {
        final providerWithNull = TestableReQcDetailProvider(
          ReQcListData.fromJson({'lotGroupName': 'Test'}),
        );
        expect(providerWithNull.lotId, isNull);
        providerWithNull.dispose();
      });
    });

    group('getDoneStatusCount', () {
      test('should return null when deviceList is null', () {
        provider.deviceList = null;
        expect(provider.getDoneStatusCount(), isNull);
      });

      test('should return null when deviceList is empty', () {
        provider.deviceList = [];
        expect(provider.getDoneStatusCount(), isNull);
      });

      test('should return correct count when all devices are pending', () {
        provider.deviceList = [
          LotDeviceListData.fromJson({'did': 1, 'status': 0}),
          LotDeviceListData.fromJson({'did': 2, 'status': 0}),
          LotDeviceListData.fromJson({'did': 3, 'status': 0}),
        ];

        expect(provider.getDoneStatusCount(), '0/3');
      });

      test('should return correct count when some devices are done', () {
        provider.deviceList = [
          LotDeviceListData.fromJson({'did': 1, 'status': 1}),
          LotDeviceListData.fromJson({'did': 2, 'status': 0}),
          LotDeviceListData.fromJson({'did': 3, 'status': 1}),
        ];

        expect(provider.getDoneStatusCount(), '2/3');
      });

      test('should return correct count when all devices are done', () {
        provider.deviceList = [
          LotDeviceListData.fromJson({'did': 1, 'status': 1}),
          LotDeviceListData.fromJson({'did': 2, 'status': 1}),
        ];

        expect(provider.getDoneStatusCount(), '2/2');
      });
    });

    group('getLotListData', () {
      test('should return null when deviceList is null', () {
        provider.deviceList = null;
        provider.scannedDeviceBarcode = 'ABC123';

        expect(provider.getLotListData(), isNull);
      });

      test('should return null when scannedDeviceBarcode is not found', () {
        provider.deviceList = [
          LotDeviceListData.fromJson({'did': 1, 'qrCode': 'DEF456'}),
        ];
        provider.scannedDeviceBarcode = 'ABC123';

        expect(provider.getLotListData(), isNull);
      });

      test('should return device data when barcode matches (case insensitive)', () {
        provider.deviceList = [
          LotDeviceListData.fromJson({'did': 1, 'qrCode': 'ABC123'}),
          LotDeviceListData.fromJson({'did': 2, 'qrCode': 'DEF456'}),
        ];
        provider.scannedDeviceBarcode = 'abc123';

        final result = provider.getLotListData();
        expect(result, isNotNull);
        expect(result?.qrCode, 'ABC123');
      });

      test('should return null when scannedDeviceBarcode is null', () {
        provider.deviceList = [
          LotDeviceListData.fromJson({'did': 1, 'qrCode': 'ABC123'}),
        ];
        provider.scannedDeviceBarcode = null;

        expect(provider.getLotListData(), isNull);
      });
    });

    group('isAllDeviceReQcComplete', () {
      test('should return true when deviceList is null', () {
        provider.deviceList = null;
        expect(provider.isAllDeviceReQcComplete(), true);
      });

      test('should return true when deviceList is empty', () {
        provider.deviceList = [];
        expect(provider.isAllDeviceReQcComplete(), true);
      });

      test('should return true when all devices have status != 0', () {
        provider.deviceList = [
          LotDeviceListData.fromJson({'did': 1, 'status': 1}),
          LotDeviceListData.fromJson({'did': 2, 'status': 2}),
        ];

        expect(provider.isAllDeviceReQcComplete(), true);
      });

      test('should return false when any device has status 0', () {
        provider.deviceList = [
          LotDeviceListData.fromJson({'did': 1, 'status': 1}),
          LotDeviceListData.fromJson({'did': 2, 'status': 0}),
        ];

        expect(provider.isAllDeviceReQcComplete(), false);
      });

      test('should return false when all devices have status 0', () {
        provider.deviceList = [
          LotDeviceListData.fromJson({'did': 1, 'status': 0}),
          LotDeviceListData.fromJson({'did': 2, 'status': 0}),
        ];

        expect(provider.isAllDeviceReQcComplete(), false);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(ReQcDetailProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = TestableReQcDetailProvider(mockReQcListData);
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });

    group('method signatures', () {
      test('should have getDeviceList method', () {
        expect(provider.getDeviceList, isNotNull);
      });

      test('should have getDeviceReportList method', () {
        expect(provider.getDeviceReportList, isNotNull);
      });

      test('should have getDeviceAccessories method', () {
        expect(provider.getDeviceAccessories, isNotNull);
      });

      test('should have completeReQc method', () {
        expect(provider.completeReQc, isNotNull);
      });
    });
  });
}
