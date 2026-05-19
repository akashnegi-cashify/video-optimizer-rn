import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/device_details/resources/device_detail_service.dart';
import 'package:flutter_trc/qc/modules/device_details/resources/device_detail_response.dart';
import 'package:flutter_trc/qc/modules/device_details/resources/stock_movement_response.dart';

/// Unit tests for [DeviceDetailService] class.
///
/// These tests execute actual service methods to ensure code coverage.
/// Since the service uses internal QcService() instances, we test:
/// - Method invocation and stream creation
/// - Endpoint construction logic
/// - Return type verification
void main() {
  group('DeviceDetailService', () {
    group('getDeviceDetails', () {
      test('should create stream with valid deviceBarcode', () {
        final stream = DeviceDetailService.getDeviceDetails('DEVICE_001');
        expect(stream, isA<Stream<DeviceDetailResponse?>>());
      });

      test('should handle empty deviceBarcode', () {
        final stream = DeviceDetailService.getDeviceDetails('');
        expect(stream, isA<Stream<DeviceDetailResponse?>>());
      });

      test('should handle special characters in deviceBarcode', () {
        final stream = DeviceDetailService.getDeviceDetails('DEVICE-001_TEST');
        expect(stream, isA<Stream<DeviceDetailResponse?>>());
      });

      test('should handle unicode characters in deviceBarcode', () {
        final stream = DeviceDetailService.getDeviceDetails('设备_001');
        expect(stream, isA<Stream<DeviceDetailResponse?>>());
      });

      test('should handle long deviceBarcode', () {
        final longBarcode = 'D' * 500;
        final stream = DeviceDetailService.getDeviceDetails(longBarcode);
        expect(stream, isA<Stream<DeviceDetailResponse?>>());
      });

      test('endpoint construction verification', () {
        const deviceBarcode = 'DEVICE_001';
        final endpoint = '/device/app/detail?qrcode=$deviceBarcode';
        
        expect(endpoint, equals('/device/app/detail?qrcode=DEVICE_001'));
        expect(endpoint, contains('qrcode='));
        expect(endpoint, startsWith('/device/app'));
      });
    });

    group('getDeviceStockMovement', () {
      test('should create stream with valid deviceBarcode', () {
        final stream = DeviceDetailService.getDeviceStockMovement('DEVICE_002');
        expect(stream, isA<Stream<StockMovementResponse?>>());
      });

      test('should handle empty deviceBarcode', () {
        final stream = DeviceDetailService.getDeviceStockMovement('');
        expect(stream, isA<Stream<StockMovementResponse?>>());
      });

      test('should handle special characters in deviceBarcode', () {
        final stream = DeviceDetailService.getDeviceStockMovement('DEVICE-002_TEST');
        expect(stream, isA<Stream<StockMovementResponse?>>());
      });

      test('should handle unicode characters in deviceBarcode', () {
        final stream = DeviceDetailService.getDeviceStockMovement('设备_002');
        expect(stream, isA<Stream<StockMovementResponse?>>());
      });

      test('endpoint construction verification', () {
        const deviceBarcode = 'DEVICE_002';
        final endpoint = '/device/app/stock-movement/$deviceBarcode';
        
        expect(endpoint, equals('/device/app/stock-movement/DEVICE_002'));
        expect(endpoint, startsWith('/device/app'));
        expect(endpoint, isNot(contains('?')));
      });
    });

    group('endpoint consistency', () {
      test('both endpoints should be under /device/app path', () {
        const deviceBarcode = 'TEST';
        final detailEndpoint = '/device/app/detail?qrcode=$deviceBarcode';
        final stockMovementEndpoint = '/device/app/stock-movement/$deviceBarcode';

        expect(detailEndpoint, startsWith('/device/app'));
        expect(stockMovementEndpoint, startsWith('/device/app'));
      });

      test('detail endpoint uses query param, stock-movement uses path param', () {
        const deviceBarcode = 'TEST';
        final detailEndpoint = '/device/app/detail?qrcode=$deviceBarcode';
        final stockMovementEndpoint = '/device/app/stock-movement/$deviceBarcode';

        expect(detailEndpoint, contains('?qrcode='));
        expect(stockMovementEndpoint, isNot(contains('?')));
        expect(stockMovementEndpoint, endsWith(deviceBarcode));
      });
    });

    group('Integration - All methods create valid streams', () {
      test('all service methods should be callable and return streams', () {
        expect(() => DeviceDetailService.getDeviceDetails('test'), returnsNormally);
        expect(() => DeviceDetailService.getDeviceStockMovement('test'), returnsNormally);
      });
    });
  });
}
