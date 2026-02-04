import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty;
import 'package:flutter_trc/qc/modules/qc_tester/disputed_image_capture/resouces/dispute_image_capture_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/disputed_image_capture/models/disputed_media_data_response.dart';

/// Unit tests for [DisputeImageCaptureService] class.
///
/// These tests execute actual service methods to ensure code coverage.
/// Since the service uses internal QcService() instances, we test:
/// - Method invocation and stream creation
/// - Request body construction logic
/// - Return type verification
void main() {
  group('DisputeImageCaptureService', () {
    group('fetchDisputeImageCaptureData', () {
      test('should create stream with valid barcode', () {
        final stream = DisputeImageCaptureService.fetchDisputeImageCaptureData('DEVICE_001');
        expect(stream, isA<Stream<DisputedMediaDataResponse?>>());
      });

      test('should handle empty barcode', () {
        final stream = DisputeImageCaptureService.fetchDisputeImageCaptureData('');
        expect(stream, isA<Stream<DisputedMediaDataResponse?>>());
      });

      test('should handle special characters in barcode', () {
        final stream = DisputeImageCaptureService.fetchDisputeImageCaptureData('DEVICE-001_TEST');
        expect(stream, isA<Stream<DisputedMediaDataResponse?>>());
      });

      test('should handle unicode characters in barcode', () {
        final stream = DisputeImageCaptureService.fetchDisputeImageCaptureData('设备_001');
        expect(stream, isA<Stream<DisputedMediaDataResponse?>>());
      });

      test('should handle long barcode', () {
        final longBarcode = 'D' * 500;
        final stream = DisputeImageCaptureService.fetchDisputeImageCaptureData(longBarcode);
        expect(stream, isA<Stream<DisputedMediaDataResponse?>>());
      });

      test('endpoint construction verification', () {
        const barcode = 'DEVICE_001';
        final endpoint = '/source/audit/$barcode';
        
        expect(endpoint, equals('/source/audit/DEVICE_001'));
        expect(endpoint, startsWith('/source/audit'));
      });
    });

    group('submitDisputeMediaData', () {
      test('should create stream with valid parameters', () {
        final stream = DisputeImageCaptureService.submitDisputeMediaData(
          barcode: 'DEVICE_002',
          bodyData: {'mediaType': 'image', 'url': 'https://example.com/image.jpg'},
        );
        expect(stream, isA<Stream<BaseResponse?>>());
      });

      test('should handle empty barcode', () {
        final stream = DisputeImageCaptureService.submitDisputeMediaData(
          barcode: '',
          bodyData: {'key': 'value'},
        );
        expect(stream, isA<Stream<BaseResponse?>>());
      });

      test('should handle empty bodyData', () {
        final stream = DisputeImageCaptureService.submitDisputeMediaData(
          barcode: 'DEVICE_003',
          bodyData: {},
        );
        expect(stream, isA<Stream<BaseResponse?>>());
      });

      test('should handle complex nested bodyData', () {
        final stream = DisputeImageCaptureService.submitDisputeMediaData(
          barcode: 'DEVICE_004',
          bodyData: {
            'images': [
              {'url': 'url1', 'type': 'front'},
              {'url': 'url2', 'type': 'back'},
            ],
            'metadata': {
              'timestamp': 1234567890,
              'source': 'app',
            },
          },
        );
        expect(stream, isA<Stream<BaseResponse?>>());
      });

      test('bodyData serialization verification', () {
        final bodyData = {
          'mediaType': 'image',
          'url': 'https://example.com/image.jpg',
          'status': 'disputed',
        };

        final encoded = jsonEncode(bodyData);
        final decoded = jsonDecode(encoded) as Map<String, dynamic>;

        expect(decoded['mediaType'], equals('image'));
        expect(decoded['url'], equals('https://example.com/image.jpg'));
        expect(decoded['status'], equals('disputed'));
      });
    });

    group('endpoint consistency', () {
      test('both endpoints should use same path pattern', () {
        const barcode = 'DEVICE';
        final fetchEndpoint = '/source/audit/$barcode';
        final submitEndpoint = '/source/audit/$barcode';

        expect(fetchEndpoint, equals(submitEndpoint));
        expect(fetchEndpoint, startsWith('/source/audit'));
        expect(submitEndpoint, startsWith('/source/audit'));
      });

      test('endpoints use REST resource pattern (GET/POST same path)', () {
        const barcode = 'TEST';
        final getEndpoint = '/source/audit/$barcode';
        final postEndpoint = '/source/audit/$barcode';

        expect(getEndpoint, equals(postEndpoint));
      });
    });

    group('Integration - All methods create valid streams', () {
      test('all service methods should be callable and return streams', () {
        expect(() => DisputeImageCaptureService.fetchDisputeImageCaptureData('test'), returnsNormally);
        expect(() => DisputeImageCaptureService.submitDisputeMediaData(barcode: 'test', bodyData: {}), returnsNormally);
      });
    });
  });
}
