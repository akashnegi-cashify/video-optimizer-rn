import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_in/resources/store_in_device_request.dart';
import 'package:flutter_trc/qc/modules/store_in/resources/store_in_location_verify_response.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for StoreInProvider - the actual provider implementation.
/// Note: StoreInProvider extends QcTrcServiceInitProvider which makes API calls
/// on construction and requires Flutter binding initialization.
/// These tests focus on the data model classes and provider structure tests
/// that don't require the full provider instantiation.
void main() {
  // Note: StoreInProvider cannot be easily unit tested because it:
  // 1. Extends QcTrcServiceInitProvider which calls initService() in constructor
  // 2. initService() calls AppPreferences which requires GetStorage/SharedPreferences
  // 3. The constructor immediately makes API calls via verifyStoreInDetails()
  // 
  // These dependencies make it untestable without significant refactoring to DI.
  // We test the data model classes and document the provider's expected behavior.

  group('StoreInDeviceRequest', () {
    test('should create request with stockBarcode and locBarcode', () {
      final request = StoreInDeviceRequest(
        stockBarcode: 'STOCK001',
        locBarcode: 'LOC001',
      );

      expect(request.stockBarcode, 'STOCK001');
      expect(request.locBarcode, 'LOC001');
    });

    test('should create request with null values', () {
      final request = StoreInDeviceRequest(
        stockBarcode: null,
        locBarcode: null,
      );

      expect(request.stockBarcode, isNull);
      expect(request.locBarcode, isNull);
    });

    test('should serialize to JSON correctly', () {
      final request = StoreInDeviceRequest(
        stockBarcode: 'STOCK001',
        locBarcode: 'LOC001',
      );

      final json = request.toJson();

      expect(json['stockBarcode'], 'STOCK001');
      expect(json['locBarcode'], 'LOC001');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'stockBarcode': 'STOCK002',
        'locBarcode': 'LOC002',
      };

      final request = StoreInDeviceRequest.fromJson(json);

      expect(request.stockBarcode, 'STOCK002');
      expect(request.locBarcode, 'LOC002');
    });
  });

  group('StoreInLocationVerifyResponse', () {
    test('should create response with all fields', () {
      final response = StoreInLocationVerifyResponse(
        availableSpace: 10,
        totalSpace: 100,
        verifyBarcodeStatus: 1,
        message: 'Success',
        requestId: 'REQ001',
      );

      expect(response.availableSpace, 10);
      expect(response.totalSpace, 100);
      expect(response.verifyBarcodeStatus, 1);
      expect(response.message, 'Success');
      expect(response.requestId, 'REQ001');
    });

    test('should handle QC format fromJson', () {
      final json = {
        's': 1,
        'availableCapacity': 50,
        'totalCapacity': 100,
        'message': 'OK',
      };

      final response = StoreInLocationVerifyResponse.fromJson(json);

      expect(response.availableSpace, 50);
      expect(response.totalSpace, 100);
    });

    test('should handle TRC format fromJson with dt object', () {
      final json = {
        'dt': {
          'r_id': 'REQ123',
          'ac': 25,
          'tc': 50,
          's': 1,
          'message': 'Success',
        },
        's': true,
      };

      final response = StoreInLocationVerifyResponse.fromJson(json);

      expect(response.requestId, 'REQ123');
      expect(response.availableSpace, 25);
      expect(response.totalSpace, 50);
      expect(response.verifyBarcodeStatus, 1);
    });

    test('should handle TRC format with boolean status', () {
      final json = {
        'dt': {
          'r_id': 'REQ456',
          'ac': 10,
          'tc': 20,
          's': true,
        },
        's': true,
      };

      final response = StoreInLocationVerifyResponse.fromJson(json);

      expect(response.verifyBarcodeStatus, 1);
    });

    test('should handle TRC format with false status', () {
      final json = {
        'dt': {
          'r_id': 'REQ789',
          'ac': 0,
          'tc': 10,
          's': false,
        },
        's': true,
      };

      final response = StoreInLocationVerifyResponse.fromJson(json);

      expect(response.verifyBarcodeStatus, 0);
    });

    test('should serialize to JSON correctly', () {
      final response = StoreInLocationVerifyResponse(
        availableSpace: 10,
        totalSpace: 100,
        verifyBarcodeStatus: 1,
        message: 'Test',
        requestId: 'REQ001',
      );

      final json = response.toJson();

      expect(json['availableCapacity'], 10);
      expect(json['totalCapacity'], 100);
      expect(json['verifyBarcodeStatus'], 1);
      expect(json['message'], 'Test');
      expect(json['r_id'], 'REQ001');
    });
  });

  group('VerifyBarcode', () {
    test('should create with qrCode', () {
      final verifyBarcode = VerifyBarcode(qrCode: 'QR001');
      expect(verifyBarcode.qrCode, 'QR001');
    });

    test('should create with null qrCode', () {
      final verifyBarcode = VerifyBarcode(qrCode: null);
      expect(verifyBarcode.qrCode, isNull);
    });

    test('should serialize to JSON', () {
      final verifyBarcode = VerifyBarcode(qrCode: 'QR001');
      final json = verifyBarcode.toJson();
      expect(json['qrCode'], 'QR001');
    });

    test('should deserialize from JSON', () {
      final json = {'qrCode': 'QR002'};
      final verifyBarcode = VerifyBarcode.fromJson(json);
      expect(verifyBarcode.qrCode, 'QR002');
    });
  });
}
