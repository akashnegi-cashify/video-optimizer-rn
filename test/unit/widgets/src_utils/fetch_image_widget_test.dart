import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/utils/fetch_image_widget.dart';

void main() {
  /// Builds a testable widget with MaterialApp wrapper
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(body: child),
    );
  }

  group('fetchImage function', () {
    testWidgets('returns CachedNetworkImage widget', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage('assets/placeholder.png', 'https://example.com/image.jpg'),
        ),
      );
      await tester.pump();

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('handles null url gracefully', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage('assets/placeholder.png', null),
        ),
      );
      await tester.pump();

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('handles empty url string', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage('assets/placeholder.png', ''),
        ),
      );
      await tester.pump();

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('applies BoxFit.cover parameter', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage(
            'assets/placeholder.png',
            'https://example.com/image.jpg',
            fit: BoxFit.cover,
          ),
        ),
      );
      await tester.pump();

      final cachedImage =
          tester.widget<CachedNetworkImage>(find.byType(CachedNetworkImage));
      expect(cachedImage.fit, BoxFit.cover);
    });

    testWidgets('applies BoxFit.contain parameter', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage(
            'assets/placeholder.png',
            'https://example.com/image.jpg',
            fit: BoxFit.contain,
          ),
        ),
      );
      await tester.pump();

      final cachedImage =
          tester.widget<CachedNetworkImage>(find.byType(CachedNetworkImage));
      expect(cachedImage.fit, BoxFit.contain);
    });

    testWidgets('applies BoxFit.fill parameter', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage(
            'assets/placeholder.png',
            'https://example.com/image.jpg',
            fit: BoxFit.fill,
          ),
        ),
      );
      await tester.pump();

      final cachedImage =
          tester.widget<CachedNetworkImage>(find.byType(CachedNetworkImage));
      expect(cachedImage.fit, BoxFit.fill);
    });

    testWidgets('applies null fit parameter', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage(
            'assets/placeholder.png',
            'https://example.com/image.jpg',
          ),
        ),
      );
      await tester.pump();

      final cachedImage =
          tester.widget<CachedNetworkImage>(find.byType(CachedNetworkImage));
      expect(cachedImage.fit, isNull);
    });

    testWidgets('sets useOldImageOnUrlChange to true', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage(
            'assets/placeholder.png',
            'https://example.com/image.jpg',
          ),
        ),
      );
      await tester.pump();

      final cachedImage =
          tester.widget<CachedNetworkImage>(find.byType(CachedNetworkImage));
      expect(cachedImage.useOldImageOnUrlChange, true);
    });

    testWidgets('sets correct imageUrl', (tester) async {
      const testUrl = 'https://example.com/test-image.jpg';
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage('assets/placeholder.png', testUrl),
        ),
      );
      await tester.pump();

      final cachedImage =
          tester.widget<CachedNetworkImage>(find.byType(CachedNetworkImage));
      expect(cachedImage.imageUrl, testUrl);
    });

    testWidgets('sets imageUrl to empty string when url is null',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage('assets/placeholder.png', null),
        ),
      );
      await tester.pump();

      final cachedImage =
          tester.widget<CachedNetworkImage>(find.byType(CachedNetworkImage));
      expect(cachedImage.imageUrl, '');
    });

    testWidgets('has placeholder builder', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage('assets/placeholder.png', 'https://example.com/image.jpg'),
        ),
      );
      await tester.pump();

      final cachedImage =
          tester.widget<CachedNetworkImage>(find.byType(CachedNetworkImage));
      expect(cachedImage.placeholder, isNotNull);
    });

    testWidgets('has error widget builder', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage('assets/placeholder.png', 'https://example.com/image.jpg'),
        ),
      );
      await tester.pump();

      final cachedImage =
          tester.widget<CachedNetworkImage>(find.byType(CachedNetworkImage));
      expect(cachedImage.errorWidget, isNotNull);
    });

    testWidgets('placeholder callback returns shimmer widget', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage('assets/placeholder.png', 'https://example.com/image.jpg'),
        ),
      );
      await tester.pump();

      final cachedImage =
          tester.widget<CachedNetworkImage>(find.byType(CachedNetworkImage));
      final placeholderBuilder = cachedImage.placeholder;
      expect(placeholderBuilder, isNotNull);
    });
  });

  group('fetchImage - Various URL Formats', () {
    testWidgets('handles HTTPS URLs', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage(
              'assets/placeholder.png', 'https://secure.example.com/image.png'),
        ),
      );
      await tester.pump();

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('handles HTTP URLs', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage(
              'assets/placeholder.png', 'http://example.com/image.png'),
        ),
      );
      await tester.pump();

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('handles URLs with query parameters', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage('assets/placeholder.png',
              'https://example.com/image.png?width=100&height=100'),
        ),
      );
      await tester.pump();

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('handles various image extensions', (tester) async {
      final extensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp'];

      for (final ext in extensions) {
        await tester.pumpWidget(
          buildTestWidget(
            fetchImage('assets/placeholder.png', 'https://example.com/image$ext'),
          ),
        );
        await tester.pump();

        expect(find.byType(CachedNetworkImage), findsOneWidget);
      }
    });

    testWidgets('handles S3 bucket URLs', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage('assets/placeholder.png',
              'https://bucket.s3.amazonaws.com/images/test.jpg'),
        ),
      );
      await tester.pump();

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });
  });

  group('fetchImage - Different Placeholder Paths', () {
    testWidgets('accepts relative asset path', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage('assets/images/placeholder.png', 'https://example.com/image.jpg'),
        ),
      );
      await tester.pump();

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('accepts package asset path', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage('packages/flutter_trc/assets/placeholder.png',
              'https://example.com/image.jpg'),
        ),
      );
      await tester.pump();

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });
  });

  group('fetchImage - BoxFit Options', () {
    testWidgets('applies BoxFit.none', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage(
            'assets/placeholder.png',
            'https://example.com/image.jpg',
            fit: BoxFit.none,
          ),
        ),
      );
      await tester.pump();

      final cachedImage =
          tester.widget<CachedNetworkImage>(find.byType(CachedNetworkImage));
      expect(cachedImage.fit, BoxFit.none);
    });

    testWidgets('applies BoxFit.scaleDown', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage(
            'assets/placeholder.png',
            'https://example.com/image.jpg',
            fit: BoxFit.scaleDown,
          ),
        ),
      );
      await tester.pump();

      final cachedImage =
          tester.widget<CachedNetworkImage>(find.byType(CachedNetworkImage));
      expect(cachedImage.fit, BoxFit.scaleDown);
    });

    testWidgets('applies BoxFit.fitWidth', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage(
            'assets/placeholder.png',
            'https://example.com/image.jpg',
            fit: BoxFit.fitWidth,
          ),
        ),
      );
      await tester.pump();

      final cachedImage =
          tester.widget<CachedNetworkImage>(find.byType(CachedNetworkImage));
      expect(cachedImage.fit, BoxFit.fitWidth);
    });

    testWidgets('applies BoxFit.fitHeight', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          fetchImage(
            'assets/placeholder.png',
            'https://example.com/image.jpg',
            fit: BoxFit.fitHeight,
          ),
        ),
      );
      await tester.pump();

      final cachedImage =
          tester.widget<CachedNetworkImage>(find.byType(CachedNetworkImage));
      expect(cachedImage.fit, BoxFit.fitHeight);
    });
  });
}
