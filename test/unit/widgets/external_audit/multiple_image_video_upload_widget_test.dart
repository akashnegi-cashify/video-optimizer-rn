import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Actual widget import
import 'package:flutter_trc/qc/modules/external_audit/widgets/multiple_image_video_upload_widget.dart';

void main() {
  group('MultipleImageVideoUploadWidget', () {
    test('MultipleImageVideoUploadWidget class exists and is a StatefulWidget', () {
      expect(MultipleImageVideoUploadWidget, isNotNull);
      final widget = MultipleImageVideoUploadWidget(
        onMediaUploaded: (images, videos) {},
      );
      expect(widget, isA<StatefulWidget>());
    });

    test('MultipleImageVideoUploadWidget can be instantiated with required callback', () {
      final widget = MultipleImageVideoUploadWidget(
        onMediaUploaded: (images, videos) {},
      );
      expect(widget, isNotNull);
      expect(widget.onMediaUploaded, isNotNull);
    });

    test('MultipleImageVideoUploadWidget stores onMediaUploaded callback', () {
      List<String>? receivedImages;
      List<String>? receivedVideos;
      
      final widget = MultipleImageVideoUploadWidget(
        onMediaUploaded: (images, videos) {
          receivedImages = images;
          receivedVideos = videos;
        },
      );
      
      widget.onMediaUploaded(['image1.jpg', 'image2.jpg'], ['video1.mp4']);
      
      expect(receivedImages?.length, equals(2));
      expect(receivedVideos?.length, equals(1));
      expect(receivedImages?.first, equals('image1.jpg'));
      expect(receivedVideos?.first, equals('video1.mp4'));
    });

    test('MultipleImageVideoUploadWidget callback can receive empty lists', () {
      List<String>? receivedImages;
      List<String>? receivedVideos;
      
      final widget = MultipleImageVideoUploadWidget(
        onMediaUploaded: (images, videos) {
          receivedImages = images;
          receivedVideos = videos;
        },
      );
      
      widget.onMediaUploaded([], []);
      
      expect(receivedImages, isEmpty);
      expect(receivedVideos, isEmpty);
    });

    test('MultipleImageVideoUploadWidget can be instantiated with a key', () {
      const key = Key('multiple_image_video_upload_widget_key');
      final widget = MultipleImageVideoUploadWidget(
        onMediaUploaded: (images, videos) {},
        key: key,
      );
      expect(widget.key, equals(key));
    });

    test('MultipleImageVideoUploadWidget creates state correctly', () {
      final widget = MultipleImageVideoUploadWidget(
        onMediaUploaded: (images, videos) {},
      );
      final element = widget.createElement();
      expect(element, isNotNull);
    });

    test('MultipleImageVideoUploadWidget callback receives correct URL format', () {
      List<String>? images;
      List<String>? videos;
      
      final widget = MultipleImageVideoUploadWidget(
        onMediaUploaded: (imgs, vids) {
          images = imgs;
          videos = vids;
        },
      );
      
      widget.onMediaUploaded(
        ['https://example.com/img1.jpg', 'https://example.com/img2.png'],
        ['https://example.com/video1.mp4'],
      );
      
      expect(images?.first.startsWith('https://'), isTrue);
      expect(videos?.first.endsWith('.mp4'), isTrue);
    });
  });
}
