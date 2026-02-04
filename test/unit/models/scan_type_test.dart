import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_in/types.dart';

/// Tests for ScanType enum.
/// Focus: Testing enum values and properties.
void main() {
  group('ScanType', () {
    group('enum values', () {
      test('should have 2 values', () {
        expect(ScanType.values.length, 2);
      });

      test('should contain STOCK_SCAN', () {
        expect(ScanType.values, contains(ScanType.STOCK_SCAN));
      });

      test('should contain LOCATION_SCAN', () {
        expect(ScanType.values, contains(ScanType.LOCATION_SCAN));
      });
    });

    group('enum index', () {
      test('STOCK_SCAN should have index 0', () {
        expect(ScanType.STOCK_SCAN.index, 0);
      });

      test('LOCATION_SCAN should have index 1', () {
        expect(ScanType.LOCATION_SCAN.index, 1);
      });
    });

    group('enum name', () {
      test('STOCK_SCAN should have name STOCK_SCAN', () {
        expect(ScanType.STOCK_SCAN.name, 'STOCK_SCAN');
      });

      test('LOCATION_SCAN should have name LOCATION_SCAN', () {
        expect(ScanType.LOCATION_SCAN.name, 'LOCATION_SCAN');
      });
    });

    group('enum comparison', () {
      test('STOCK_SCAN should equal itself', () {
        expect(ScanType.STOCK_SCAN, equals(ScanType.STOCK_SCAN));
      });

      test('LOCATION_SCAN should equal itself', () {
        expect(ScanType.LOCATION_SCAN, equals(ScanType.LOCATION_SCAN));
      });

      test('STOCK_SCAN should not equal LOCATION_SCAN', () {
        expect(ScanType.STOCK_SCAN, isNot(equals(ScanType.LOCATION_SCAN)));
      });
    });
  });
}
