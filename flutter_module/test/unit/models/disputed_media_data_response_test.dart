import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/disputed_image_capture/models/disputed_media_data_response.dart';

/// Tests for DisputeMediaInfoData model.
/// Focus: Testing getTotalMediaCount computed method.
void main() {
  group('DisputeMediaInfoData', () {
    group('getTotalMediaCount', () {
      test('should return sum of imageCount and videoCount', () {
        // Arrange
        final data = DisputeMediaInfoData(
          imageCount: 5,
          videoCount: 3,
        );

        // Act
        final total = data.getTotalMediaCount();

        // Assert
        expect(total, 8);
      });

      test('should return imageCount when videoCount is null', () {
        // Arrange
        final data = DisputeMediaInfoData(
          imageCount: 5,
          videoCount: null,
        );

        // Act
        final total = data.getTotalMediaCount();

        // Assert
        expect(total, 5);
      });

      test('should return videoCount when imageCount is null', () {
        // Arrange
        final data = DisputeMediaInfoData(
          imageCount: null,
          videoCount: 7,
        );

        // Act
        final total = data.getTotalMediaCount();

        // Assert
        expect(total, 7);
      });

      test('should return zero when both counts are null', () {
        // Arrange
        final data = DisputeMediaInfoData(
          imageCount: null,
          videoCount: null,
        );

        // Act
        final total = data.getTotalMediaCount();

        // Assert
        expect(total, 0);
      });

      test('should return zero when both counts are zero', () {
        // Arrange
        final data = DisputeMediaInfoData(
          imageCount: 0,
          videoCount: 0,
        );

        // Act
        final total = data.getTotalMediaCount();

        // Assert
        expect(total, 0);
      });

      test('should handle only imageCount set', () {
        // Arrange
        final data = DisputeMediaInfoData(
          imageCount: 10,
        );

        // Act
        final total = data.getTotalMediaCount();

        // Assert
        expect(total, 10);
      });

      test('should handle only videoCount set', () {
        // Arrange
        final data = DisputeMediaInfoData(
          videoCount: 15,
        );

        // Act
        final total = data.getTotalMediaCount();

        // Assert
        expect(total, 15);
      });

      test('should handle large counts', () {
        // Arrange
        final data = DisputeMediaInfoData(
          imageCount: 999999,
          videoCount: 888888,
        );

        // Act
        final total = data.getTotalMediaCount();

        // Assert
        expect(total, 1888887);
      });
    });

    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'apiKey': 'screen_check',
          'label': 'Screen Check',
          'images': 3,
          'videos': 2,
          'selectedReport': 'Minor scratches',
          'auditType': 1,
        };

        // Act
        final data = DisputeMediaInfoData.fromJson(json);

        // Assert
        expect(data.auditKey, 'screen_check');
        expect(data.label, 'Screen Check');
        expect(data.imageCount, 3);
        expect(data.videoCount, 2);
        expect(data.subHeading, 'Minor scratches');
        expect(data.at, 1);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = DisputeMediaInfoData.fromJson(json);

        // Assert
        expect(data.auditKey, null);
        expect(data.label, null);
        expect(data.imageCount, null);
        expect(data.videoCount, null);
        expect(data.subHeading, null);
        expect(data.at, null);
      });

      test('should handle zero counts', () {
        // Arrange
        final json = {
          'images': 0,
          'videos': 0,
        };

        // Act
        final data = DisputeMediaInfoData.fromJson(json);

        // Assert
        expect(data.imageCount, 0);
        expect(data.videoCount, 0);
        expect(data.getTotalMediaCount(), 0);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = DisputeMediaInfoData(
          auditKey: 'battery_check',
          label: 'Battery Check',
          imageCount: 2,
          videoCount: 1,
          subHeading: 'Original battery',
          at: 2,
        );

        // Act
        final json = data.toJson();

        // Assert
        expect(json['apiKey'], 'battery_check');
        expect(json['label'], 'Battery Check');
        expect(json['images'], 2);
        expect(json['videos'], 1);
        expect(json['selectedReport'], 'Original battery');
        expect(json['auditType'], 2);
      });

      test('should not include transient fields', () {
        // Arrange
        final data = DisputeMediaInfoData(
          imageCount: 1,
          imageS3Urls: ['https://s3.example.com/img1.jpg'],
        );
        data.videoS3urls = [VideoUrlData('https://s3.example.com/vid1.mp4')];

        // Act
        final json = data.toJson();

        // Assert
        expect(json.containsKey('imageS3Urls'), false);
        expect(json.containsKey('videoS3urls'), false);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange & Act
        final data = DisputeMediaInfoData(
          auditKey: 'test_key',
          label: 'Test Label',
          imageCount: 5,
          videoCount: 3,
          subHeading: 'Test subheading',
          at: 1,
          imageS3Urls: ['url1', 'url2'],
        );

        // Assert
        expect(data.auditKey, 'test_key');
        expect(data.label, 'Test Label');
        expect(data.imageCount, 5);
        expect(data.videoCount, 3);
        expect(data.subHeading, 'Test subheading');
        expect(data.at, 1);
        expect(data.imageS3Urls?.length, 2);
      });

      test('should create instance with minimal parameters', () {
        // Arrange & Act
        final data = DisputeMediaInfoData();

        // Assert
        expect(data.auditKey, null);
        expect(data.label, null);
        expect(data.getTotalMediaCount(), 0);
      });
    });

    group('transient properties', () {
      test('imageS3Urls should be settable', () {
        // Arrange
        final data = DisputeMediaInfoData();

        // Act
        data.imageS3Urls = ['url1', 'url2', 'url3'];

        // Assert
        expect(data.imageS3Urls?.length, 3);
      });

      test('videoS3urls should be settable', () {
        // Arrange
        final data = DisputeMediaInfoData();

        // Act
        data.videoS3urls = [
          VideoUrlData('video1.mp4', videoThumbnail: 'thumb1.jpg'),
          VideoUrlData('video2.mp4'),
        ];

        // Assert
        expect(data.videoS3urls?.length, 2);
        expect(data.videoS3urls?[0].videoThumbnail, 'thumb1.jpg');
      });
    });

    group('edge cases', () {
      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'label': 'バッテリーチェック 🔋',
          'selectedReport': '正常動作 ✓',
        };

        // Act
        final data = DisputeMediaInfoData.fromJson(json);

        // Assert
        expect(data.label, 'バッテリーチェック 🔋');
        expect(data.subHeading, '正常動作 ✓');
      });

      test('should handle very long labels', () {
        // Arrange
        final longLabel = 'A' * 500;
        final json = {
          'label': longLabel,
        };

        // Act
        final data = DisputeMediaInfoData.fromJson(json);

        // Assert
        expect(data.label?.length, 500);
      });
    });
  });

  group('VideoUrlData', () {
    test('should create instance with required videoUrl', () {
      // Arrange & Act
      final video = VideoUrlData('https://example.com/video.mp4');

      // Assert
      expect(video.videoUrl, 'https://example.com/video.mp4');
      expect(video.videoThumbnail, null);
    });

    test('should create instance with videoThumbnail', () {
      // Arrange & Act
      final video = VideoUrlData(
        'https://example.com/video.mp4',
        videoThumbnail: 'https://example.com/thumb.jpg',
      );

      // Assert
      expect(video.videoUrl, 'https://example.com/video.mp4');
      expect(video.videoThumbnail, 'https://example.com/thumb.jpg');
    });

    test('should handle empty strings', () {
      // Arrange & Act
      final video = VideoUrlData('', videoThumbnail: '');

      // Assert
      expect(video.videoUrl, '');
      expect(video.videoThumbnail, '');
    });
  });

  group('DisputedMediaDataResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'r_id': 'req-123',
          'modal': 'iPhone 13 Pro',
          'brand': 'Apple',
          'imeis': ['123456789012345', '543210987654321'],
          'auditStatus': 1,
          'auditData': [
            {
              'apiKey': 'screen',
              'label': 'Screen',
              'images': 2,
              'videos': 1,
            },
          ],
        };

        // Act
        final response = DisputedMediaDataResponse.fromJson(json);

        // Assert
        expect(response.rid, 'req-123');
        expect(response.modal, 'iPhone 13 Pro');
        expect(response.brand, 'Apple');
        expect(response.imeis?.length, 2);
        expect(response.auditStatus, 1);
        expect(response.mediaDataList?.length, 1);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = DisputedMediaDataResponse.fromJson(json);

        // Assert
        expect(response.rid, null);
        expect(response.modal, null);
        expect(response.brand, null);
        expect(response.imeis, null);
        expect(response.auditStatus, null);
        expect(response.mediaDataList, null);
      });

      test('should handle empty lists', () {
        // Arrange
        final json = {
          'imeis': <String>[],
          'auditData': <Map<String, dynamic>>[],
        };

        // Act
        final response = DisputedMediaDataResponse.fromJson(json);

        // Assert
        expect(response.imeis, isEmpty);
        expect(response.mediaDataList, isEmpty);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = DisputedMediaDataResponse(
          rid: 'req-456',
          modal: 'Samsung Galaxy S21',
          brand: 'Samsung',
          imeis: ['111111111111111'],
          auditStatus: 2,
          mediaDataList: [
            DisputeMediaInfoData(
              auditKey: 'battery',
              label: 'Battery',
              imageCount: 1,
            ),
          ],
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['r_id'], 'req-456');
        expect(json['modal'], 'Samsung Galaxy S21');
        expect(json['brand'], 'Samsung');
        expect(json['imeis'], ['111111111111111']);
        expect(json['auditStatus'], 2);
        expect(json['auditData'], isNotNull);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange & Act
        final response = DisputedMediaDataResponse(
          rid: 'req-test',
          modal: 'Test Model',
          brand: 'Test Brand',
          imeis: ['imei1', 'imei2'],
          auditStatus: 0,
          mediaDataList: [],
        );

        // Assert
        expect(response.rid, 'req-test');
        expect(response.modal, 'Test Model');
        expect(response.brand, 'Test Brand');
        expect(response.imeis?.length, 2);
        expect(response.auditStatus, 0);
        expect(response.mediaDataList, isEmpty);
      });
    });

    group('integration with DisputeMediaInfoData', () {
      test('should calculate total media count across all items', () {
        // Arrange
        final response = DisputedMediaDataResponse.fromJson({
          'auditData': [
            {'images': 3, 'videos': 1},
            {'images': 2, 'videos': 2},
            {'images': 1, 'videos': 0},
          ],
        });

        // Act
        int totalCount = 0;
        for (final item in response.mediaDataList ?? <DisputeMediaInfoData>[]) {
          totalCount = (totalCount + item.getTotalMediaCount()).toInt();
        }

        // Assert
        expect(totalCount, 9); // 4 + 4 + 1
      });
    });
  });
}
