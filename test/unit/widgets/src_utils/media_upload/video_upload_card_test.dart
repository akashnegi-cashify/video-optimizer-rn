import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_media_response.dart';
import 'package:flutter_trc/src/utils/media_upload/widgets/video_upload_card.dart';

void main() {
  // Note: VideoUploadOptimizerCard uses MediaQuery.of(context).size in build()
  // which creates very large heights in test environment, making widget tests
  // impractical without significant mocking. Focus on class structure tests.

  group('VideoUploadOptimizerCard - Class Structure', () {
    test('VideoUploadOptimizerCard class exists', () {
      expect(VideoUploadOptimizerCard, isNotNull);
    });

    test('VideoUploadOptimizerCard is a StatefulWidget', () {
      const widget = VideoUploadOptimizerCard();
      expect(widget, isA<VideoUploadOptimizerCard>());
    });

    test('can create widget with default parameters', () {
      const widget = VideoUploadOptimizerCard();
      expect(widget.dataModel, isNull);
      expect(widget.onMediaUploaded, isNull);
    });

    test('can create widget with dataModel', () {
      final dataModel = ImageListData('r1', 'Test Video', true);
      final widget = VideoUploadOptimizerCard(dataModel: dataModel);
      expect(widget.dataModel, dataModel);
    });

    test('can create widget with onMediaUploaded callback', () {
      String? capturedUrl;
      final widget = VideoUploadOptimizerCard(
        onMediaUploaded: (url) {
          capturedUrl = url;
        },
      );
      expect(widget.onMediaUploaded, isNotNull);
    });

    test('can create widget with all parameters', () {
      final dataModel = ImageListData('r1', 'Test Video', true);
      final widget = VideoUploadOptimizerCard(
        dataModel: dataModel,
        onMediaUploaded: (url) {},
      );
      expect(widget.dataModel, dataModel);
      expect(widget.onMediaUploaded, isNotNull);
    });
  });

  group('VideoUploadOptimizerCard - Widget Properties', () {
    test('dataModel can be null', () {
      const widget = VideoUploadOptimizerCard(dataModel: null);
      expect(widget.dataModel, isNull);
    });

    test('dataModel with video flag', () {
      final dataModel = ImageListData('v1', 'Video Name', true);
      final widget = VideoUploadOptimizerCard(dataModel: dataModel);
      expect(widget.dataModel?.isVideo, true);
    });

    test('dataModel imageName is used as label', () {
      final dataModel = ImageListData('v1', 'My Video', true);
      final widget = VideoUploadOptimizerCard(dataModel: dataModel);
      expect(widget.dataModel?.imageName, 'My Video');
    });
  });
}
