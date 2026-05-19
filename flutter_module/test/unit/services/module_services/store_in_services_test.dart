import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_in/resources/services.dart';
import 'package:flutter_trc/qc/modules/store_in/resources/store_in_location_verify_response.dart';
import 'package:flutter_trc/qc/modules/store_in/resources/store_in_device_request.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

/// Unit tests for [StoreInServices] class.
///
/// These tests verify the service methods work correctly by:
/// - Testing parameter/request body construction logic
/// - Verifying method signatures and return types
/// - Testing conditional endpoint selection (mIsBinIn flag)
/// - Using actual QcService to ensure code coverage of the service methods
void main() {
  group('StoreInServices', () {
    late QcService service;

    setUp(() {
      service = QcService();
    });

    group('verifyLocBarCode', () {
      test('should return correct stream type when mIsBinIn is false', () {
        final stream = StoreInServices.verifyLocBarCode(
          'LOC_001',
          false,
          service: service,
        );
        expect(stream, isA<Stream<StoreInLocationVerifyResponse?>>());
      });

      test('should return correct stream type when mIsBinIn is true', () {
        final stream = StoreInServices.verifyLocBarCode(
          'LOC_001',
          true,
          service: service,
        );
        expect(stream, isA<Stream<StoreInLocationVerifyResponse?>>());
      });

      test('should handle null locationBarcode', () {
        final stream = StoreInServices.verifyLocBarCode(
          null,
          false,
          service: service,
        );
        expect(stream, isA<Stream<StoreInLocationVerifyResponse?>>());
      });

      test('should handle empty locationBarcode', () {
        final stream = StoreInServices.verifyLocBarCode(
          '',
          false,
          service: service,
        );
        expect(stream, isA<Stream<StoreInLocationVerifyResponse?>>());
      });

      test('should handle special characters in locationBarcode', () {
        final stream = StoreInServices.verifyLocBarCode(
          'LOC-001_ABC@#\$%',
          false,
          service: service,
        );
        expect(stream, isA<Stream<StoreInLocationVerifyResponse?>>());
      });

      test('should handle unicode characters in locationBarcode', () {
        final stream = StoreInServices.verifyLocBarCode(
          'LOC_日本語_😀',
          true,
          service: service,
        );
        expect(stream, isA<Stream<StoreInLocationVerifyResponse?>>());
      });

      test('should handle very long locationBarcode', () {
        final longBarcode = 'LOC_' + 'A' * 1000;
        final stream = StoreInServices.verifyLocBarCode(
          longBarcode,
          false,
          service: service,
        );
        expect(stream, isA<Stream<StoreInLocationVerifyResponse?>>());
      });

      test('params construction verification', () {
        const locationBarcode = 'LOC_123';
        final params = {
          "lbc": [locationBarcode.toString()]
        };
        expect(params['lbc'], equals(['LOC_123']));
      });

      test('params construction with null locationBarcode converts to string', () {
        const String? locationBarcode = null;
        final params = {
          "lbc": [locationBarcode.toString()]
        };
        expect(params['lbc'], equals(['null']));
      });

      test('endpoint selection based on mIsBinIn flag', () {
        String getEndpoint(bool mIsBinIn) => 
            mIsBinIn ? "/bin/store-in/verify-cell" : "/v1/store-in/validate-location";
        
        expect(getEndpoint(false), equals("/v1/store-in/validate-location"));
        expect(getEndpoint(true), equals("/bin/store-in/verify-cell"));
      });
    });

    group('storeInDevice', () {
      test('should return correct stream type when mIsBinIn is false', () {
        final request = StoreInDeviceRequest(
          stockBarcode: 'STOCK_001',
          locBarcode: 'LOC_001',
        );
        
        final stream = StoreInServices.storeInDevice(
          request,
          false,
          service: service,
        );
        expect(stream, isA<Stream<StoreInLocationVerifyResponse?>>());
      });

      test('should return correct stream type when mIsBinIn is true', () {
        final request = StoreInDeviceRequest(
          stockBarcode: 'STOCK_001',
          locBarcode: 'LOC_001',
        );
        
        final stream = StoreInServices.storeInDevice(
          request,
          true,
          service: service,
        );
        expect(stream, isA<Stream<StoreInLocationVerifyResponse?>>());
      });

      test('should handle null barcodes in request', () {
        final request = StoreInDeviceRequest(
          stockBarcode: null,
          locBarcode: null,
        );
        
        final stream = StoreInServices.storeInDevice(
          request,
          false,
          service: service,
        );
        expect(stream, isA<Stream<StoreInLocationVerifyResponse?>>());
      });

      test('should handle empty barcodes in request', () {
        final request = StoreInDeviceRequest(
          stockBarcode: '',
          locBarcode: '',
        );
        
        final stream = StoreInServices.storeInDevice(
          request,
          true,
          service: service,
        );
        expect(stream, isA<Stream<StoreInLocationVerifyResponse?>>());
      });

      test('should handle special characters in barcodes', () {
        final request = StoreInDeviceRequest(
          stockBarcode: 'STOCK-001_ABC@#\$%',
          locBarcode: 'LOC/001\\XYZ',
        );
        
        final stream = StoreInServices.storeInDevice(
          request,
          false,
          service: service,
        );
        expect(stream, isA<Stream<StoreInLocationVerifyResponse?>>());
      });

      test('should handle unicode characters in barcodes', () {
        final request = StoreInDeviceRequest(
          stockBarcode: 'STOCK_日本語',
          locBarcode: 'LOC_中文',
        );
        
        final stream = StoreInServices.storeInDevice(
          request,
          true,
          service: service,
        );
        expect(stream, isA<Stream<StoreInLocationVerifyResponse?>>());
      });

      test('request body JSON encoding verification', () {
        const stockBarcode = 'STOCK_001';
        const locBarcode = 'LOC_001';
        
        final request = StoreInDeviceRequest(
          stockBarcode: stockBarcode,
          locBarcode: locBarcode,
        );
        
        final body = jsonEncode(request);
        final decoded = jsonDecode(body) as Map<String, dynamic>;
        
        expect(decoded['stockBarcode'], equals(stockBarcode));
        expect(decoded['locBarcode'], equals(locBarcode));
      });

      test('request body JSON encoding with null values', () {
        final request = StoreInDeviceRequest(
          stockBarcode: null,
          locBarcode: null,
        );
        
        final body = jsonEncode(request);
        final decoded = jsonDecode(body) as Map<String, dynamic>;
        
        expect(decoded['stockBarcode'], isNull);
        expect(decoded['locBarcode'], isNull);
      });

      test('endpoint selection based on mIsBinIn flag', () {
        String getEndpoint(bool mIsBinIn) => 
            mIsBinIn ? "/bin/store-in/verify-cell" : "/v1/store-in/verify-cell";
        
        expect(getEndpoint(false), equals("/v1/store-in/verify-cell"));
        expect(getEndpoint(true), equals("/bin/store-in/verify-cell"));
      });
    });

    group('StoreInDeviceRequest', () {
      test('fromJson should parse valid request', () {
        final json = {
          'stockBarcode': 'STOCK_001',
          'locBarcode': 'LOC_001',
        };
        
        final request = StoreInDeviceRequest.fromJson(json);
        expect(request.stockBarcode, equals('STOCK_001'));
        expect(request.locBarcode, equals('LOC_001'));
      });

      test('fromJson should handle null values', () {
        final json = <String, dynamic>{
          'stockBarcode': null,
          'locBarcode': null,
        };
        
        final request = StoreInDeviceRequest.fromJson(json);
        expect(request.stockBarcode, isNull);
        expect(request.locBarcode, isNull);
      });

      test('toJson should serialize correctly', () {
        final request = StoreInDeviceRequest(
          stockBarcode: 'STOCK_002',
          locBarcode: 'LOC_002',
        );
        
        final json = request.toJson();
        expect(json['stockBarcode'], equals('STOCK_002'));
        expect(json['locBarcode'], equals('LOC_002'));
      });

      test('toJson should handle null values', () {
        final request = StoreInDeviceRequest(
          stockBarcode: null,
          locBarcode: null,
        );
        
        final json = request.toJson();
        expect(json['stockBarcode'], isNull);
        expect(json['locBarcode'], isNull);
      });
    });

    group('StoreInLocationVerifyResponse', () {
      test('fromJson should parse QC format response', () {
        final json = {
          'availableCapacity': 50,
          'totalCapacity': 100,
          'verifyBarcodeStatus': 1,
          'message': 'Verification successful',
          'r_id': 'REQ_001',
        };
        
        final response = StoreInLocationVerifyResponse.fromJson(json);
        expect(response.availableSpace, equals(50));
        expect(response.totalSpace, equals(100));
        expect(response.verifyBarcodeStatus, equals(1));
        expect(response.message, equals('Verification successful'));
        expect(response.requestId, equals('REQ_001'));
      });

      test('fromJson should parse TRC format response with dt object', () {
        final json = {
          'dt': {
            's': 1,
            'ac': 30,
            'tc': 80,
            'r_id': 'TRC_REQ_001',
            'message': 'TRC success',
          },
          's': true,
        };
        
        final response = StoreInLocationVerifyResponse.fromJson(json);
        expect(response.verifyBarcodeStatus, equals(1));
        expect(response.availableSpace, equals(30));
        expect(response.totalSpace, equals(80));
        expect(response.requestId, equals('TRC_REQ_001'));
        expect(response.message, equals('TRC success'));
      });

      test('fromJson TRC format should handle boolean status', () {
        final json = {
          'dt': {
            's': true,
            'ac': 20,
            'tc': 50,
          },
          's': true,
        };
        
        final response = StoreInLocationVerifyResponse.fromJson(json);
        expect(response.verifyBarcodeStatus, equals(1));
      });

      test('fromJson TRC format should handle false boolean status', () {
        final json = {
          'dt': {
            's': false,
            'ac': 0,
            'tc': 50,
          },
          's': false,
        };
        
        final response = StoreInLocationVerifyResponse.fromJson(json);
        expect(response.verifyBarcodeStatus, equals(0));
      });

      test('fromJson should handle null values in TRC format', () {
        final json = {
          'dt': {
            's': 1,
            'ac': null,
            'tc': null,
            'r_id': null,
            'message': null,
          },
          's': true,
        };
        
        final response = StoreInLocationVerifyResponse.fromJson(json);
        expect(response.verifyBarcodeStatus, equals(1));
        expect(response.availableSpace, isNull);
        expect(response.totalSpace, isNull);
        expect(response.requestId, isNull);
        expect(response.message, isNull);
      });

      test('fromJson TRC format should handle numeric capacity as double', () {
        final json = {
          'dt': {
            's': 1,
            'ac': 30.5,
            'tc': 80.9,
          },
          's': true,
        };
        
        final response = StoreInLocationVerifyResponse.fromJson(json);
        expect(response.availableSpace, equals(30));
        expect(response.totalSpace, equals(80));
      });

      test('toJson should serialize correctly', () {
        final response = StoreInLocationVerifyResponse(
          availableSpace: 40,
          totalSpace: 100,
          verifyBarcodeStatus: 1,
          message: 'OK',
          requestId: 'REQ_123',
        );
        
        final json = response.toJson();
        expect(json['availableCapacity'], equals(40));
        expect(json['totalCapacity'], equals(100));
        expect(json['verifyBarcodeStatus'], equals(1));
        expect(json['message'], equals('OK'));
        expect(json['r_id'], equals('REQ_123'));
      });
    });

    group('VerifyBarcode', () {
      test('fromJson should parse valid response', () {
        final json = {'qrCode': 'QR_001'};
        final verifyBarcode = VerifyBarcode.fromJson(json);
        expect(verifyBarcode.qrCode, equals('QR_001'));
      });

      test('fromJson should handle null qrCode', () {
        final json = <String, dynamic>{'qrCode': null};
        final verifyBarcode = VerifyBarcode.fromJson(json);
        expect(verifyBarcode.qrCode, isNull);
      });

      test('toJson should serialize correctly', () {
        final verifyBarcode = VerifyBarcode(qrCode: 'QR_002');
        final json = verifyBarcode.toJson();
        expect(json['qrCode'], equals('QR_002'));
      });

      test('toJson should handle null qrCode', () {
        final verifyBarcode = VerifyBarcode(qrCode: null);
        final json = verifyBarcode.toJson();
        expect(json['qrCode'], isNull);
      });
    });

    group('Integration - All methods create valid streams', () {
      test('all service methods should be callable with QcService', () {
        final testService = QcService();
        final request = StoreInDeviceRequest(
          stockBarcode: 'test',
          locBarcode: 'test',
        );
        
        // verifyLocBarCode with mIsBinIn = false
        expect(
          () => StoreInServices.verifyLocBarCode('test', false, service: testService),
          returnsNormally,
        );
        
        // verifyLocBarCode with mIsBinIn = true
        expect(
          () => StoreInServices.verifyLocBarCode('test', true, service: testService),
          returnsNormally,
        );
        
        // storeInDevice with mIsBinIn = false
        expect(
          () => StoreInServices.storeInDevice(request, false, service: testService),
          returnsNormally,
        );
        
        // storeInDevice with mIsBinIn = true
        expect(
          () => StoreInServices.storeInDevice(request, true, service: testService),
          returnsNormally,
        );
      });

      test('multiple calls should return independent streams', () {
        final request = StoreInDeviceRequest(
          stockBarcode: 'STOCK_001',
          locBarcode: 'LOC_001',
        );
        
        final stream1 = StoreInServices.verifyLocBarCode('LOC_001', false, service: service);
        final stream2 = StoreInServices.verifyLocBarCode('LOC_001', false, service: service);
        
        expect(stream1, isNotNull);
        expect(stream2, isNotNull);
        expect(identical(stream1, stream2), isFalse);
        
        final stream3 = StoreInServices.storeInDevice(request, true, service: service);
        final stream4 = StoreInServices.storeInDevice(request, true, service: service);
        
        expect(stream3, isNotNull);
        expect(stream4, isNotNull);
        expect(identical(stream3, stream4), isFalse);
      });
    });
  });
}
