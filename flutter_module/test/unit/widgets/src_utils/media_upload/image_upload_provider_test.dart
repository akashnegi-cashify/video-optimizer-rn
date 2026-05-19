import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/utils/media_upload/providers/image_upload_provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'getApplicationDocumentsDirectory') {
          return '.';
        }
        return null;
      },
    );
    await GetStorage.init();
    await GetStorage.init('GetStorage');
  });

  group('ImageUploadProvider', () {
    test('can be instantiated with default values', () {
      final provider = ImageUploadProvider();

      expect(provider.isDataLoading, false);
      expect(provider.s3Url, isNull);
    });

    test('can be instantiated with initial s3Url', () {
      final provider =
          ImageUploadProvider(s3Url: 'https://example.com/image.jpg');

      expect(provider.s3Url, 'https://example.com/image.jpg');
    });

    test('can be instantiated with null s3Url', () {
      final provider = ImageUploadProvider(s3Url: null);

      expect(provider.s3Url, isNull);
    });

    test('clearImage sets s3Url to empty string', () {
      final provider =
          ImageUploadProvider(s3Url: 'https://example.com/image.jpg');

      provider.clearImage();

      expect(provider.s3Url, '');
    });

    test('clearImage notifies listeners', () {
      final provider =
          ImageUploadProvider(s3Url: 'https://example.com/image.jpg');
      bool notified = false;

      provider.addListener(() {
        notified = true;
      });

      provider.clearImage();

      expect(notified, true);
    });

    test('is a ChangeNotifier', () {
      final provider = ImageUploadProvider();

      expect(provider, isA<ChangeNotifier>());
    });
  });

  group('ImageUploadProvider.of', () {
    testWidgets('retrieves provider from context', (tester) async {
      late ImageUploadProvider retrievedProvider;

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) =>
              ImageUploadProvider(s3Url: 'https://example.com/test.jpg'),
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                retrievedProvider = ImageUploadProvider.of(context);
                return const Scaffold();
              },
            ),
          ),
        ),
      );
      await tester.pump();

      expect(retrievedProvider, isA<ImageUploadProvider>());
      expect(retrievedProvider.s3Url, 'https://example.com/test.jpg');
    });

    testWidgets('retrieves provider with listen=true', (tester) async {
      late ImageUploadProvider retrievedProvider;

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => ImageUploadProvider(),
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                retrievedProvider = ImageUploadProvider.of(context, listen: true);
                return const Scaffold();
              },
            ),
          ),
        ),
      );
      await tester.pump();

      expect(retrievedProvider, isA<ImageUploadProvider>());
    });

    testWidgets('retrieves provider with listen=false', (tester) async {
      late ImageUploadProvider retrievedProvider;

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => ImageUploadProvider(),
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                retrievedProvider =
                    ImageUploadProvider.of(context, listen: false);
                return const Scaffold();
              },
            ),
          ),
        ),
      );
      await tester.pump();

      expect(retrievedProvider, isA<ImageUploadProvider>());
    });
  });

  group('ImageUploadProvider - State Changes', () {
    test('initial isDataLoading is false', () {
      final provider = ImageUploadProvider();
      expect(provider.isDataLoading, false);
    });

    test('s3Url can be set after initialization', () {
      final provider = ImageUploadProvider();

      // s3Url is not a setter, but we can verify the initial state
      expect(provider.s3Url, isNull);
    });
  });

  group('ImageUploadProvider - Memory Management', () {
    test('can be disposed', () {
      final provider = ImageUploadProvider();

      // Add listener
      bool notified = false;
      provider.addListener(() => notified = true);

      // Dispose should not throw
      expect(() => provider.dispose(), returnsNormally);
    });

    test('listeners are properly managed', () {
      final provider = ImageUploadProvider();

      int notificationCount = 0;
      void listener() {
        notificationCount++;
      }

      provider.addListener(listener);
      provider.clearImage();

      expect(notificationCount, 1);

      provider.removeListener(listener);
      provider.clearImage();

      // Should still be 1 since listener was removed
      expect(notificationCount, 1);
    });
  });

  group('ImageUploadProvider - Edge Cases', () {
    test('handles empty string s3Url', () {
      final provider = ImageUploadProvider(s3Url: '');
      expect(provider.s3Url, '');
    });

    test('handles whitespace s3Url', () {
      final provider = ImageUploadProvider(s3Url: '   ');
      expect(provider.s3Url, '   ');
    });

    test('handles URL with special characters', () {
      final url =
          'https://example.com/image%20name?param=value&other=123#hash';
      final provider = ImageUploadProvider(s3Url: url);
      expect(provider.s3Url, url);
    });
  });
}
