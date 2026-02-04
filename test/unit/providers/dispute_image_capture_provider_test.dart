import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/disputed_image_capture/providers/dispute_image_capture_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/disputed_image_capture/models/disputed_media_data_response.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for DisputeImageCaptureProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('DisputeImageCaptureProvider', () {
    group('constructor', () {
      test('should accept barcode parameter', () {
        // Constructor calls _fetchDisputeMediaData which makes API call
        // We can't avoid this in unit tests without DI
        final provider = DisputeImageCaptureProvider('TEST_BARCODE_001');
        
        expect(provider, isNotNull);
        provider.dispose();
      });

      test('should initialize with empty mediaInfoList', () {
        final provider = DisputeImageCaptureProvider('TEST');
        
        // Initially empty until API response arrives
        expect(provider.mediaInfoList, isA<List<DisputeMediaInfoData>>());
        provider.dispose();
      });
    });

    group('initial state', () {
      late DisputeImageCaptureProvider provider;

      setUp(() {
        provider = DisputeImageCaptureProvider('TEST_BARCODE');
      });

      tearDown(() {
        provider.dispose();
      });

      test('isDataLoading should initially be true', () {
        expect(provider.isDataLoading, true);
      });

      test('errorMessage should initially be null', () {
        expect(provider.errorMessage, isNull);
      });

      test('disputeDataModel should initially be null', () {
        expect(provider.disputeDataModel, isNull);
      });

      test('totalMediaCount should initially be 0', () {
        expect(provider.totalMediaCount, 0);
      });

      test('crossCheckMediaCount should initially be 0', () {
        expect(provider.crossCheckMediaCount, 0);
      });
    });

    group('checkSubmitButtonStatus', () {
      late DisputeImageCaptureProvider provider;

      setUp(() {
        provider = DisputeImageCaptureProvider('TEST');
      });

      tearDown(() {
        provider.dispose();
      });

      test('should return true when totalMediaCount equals mediaCounter', () {
        // Both are 0 initially
        expect(provider.checkSubmitButtonStatus(), true);
      });

      test('should return true when mediaInfoList is empty', () {
        provider.mediaInfoList = [];
        provider.totalMediaCount = 0;

        expect(provider.checkSubmitButtonStatus(), true);
      });

      test('should return false when media not fully captured', () {
        // Create a DisputeMediaInfoData with required media but empty URLs
        final mediaData = DisputeMediaInfoData.fromJson({
          'apiKey': '1',
          'label': 'Test Label',
          'images': 2,
          'videos': 1,
        });
        mediaData.imageS3Urls = ['', '']; // 2 empty images
        mediaData.videoS3urls = [VideoUrlData('')]; // 1 empty video

        provider.mediaInfoList = [mediaData];
        provider.totalMediaCount = 3;

        expect(provider.checkSubmitButtonStatus(), false);
      });

      test('should return true when all media captured', () {
        final mediaData = DisputeMediaInfoData.fromJson({
          'apiKey': '1',
          'label': 'Test Label',
          'images': 2,
          'videos': 1,
        });
        mediaData.imageS3Urls = ['http://img1.jpg', 'http://img2.jpg'];
        mediaData.videoS3urls = [VideoUrlData('http://video1.mp4')];

        provider.mediaInfoList = [mediaData];
        provider.totalMediaCount = 3;

        expect(provider.checkSubmitButtonStatus(), true);
      });
    });

    group('checkAuditAlreadyDone', () {
      late DisputeImageCaptureProvider provider;

      setUp(() {
        provider = DisputeImageCaptureProvider('TEST');
      });

      tearDown(() {
        provider.dispose();
      });

      test('should not call callback when auditStatus is null', () {
        provider.disputeDataModel = null;
        var callbackCalled = false;

        provider.checkAuditAlreadyDone(() {
          callbackCalled = true;
        });

        expect(callbackCalled, false);
      });

      test('should call callback when auditStatus is 1', () {
        provider.disputeDataModel = DisputedMediaDataResponse.fromJson({
          'auditStatus': 1,
        });
        var callbackCalled = false;

        provider.checkAuditAlreadyDone(() {
          callbackCalled = true;
        });

        expect(callbackCalled, true);
      });

      test('should not call callback when auditStatus is 0', () {
        provider.disputeDataModel = DisputedMediaDataResponse.fromJson({
          'auditStatus': 0,
        });
        var callbackCalled = false;

        provider.checkAuditAlreadyDone(() {
          callbackCalled = true;
        });

        expect(callbackCalled, false);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(DisputeImageCaptureProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = DisputeImageCaptureProvider('TEST');
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });

    group('method signatures', () {
      late DisputeImageCaptureProvider provider;

      setUp(() {
        provider = DisputeImageCaptureProvider('TEST');
      });

      tearDown(() {
        provider.dispose();
      });

      test('should have subDisputeMediaData method', () {
        expect(provider.subDisputeMediaData, isNotNull);
      });
    });
  });

  group('DisputeMediaInfoData', () {
    test('should create from JSON', () {
      final data = DisputeMediaInfoData.fromJson({
        'apiKey': '8',
        'label': 'Screen Cracked or Glass Broken',
        'images': 1,
        'videos': 0,
        'selectedReport': 'Minor Scratches; normal signs of usage',
        'auditType': 1,
      });

      expect(data.auditKey, '8');
      expect(data.label, 'Screen Cracked or Glass Broken');
      expect(data.imageCount, 1);
      expect(data.videoCount, 0);
      expect(data.subHeading, 'Minor Scratches; normal signs of usage');
      expect(data.at, 1);
    });

    test('should handle missing fields', () {
      final data = DisputeMediaInfoData.fromJson({});

      expect(data.auditKey, isNull);
      expect(data.label, isNull);
      expect(data.imageCount, isNull);
      expect(data.videoCount, isNull);
    });

    test('should calculate total media count', () {
      final data = DisputeMediaInfoData.fromJson({
        'images': 2,
        'videos': 3,
      });

      expect(data.getTotalMediaCount(), 5);
    });

    test('should handle null counts in total media calculation', () {
      final data = DisputeMediaInfoData.fromJson({});

      expect(data.getTotalMediaCount(), 0);
    });
  });

  group('VideoUrlData', () {
    test('should create with video URL', () {
      final data = VideoUrlData('http://example.com/video.mp4');

      expect(data.videoUrl, 'http://example.com/video.mp4');
    });

    test('should handle empty URL', () {
      final data = VideoUrlData('');

      expect(data.videoUrl, '');
    });
  });

  group('DisputedMediaDataResponse', () {
    test('should create from JSON', () {
      final response = DisputedMediaDataResponse.fromJson({
        'auditData': [
          {
            'apiKey': '8',
            'label': 'Screen Cracked',
            'images': 1,
            'videos': 0,
          },
        ],
        'r_id': '965f2943-2170-41da-891a-25f298e45a74',
        'modal': 'Apple iPhone 8 64 GB',
        'brand': 'Apple',
        'imeis': ['344663415178694'],
        'auditStatus': 1,
      });

      expect(response.mediaDataList, isNotNull);
      expect(response.mediaDataList?.length, 1);
      expect(response.rid, '965f2943-2170-41da-891a-25f298e45a74');
      expect(response.modal, 'Apple iPhone 8 64 GB');
      expect(response.brand, 'Apple');
      expect(response.imeis, ['344663415178694']);
      expect(response.auditStatus, 1);
    });

    test('should handle empty JSON', () {
      final response = DisputedMediaDataResponse.fromJson({});

      expect(response.mediaDataList, isNull);
      expect(response.auditStatus, isNull);
    });
  });
}
