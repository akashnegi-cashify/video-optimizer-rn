import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/media_submit_request.dart';

/// Tests for MediaSubmitRequest model.
/// Focus: Testing fromJson/toJson for media submit request with image/video fields.
void main() {
  group('MediaSubmitRequest', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'mn': 'front_image.jpg',
          'fp': 'https://cdn.example.com/uploads/front_image.jpg',
          'iv': 0,
        };

        // Act
        final request = MediaSubmitRequest.fromJson(json);

        // Assert
        expect(request.imageName, 'front_image.jpg');
        expect(request.mediaUrl, 'https://cdn.example.com/uploads/front_image.jpg');
        expect(request.isVideo, 0);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final request = MediaSubmitRequest.fromJson(json);

        // Assert
        expect(request.imageName, null);
        expect(request.mediaUrl, null);
        expect(request.isVideo, null);
      });

      test('should handle null imageName only', () {
        // Arrange
        final json = {
          'mn': null,
          'fp': 'https://example.com/image.jpg',
          'iv': 0,
        };

        // Act
        final request = MediaSubmitRequest.fromJson(json);

        // Assert
        expect(request.imageName, null);
        expect(request.mediaUrl, 'https://example.com/image.jpg');
        expect(request.isVideo, 0);
      });

      test('should handle null mediaUrl only', () {
        // Arrange
        final json = {
          'mn': 'test.jpg',
          'fp': null,
          'iv': 0,
        };

        // Act
        final request = MediaSubmitRequest.fromJson(json);

        // Assert
        expect(request.imageName, 'test.jpg');
        expect(request.mediaUrl, null);
        expect(request.isVideo, 0);
      });

      test('should handle null isVideo only', () {
        // Arrange
        final json = {
          'mn': 'test.jpg',
          'fp': 'https://example.com/test.jpg',
          'iv': null,
        };

        // Act
        final request = MediaSubmitRequest.fromJson(json);

        // Assert
        expect(request.imageName, 'test.jpg');
        expect(request.mediaUrl, 'https://example.com/test.jpg');
        expect(request.isVideo, null);
      });

      test('should handle video media (isVideo = 1)', () {
        // Arrange
        final json = {
          'mn': 'demo_video.mp4',
          'fp': 'https://cdn.example.com/videos/demo_video.mp4',
          'iv': 1,
        };

        // Act
        final request = MediaSubmitRequest.fromJson(json);

        // Assert
        expect(request.imageName, 'demo_video.mp4');
        expect(request.isVideo, 1);
      });

      test('should handle image media (isVideo = 0)', () {
        // Arrange
        final json = {
          'mn': 'photo.png',
          'fp': 'https://cdn.example.com/images/photo.png',
          'iv': 0,
        };

        // Act
        final request = MediaSubmitRequest.fromJson(json);

        // Assert
        expect(request.isVideo, 0);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final request = MediaSubmitRequest(
          imageName: 'back_image.jpg',
          mediaUrl: 'https://cdn.example.com/uploads/back_image.jpg',
          isVideo: 0,
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['mn'], 'back_image.jpg');
        expect(json['fp'], 'https://cdn.example.com/uploads/back_image.jpg');
        expect(json['iv'], 0);
      });

      test('should handle null fields in serialization', () {
        // Arrange
        final request = MediaSubmitRequest();

        // Act
        final json = request.toJson();

        // Assert
        expect(json['mn'], null);
        expect(json['fp'], null);
        expect(json['iv'], null);
      });

      test('should serialize video request', () {
        // Arrange
        final request = MediaSubmitRequest(
          imageName: 'recording.mp4',
          mediaUrl: 'https://example.com/videos/recording.mp4',
          isVideo: 1,
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['iv'], 1);
      });

      test('should serialize partial data', () {
        // Arrange
        final request = MediaSubmitRequest(
          imageName: 'partial.jpg',
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['mn'], 'partial.jpg');
        expect(json['fp'], null);
        expect(json['iv'], null);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final request = MediaSubmitRequest(
          imageName: 'constructor_test.jpg',
          mediaUrl: 'https://example.com/test.jpg',
          isVideo: 0,
        );

        // Assert
        expect(request.imageName, 'constructor_test.jpg');
        expect(request.mediaUrl, 'https://example.com/test.jpg');
        expect(request.isVideo, 0);
      });

      test('should create instance with no parameters', () {
        // Act
        final request = MediaSubmitRequest();

        // Assert
        expect(request.imageName, null);
        expect(request.mediaUrl, null);
        expect(request.isVideo, null);
      });

      test('should create instance with imageName only', () {
        // Act
        final request = MediaSubmitRequest(imageName: 'only_name.jpg');

        // Assert
        expect(request.imageName, 'only_name.jpg');
        expect(request.mediaUrl, null);
        expect(request.isVideo, null);
      });

      test('should create instance with mediaUrl only', () {
        // Act
        final request = MediaSubmitRequest(mediaUrl: 'https://example.com/image.jpg');

        // Assert
        expect(request.imageName, null);
        expect(request.mediaUrl, 'https://example.com/image.jpg');
        expect(request.isVideo, null);
      });

      test('should create instance with isVideo only', () {
        // Act
        final request = MediaSubmitRequest(isVideo: 1);

        // Assert
        expect(request.imageName, null);
        expect(request.mediaUrl, null);
        expect(request.isVideo, 1);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'mn': 'roundtrip.jpg',
          'fp': 'https://cdn.example.com/roundtrip.jpg',
          'iv': 0,
        };

        // Act
        final request = MediaSubmitRequest.fromJson(originalJson);
        final serialized = request.toJson();

        // Assert
        expect(serialized['mn'], originalJson['mn']);
        expect(serialized['fp'], originalJson['fp']);
        expect(serialized['iv'], originalJson['iv']);
      });

      test('should maintain null values through cycle', () {
        // Arrange
        final originalJson = <String, dynamic>{
          'mn': null,
          'fp': null,
          'iv': null,
        };

        // Act
        final request = MediaSubmitRequest.fromJson(originalJson);
        final serialized = request.toJson();

        // Assert
        expect(serialized['mn'], null);
        expect(serialized['fp'], null);
        expect(serialized['iv'], null);
      });

      test('should maintain video flag through cycle', () {
        // Arrange
        final originalJson = {
          'mn': 'video.mp4',
          'fp': 'https://example.com/video.mp4',
          'iv': 1,
        };

        // Act
        final request = MediaSubmitRequest.fromJson(originalJson);
        final serialized = request.toJson();

        // Assert
        expect(serialized['iv'], 1);
      });
    });

    group('edge cases', () {
      test('should handle empty string imageName', () {
        // Arrange
        final json = {
          'mn': '',
          'fp': 'https://example.com/image.jpg',
          'iv': 0,
        };

        // Act
        final request = MediaSubmitRequest.fromJson(json);

        // Assert
        expect(request.imageName, '');
      });

      test('should handle empty string mediaUrl', () {
        // Arrange
        final json = {
          'mn': 'test.jpg',
          'fp': '',
          'iv': 0,
        };

        // Act
        final request = MediaSubmitRequest.fromJson(json);

        // Assert
        expect(request.mediaUrl, '');
      });

      test('should handle long image names', () {
        // Arrange
        final longName = 'a' * 255 + '.jpg';
        final json = {
          'mn': longName,
        };

        // Act
        final request = MediaSubmitRequest.fromJson(json);

        // Assert
        expect(request.imageName!.length, 259);
      });

      test('should handle special characters in imageName', () {
        // Arrange
        final json = {
          'mn': 'device (1)_front-view_2024.01.29.jpg',
        };

        // Act
        final request = MediaSubmitRequest.fromJson(json);

        // Assert
        expect(request.imageName, 'device (1)_front-view_2024.01.29.jpg');
      });

      test('should handle various file extensions', () {
        // Arrange
        final jpgJson = {'mn': 'test.jpg', 'iv': 0};
        final pngJson = {'mn': 'test.png', 'iv': 0};
        final jpegJson = {'mn': 'test.jpeg', 'iv': 0};
        final mp4Json = {'mn': 'test.mp4', 'iv': 1};
        final webmJson = {'mn': 'test.webm', 'iv': 1};
        final movJson = {'mn': 'test.mov', 'iv': 1};

        // Act
        final jpgRequest = MediaSubmitRequest.fromJson(jpgJson);
        final pngRequest = MediaSubmitRequest.fromJson(pngJson);
        final jpegRequest = MediaSubmitRequest.fromJson(jpegJson);
        final mp4Request = MediaSubmitRequest.fromJson(mp4Json);
        final webmRequest = MediaSubmitRequest.fromJson(webmJson);
        final movRequest = MediaSubmitRequest.fromJson(movJson);

        // Assert
        expect(jpgRequest.imageName, 'test.jpg');
        expect(pngRequest.imageName, 'test.png');
        expect(jpegRequest.imageName, 'test.jpeg');
        expect(mp4Request.imageName, 'test.mp4');
        expect(webmRequest.imageName, 'test.webm');
        expect(movRequest.imageName, 'test.mov');
      });

      test('should handle full URL with query parameters', () {
        // Arrange
        final json = {
          'fp': 'https://cdn.example.com/uploads/image.jpg?token=abc123&expires=12345',
        };

        // Act
        final request = MediaSubmitRequest.fromJson(json);

        // Assert
        expect(request.mediaUrl, 'https://cdn.example.com/uploads/image.jpg?token=abc123&expires=12345');
      });

      test('should handle S3 presigned URLs', () {
        // Arrange
        final json = {
          'fp': 'https://bucket.s3.region.amazonaws.com/key?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKID',
        };

        // Act
        final request = MediaSubmitRequest.fromJson(json);

        // Assert
        expect(request.mediaUrl!.contains('s3'), true);
      });

      test('should handle whitespace-only imageName', () {
        // Arrange
        final json = {
          'mn': '   ',
        };

        // Act
        final request = MediaSubmitRequest.fromJson(json);

        // Assert
        expect(request.imageName, '   ');
      });

      test('should handle zero as isVideo', () {
        // Arrange
        final json = {
          'iv': 0,
        };

        // Act
        final request = MediaSubmitRequest.fromJson(json);

        // Assert
        expect(request.isVideo, 0);
      });

      test('should handle negative isVideo', () {
        // Arrange
        final json = {
          'iv': -1,
        };

        // Act
        final request = MediaSubmitRequest.fromJson(json);

        // Assert
        expect(request.isVideo, -1);
      });

      test('should handle large isVideo value', () {
        // Arrange
        final json = {
          'iv': 999,
        };

        // Act
        final request = MediaSubmitRequest.fromJson(json);

        // Assert
        expect(request.isVideo, 999);
      });

      test('should handle unicode in imageName', () {
        // Arrange
        final json = {
          'mn': 'तस्वीर_2024.jpg',
        };

        // Act
        final request = MediaSubmitRequest.fromJson(json);

        // Assert
        expect(request.imageName, 'तस्वीर_2024.jpg');
      });

      test('should handle relative URL in mediaUrl', () {
        // Arrange
        final json = {
          'fp': '/uploads/images/test.jpg',
        };

        // Act
        final request = MediaSubmitRequest.fromJson(json);

        // Assert
        expect(request.mediaUrl, '/uploads/images/test.jpg');
      });
    });
  });
}
