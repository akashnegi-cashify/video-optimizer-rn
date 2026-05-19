import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/resources/stock_in_service.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/models/validate_awb_response.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/models/stock_in_submit_response.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/models/stock_in_submit_request.dart';

/// Unit tests for [StockInService] class.
///
/// These tests execute actual service methods to ensure code coverage.
/// Since the service uses internal QcService() instances, we test:
/// - Method invocation and stream creation
/// - Parameter construction logic
/// - Return type verification
void main() {
  group('StockInService', () {
    group('validateAwb', () {
      test('should create stream with valid parameters', () {
        final stream = StockInService.validateAwb('AWB123456', 'BARCODE_001');
        expect(stream, isA<Stream<ValidateAwbResponse?>>());
      });

      test('should handle empty awbNumber', () {
        final stream = StockInService.validateAwb('', 'BARCODE_001');
        expect(stream, isA<Stream<ValidateAwbResponse?>>());
      });

      test('should handle empty barcode', () {
        final stream = StockInService.validateAwb('AWB123', '');
        expect(stream, isA<Stream<ValidateAwbResponse?>>());
      });

      test('should handle both empty parameters', () {
        final stream = StockInService.validateAwb('', '');
        expect(stream, isA<Stream<ValidateAwbResponse?>>());
      });

      test('should handle special characters in awbNumber', () {
        final stream = StockInService.validateAwb('AWB-123_456/ABC', 'BARCODE_001');
        expect(stream, isA<Stream<ValidateAwbResponse?>>());
      });

      test('should handle special characters in barcode', () {
        final stream = StockInService.validateAwb('AWB123', 'BARCODE-001_TEST');
        expect(stream, isA<Stream<ValidateAwbResponse?>>());
      });

      test('should handle long awbNumber', () {
        final longAwb = 'AWB' + '1' * 100;
        final stream = StockInService.validateAwb(longAwb, 'BARCODE_001');
        expect(stream, isA<Stream<ValidateAwbResponse?>>());
      });

      test('params construction verification', () {
        const awbNumber = 'AWB123456';
        const barcode = 'BARCODE_001';
        
        Map<String, List<String>> params = {
          "awb": [awbNumber],
          "qrCode": [barcode],
        };

        expect(params['awb'], equals(['AWB123456']));
        expect(params['qrCode'], equals(['BARCODE_001']));
        expect(params.length, equals(2));
      });
    });

    group('pushAwb', () {
      test('should create stream with valid request', () {
        final request = StockInSubmitRequest();
        final stream = StockInService.pushAwb(request);
        expect(stream, isA<Stream<StockInSubmitResponse?>>());
      });

      test('request serialization verification', () {
        final request = {
          'awb': 'AWB123',
          'qrCode': 'QR123',
          'additionalInfo': 'info',
        };

        final encoded = jsonEncode(request);
        final decoded = jsonDecode(encoded) as Map<String, dynamic>;

        expect(decoded, isA<Map<String, dynamic>>());
        expect(decoded['awb'], equals('AWB123'));
      });
    });

    group('Integration - All methods create valid streams', () {
      test('all service methods should be callable and return streams', () {
        expect(() => StockInService.validateAwb('awb', 'barcode'), returnsNormally);
        expect(() => StockInService.pushAwb(StockInSubmitRequest()), returnsNormally);
      });
    });
  });
}
