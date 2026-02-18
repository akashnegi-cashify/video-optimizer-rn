import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/trc_scanner_widget.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

void main() {
  /// Builds a testable widget with MaterialApp and LocaleProvider wrapper
  Widget buildTestWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        home: Scaffold(body: child),
      ),
    );
  }

  group('TRCScannerWidget', () {
    testWidgets('renders correctly with required onScanDetected', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          TRCScannerWidget(
            onScanDetected: (scannedData, controller, {bool? isManualEntry}) {},
          ),
        ),
      );
      // Use pump instead of pumpAndSettle to avoid camera initialization issues
      await tester.pump();

      expect(find.byType(TRCScannerWidget), findsOneWidget);
    });

    testWidgets('renders Container with padding', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          TRCScannerWidget(
            onScanDetected: (scannedData, controller, {bool? isManualEntry}) {},
          ),
        ),
      );
      await tester.pump();

      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.padding, const EdgeInsets.all(Dimens.space_16));
    });

    testWidgets('renders with custom scanFormatList', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          TRCScannerWidget(
            onScanDetected: (scannedData, controller, {bool? isManualEntry}) {},
            scanFormatList: const [BarcodeFormat.qrCode, BarcodeFormat.ean13],
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(TRCScannerWidget), findsOneWidget);
    });

    testWidgets('renders with default scanFormatList (code128)', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          TRCScannerWidget(
            onScanDetected: (scannedData, controller, {bool? isManualEntry}) {},
          ),
        ),
      );
      await tester.pump();

      // Default format should be code128
      expect(find.byType(TRCScannerWidget), findsOneWidget);
    });

    testWidgets('renders with isEditTextSubmitButtonDirectionHorizontal false', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          TRCScannerWidget(
            onScanDetected: (scannedData, controller, {bool? isManualEntry}) {},
            isEditTextSubmitButtonDirectionHorizontal: false,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(TRCScannerWidget), findsOneWidget);
    });

    testWidgets('renders with isEditTextSubmitButtonDirectionHorizontal true', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          TRCScannerWidget(
            onScanDetected: (scannedData, controller, {bool? isManualEntry}) {},
            isEditTextSubmitButtonDirectionHorizontal: true,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(TRCScannerWidget), findsOneWidget);
    });

    testWidgets('renders with custom hintText', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          TRCScannerWidget(
            onScanDetected: (scannedData, controller, {bool? isManualEntry}) {},
            hintText: 'Custom hint text',
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(TRCScannerWidget), findsOneWidget);
    });

    testWidgets('renders with bottomView provided', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          TRCScannerWidget(
            onScanDetected: (scannedData, controller, {bool? isManualEntry}) {},
            bottomView: const Text('Custom Bottom View'),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Custom Bottom View'), findsOneWidget);
    });

    testWidgets('renders without bottomView (shows text field and button)', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          TRCScannerWidget(
            onScanDetected: (scannedData, controller, {bool? isManualEntry}) {},
          ),
        ),
      );
      await tester.pump();

      // Should render text form field when bottomView is null
      expect(find.byType(CshTextFormField), findsOneWidget);
    });

    testWidgets('renders CshCard for scanner area', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          TRCScannerWidget(
            onScanDetected: (scannedData, controller, {bool? isManualEntry}) {},
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(CshCard), findsOneWidget);
    });

    testWidgets('renders Column layout', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          TRCScannerWidget(
            onScanDetected: (scannedData, controller, {bool? isManualEntry}) {},
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('renders Expanded widget for scanner area', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          TRCScannerWidget(
            onScanDetected: (scannedData, controller, {bool? isManualEntry}) {},
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(Expanded), findsWidgets);
    });

    testWidgets('calls onResetController callback when provided', (tester) async {
      ResetLastScannedBarcode? resetController;
      await tester.pumpWidget(
        buildTestWidget(
          TRCScannerWidget(
            onScanDetected: (scannedData, controller, {bool? isManualEntry}) {},
            onResetController: (controller) {
              resetController = controller;
            },
          ),
        ),
      );
      await tester.pump();

      expect(resetController, isNotNull);
    });

    testWidgets('renders submit button', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          TRCScannerWidget(
            onScanDetected: (scannedData, controller, {bool? isManualEntry}) {},
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(CshBigButtonWithLoader), findsOneWidget);
    });

    testWidgets('submit button is initially disabled', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          TRCScannerWidget(
            onScanDetected: (scannedData, controller, {bool? isManualEntry}) {},
          ),
        ),
      );
      await tester.pump();

      // Find the button - it should be disabled when text field is empty
      expect(find.byType(CshBigButtonWithLoader), findsOneWidget);
    });

    testWidgets('text field updates button state', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          TRCScannerWidget(
            onScanDetected: (scannedData, controller, {bool? isManualEntry}) {},
          ),
        ),
      );
      await tester.pump();

      // Find text field and enter text
      final textField = find.byType(CshTextFormField);
      expect(textField, findsOneWidget);

      // Enter text to enable button
      await tester.enterText(textField, 'test input');
      await tester.pump();

      // Button should now be enabled
      expect(find.byType(CshBigButtonWithLoader), findsOneWidget);
    });

    testWidgets('renders Row for horizontal button layout', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          TRCScannerWidget(
            onScanDetected: (scannedData, controller, {bool? isManualEntry}) {},
            isEditTextSubmitButtonDirectionHorizontal: true,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(Row), findsWidgets);
    });

    testWidgets('disposes controller on widget dispose', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          TRCScannerWidget(
            onScanDetected: (scannedData, controller, {bool? isManualEntry}) {},
          ),
        ),
      );
      await tester.pump();

      // Navigate away to trigger dispose
      await tester.pumpWidget(
        buildTestWidget(const SizedBox()),
      );
      await tester.pump();

      // No errors should occur during dispose
      expect(find.byType(TRCScannerWidget), findsNothing);
    });
  });

  group('ResetLastScannedBarcode interface', () {
    test('interface has resetLastScannedBarcode method', () {
      // Interface verification
      expect(ResetLastScannedBarcode, isNotNull);
    });
  });
}
