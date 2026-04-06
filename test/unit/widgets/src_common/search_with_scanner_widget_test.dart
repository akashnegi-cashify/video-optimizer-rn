import 'dart:async';
import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/search_with_scanner_widget.dart';

void main() {
  /// Builds a testable widget with MaterialApp wrapper
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
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
    );
  }

  group('SearchWithScannerWidget', () {
    testWidgets('renders correctly with required parameters', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchWithScannerWidget(
            'Search hint',
            onQuery: (barcode, isManualSearch) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SearchWithScannerWidget), findsOneWidget);
    });

    testWidgets('renders CshTextFormField', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchWithScannerWidget(
            'Enter barcode',
            onQuery: (barcode, isManualSearch) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CshTextFormField), findsOneWidget);
    });

    testWidgets('displays hint text', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchWithScannerWidget(
            'Custom hint text',
            onQuery: (barcode, isManualSearch) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Hint text should be passed to CshTextFormField
      expect(find.byType(SearchWithScannerWidget), findsOneWidget);
    });

    testWidgets('renders with initial value', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchWithScannerWidget(
            'Search',
            initialValue: 'Initial text',
            onQuery: (barcode, isManualSearch) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Text field should contain initial value
      expect(find.text('Initial text'), findsOneWidget);
    });

    testWidgets('renders scanner icon as suffix', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchWithScannerWidget(
            'Search',
            onQuery: (barcode, isManualSearch) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find the QR code icon
      expect(find.byIcon(Icons.qr_code_2), findsOneWidget);
    });

    testWidgets('scanner icon is wrapped in InkWell', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchWithScannerWidget(
            'Search',
            onQuery: (barcode, isManualSearch) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('calls onQuery with isManualSearch true on text change', (tester) async {
      String? receivedBarcode;
      bool? wasManualSearch;

      await tester.pumpWidget(
        buildTestWidget(
          SearchWithScannerWidget(
            'Search',
            onQuery: (barcode, isManualSearch) {
              receivedBarcode = barcode;
              wasManualSearch = isManualSearch;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter text
      await tester.enterText(find.byType(TextField), 'test search');
      
      // Wait for debounce timer (500ms)
      await tester.pump(const Duration(milliseconds: 600));

      expect(receivedBarcode, 'test search');
      expect(wasManualSearch, isTrue);
    });

    testWidgets('debounces text input', (tester) async {
      int callCount = 0;

      await tester.pumpWidget(
        buildTestWidget(
          SearchWithScannerWidget(
            'Search',
            onQuery: (barcode, isManualSearch) {
              callCount++;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter text multiple times quickly
      await tester.enterText(find.byType(TextField), 'a');
      await tester.pump(const Duration(milliseconds: 100));
      await tester.enterText(find.byType(TextField), 'ab');
      await tester.pump(const Duration(milliseconds: 100));
      await tester.enterText(find.byType(TextField), 'abc');
      
      // Wait for debounce
      await tester.pump(const Duration(milliseconds: 600));

      // Should only have been called once due to debounce
      expect(callCount, 1);
    });

    testWidgets('renders without initial value', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchWithScannerWidget(
            'Search',
            onQuery: (barcode, isManualSearch) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SearchWithScannerWidget), findsOneWidget);
    });

    testWidgets('text controller initialized with initialValue', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchWithScannerWidget(
            'Search',
            initialValue: 'preset value',
            onQuery: (barcode, isManualSearch) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('preset value'), findsOneWidget);
    });

    testWidgets('cancels timer when new input received', (tester) async {
      final results = <String>[];

      await tester.pumpWidget(
        buildTestWidget(
          SearchWithScannerWidget(
            'Search',
            onQuery: (barcode, isManualSearch) {
              results.add(barcode);
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter text and immediately replace
      await tester.enterText(find.byType(TextField), 'first');
      await tester.pump(const Duration(milliseconds: 200));
      await tester.enterText(find.byType(TextField), 'second');
      
      // Wait for debounce
      await tester.pump(const Duration(milliseconds: 600));

      // Only the second value should be received
      expect(results.length, 1);
      expect(results.first, 'second');
    });

    testWidgets('empty text triggers onQuery', (tester) async {
      String? receivedBarcode;

      await tester.pumpWidget(
        buildTestWidget(
          SearchWithScannerWidget(
            'Search',
            initialValue: 'initial',
            onQuery: (barcode, isManualSearch) {
              receivedBarcode = barcode;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Clear the text
      await tester.enterText(find.byType(TextField), '');
      await tester.pump(const Duration(milliseconds: 600));

      expect(receivedBarcode, '');
    });
  });
}
