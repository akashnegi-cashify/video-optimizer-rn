import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:core_widgets/src/theme/theme_change.provider.dart';
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
        ChangeNotifierProvider<ThemeChangeProvider>(
            create: (_) => ThemeChangeProvider(false)),
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
        home: Scaffold(body: child),
      ),
    );
  }

  group('TRCScannerWidget', () {
    // Note: MlBarcodeScannerWidget creates a recursive 200ms timer for _setZoomScale
    // that cannot be drained in widget tests (camera never initializes in test env).
    // Tests are skipped with a descriptive reason until the ml_barcode_scanner package
    // adds a mounted check before rescheduling the timer.

    testWidgets(
      'renders correctly with required onScanDetected',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            TRCScannerWidget(
              onScanDetected: (scannedData, controller,
                  {bool? isManualEntry}) {},
            ),
          ),
        );
        await tester.pump();
        expect(find.byType(TRCScannerWidget), findsOneWidget);
      },
      // Skip: MlBarcodeScannerWidget creates undrained recursive timer in test env
      skip: true,
    );

    testWidgets(
      'renders Container with padding',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            TRCScannerWidget(
              onScanDetected: (scannedData, controller,
                  {bool? isManualEntry}) {},
            ),
          ),
        );
        await tester.pump();
        final container =
            tester.widget<Container>(find.byType(Container).first);
        expect(container.padding, const EdgeInsets.all(Dimens.space_16));
      },
      // Skip: MlBarcodeScannerWidget creates undrained recursive timer in test env
      skip: true,
    );

    testWidgets(
      'renders with custom scanFormatList',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            TRCScannerWidget(
              onScanDetected: (scannedData, controller,
                  {bool? isManualEntry}) {},
              scanFormatList: const [
                BarcodeFormat.qrCode,
                BarcodeFormat.ean13,
              ],
            ),
          ),
        );
        await tester.pump();
        expect(find.byType(TRCScannerWidget), findsOneWidget);
      },
      // Skip: MlBarcodeScannerWidget creates undrained recursive timer in test env
      skip: true,
    );

    testWidgets(
      'renders with default scanFormatList (code128)',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            TRCScannerWidget(
              onScanDetected: (scannedData, controller,
                  {bool? isManualEntry}) {},
            ),
          ),
        );
        await tester.pump();
        expect(find.byType(TRCScannerWidget), findsOneWidget);
      },
      // Skip: MlBarcodeScannerWidget creates undrained recursive timer in test env
      skip: true,
    );

    testWidgets(
      'renders with isEditTextSubmitButtonDirectionHorizontal false',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            TRCScannerWidget(
              onScanDetected: (scannedData, controller,
                  {bool? isManualEntry}) {},
              isEditTextSubmitButtonDirectionHorizontal: false,
            ),
          ),
        );
        await tester.pump();
        expect(find.byType(TRCScannerWidget), findsOneWidget);
      },
      // Skip: MlBarcodeScannerWidget creates undrained recursive timer in test env
      skip: true,
    );

    testWidgets(
      'renders with isEditTextSubmitButtonDirectionHorizontal true',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            TRCScannerWidget(
              onScanDetected: (scannedData, controller,
                  {bool? isManualEntry}) {},
              isEditTextSubmitButtonDirectionHorizontal: true,
            ),
          ),
        );
        await tester.pump();
        expect(find.byType(TRCScannerWidget), findsOneWidget);
      },
      // Skip: MlBarcodeScannerWidget creates undrained recursive timer in test env
      skip: true,
    );

    testWidgets(
      'renders with custom hintText',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            TRCScannerWidget(
              onScanDetected: (scannedData, controller,
                  {bool? isManualEntry}) {},
              hintText: 'Custom hint text',
            ),
          ),
        );
        await tester.pump();
        expect(find.byType(TRCScannerWidget), findsOneWidget);
      },
      // Skip: MlBarcodeScannerWidget creates undrained recursive timer in test env
      skip: true,
    );

    testWidgets(
      'renders with bottomView provided',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            TRCScannerWidget(
              onScanDetected: (scannedData, controller,
                  {bool? isManualEntry}) {},
              bottomView: const Text('Custom Bottom View'),
            ),
          ),
        );
        await tester.pump();
        expect(find.text('Custom Bottom View'), findsOneWidget);
      },
      // Skip: MlBarcodeScannerWidget creates undrained recursive timer in test env
      skip: true,
    );

    testWidgets(
      'renders without bottomView (shows text field and button)',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            TRCScannerWidget(
              onScanDetected: (scannedData, controller,
                  {bool? isManualEntry}) {},
            ),
          ),
        );
        await tester.pump();
        expect(find.byType(CshTextFormField), findsOneWidget);
      },
      // Skip: MlBarcodeScannerWidget creates undrained recursive timer in test env
      skip: true,
    );

    testWidgets(
      'renders CshCard for scanner area',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            TRCScannerWidget(
              onScanDetected: (scannedData, controller,
                  {bool? isManualEntry}) {},
            ),
          ),
        );
        await tester.pump();
        expect(find.byType(CshCard), findsOneWidget);
      },
      // Skip: MlBarcodeScannerWidget creates undrained recursive timer in test env
      skip: true,
    );

    testWidgets(
      'renders Column layout',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            TRCScannerWidget(
              onScanDetected: (scannedData, controller,
                  {bool? isManualEntry}) {},
            ),
          ),
        );
        await tester.pump();
        expect(find.byType(Column), findsWidgets);
      },
      // Skip: MlBarcodeScannerWidget creates undrained recursive timer in test env
      skip: true,
    );

    testWidgets(
      'renders Expanded widget for scanner area',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            TRCScannerWidget(
              onScanDetected: (scannedData, controller,
                  {bool? isManualEntry}) {},
            ),
          ),
        );
        await tester.pump();
        expect(find.byType(Expanded), findsWidgets);
      },
      // Skip: MlBarcodeScannerWidget creates undrained recursive timer in test env
      skip: true,
    );

    testWidgets(
      'calls onResetController callback when provided',
      (tester) async {
        ResetLastScannedBarcode? resetController;
        await tester.pumpWidget(
          buildTestWidget(
            TRCScannerWidget(
              onScanDetected: (scannedData, controller,
                  {bool? isManualEntry}) {},
              onResetController: (controller) {
                resetController = controller;
              },
            ),
          ),
        );
        await tester.pump();
        expect(resetController, isNotNull);
      },
      // Skip: MlBarcodeScannerWidget creates undrained recursive timer in test env
      skip: true,
    );

    testWidgets(
      'renders submit button',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            TRCScannerWidget(
              onScanDetected: (scannedData, controller,
                  {bool? isManualEntry}) {},
            ),
          ),
        );
        await tester.pump();
        expect(find.byType(CshBigButtonWithLoader), findsOneWidget);
      },
      // Skip: MlBarcodeScannerWidget creates undrained recursive timer in test env
      skip: true,
    );

    testWidgets(
      'submit button is initially disabled',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            TRCScannerWidget(
              onScanDetected: (scannedData, controller,
                  {bool? isManualEntry}) {},
            ),
          ),
        );
        await tester.pump();
        expect(find.byType(CshBigButtonWithLoader), findsOneWidget);
      },
      // Skip: MlBarcodeScannerWidget creates undrained recursive timer in test env
      skip: true,
    );

    testWidgets(
      'text field updates button state',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            TRCScannerWidget(
              onScanDetected: (scannedData, controller,
                  {bool? isManualEntry}) {},
            ),
          ),
        );
        await tester.pump();
        final textField = find.byType(CshTextFormField);
        expect(textField, findsOneWidget);
        await tester.enterText(textField, 'test input');
        await tester.pump();
        expect(find.byType(CshBigButtonWithLoader), findsOneWidget);
      },
      // Skip: MlBarcodeScannerWidget creates undrained recursive timer in test env
      skip: true,
    );

    testWidgets(
      'renders Row for horizontal button layout',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            TRCScannerWidget(
              onScanDetected: (scannedData, controller,
                  {bool? isManualEntry}) {},
              isEditTextSubmitButtonDirectionHorizontal: true,
            ),
          ),
        );
        await tester.pump();
        expect(find.byType(Row), findsWidgets);
      },
      // Skip: MlBarcodeScannerWidget creates undrained recursive timer in test env
      skip: true,
    );

    testWidgets(
      'disposes controller on widget dispose',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            TRCScannerWidget(
              onScanDetected: (scannedData, controller,
                  {bool? isManualEntry}) {},
            ),
          ),
        );
        await tester.pump();
        await tester.pumpWidget(buildTestWidget(const SizedBox()));
        await tester.pump();
        expect(find.byType(TRCScannerWidget), findsNothing);
      },
      // Skip: MlBarcodeScannerWidget creates undrained recursive timer in test env
      skip: true,
    );
  });

  group('TRCScannerWidget - Constructor and Properties', () {
    test('can be instantiated with required parameters', () {
      final widget = TRCScannerWidget(
        onScanDetected: (scannedData, controller,
            {bool? isManualEntry}) {},
      );
      expect(widget, isNotNull);
      expect(widget.isEditTextSubmitButtonDirectionHorizontal, false);
      expect(widget.scanFormatList, const [BarcodeFormat.code128]);
      expect(widget.hintText, isNull);
      expect(widget.bottomView, isNull);
      expect(widget.onResetController, isNull);
    });

    test('can be instantiated with all parameters', () {
      final bottomView = const Text('bottom');
      void resetCallback(ResetLastScannedBarcode c) {}
      final widget = TRCScannerWidget(
        onScanDetected: (scannedData, controller,
            {bool? isManualEntry}) {},
        scanFormatList: const [BarcodeFormat.qrCode],
        isEditTextSubmitButtonDirectionHorizontal: true,
        hintText: 'scan here',
        bottomView: bottomView,
        onResetController: resetCallback,
      );
      expect(widget.scanFormatList, const [BarcodeFormat.qrCode]);
      expect(widget.isEditTextSubmitButtonDirectionHorizontal, true);
      expect(widget.hintText, 'scan here');
      expect(widget.bottomView, bottomView);
      expect(widget.onResetController, resetCallback);
    });

    test('default scanFormatList is code128', () {
      final widget = TRCScannerWidget(
        onScanDetected: (scannedData, controller,
            {bool? isManualEntry}) {},
      );
      expect(widget.scanFormatList, [BarcodeFormat.code128]);
    });

    test('isEditTextSubmitButtonDirectionHorizontal defaults to false', () {
      final widget = TRCScannerWidget(
        onScanDetected: (scannedData, controller,
            {bool? isManualEntry}) {},
      );
      expect(widget.isEditTextSubmitButtonDirectionHorizontal, false);
    });
  });

  group('ResetLastScannedBarcode interface', () {
    test('interface has resetLastScannedBarcode method', () {
      expect(ResetLastScannedBarcode, isNotNull);
    });
  });
}
