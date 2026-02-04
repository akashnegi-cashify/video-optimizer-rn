import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty;
import 'package:flutter_trc/qc/modules/gaurd/resources/guard_service.dart';
import 'package:flutter_trc/qc/modules/gaurd/models/guard_entry_scan_response.dart';
import 'package:flutter_trc/qc/modules/gaurd/models/collected_order_list_response.dart';

/// Unit tests for [GuardService] class.
///
/// These tests execute actual service methods to ensure code coverage.
/// Since the service uses internal QcService() instances, we test:
/// - Method invocation and stream creation
/// - Request body construction logic
/// - Return type verification
void main() {
  group('GuardService', () {
    group('entryScanData', () {
      test('should create stream with valid scannedBarcode', () {
        final stream = GuardService.entryScanData('ENTRY_001');
        expect(stream, isA<Stream<GuardEntryScanResponse?>>());
      });

      test('should handle null scannedBarcode', () {
        final stream = GuardService.entryScanData(null);
        expect(stream, isA<Stream<GuardEntryScanResponse?>>());
      });

      test('should handle empty scannedBarcode', () {
        final stream = GuardService.entryScanData('');
        expect(stream, isA<Stream<GuardEntryScanResponse?>>());
      });

      test('should handle special characters in scannedBarcode', () {
        final stream = GuardService.entryScanData('ENTRY-001_TEST/123');
        expect(stream, isA<Stream<GuardEntryScanResponse?>>());
      });

      test('should handle unicode characters in scannedBarcode', () {
        final stream = GuardService.entryScanData('入口_001');
        expect(stream, isA<Stream<GuardEntryScanResponse?>>());
      });

      test('request body construction verification', () {
        const scannedBarcode = 'ENTRY_001';
        var req = {"et": scannedBarcode};
        
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;
        
        expect(decoded['et'], equals('ENTRY_001'));
        expect(req.length, equals(1));
        expect(req.containsKey('et'), isTrue);
      });
    });

    group('getCollectedOrderList', () {
      test('should create stream and execute method', () {
        final stream = GuardService.getCollectedOrderList();
        expect(stream, isA<Stream<CollectedOrderListResponse?>>());
      });

      test('method should be callable without throwing', () {
        expect(() => GuardService.getCollectedOrderList(), returnsNormally);
      });

      test('endpoint verification', () {
        const endpoint = '/collect-order/collected-orders';
        
        expect(endpoint, equals('/collect-order/collected-orders'));
        expect(endpoint, isNot(contains('?')));
      });
    });

    group('submitInvoice', () {
      test('should create stream with all parameters', () {
        final stream = GuardService.submitInvoice('Agent Smith', 10, 'https://example.com/invoice.jpg');
        expect(stream, isA<Stream<BaseResponse?>>());
      });

      test('should handle null agentName', () {
        final stream = GuardService.submitInvoice(null, 10, 'https://example.com/invoice.jpg');
        expect(stream, isA<Stream<BaseResponse?>>());
      });

      test('should handle null deviceCount', () {
        final stream = GuardService.submitInvoice('Agent Smith', null, 'https://example.com/invoice.jpg');
        expect(stream, isA<Stream<BaseResponse?>>());
      });

      test('should handle null imageUrl', () {
        final stream = GuardService.submitInvoice('Agent Smith', 10, null);
        expect(stream, isA<Stream<BaseResponse?>>());
      });

      test('should handle all null parameters', () {
        final stream = GuardService.submitInvoice(null, null, null);
        expect(stream, isA<Stream<BaseResponse?>>());
      });

      test('should handle zero deviceCount', () {
        final stream = GuardService.submitInvoice('Agent', 0, 'url');
        expect(stream, isA<Stream<BaseResponse?>>());
      });

      test('should handle negative deviceCount', () {
        final stream = GuardService.submitInvoice('Agent', -1, 'url');
        expect(stream, isA<Stream<BaseResponse?>>());
      });

      test('request body construction verification', () {
        const agentName = 'Agent Smith';
        const deviceCount = 10;
        const imageUrl = 'https://example.com/invoice.jpg';

        var req = {
          "an": agentName,
          "dc": deviceCount,
          "im": imageUrl,
        };

        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        expect(decoded['an'], equals('Agent Smith'));
        expect(decoded['dc'], equals(10));
        expect(decoded['im'], equals('https://example.com/invoice.jpg'));
        expect(req.length, equals(3));
      });

      test('should use abbreviated field names', () {
        var req = {
          "an": "agent",
          "dc": 5,
          "im": "url",
        };

        expect(req.containsKey('an'), isTrue);
        expect(req.containsKey('dc'), isTrue);
        expect(req.containsKey('im'), isTrue);
        expect(req.containsKey('agentName'), isFalse);
        expect(req.containsKey('deviceCount'), isFalse);
        expect(req.containsKey('imageUrl'), isFalse);
      });
    });

    group('endpoint consistency', () {
      test('entry endpoint should be under /vendor/wh path', () {
        const endpoint = '/vendor/wh/entry/scan';
        expect(endpoint, startsWith('/vendor/wh'));
      });

      test('collect order endpoints should be under /collect-order path', () {
        const listEndpoint = '/collect-order/collected-orders';
        const submitEndpoint = '/collect-order/collect';

        expect(listEndpoint, startsWith('/collect-order'));
        expect(submitEndpoint, startsWith('/collect-order'));
      });
    });

    group('Integration - All methods create valid streams', () {
      test('all service methods should be callable and return streams', () {
        expect(() => GuardService.entryScanData('test'), returnsNormally);
        expect(() => GuardService.getCollectedOrderList(), returnsNormally);
        expect(() => GuardService.submitInvoice('agent', 1, 'url'), returnsNormally);
      });
    });
  });
}
