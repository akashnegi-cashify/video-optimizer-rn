import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/select_brand_event.dart';

void main() {
  group('SelectBrandEvent', () {
    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange & Act
        final event = SelectBrandEvent('DEVICE123', 'BRAND001');

        // Assert
        expect(event.barcode, equals('DEVICE123'));
        expect(event.brandId, equals('BRAND001'));
      });

      test('should create instance with null brand id', () {
        // Arrange & Act
        final event = SelectBrandEvent('DEVICE123', null);

        // Assert
        expect(event.barcode, equals('DEVICE123'));
        expect(event.brandId, isNull);
      });

      test('should require barcode parameter', () {
        // Arrange & Act
        final event = SelectBrandEvent('BARCODE', 'BRAND');

        // Assert
        expect(event.barcode, isNotEmpty);
      });
    });

    group('getSubordinateKey', () {
      test('should return correct subordinate key', () {
        // Arrange
        final event = SelectBrandEvent('DEVICE', 'BRAND');

        // Act
        final key = event.getSubordinateKey();

        // Assert
        expect(key, equals(AnalyticEventKeys.manualTesting.selectBrand));
        expect(key, equals('dmt_select_brand'));
      });

      test('should return consistent key regardless of parameters', () {
        // Arrange
        final event1 = SelectBrandEvent('DEVICE1', 'BRAND1');
        final event2 = SelectBrandEvent('DEVICE2', 'BRAND2');
        final event3 = SelectBrandEvent('DEVICE3', null);

        // Act & Assert
        expect(event1.getSubordinateKey(), equals(event2.getSubordinateKey()));
        expect(event2.getSubordinateKey(), equals(event3.getSubordinateKey()));
      });
    });

    group('getEventKey', () {
      test('should return parent event key', () {
        // Arrange
        final event = SelectBrandEvent('DEVICE', 'BRAND');

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
        final event = SelectBrandEvent('DEVICE123', 'BRAND001');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceBarcode], equals('DEVICE123'));
      });

      test('should include brand id in arguments', () async {
        // Arrange
        final event = SelectBrandEvent('DEVICE123', 'BRAND001');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.brandId], equals('BRAND001'));
      });

      test('should handle null brand id in arguments', () async {
        // Arrange
        final event = SelectBrandEvent('DEVICE123', null);

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceBarcode], equals('DEVICE123'));
        expect(arguments?[AnalyticEventParams.brandId], isNull);
      });

      test('should include common event arguments', () async {
        // Arrange
        final event = SelectBrandEvent('DEVICE', 'BRAND');

        // Act
        final arguments = await event.getArguments();

        // Assert - Common arguments from CommonEvents
        expect(arguments?.containsKey(AnalyticEventParams.hitTimeStamp), isTrue);
      });
    });

    group('brand id variations', () {
      test('should handle numeric brand id', () async {
        // Arrange
        final event = SelectBrandEvent('DEVICE', '12345');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.brandId], equals('12345'));
      });

      test('should handle UUID-like brand id', () async {
        // Arrange
        final event = SelectBrandEvent('DEVICE', 'a1b2c3d4-e5f6-7890');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.brandId], equals('a1b2c3d4-e5f6-7890'));
      });

      test('should handle empty brand id', () async {
        // Arrange
        final event = SelectBrandEvent('DEVICE', '');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.brandId], equals(''));
      });
    });
  });
}
