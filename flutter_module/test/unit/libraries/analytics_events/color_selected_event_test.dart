import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/color_selected_event.dart';

void main() {
  group('ColorSelectedEvent', () {
    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange & Act
        final event = ColorSelectedEvent('DEVICE123', 'Red');

        // Assert
        expect(event.barcode, equals('DEVICE123'));
        expect(event.selectedColor, equals('Red'));
      });

      test('should create instance with null barcode', () {
        // Arrange & Act
        final event = ColorSelectedEvent(null, 'Blue');

        // Assert
        expect(event.barcode, isNull);
        expect(event.selectedColor, equals('Blue'));
      });

      test('should create instance with null color', () {
        // Arrange & Act
        final event = ColorSelectedEvent('DEVICE123', null);

        // Assert
        expect(event.barcode, equals('DEVICE123'));
        expect(event.selectedColor, isNull);
      });

      test('should create instance with both null', () {
        // Arrange & Act
        final event = ColorSelectedEvent(null, null);

        // Assert
        expect(event.barcode, isNull);
        expect(event.selectedColor, isNull);
      });
    });

    group('getSubordinateKey', () {
      test('should return correct subordinate key', () {
        // Arrange
        final event = ColorSelectedEvent('DEVICE123', 'Red');

        // Act
        final key = event.getSubordinateKey();

        // Assert
        expect(key, equals(AnalyticEventKeys.manualTesting.colorSelected));
        expect(key, equals('dmt_color_selected'));
      });

      test('should return consistent key regardless of parameters', () {
        // Arrange
        final event1 = ColorSelectedEvent('DEVICE1', 'Red');
        final event2 = ColorSelectedEvent('DEVICE2', 'Blue');
        final event3 = ColorSelectedEvent(null, null);

        // Act & Assert
        expect(event1.getSubordinateKey(), equals(event2.getSubordinateKey()));
        expect(event2.getSubordinateKey(), equals(event3.getSubordinateKey()));
      });
    });

    group('getEventKey', () {
      test('should return parent event key', () {
        // Arrange
        final event = ColorSelectedEvent('DEVICE123', 'Red');

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
        final event = ColorSelectedEvent('DEVICE123', 'Red');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceBarcode], equals('DEVICE123'));
      });

      test('should include selected color in arguments', () async {
        // Arrange
        final event = ColorSelectedEvent('DEVICE123', 'Red');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.selectedColor], equals('Red'));
      });

      test('should handle null barcode in arguments', () async {
        // Arrange
        final event = ColorSelectedEvent(null, 'Red');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceBarcode], isNull);
        expect(arguments?[AnalyticEventParams.selectedColor], equals('Red'));
      });

      test('should handle null color in arguments', () async {
        // Arrange
        final event = ColorSelectedEvent('DEVICE123', null);

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceBarcode], equals('DEVICE123'));
        expect(arguments?[AnalyticEventParams.selectedColor], isNull);
      });

      test('should include common event arguments', () async {
        // Arrange
        final event = ColorSelectedEvent('DEVICE', 'Color');

        // Act
        final arguments = await event.getArguments();

        // Assert - Common arguments from CommonEvents
        expect(arguments?.containsKey(AnalyticEventParams.hitTimeStamp), isTrue);
      });
    });

    group('color variations', () {
      test('should handle various color names', () async {
        // Arrange
        final colors = ['Red', 'Blue', 'Green', 'Black', 'White', 'Space Gray', 'Rose Gold'];

        for (final color in colors) {
          // Act
          final event = ColorSelectedEvent('DEVICE', color);
          final arguments = await event.getArguments();

          // Assert
          expect(arguments?[AnalyticEventParams.selectedColor], equals(color));
        }
      });

      test('should handle color with special characters', () async {
        // Arrange
        final event = ColorSelectedEvent('DEVICE', 'Midnight Blue-128GB');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.selectedColor], equals('Midnight Blue-128GB'));
      });
    });
  });
}
