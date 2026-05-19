import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/color_view_event.dart';

void main() {
  group('ColorViewEvent', () {
    group('constructor', () {
      test('should create instance with barcode', () {
        // Arrange & Act
        final event = ColorViewEvent('DEVICE123');

        // Assert
        expect(event.barcode, equals('DEVICE123'));
      });

      test('should create instance with null barcode', () {
        // Arrange & Act
        final event = ColorViewEvent(null);

        // Assert
        expect(event.barcode, isNull);
      });
    });

    group('getSubordinateKey', () {
      test('should return correct subordinate key', () {
        // Arrange
        final event = ColorViewEvent('DEVICE123');

        // Act
        final key = event.getSubordinateKey();

        // Assert
        expect(key, equals(AnalyticEventKeys.manualTesting.colorView));
        expect(key, equals('dmt_color_view'));
      });

      test('should return consistent key regardless of barcode', () {
        // Arrange
        final event1 = ColorViewEvent('DEVICE1');
        final event2 = ColorViewEvent('DEVICE2');
        final event3 = ColorViewEvent(null);

        // Act & Assert
        expect(event1.getSubordinateKey(), equals(event2.getSubordinateKey()));
        expect(event2.getSubordinateKey(), equals(event3.getSubordinateKey()));
      });
    });

    group('getEventKey', () {
      test('should return parent event key', () {
        // Arrange
        final event = ColorViewEvent('DEVICE123');

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
        final event = ColorViewEvent('DEVICE123');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceBarcode], equals('DEVICE123'));
      });

      test('should handle null barcode in arguments', () async {
        // Arrange
        final event = ColorViewEvent(null);

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceBarcode], isNull);
      });

      test('should include common event arguments', () async {
        // Arrange
        final event = ColorViewEvent('DEVICE');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?.containsKey(AnalyticEventParams.hitTimeStamp), isTrue);
      });
    });
  });
}
