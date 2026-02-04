import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/end_testing_session_event.dart';

void main() {
  group('EndTestingSessionEvent', () {
    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange & Act
        final event = EndTestingSessionEvent('DEVICE123', 'A');

        // Assert
        expect(event.barcode, equals('DEVICE123'));
        expect(event.deviceGrade, equals('A'));
      });

      test('should create instance with null barcode', () {
        // Arrange & Act
        final event = EndTestingSessionEvent(null, 'B');

        // Assert
        expect(event.barcode, isNull);
        expect(event.deviceGrade, equals('B'));
      });

      test('should create instance with null device grade', () {
        // Arrange & Act
        final event = EndTestingSessionEvent('DEVICE123', null);

        // Assert
        expect(event.barcode, equals('DEVICE123'));
        expect(event.deviceGrade, isNull);
      });

      test('should create instance with both null', () {
        // Arrange & Act
        final event = EndTestingSessionEvent(null, null);

        // Assert
        expect(event.barcode, isNull);
        expect(event.deviceGrade, isNull);
      });
    });

    group('getSubordinateKey', () {
      test('should return correct subordinate key', () {
        // Arrange
        final event = EndTestingSessionEvent('DEVICE', 'A');

        // Act
        final key = event.getSubordinateKey();

        // Assert
        expect(key, equals(AnalyticEventKeys.manualTesting.endTestingSession));
        expect(key, equals('dmt_end_testing_session'));
      });

      test('should return consistent key regardless of parameters', () {
        // Arrange
        final event1 = EndTestingSessionEvent('D1', 'A');
        final event2 = EndTestingSessionEvent('D2', 'B');
        final event3 = EndTestingSessionEvent(null, null);

        // Act & Assert
        expect(event1.getSubordinateKey(), equals(event2.getSubordinateKey()));
        expect(event2.getSubordinateKey(), equals(event3.getSubordinateKey()));
      });
    });

    group('getEventKey', () {
      test('should return parent event key', () {
        // Arrange
        final event = EndTestingSessionEvent('DEVICE', 'A');

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
        final event = EndTestingSessionEvent('DEVICE123', 'A');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceBarcode], equals('DEVICE123'));
      });

      test('should include device grade in arguments', () async {
        // Arrange
        final event = EndTestingSessionEvent('DEVICE123', 'A');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceGrade], equals('A'));
      });

      test('should handle null barcode in arguments', () async {
        // Arrange
        final event = EndTestingSessionEvent(null, 'A');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceBarcode], isNull);
        expect(arguments?[AnalyticEventParams.deviceGrade], equals('A'));
      });

      test('should handle null device grade in arguments', () async {
        // Arrange
        final event = EndTestingSessionEvent('DEVICE', null);

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceBarcode], equals('DEVICE'));
        expect(arguments?[AnalyticEventParams.deviceGrade], isNull);
      });

      test('should include common event arguments', () async {
        // Arrange
        final event = EndTestingSessionEvent('DEVICE', 'A');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?.containsKey(AnalyticEventParams.hitTimeStamp), isTrue);
      });
    });

    group('device grade variations', () {
      test('should handle various grade values', () async {
        // Arrange
        final grades = ['A', 'B', 'C', 'D', 'F', 'A+', 'B-'];

        for (final grade in grades) {
          // Act
          final event = EndTestingSessionEvent('DEVICE', grade);
          final arguments = await event.getArguments();

          // Assert
          expect(arguments?[AnalyticEventParams.deviceGrade], equals(grade));
        }
      });

      test('should handle empty grade value', () async {
        // Arrange
        final event = EndTestingSessionEvent('DEVICE', '');

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceGrade], equals(''));
      });
    });
  });
}
