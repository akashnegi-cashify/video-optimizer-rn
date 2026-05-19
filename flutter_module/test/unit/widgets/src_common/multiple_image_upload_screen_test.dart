import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:core_widgets/src/theme/theme_change.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/multiple_image_upload_screen.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:provider/provider.dart';

void main() {
  /// Builds a testable widget with MaterialApp and LocaleProvider wrapper
  Widget buildTestWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
        ChangeNotifierProvider<ThemeChangeProvider>(create: (_) => ThemeChangeProvider(false)),
      ],
      child: MaterialApp(
        theme: ThemeData(
          extensions: [
            CustomColors(
              successColor: Colors.green,
              warnColor: Colors.orange,
              inputStrokeColor: Colors.grey,
              searchShadow: Colors.grey.withAlpha(50),
              shadows: {
                10: const BoxShadow(color: Colors.black12, blurRadius: 10),
                15: const BoxShadow(color: Colors.black12, blurRadius: 15),
                20: const BoxShadow(color: Colors.black12, blurRadius: 20),
              },
            ),
          ],
        ),
        home: child,
      ),
    );
  }

  group('MultipleImageUploadScreen', () {
    testWidgets('renders correctly with required parameters', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const MultipleImageUploadScreen(
            DeviceMediaType.markOk,
            'test-barcode',
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MultipleImageUploadScreen), findsOneWidget);

      // Flush pending timers from widget initialization
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 1));
    });

    testWidgets('renders Scaffold', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const MultipleImageUploadScreen(
            DeviceMediaType.markOk,
            'test-barcode',
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('renders GridView', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const MultipleImageUploadScreen(
            DeviceMediaType.markOk,
            'test-barcode',
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('renders with DeviceMediaType.markOk', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const MultipleImageUploadScreen(
            DeviceMediaType.markOk,
            'barcode123',
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MultipleImageUploadScreen), findsOneWidget);
    });

    testWidgets('renders with DeviceMediaType.markToTl', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const MultipleImageUploadScreen(
            DeviceMediaType.markToTl,
            'barcode123',
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MultipleImageUploadScreen), findsOneWidget);
    });

    testWidgets('renders with DeviceMediaType.screwSealImages', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const MultipleImageUploadScreen(
            DeviceMediaType.screwSealImages,
            'barcode123',
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MultipleImageUploadScreen), findsOneWidget);
    });

    testWidgets('renders with DeviceMediaType.markFail', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const MultipleImageUploadScreen(
            DeviceMediaType.markFail,
            'barcode123',
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MultipleImageUploadScreen), findsOneWidget);
    });

    testWidgets('renders with DeviceMediaType.glassChange', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const MultipleImageUploadScreen(
            DeviceMediaType.glassChange,
            'barcode123',
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MultipleImageUploadScreen), findsOneWidget);
    });

    testWidgets('renders with callStatusUpdateApi callback', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          MultipleImageUploadScreen(
            DeviceMediaType.markOk,
            'barcode123',
            callStatusUpdateApi: () async {},
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MultipleImageUploadScreen), findsOneWidget);
    });

    testWidgets('renders with onMediaUploaded callback', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          MultipleImageUploadScreen(
            DeviceMediaType.markOk,
            'barcode123',
            onMediaUploaded: () {},
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MultipleImageUploadScreen), findsOneWidget);
    });

    testWidgets('renders with isImageMarkingRequired false', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const MultipleImageUploadScreen(
            DeviceMediaType.markOk,
            'barcode123',
            isImageMarkingRequired: false,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MultipleImageUploadScreen), findsOneWidget);
    });

    testWidgets('renders with isImageMarkingRequired true', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const MultipleImageUploadScreen(
            DeviceMediaType.markOk,
            'barcode123',
            isImageMarkingRequired: true,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MultipleImageUploadScreen), findsOneWidget);
    });

    testWidgets('renders Column layout', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const MultipleImageUploadScreen(
            DeviceMediaType.markOk,
            'barcode123',
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('renders Expanded widget', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const MultipleImageUploadScreen(
            DeviceMediaType.markOk,
            'barcode123',
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(Expanded), findsOneWidget);
    });

    testWidgets('renders CshBigButton for submit', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const MultipleImageUploadScreen(
            DeviceMediaType.markOk,
            'barcode123',
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(CshBigButton), findsOneWidget);
    });

    testWidgets('submit button shows "Submit" text', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const MultipleImageUploadScreen(
            DeviceMediaType.markOk,
            'barcode123',
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Submit'), findsOneWidget);
    });

    test('has correct route constant', () {
      expect(MultipleImageUploadScreen.route, '/multiple_image_upload_screen');
    });
  });

  group('DeviceMediaType enum', () {
    test('markOk has value 1', () {
      expect(DeviceMediaType.markOk.val, 1);
    });

    test('markToTl has value 2', () {
      expect(DeviceMediaType.markToTl.val, 2);
    });

    test('screwSealImages has value 3', () {
      expect(DeviceMediaType.screwSealImages.val, 3);
    });

    test('markFail has value 5', () {
      expect(DeviceMediaType.markFail.val, 5);
    });

    test('glassChange has value 6', () {
      expect(DeviceMediaType.glassChange.val, 6);
    });

    test('has 5 values', () {
      expect(DeviceMediaType.values.length, 5);
    });
  });
}
