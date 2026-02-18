import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_media_response.dart';

/// Tests for DeviceMediaResponse and ImageListData models.
/// Focus: Testing fromJson/toJson for device media response and nested image data.
void main() {
  group('DeviceMediaResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'r_id': 'record-123',
          'dt': [
            {'r_id': 'img-1', 'mn': 'front_image.jpg', 'iv': false},
            {'r_id': 'img-2', 'mn': 'back_image.jpg', 'iv': false},
          ],
        };

        // Act
        final response = DeviceMediaResponse.fromJson(json);

        // Assert
        expect(response.rId, 'record-123');
        expect(response.imageList, isNotNull);
        expect(response.imageList!.length, 2);
        expect(response.trackUrl, 'https://example.com/track');
      });

      test('should handle null imageList', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'r_id': null,
          'dt': null,
        };

        // Act
        final response = DeviceMediaResponse.fromJson(json);

        // Assert
        expect(response.rId, null);
        expect(response.imageList, null);
      });

      test('should handle empty imageList', () {
        // Arrange
        final json = {
          'r_id': 'rec-456',
          'dt': <Map<String, dynamic>>[],
        };

        // Act
        final response = DeviceMediaResponse.fromJson(json);

        // Assert
        expect(response.imageList, isNotNull);
        expect(response.imageList!.isEmpty, true);
      });

      test('should parse multiple image items', () {
        // Arrange
        final json = {
          'r_id': 'record-789',
          'dt': [
            {'r_id': 'img-1', 'mn': 'image1.jpg', 'iv': false},
            {'r_id': 'img-2', 'mn': 'image2.jpg', 'iv': false},
            {'r_id': 'vid-1', 'mn': 'video1.mp4', 'iv': true},
            {'r_id': 'img-3', 'mn': 'image3.png', 'iv': false},
          ],
        };

        // Act
        final response = DeviceMediaResponse.fromJson(json);

        // Assert
        expect(response.imageList!.length, 4);
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Alert Title',
            'msg': 'Alert Message',
          },
          'turl': 'https://track.com',
          'r_id': 'rec-1',
          'dt': null,
        };

        // Act
        final response = DeviceMediaResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should handle missing dt field', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': 'https://example.com',
          'r_id': 'rec-2',
        };

        // Act
        final response = DeviceMediaResponse.fromJson(json);

        // Assert
        expect(response.imageList, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'r_id': 'record-123',
          'dt': [
            {'r_id': 'img-1', 'mn': 'test.jpg', 'iv': false},
          ],
        };
        final response = DeviceMediaResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['r_id'], 'record-123');
        expect(serialized['dt'], isNotNull);
        expect(serialized['turl'], 'https://example.com/track');
      });

      test('should handle null values in serialization', () {
        // Arrange
        final response = DeviceMediaResponse.fromJson({
          '__ca': null,
          'turl': null,
          'r_id': null,
          'dt': null,
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['r_id'], null);
        expect(serialized['dt'], null);
      });

      test('should serialize empty list', () {
        // Arrange
        final response = DeviceMediaResponse.fromJson({
          'r_id': 'rec-1',
          'dt': <Map<String, dynamic>>[],
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['dt'], isNotNull);
        expect((serialized['dt'] as List).isEmpty, true);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com',
          'r_id': 'record-456',
          'dt': [
            {'r_id': 'img-1', 'mn': 'front.jpg', 'iv': false},
            {'r_id': 'vid-1', 'mn': 'demo.mp4', 'iv': true},
          ],
        };

        // Act
        final response = DeviceMediaResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['r_id'], 'record-456');
        expect(serialized['turl'], 'https://example.com');
        final dtList = serialized['dt'] as List;
        expect(dtList.length, 2);
      });
    });
  });

  group('ImageListData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'r_id': 'image-123',
          'mn': 'front_image.jpg',
          'iv': false,
        };

        // Act
        final data = ImageListData.fromJson(json);

        // Assert
        expect(data.rId, 'image-123');
        expect(data.imageName, 'front_image.jpg');
        expect(data.isVideo, false);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = ImageListData.fromJson(json);

        // Assert
        expect(data.rId, null);
        expect(data.imageName, null);
        expect(data.isVideo, null);
      });

      test('should handle null rId only', () {
        // Arrange
        final json = {
          'r_id': null,
          'mn': 'image.jpg',
          'iv': false,
        };

        // Act
        final data = ImageListData.fromJson(json);

        // Assert
        expect(data.rId, null);
        expect(data.imageName, 'image.jpg');
        expect(data.isVideo, false);
      });

      test('should handle video media (isVideo = true)', () {
        // Arrange
        final json = {
          'r_id': 'vid-123',
          'mn': 'demo_video.mp4',
          'iv': true,
        };

        // Act
        final data = ImageListData.fromJson(json);

        // Assert
        expect(data.rId, 'vid-123');
        expect(data.imageName, 'demo_video.mp4');
        expect(data.isVideo, true);
      });

      test('should handle image media (isVideo = false)', () {
        // Arrange
        final json = {
          'r_id': 'img-456',
          'mn': 'screen_shot.png',
          'iv': false,
        };

        // Act
        final data = ImageListData.fromJson(json);

        // Assert
        expect(data.isVideo, false);
      });

      test('should not parse mediaUrl from JSON', () {
        // Arrange - mediaUrl has includeFromJson: false
        final json = {
          'r_id': 'img-1',
          'mn': 'test.jpg',
          'iv': false,
          'mediaUrl': 'https://example.com/image.jpg',
        };

        // Act
        final data = ImageListData.fromJson(json);

        // Assert
        expect(data.mediaUrl, null); // Should be null as it's excluded from JSON
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = ImageListData.fromJson({
          'r_id': 'image-789',
          'mn': 'back_image.jpg',
          'iv': false,
        });

        // Act
        final json = data.toJson();

        // Assert
        expect(json['r_id'], 'image-789');
        expect(json['mn'], 'back_image.jpg');
        expect(json['iv'], false);
      });

      test('should handle null fields in serialization', () {
        // Arrange
        final data = ImageListData.fromJson(<String, dynamic>{});

        // Act
        final json = data.toJson();

        // Assert
        expect(json['r_id'], null);
        expect(json['mn'], null);
        expect(json['iv'], null);
      });

      test('should not include mediaUrl in toJson', () {
        // Arrange - mediaUrl has includeToJson: false
        final data = ImageListData.fromJson({
          'r_id': 'img-1',
          'mn': 'test.jpg',
          'iv': false,
        });
        data.mediaUrl = 'https://example.com/image.jpg';

        // Act
        final json = data.toJson();

        // Assert
        expect(json.containsKey('mediaUrl'), false);
      });

      test('should serialize video as true', () {
        // Arrange
        final data = ImageListData.fromJson({
          'r_id': 'vid-1',
          'mn': 'video.mp4',
          'iv': true,
        });

        // Act
        final json = data.toJson();

        // Assert
        expect(json['iv'], true);
      });
    });

    group('constructor', () {
      test('should create instance with parameters', () {
        // Act
        final data = ImageListData('img-123', 'custom_image.jpg', false);

        // Assert
        expect(data.rId, 'img-123');
        expect(data.imageName, 'custom_image.jpg');
        expect(data.isVideo, false);
      });

      test('should create instance with null parameters', () {
        // Act
        final data = ImageListData(null, null, null);

        // Assert
        expect(data.rId, null);
        expect(data.imageName, null);
        expect(data.isVideo, null);
      });

      test('should create video instance', () {
        // Act
        final data = ImageListData('vid-1', 'demo.mp4', true);

        // Assert
        expect(data.isVideo, true);
      });
    });

    group('mediaUrl property', () {
      test('should be settable and gettable', () {
        // Arrange
        final data = ImageListData('img-1', 'test.jpg', false);

        // Act
        data.mediaUrl = 'https://cdn.example.com/images/test.jpg';

        // Assert
        expect(data.mediaUrl, 'https://cdn.example.com/images/test.jpg');
      });

      test('should default to null', () {
        // Arrange
        final data = ImageListData('img-1', 'test.jpg', false);

        // Assert
        expect(data.mediaUrl, null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'r_id': 'img-999',
          'mn': 'roundtrip.jpg',
          'iv': false,
        };

        // Act
        final data = ImageListData.fromJson(originalJson);
        final serialized = data.toJson();

        // Assert
        expect(serialized['r_id'], originalJson['r_id']);
        expect(serialized['mn'], originalJson['mn']);
        expect(serialized['iv'], originalJson['iv']);
      });

      test('should maintain video flag through cycle', () {
        // Arrange
        final originalJson = {
          'r_id': 'vid-999',
          'mn': 'roundtrip.mp4',
          'iv': true,
        };

        // Act
        final data = ImageListData.fromJson(originalJson);
        final serialized = data.toJson();

        // Assert
        expect(serialized['iv'], true);
      });
    });

    group('edge cases', () {
      test('should handle empty string imageName', () {
        // Arrange
        final json = {
          'r_id': 'img-1',
          'mn': '',
          'iv': false,
        };

        // Act
        final data = ImageListData.fromJson(json);

        // Assert
        expect(data.imageName, '');
      });

      test('should handle long image names', () {
        // Arrange
        final longName = 'a' * 255 + '.jpg';
        final json = {
          'r_id': 'img-1',
          'mn': longName,
          'iv': false,
        };

        // Act
        final data = ImageListData.fromJson(json);

        // Assert
        expect(data.imageName!.length, 259);
      });

      test('should handle special characters in imageName', () {
        // Arrange
        final json = {
          'r_id': 'img-1',
          'mn': 'device (1)_front-view.jpg',
          'iv': false,
        };

        // Act
        final data = ImageListData.fromJson(json);

        // Assert
        expect(data.imageName, 'device (1)_front-view.jpg');
      });

      test('should handle various file extensions', () {
        // Arrange
        final jpgJson = {'mn': 'test.jpg', 'iv': false};
        final pngJson = {'mn': 'test.png', 'iv': false};
        final mp4Json = {'mn': 'test.mp4', 'iv': true};
        final webmJson = {'mn': 'test.webm', 'iv': true};

        // Act
        final jpgData = ImageListData.fromJson(jpgJson);
        final pngData = ImageListData.fromJson(pngJson);
        final mp4Data = ImageListData.fromJson(mp4Json);
        final webmData = ImageListData.fromJson(webmJson);

        // Assert
        expect(jpgData.imageName, 'test.jpg');
        expect(pngData.imageName, 'test.png');
        expect(mp4Data.imageName, 'test.mp4');
        expect(webmData.imageName, 'test.webm');
      });

      test('should handle uuid-style rId', () {
        // Arrange
        final json = {
          'r_id': 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
          'mn': 'image.jpg',
          'iv': false,
        };

        // Act
        final data = ImageListData.fromJson(json);

        // Assert
        expect(data.rId, 'a1b2c3d4-e5f6-7890-abcd-ef1234567890');
      });
    });
  });
}
