import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/scan_manual_test_barcode_event.dart';

void main() {
  group('ScanManualTestBarcodeEvent', () {
    group('constructor', () {
      test('should create instance with barcode', () {
        // Arrange & Act
        final event = ScanManualTestBarcodeEvent('DEVICE123');

        // Assert
        expect(event.barcode, equals('DEVICE123'));
      });

      test('should require barcode parameter', () {
        // Arrange & Act
        final event = ScanManualTestBarcodeEvent('BARCODE');

        // Assert
        expect(event.barcode, isNotEmpty);
      });
    });

    group('getSubordinateKey', () {
      test('should return correct subordinate key', () {
        // Arrange
        final event = ScanManualTestBarcodeEvent('DEVICE123');

        // Act
        final key = event.getSubordinateKey();

        // Assert
        expect(key, equals(AnalyticEventKeys.manualTesting.scanManualTestBarcode));
        expect(key, equals('dmt_scan_manual_test_barcode'));
      });

      test('should return consistent key regardless of barcode', () {
        // Arrange
        final event1 = ScanManualTestBarcodeEvent('DEVICE1');
        final event2 = ScanManualTestBarcodeEvent('DEVICE2');

        // Act & Assert
        expect(event1.getSubordinateKey(), equals(event2.getSubordinateKey()));
      });
    });

    group('getEventKey', () {
      test('should return parent event key', () {
        // Arrange
        final event = ScanManualTestBarcodeEvent('DEVICE123');

        // Act
        final key = event.getEventKey();

        // Assert
        expect(key, equals(AnalyticEventKeys.manualTesting.parentEventKey));
        expect(key, equals('dmt_manual_testing'));
      });
    });

    group('getArguments', () {
      test('should include device barcode in arguments', () async {
        // Arrange
        final event = ScanManualTestBarcodeEvent('DEVICE123');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceBarcode], equals('DEVICE123'));
      });

      test('should include common event arguments', () async {
        // Arrange
        final event = ScanManualTestBarcodeEvent('DEVICE');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?.containsKey(AnalyticEventParams.hitTimeStamp), isTrue);
      });
    });

    group('barcode variations', () {
      test('should handle alphanumeric barcodes', () async {
        // Arrange
        final event = ScanManualTestBarcodeEvent('ABC123XYZ789');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceBarcode], equals('ABC123XYZ789'));
      });

      test('should handle numeric barcodes', () async {
        // Arrange
        final event = ScanManualTestBarcodeEvent('1234567890');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceBarcode], equals('1234567890'));
      });

      test('should handle barcodes with special characters', () async {
        // Arrange
        final event = ScanManualTestBarcodeEvent('DEV-123_456');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceBarcode], equals('DEV-123_456'));
      });
    });
  });
}
