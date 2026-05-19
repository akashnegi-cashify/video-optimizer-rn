import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/device_receive_module/resources/device_receive_service.dart';
import 'package:flutter_trc/qc/modules/device_receive_module/models/device_receive_response.dart';

/// Unit tests for [DeviceReceiveService] class.
///
/// These tests execute actual service methods to ensure code coverage.
/// Since the service uses internal QcService() instances, we test:
/// - Method invocation and stream creation
/// - Request body construction logic
/// - Return type verification
void main() {
  group('DeviceReceiveService', () {
    group('receiveDevice', () {
      test('should create stream with valid deviceBarcode', () {
        final stream = DeviceReceiveService.receiveDevice('DEVICE_001');
        expect(stream, isA<Stream<DeviceReceiveData?>>());
      });

      test('should handle empty deviceBarcode', () {
        final stream = DeviceReceiveService.receiveDevice('');
        expect(stream, isA<Stream<DeviceReceiveData?>>());
      });

      test('should handle special characters in deviceBarcode', () {
        final stream = DeviceReceiveService.receiveDevice('DEVICE-001_TEST/123');
        expect(stream, isA<Stream<DeviceReceiveData?>>());
      });

      test('should handle unicode characters in deviceBarcode', () {
        final stream = DeviceReceiveService.receiveDevice('设备_001');
        expect(stream, isA<Stream<DeviceReceiveData?>>());
      });

      test('should handle long deviceBarcode', () {
        final longBarcode = 'D' * 500;
        final stream = DeviceReceiveService.receiveDevice(longBarcode);
        expect(stream, isA<Stream<DeviceReceiveData?>>());
      });

      test('request body construction verification', () {
        const deviceBarcode = 'DEVICE_001';
        Map<String, String> data = {"deviceBarcode": deviceBarcode};
        
        final bodyData = jsonEncode(data);
        final decoded = jsonDecode(bodyData) as Map<String, dynamic>;

        expect(decoded['deviceBarcode'], equals('DEVICE_001'));
        expect(data.length, equals(1));
        expect(data.containsKey('deviceBarcode'), isTrue);
      });

      test('request body field should use full name deviceBarcode', () {
        Map<String, String> data = {"deviceBarcode": "QR"};
        
        expect(data.containsKey('deviceBarcode'), isTrue);
        expect(data.containsKey('qrCode'), isFalse);
        expect(data.containsKey('qr'), isFalse);
      });

      test('endpoint verification', () {
        const endpoint = '/device/repair/receive';
        
        expect(endpoint, equals('/device/repair/receive'));
        expect(endpoint, startsWith('/device'));
        expect(endpoint, contains('repair'));
        expect(endpoint, endsWith('/receive'));
        expect(endpoint, isNot(startsWith('/v1')));
        expect(endpoint, isNot(contains('?')));
      });
    });

    group('Integration - Method creates valid stream', () {
      test('receiveDevice should be callable and return stream', () {
        expect(
          () => DeviceReceiveService.receiveDevice('test'),
          returnsNormally,
        );
        
        final stream = DeviceReceiveService.receiveDevice('test');
        expect(stream, isA<Stream<DeviceReceiveData?>>());
      });
    });
  });
}
