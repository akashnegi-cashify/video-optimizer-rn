import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/start_manual_testing_event.dart';

void main() {
  group('StartManualTestingEvent', () {
    group('constructor', () {
      test('should create instance without parameters', () {
        // Arrange & Act
        final event = StartManualTestingEvent();

        // Assert
        expect(event, isNotNull);
        expect(event, isA<StartManualTestingEvent>());
      });
    });

    group('getSubordinateKey', () {
      test('should return correct subordinate key', () {
        // Arrange
        final event = StartManualTestingEvent();

        // Act
        final key = event.getSubordinateKey();

        // Assert
        expect(key, equals(AnalyticEventKeys.manualTesting.startManualTesting));
        expect(key, equals('dmt_start_manual_testing'));
      });

      test('should return consistent key', () {
        // Arrange
        final event1 = StartManualTestingEvent();
        final event2 = StartManualTestingEvent();

        // Act & Assert
        expect(event1.getSubordinateKey(), equals(event2.getSubordinateKey()));
      });
    });

    group('getEventKey', () {
      test('should return parent event key', () {
        // Arrange
        final event = StartManualTestingEvent();

        // Act
        final key = event.getEventKey();

        // Assert
        expect(key, equals(AnalyticEventKeys.manualTesting.parentEventKey));
        expect(key, equals('dmt_manual_testing'));
      });
    });

    group('inheritance from CommonEvents', () {
      test('should include common event arguments', () async {
        // Arrange
        final event = StartManualTestingEvent();

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?.containsKey(AnalyticEventParams.hitTimeStamp), isTrue);
      });

      test('should have getTrackers method', () {
        // Arrange
        final event = StartManualTestingEvent();

        // Assert
        expect(event.getTrackers, isNotNull);
      });

      test('getTrackers should return non-empty list', () {
        // Arrange
        final event = StartManualTestingEvent();

        // Act
        final trackers = event.getTrackers();

        // Assert
        expect(trackers, isNotEmpty);
      });
    });

    group('event key format', () {
      test('subordinate key should start with dmt_', () {
        // Arrange
        final event = StartManualTestingEvent();

        // Act
        final key = event.getSubordinateKey();

        // Assert
        expect(key.startsWith('dmt_'), isTrue);
      });

      test('event key should start with dmt_', () {
        // Arrange
        final event = StartManualTestingEvent();

        // Act
        final key = event.getEventKey();

        // Assert
        expect(key.startsWith('dmt_'), isTrue);
      });
    });
  });
}
