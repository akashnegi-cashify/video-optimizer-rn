import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/re_calculate_event.dart';

void main() {
  group('ReCalculateEvent', () {
    group('constructor', () {
      test('should create instance with device barcode', () {
        // Arrange & Act
        final event = ReCalculateEvent('DEVICE123');

        // Assert
        expect(event.deviceBarcode, equals('DEVICE123'));
      });

      test('should require device barcode', () {
        // Arrange & Act
        final event = ReCalculateEvent('BARCODE');

        // Assert
        expect(event.deviceBarcode, isNotEmpty);
      });
    });

    group('getSubordinateKey', () {
      test('should return correct subordinate key', () {
        // Arrange
        final event = ReCalculateEvent('DEVICE123');

        // Act
        final key = event.getSubordinateKey();

        // Assert
        expect(key, equals(AnalyticEventKeys.manualTesting.reCalculate));
        expect(key, equals('dmt_calc_re_calculate'));
      });

      test('should return consistent key regardless of barcode', () {
        // Arrange
        final event1 = ReCalculateEvent('DEVICE1');
        final event2 = ReCalculateEvent('DEVICE2');

        // Act & Assert
        expect(event1.getSubordinateKey(), equals(event2.getSubordinateKey()));
      });
    });

    group('getArguments', () {
      test('should include device barcode in arguments', () async {
        // Arrange
        final event = ReCalculateEvent('DEVICE123');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceBarcode], equals('DEVICE123'));
      });

      test('should include common event arguments', () async {
        // Arrange
        final event = ReCalculateEvent('DEVICE');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?.containsKey(AnalyticEventParams.hitTimeStamp), isTrue);
      });
    });

    group('event key format', () {
      test('subordinate key should contain re_calculate', () {
        // Arrange
        final event = ReCalculateEvent('DEVICE');

        // Act
        final key = event.getSubordinateKey();

        // Assert
        expect(key.contains('re_calculate'), isTrue);
      });
    });
  });
}
