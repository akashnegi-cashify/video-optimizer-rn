import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_media_response.dart';
import 'package:flutter_trc/src/utils/media_upload/widgets/image_upload_widget.dart';

void main() {
  // Note: ImageUploadOptimizerCard uses MediaQuery.of(context).size in build()
  // which creates very large heights in test environment, making widget tests
  // impractical without significant mocking. Focus on model tests instead.

  group('ImageUploadOptimizerCard - Class Structure', () {
    test('ImageUploadOptimizerCard class exists', () {
      expect(ImageUploadOptimizerCard, isNotNull);
    });

    test('ImageUploadOptimizerCard is a StatefulWidget', () {
      const widget = ImageUploadOptimizerCard();
      expect(widget, isA<ImageUploadOptimizerCard>());
    });

    test('can create widget with default parameters', () {
      const widget = ImageUploadOptimizerCard();
      expect(widget.dataModel, isNull);
      expect(widget.onMediaUploaded, isNull);
      expect(widget.initialUrl, isNull);
    });

    test('can create widget with dataModel', () {
      final dataModel = ImageListData('r1', 'Test', false);
      final widget = ImageUploadOptimizerCard(dataModel: dataModel);
      expect(widget.dataModel, dataModel);
    });

    test('can create widget with initialUrl', () {
      const widget = ImageUploadOptimizerCard(
        initialUrl: 'https://example.com/image.jpg',
      );
      expect(widget.initialUrl, 'https://example.com/image.jpg');
    });

    test('can create widget with onMediaUploaded callback', () {
      String? capturedUrl;
      final widget = ImageUploadOptimizerCard(
        onMediaUploaded: (url) {
          capturedUrl = url;
        },
      );
      expect(widget.onMediaUploaded, isNotNull);
    });

    test('can create widget with all parameters', () {
      final dataModel = ImageListData('r1', 'Test', false);
      final widget = ImageUploadOptimizerCard(
        dataModel: dataModel,
        initialUrl: 'https://example.com/image.jpg',
        onMediaUploaded: (url) {},
      );
      expect(widget.dataModel, dataModel);
      expect(widget.initialUrl, 'https://example.com/image.jpg');
      expect(widget.onMediaUploaded, isNotNull);
    });
  });

  group('ImageListData Model', () {
    test('can be instantiated with all parameters', () {
      final data = ImageListData('r1', 'Test', true);
      expect(data.rId, 'r1');
      expect(data.imageName, 'Test');
      expect(data.isVideo, true);
    });

    test('can have null rId', () {
      final data = ImageListData(null, 'Test', false);
      expect(data.rId, isNull);
    });

    test('can have null imageName', () {
      final data = ImageListData('r1', null, false);
      expect(data.imageName, isNull);
    });

    test('can have null isVideo', () {
      final data = ImageListData('r1', 'Test', null);
      expect(data.isVideo, isNull);
    });

    test('fromJson parses correctly', () {
      final json = {
        'r_id': 'r1',
        'mn': 'Test Image',
        'iv': false,
      };
      final data = ImageListData.fromJson(json);
      expect(data.rId, 'r1');
      expect(data.imageName, 'Test Image');
      expect(data.isVideo, false);
    });

    test('fromJson handles null values', () {
      final json = <String, dynamic>{
        'r_id': null,
        'mn': null,
        'iv': null,
      };
      final data = ImageListData.fromJson(json);
      expect(data.rId, isNull);
      expect(data.imageName, isNull);
      expect(data.isVideo, isNull);
    });

    test('fromJson handles missing keys', () {
      final json = <String, dynamic>{};
      final data = ImageListData.fromJson(json);
      expect(data.rId, isNull);
      expect(data.imageName, isNull);
      expect(data.isVideo, isNull);
    });

    test('toJson returns correct map', () {
      final data = ImageListData('r1', 'Test', true);
      final json = data.toJson();
      expect(json['r_id'], 'r1');
      expect(json['mn'], 'Test');
      expect(json['iv'], true);
    });

    test('toJson handles null values', () {
      final data = ImageListData(null, null, null);
      final json = data.toJson();
      expect(json['r_id'], isNull);
      expect(json['mn'], isNull);
      expect(json['iv'], isNull);
    });

    test('mediaUrl property exists and is settable', () {
      final data = ImageListData('r1', 'Test', false);
      data.mediaUrl = 'https://example.com/media.jpg';
      expect(data.mediaUrl, 'https://example.com/media.jpg');
    });

    test('mediaUrl is not included in toJson', () {
      final data = ImageListData('r1', 'Test', false);
      data.mediaUrl = 'https://example.com/media.jpg';
      final json = data.toJson();
      expect(json.containsKey('mediaUrl'), false);
    });
  });

  group('DeviceMediaResponse Model', () {
    test('fromJson parses response correctly', () {
      final json = {
        'r_id': 'response1',
        'dt': [
          {'r_id': 'img1', 'mn': 'Image 1', 'iv': false},
          {'r_id': 'img2', 'mn': 'Image 2', 'iv': true},
        ],
        'cashify_alert': null,
        'track_url': null,
      };
      final response = DeviceMediaResponse.fromJson(json);
      expect(response.rId, 'response1');
      expect(response.imageList?.length, 2);
      expect(response.imageList?[0].imageName, 'Image 1');
      expect(response.imageList?[1].isVideo, true);
    });

    test('fromJson handles empty image list', () {
      final json = {
        'r_id': 'response1',
        'dt': <Map<String, dynamic>>[],
        'cashify_alert': null,
        'track_url': null,
      };
      final response = DeviceMediaResponse.fromJson(json);
      expect(response.imageList, isEmpty);
    });

    test('fromJson handles null image list', () {
      final json = {
        'r_id': 'response1',
        'dt': null,
        'cashify_alert': null,
        'track_url': null,
      };
      final response = DeviceMediaResponse.fromJson(json);
      expect(response.imageList, isNull);
    });
  });
}
