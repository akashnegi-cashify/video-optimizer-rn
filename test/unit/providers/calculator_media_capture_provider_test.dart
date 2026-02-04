import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator_media_capture/providers/calculator_media_capture_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator_media_capture/resources/journey_type.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_media_response.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for CalculatorMediaCaptureProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('CalculatorMediaCaptureProvider', () {
    late CalculatorMediaCaptureProvider provider;

    setUp(() {
      provider = CalculatorMediaCaptureProvider('TEST_BARCODE_001', JourneyType.testing);
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should store deviceBarcode', () {
        expect(provider.deviceBarcode, 'TEST_BARCODE_001');
      });

      test('should store journeyType', () {
        expect(provider.journeyType, JourneyType.testing);
      });

      test('should accept null journeyType', () {
        final providerWithNull = CalculatorMediaCaptureProvider('TEST', null);
        expect(providerWithNull.journeyType, isNull);
        providerWithNull.dispose();
      });

      test('should accept categoryId', () {
        final providerWithCategory = CalculatorMediaCaptureProvider(
          'TEST',
          JourneyType.testing,
          categoryId: 123,
        );
        expect(providerWithCategory.categoryId, 123);
        providerWithCategory.dispose();
      });
    });

    group('initial state', () {
      test('isDataLoading should initially be true', () {
        expect(provider.isDataLoading, true);
      });

      test('deviceMediaResponse should initially be null', () {
        expect(provider.deviceMediaResponse, isNull);
      });

      test('errorMessage should initially be null', () {
        expect(provider.errorMessage, isNull);
      });
    });

    group('isAllMediaUpLoaded', () {
      test('should return false when deviceMediaResponse is null', () {
        provider.deviceMediaResponse = null;
        expect(provider.isAllMediaUpLoaded(), false);
      });

      test('should return false when imageList is null', () {
        provider.deviceMediaResponse = DeviceMediaResponse(null, null, null, null);
        expect(provider.isAllMediaUpLoaded(), false);
      });

      test('should return false when imageList is empty', () {
        provider.deviceMediaResponse = DeviceMediaResponse(null, [], null, null);
        expect(provider.isAllMediaUpLoaded(), false);
      });

      test('should return false when any item has empty mediaUrl', () {
        final imageList = [
          _createImageListData(mediaUrl: 'http://example.com/image1.jpg'),
          _createImageListData(mediaUrl: ''),
          _createImageListData(mediaUrl: 'http://example.com/image3.jpg'),
        ];
        provider.deviceMediaResponse = DeviceMediaResponse(null, imageList, null, null);

        expect(provider.isAllMediaUpLoaded(), false);
      });

      test('should return false when any item has null mediaUrl', () {
        final imageList = [
          _createImageListData(mediaUrl: 'http://example.com/image1.jpg'),
          _createImageListData(mediaUrl: null),
        ];
        provider.deviceMediaResponse = DeviceMediaResponse(null, imageList, null, null);

        expect(provider.isAllMediaUpLoaded(), false);
      });

      test('should return true when all items have non-empty mediaUrl', () {
        final imageList = [
          _createImageListData(mediaUrl: 'http://example.com/image1.jpg'),
          _createImageListData(mediaUrl: 'http://example.com/image2.jpg'),
          _createImageListData(mediaUrl: 'http://example.com/image3.jpg'),
        ];
        provider.deviceMediaResponse = DeviceMediaResponse(null, imageList, null, null);

        expect(provider.isAllMediaUpLoaded(), true);
      });

      test('should return true when single item has non-empty mediaUrl', () {
        final imageList = [
          _createImageListData(mediaUrl: 'http://example.com/image.jpg'),
        ];
        provider.deviceMediaResponse = DeviceMediaResponse(null, imageList, null, null);

        expect(provider.isAllMediaUpLoaded(), true);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(CalculatorMediaCaptureProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = CalculatorMediaCaptureProvider('TEST', JourneyType.testing);
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });

    group('method signatures', () {
      test('should have getDeviceMedia method', () {
        expect(provider.getDeviceMedia, isNotNull);
      });

      test('should have submitDeviceMedia method', () {
        expect(provider.submitDeviceMedia, isNotNull);
      });

      test('should have saveMediaList method', () {
        expect(provider.saveMediaList, isNotNull);
      });
    });
  });

  group('JourneyType enum', () {
    test('should have testing value', () {
      expect(JourneyType.testing, isNotNull);
    });
  });

  group('ImageListData', () {
    test('should create with constructor parameters', () {
      final item = ImageListData('r_123', 'front_camera', false);
      item.mediaUrl = 'http://example.com/image.jpg';

      expect(item.rId, 'r_123');
      expect(item.imageName, 'front_camera');
      expect(item.isVideo, false);
      expect(item.mediaUrl, 'http://example.com/image.jpg');
    });

    test('should handle video media type', () {
      final item = ImageListData('r_456', 'recording', true);
      item.mediaUrl = 'http://example.com/video.mp4';

      expect(item.isVideo, true);
    });

    test('should allow null values', () {
      final item = ImageListData(null, null, null);

      expect(item.rId, isNull);
      expect(item.imageName, isNull);
      expect(item.isVideo, isNull);
      expect(item.mediaUrl, isNull);
    });
  });
}

/// Helper to create ImageListData for testing
ImageListData _createImageListData({String? mediaUrl}) {
  final item = ImageListData(null, null, null);
  item.mediaUrl = mediaUrl;
  return item;
}
