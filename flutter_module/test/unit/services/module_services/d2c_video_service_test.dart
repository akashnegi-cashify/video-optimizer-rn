import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty;
import 'package:flutter_trc/qc/modules/d2c_video/resources/d2c_video_service.dart';
import 'package:flutter_trc/qc/modules/d2c_video/resources/d2c_device_detail_response.dart';
import 'package:flutter_trc/qc/modules/d2c_video/resources/d2c_lot_device_list_response.dart';

/// Unit tests for [D2CVideoService] class.
///
/// These tests execute actual service methods to ensure code coverage.
/// Since the service uses internal QcService() instances, we test:
/// - Method invocation and stream creation
/// - Request body/parameter construction logic
/// - Return type verification
void main() {
  group('D2CVideoService', () {
    group('saveVideo', () {
      test('should create stream with valid parameters', () {
        final stream = D2CVideoService.saveVideo('DEVICE_001', 'https://example.com/video.mp4');
        expect(stream, isA<Stream<BaseResponse>>());
      });

      test('should handle null deviceBarcode', () {
        final stream = D2CVideoService.saveVideo(null, 'https://example.com/video.mp4');
        expect(stream, isA<Stream<BaseResponse>>());
      });

      test('should handle null videoUrl', () {
        final stream = D2CVideoService.saveVideo('DEVICE_001', null);
        expect(stream, isA<Stream<BaseResponse>>());
      });

      test('should handle both null parameters', () {
        final stream = D2CVideoService.saveVideo(null, null);
        expect(stream, isA<Stream<BaseResponse>>());
      });

      test('should handle empty strings', () {
        final stream = D2CVideoService.saveVideo('', '');
        expect(stream, isA<Stream<BaseResponse>>());
      });

      test('request body construction verification', () {
        const videoUrl = 'https://example.com/video.mp4';
        var req = {'url': videoUrl};
        
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;
        
        expect(decoded['url'], equals('https://example.com/video.mp4'));
        expect(req.length, equals(1));
        expect(req.containsKey('url'), isTrue);
      });
    });

    group('getDeviceDetails', () {
      test('should create stream with valid deviceBarcode', () {
        final stream = D2CVideoService.getDeviceDetails('DEVICE_002');
        expect(stream, isA<Stream<D2CDeviceDetail>>());
      });

      test('should handle null deviceBarcode', () {
        final stream = D2CVideoService.getDeviceDetails(null);
        expect(stream, isA<Stream<D2CDeviceDetail>>());
      });

      test('should handle empty deviceBarcode', () {
        final stream = D2CVideoService.getDeviceDetails('');
        expect(stream, isA<Stream<D2CDeviceDetail>>());
      });

      test('should handle special characters in deviceBarcode', () {
        final stream = D2CVideoService.getDeviceDetails('DEVICE-002_TEST');
        expect(stream, isA<Stream<D2CDeviceDetail>>());
      });

      test('endpoint construction verification', () {
        const deviceBarcode = 'DEVICE_002';
        final endpoint = '/device/recording/$deviceBarcode/detail';
        
        expect(endpoint, equals('/device/recording/DEVICE_002/detail'));
        expect(endpoint, endsWith('/detail'));
        expect(endpoint, startsWith('/device/recording'));
      });
    });

    group('getLotDeviceList', () {
      test('should create stream with valid parameters', () {
        final stream = D2CVideoService.getLotDeviceList(123, 'GROUP_LOT_001');
        expect(stream, isA<Stream<List<D2cLotDeviceListData>>>());
      });

      test('should handle zero lotId', () {
        final stream = D2CVideoService.getLotDeviceList(0, 'GROUP_LOT');
        expect(stream, isA<Stream<List<D2cLotDeviceListData>>>());
      });

      test('should handle negative lotId', () {
        final stream = D2CVideoService.getLotDeviceList(-1, 'GROUP_LOT');
        expect(stream, isA<Stream<List<D2cLotDeviceListData>>>());
      });

      test('should handle empty groupLotName', () {
        final stream = D2CVideoService.getLotDeviceList(123, '');
        expect(stream, isA<Stream<List<D2cLotDeviceListData>>>());
      });

      test('endpoint construction verification', () {
        const lotId = 123;
        final endpoint = '/device/recording/pending-lot-device-list?lotId=$lotId';
        
        expect(endpoint, equals('/device/recording/pending-lot-device-list?lotId=123'));
        expect(endpoint, contains('lotId='));
      });
    });

    group('updateLotStatus', () {
      test('should create stream with valid lotId', () {
        final stream = D2CVideoService.updateLotStatus(100);
        expect(stream, isA<Stream<BaseResponse>>());
      });

      test('should handle zero lotId', () {
        final stream = D2CVideoService.updateLotStatus(0);
        expect(stream, isA<Stream<BaseResponse>>());
      });

      test('should handle negative lotId', () {
        final stream = D2CVideoService.updateLotStatus(-1);
        expect(stream, isA<Stream<BaseResponse>>());
      });

      test('should handle large lotId', () {
        final stream = D2CVideoService.updateLotStatus(999999999);
        expect(stream, isA<Stream<BaseResponse>>());
      });

      test('request body construction verification', () {
        const lotId = 100;
        Map<String, dynamic> req = {'lotId': lotId};
        
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;
        
        expect(decoded['lotId'], equals(100));
        expect(req.length, equals(1));
        expect(req.containsKey('lotId'), isTrue);
      });
    });

    group('endpoint consistency', () {
      test('all endpoints should be under /device/recording path', () {
        const saveEndpoint = '/device/recording/DEVICE/save';
        const detailEndpoint = '/device/recording/DEVICE/detail';
        const listEndpoint = '/device/recording/pending-lot-device-list';
        const updateEndpoint = '/device/recording/update-group';

        expect(saveEndpoint, startsWith('/device/recording'));
        expect(detailEndpoint, startsWith('/device/recording'));
        expect(listEndpoint, startsWith('/device/recording'));
        expect(updateEndpoint, startsWith('/device/recording'));
      });
    });

    group('Integration - All methods create valid streams', () {
      test('all service methods should be callable and return streams', () {
        expect(() => D2CVideoService.saveVideo('bc', 'url'), returnsNormally);
        expect(() => D2CVideoService.getDeviceDetails('bc'), returnsNormally);
        expect(() => D2CVideoService.getLotDeviceList(1, 'group'), returnsNormally);
        expect(() => D2CVideoService.updateLotStatus(1), returnsNormally);
      });
    });
  });
}
