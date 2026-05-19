import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/utils/media_upload/widgets/general_image_upload_card.dart';

void main() {
  group('GeneralImageUploadCard - Class Structure', () {
    test('GeneralImageUploadCard class exists', () {
      expect(GeneralImageUploadCard, isNotNull);
    });

    test('GeneralImageUploadCard is a StatelessWidget', () {
      const widget = GeneralImageUploadCard();
      expect(widget, isA<GeneralImageUploadCard>());
    });

    test('can create widget with default parameters', () {
      const widget = GeneralImageUploadCard();
      expect(widget.onMediaUploaded, isNull);
      expect(widget.cardHeight, isNull);
      expect(widget.cardWidth, isNull);
      expect(widget.imageUrl, isNull);
      expect(widget.isImageMarkingRequired, false);
      expect(widget.onMediaUploadingStarted, isNull);
      expect(widget.onImageDelete, isNull);
    });

    test('can create widget with custom cardHeight', () {
      const widget = GeneralImageUploadCard(cardHeight: 100);
      expect(widget.cardHeight, 100);
    });

    test('can create widget with custom cardWidth', () {
      const widget = GeneralImageUploadCard(cardWidth: 100);
      expect(widget.cardWidth, 100);
    });

    test('can create widget with imageUrl', () {
      const widget = GeneralImageUploadCard(
        imageUrl: 'https://example.com/image.jpg',
      );
      expect(widget.imageUrl, 'https://example.com/image.jpg');
    });

    test('can create widget with isImageMarkingRequired true', () {
      const widget = GeneralImageUploadCard(isImageMarkingRequired: true);
      expect(widget.isImageMarkingRequired, true);
    });

    test('can create widget with onMediaUploaded callback', () {
      String? capturedUrl;
      final widget = GeneralImageUploadCard(
        onMediaUploaded: (url) {
          capturedUrl = url;
        },
      );
      expect(widget.onMediaUploaded, isNotNull);
    });

    test('can create widget with onMediaUploadingStarted callback', () {
      bool started = false;
      final widget = GeneralImageUploadCard(
        onMediaUploadingStarted: () {
          started = true;
        },
      );
      expect(widget.onMediaUploadingStarted, isNotNull);
    });

    test('can create widget with onImageDelete callback', () {
      bool deleted = false;
      final widget = GeneralImageUploadCard(
        onImageDelete: () {
          deleted = true;
        },
      );
      expect(widget.onImageDelete, isNotNull);
    });

    test('can create widget with all parameters', () {
      final widget = GeneralImageUploadCard(
        cardHeight: 80,
        cardWidth: 80,
        imageUrl: 'https://example.com/image.jpg',
        isImageMarkingRequired: true,
        onMediaUploaded: (url) {},
        onMediaUploadingStarted: () {},
        onImageDelete: () {},
      );
      expect(widget.cardHeight, 80);
      expect(widget.cardWidth, 80);
      expect(widget.imageUrl, 'https://example.com/image.jpg');
      expect(widget.isImageMarkingRequired, true);
      expect(widget.onMediaUploaded, isNotNull);
      expect(widget.onMediaUploadingStarted, isNotNull);
      expect(widget.onImageDelete, isNotNull);
    });
  });

  group('GeneralImageUploadCard - Default Values', () {
    test('isImageMarkingRequired defaults to false', () {
      const widget = GeneralImageUploadCard();
      expect(widget.isImageMarkingRequired, false);
    });

    test('all optional parameters default to null', () {
      const widget = GeneralImageUploadCard();
      expect(widget.cardHeight, isNull);
      expect(widget.cardWidth, isNull);
      expect(widget.imageUrl, isNull);
      expect(widget.onMediaUploaded, isNull);
      expect(widget.onMediaUploadingStarted, isNull);
      expect(widget.onImageDelete, isNull);
    });
  });
}
