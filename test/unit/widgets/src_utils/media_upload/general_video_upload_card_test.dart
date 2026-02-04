import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/disputed_image_capture/models/disputed_media_data_response.dart';
import 'package:flutter_trc/src/utils/media_upload/widgets/general_video_upload_card.dart';

void main() {
  group('GeneralVideoUploadCard - Class Structure', () {
    test('GeneralVideoUploadCard class exists', () {
      expect(GeneralVideoUploadCard, isNotNull);
    });

    test('GeneralVideoUploadCard is a StatelessWidget', () {
      const widget = GeneralVideoUploadCard();
      expect(widget, isA<GeneralVideoUploadCard>());
    });

    test('can create widget with default parameters', () {
      const widget = GeneralVideoUploadCard();
      expect(widget.onMediaUploaded, isNull);
      expect(widget.cardHeight, isNull);
      expect(widget.cardWidth, isNull);
      expect(widget.videoUrl, isNull);
      expect(widget.onMediaUploadingStarted, isNull);
      expect(widget.isCustomCameraVideo, false);
    });

    test('can create widget with custom cardHeight', () {
      const widget = GeneralVideoUploadCard(cardHeight: 100);
      expect(widget.cardHeight, 100);
    });

    test('can create widget with custom cardWidth', () {
      const widget = GeneralVideoUploadCard(cardWidth: 100);
      expect(widget.cardWidth, 100);
    });

    test('can create widget with isCustomCameraVideo true', () {
      const widget = GeneralVideoUploadCard(isCustomCameraVideo: true);
      expect(widget.isCustomCameraVideo, true);
    });

    test('can create widget with onMediaUploaded callback', () {
      String? capturedUrl;
      String? capturedThumbnail;
      final widget = GeneralVideoUploadCard(
        onMediaUploaded: (url, thumbnail) {
          capturedUrl = url;
          capturedThumbnail = thumbnail;
        },
      );
      expect(widget.onMediaUploaded, isNotNull);
    });

    test('can create widget with onMediaUploadingStarted callback', () {
      bool started = false;
      final widget = GeneralVideoUploadCard(
        onMediaUploadingStarted: () {
          started = true;
        },
      );
      expect(widget.onMediaUploadingStarted, isNotNull);
    });

    test('can create widget with videoUrl', () {
      final videoData = VideoUrlData(
        videoUrl: 'https://example.com/video.mp4',
        videoThumbnail: '/path/thumbnail.jpg',
      );
      final widget = GeneralVideoUploadCard(videoUrl: videoData);
      expect(widget.videoUrl, videoData);
    });

    test('can create widget with all parameters', () {
      final videoData = VideoUrlData(
        videoUrl: 'https://example.com/video.mp4',
        videoThumbnail: '/path/thumbnail.jpg',
      );
      final widget = GeneralVideoUploadCard(
        cardHeight: 80,
        cardWidth: 80,
        videoUrl: videoData,
        isCustomCameraVideo: true,
        onMediaUploaded: (url, thumbnail) {},
        onMediaUploadingStarted: () {},
      );
      expect(widget.cardHeight, 80);
      expect(widget.cardWidth, 80);
      expect(widget.videoUrl, videoData);
      expect(widget.isCustomCameraVideo, true);
      expect(widget.onMediaUploaded, isNotNull);
      expect(widget.onMediaUploadingStarted, isNotNull);
    });
  });

  group('GeneralVideoUploadCard - Default Values', () {
    test('isCustomCameraVideo defaults to false', () {
      const widget = GeneralVideoUploadCard();
      expect(widget.isCustomCameraVideo, false);
    });

    test('all optional parameters default to null', () {
      const widget = GeneralVideoUploadCard();
      expect(widget.cardHeight, isNull);
      expect(widget.cardWidth, isNull);
      expect(widget.videoUrl, isNull);
      expect(widget.onMediaUploaded, isNull);
      expect(widget.onMediaUploadingStarted, isNull);
    });
  });

  group('VideoUrlData Model', () {
    test('can be instantiated with all parameters', () {
      final data = VideoUrlData(
        videoUrl: 'https://example.com/video.mp4',
        videoThumbnail: '/path/to/thumbnail.jpg',
      );
      expect(data.videoUrl, 'https://example.com/video.mp4');
      expect(data.videoThumbnail, '/path/to/thumbnail.jpg');
    });

    test('can have null videoUrl', () {
      final data = VideoUrlData(
        videoUrl: null,
        videoThumbnail: '/path/thumbnail.jpg',
      );
      expect(data.videoUrl, isNull);
    });

    test('can have null videoThumbnail', () {
      final data = VideoUrlData(
        videoUrl: 'https://example.com/video.mp4',
        videoThumbnail: null,
      );
      expect(data.videoThumbnail, isNull);
    });

    test('can have all null values', () {
      final data = VideoUrlData(
        videoUrl: null,
        videoThumbnail: null,
      );
      expect(data.videoUrl, isNull);
      expect(data.videoThumbnail, isNull);
    });

    test('handles different video URL formats', () {
      final formats = [
        'https://example.com/video.mp4',
        'https://s3.amazonaws.com/bucket/video.mp4',
        'https://cdn.example.com/videos/video.webm',
        '/local/path/video.mov',
      ];

      for (final url in formats) {
        final data = VideoUrlData(videoUrl: url, videoThumbnail: null);
        expect(data.videoUrl, url);
      }
    });
  });
}
