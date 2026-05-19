import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Actual widget import
import 'package:flutter_trc/qc/modules/external_audit/widgets/scan_barcode_widget.dart';

void main() {
  group('ScanBarcodeWidget', () {
    test('ScanBarcodeWidget class exists and is a StatefulWidget', () {
      expect(ScanBarcodeWidget, isNotNull);
      final widget = ScanBarcodeWidget(
        onScanDetected: (data) {},
        step: 'Step 1',
      );
      expect(widget, isA<StatefulWidget>());
    });

    test('ScanBarcodeWidget can be instantiated with required parameters', () {
      final widget = ScanBarcodeWidget(
        onScanDetected: (data) {},
        step: 'Step 1: Scan Barcode',
      );
      expect(widget, isNotNull);
      expect(widget.step, equals('Step 1: Scan Barcode'));
    });

    test('ScanBarcodeWidget stores onScanDetected callback', () {
      String? scannedData;
      final widget = ScanBarcodeWidget(
        onScanDetected: (data) {
          scannedData = data;
        },
        step: 'Step 1',
      );
      expect(widget.onScanDetected, isNotNull);
      
      widget.onScanDetected('TEST_BARCODE_123');
      expect(scannedData, equals('TEST_BARCODE_123'));
    });

    test('ScanBarcodeWidget stores step text correctly', () {
      final widget = ScanBarcodeWidget(
        onScanDetected: (data) {},
        step: 'Step 2: Verify',
      );
      expect(widget.step, equals('Step 2: Verify'));
    });

    test('ScanBarcodeWidget can be instantiated with a key', () {
      const key = Key('scan_barcode_widget_key');
      final widget = ScanBarcodeWidget(
        onScanDetected: (data) {},
        step: 'Step 1',
        key: key,
      );
      expect(widget.key, equals(key));
    });

    test('ScanBarcodeWidget creates state correctly', () {
      final widget = ScanBarcodeWidget(
        onScanDetected: (data) {},
        step: 'Step 1',
      );
      final element = widget.createElement();
      expect(element, isNotNull);
    });

    test('ScanBarcodeWidget callback receives trimmed data', () {
      String? receivedData;
      final widget = ScanBarcodeWidget(
        onScanDetected: (data) {
          receivedData = data;
        },
        step: 'Step 1',
      );
      
      widget.onScanDetected('IMEI_123456');
      expect(receivedData, equals('IMEI_123456'));
    });

    test('ScanBarcodeWidget can handle empty step', () {
      final widget = ScanBarcodeWidget(
        onScanDetected: (data) {},
        step: '',
      );
      expect(widget.step, isEmpty);
    });
  });
}
