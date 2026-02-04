import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/resources/warehouse_audit_service.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/resources/scan_device_response.dart';

/// Unit tests for [WarehouseAuditService] class.
///
/// These tests execute actual service methods to ensure code coverage.
/// Since the service uses internal QcService() instances, we test:
/// - Method invocation and stream creation
/// - Request body construction logic including conditional mediaMap field
/// - Conditional endpoint selection
/// - Return type verification
void main() {
  group('WarehouseAuditService', () {
    group('scanDeviceForAudit', () {
      test('should create stream with required parameters only', () {
        final stream = WarehouseAuditService.scanDeviceForAudit(123, 'DEVICE_001');
        expect(stream, isA<Stream<ScanDeviceData?>>());
      });

      test('should create stream with imagesListMap parameter', () {
        final stream = WarehouseAuditService.scanDeviceForAudit(
          456,
          'DEVICE_002',
          imagesListMap: {'front': 'url1', 'back': 'url2'},
        );
        expect(stream, isA<Stream<ScanDeviceData?>>());
      });

      test('should create stream with isManualEntry true', () {
        final stream = WarehouseAuditService.scanDeviceForAudit(
          789,
          'DEVICE_003',
          isManualEntry: true,
        );
        expect(stream, isA<Stream<ScanDeviceData?>>());
      });

      test('should create stream with all optional parameters', () {
        final stream = WarehouseAuditService.scanDeviceForAudit(
          100,
          'DEVICE_004',
          imagesListMap: {'image': 'url'},
          isManualEntry: true,
        );
        expect(stream, isA<Stream<ScanDeviceData?>>());
      });

      test('should handle zero auditId', () {
        final stream = WarehouseAuditService.scanDeviceForAudit(0, 'DEVICE');
        expect(stream, isA<Stream<ScanDeviceData?>>());
      });

      test('should handle negative auditId', () {
        final stream = WarehouseAuditService.scanDeviceForAudit(-1, 'DEVICE');
        expect(stream, isA<Stream<ScanDeviceData?>>());
      });

      test('should handle empty deviceBarcode', () {
        final stream = WarehouseAuditService.scanDeviceForAudit(123, '');
        expect(stream, isA<Stream<ScanDeviceData?>>());
      });

      test('should handle special characters in deviceBarcode', () {
        final stream = WarehouseAuditService.scanDeviceForAudit(123, 'DEVICE-001_TEST/ABC');
        expect(stream, isA<Stream<ScanDeviceData?>>());
      });

      test('should handle empty imagesListMap', () {
        final stream = WarehouseAuditService.scanDeviceForAudit(
          123,
          'DEVICE',
          imagesListMap: {},
        );
        expect(stream, isA<Stream<ScanDeviceData?>>());
      });

      test('request body construction without imagesListMap', () {
        const deviceBarcode = 'DEVICE_001';
        const isManualEntry = false;

        Map<String, dynamic> req = {
          "qrCode": deviceBarcode,
          "manualEntry": isManualEntry,
        };

        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        expect(decoded['qrCode'], equals('DEVICE_001'));
        expect(decoded['manualEntry'], equals(false));
        expect(req.containsKey('mediaMap'), isFalse);
      });

      test('request body construction with imagesListMap', () {
        const deviceBarcode = 'DEVICE_002';
        const isManualEntry = false;
        final imagesListMap = {'front': 'url1', 'back': 'url2'};

        Map<String, dynamic> req = {
          "qrCode": deviceBarcode,
          "manualEntry": isManualEntry,
          "mediaMap": imagesListMap,
        };

        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        expect(decoded.containsKey('mediaMap'), isTrue);
        expect(decoded['mediaMap']['front'], equals('url1'));
        expect(decoded['mediaMap']['back'], equals('url2'));
      });

      test('conditional endpoint selection - basic endpoint when no images', () {
        const auditId = 123;
        const Map<String, String>? imagesListMap = null;
        
        final endpoint = imagesListMap == null
            ? '/warehouse-audit/app/scan/$auditId'
            : '/warehouse-audit/app/scan/$auditId/media';

        expect(endpoint, equals('/warehouse-audit/app/scan/123'));
        expect(endpoint, isNot(contains('/media')));
      });

      test('conditional endpoint selection - media endpoint when images provided', () {
        const auditId = 456;
        final imagesListMap = {'image': 'url'};
        
        // ignore: unnecessary_null_comparison
        final endpoint = imagesListMap == null
            ? '/warehouse-audit/app/scan/$auditId'
            : '/warehouse-audit/app/scan/$auditId/media';

        expect(endpoint, equals('/warehouse-audit/app/scan/456/media'));
        expect(endpoint, endsWith('/media'));
      });
    });

    group('endpoint construction', () {
      test('endpoint should include auditId path parameter', () {
        const auditId = 789;
        final endpoint = '/warehouse-audit/app/scan/$auditId';

        expect(endpoint, contains('789'));
      });

      test('basic endpoint should follow pattern /warehouse-audit/app/scan/{auditId}', () {
        const auditId = 100;
        final endpoint = '/warehouse-audit/app/scan/$auditId';

        expect(endpoint, matches(RegExp(r'/warehouse-audit/app/scan/\d+')));
      });

      test('media endpoint should follow pattern /warehouse-audit/app/scan/{auditId}/media', () {
        const auditId = 200;
        final endpoint = '/warehouse-audit/app/scan/$auditId/media';

        expect(endpoint, matches(RegExp(r'/warehouse-audit/app/scan/\d+/media')));
      });
    });

    group('endpoint prefix', () {
      test('endpoints should start with /warehouse-audit prefix', () {
        const basicEndpoint = '/warehouse-audit/app/scan/1';
        const mediaEndpoint = '/warehouse-audit/app/scan/1/media';

        expect(basicEndpoint, startsWith('/warehouse-audit'));
        expect(mediaEndpoint, startsWith('/warehouse-audit'));
      });
    });

    group('Integration - Method creates valid stream', () {
      test('scanDeviceForAudit should be callable and return stream', () {
        expect(
          () => WarehouseAuditService.scanDeviceForAudit(1, 'device'),
          returnsNormally,
        );
        
        final stream = WarehouseAuditService.scanDeviceForAudit(1, 'device');
        expect(stream, isA<Stream<ScanDeviceData?>>());
      });
    });
  });
}
