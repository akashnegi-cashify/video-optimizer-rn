import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/qc_login_event.dart';

void main() {
  group('QcLoginEvent', () {
    group('constructor', () {
      test('should create instance without parameters', () {
        // Arrange & Act
        final event = QcLoginEvent();

        // Assert
        expect(event, isNotNull);
        expect(event, isA<QcLoginEvent>());
      });
    });

    group('getSubordinateKey', () {
      test('should return correct subordinate key', () {
        // Arrange
        final event = QcLoginEvent();

        // Act
        final key = event.getSubordinateKey();

        // Assert
        expect(key, equals(AnalyticEventKeys.common.qcLogin));
        expect(key, equals('qc_login'));
      });

      test('should return consistent key', () {
        // Arrange
        final event1 = QcLoginEvent();
        final event2 = QcLoginEvent();

        // Act & Assert
        expect(event1.getSubordinateKey(), equals(event2.getSubordinateKey()));
      });
    });

    group('getEventKey', () {
      test('should return correct event key', () {
        // Arrange
        final event = QcLoginEvent();

        // Act
        final key = event.getEventKey();

        // Assert
        expect(key, equals(AnalyticEventKeys.common.login));
        expect(key, equals('login'));
      });
    });

    group('inheritance from CommonEvents', () {
      test('should include common event arguments', () async {
        // Arrange
        final event = QcLoginEvent();

        // Act
        final arguments = await event.getArguments();

        // Assert - Common arguments from CommonEvents
        expect(arguments?.containsKey(AnalyticEventParams.hitTimeStamp), isTrue);
      });

      test('should have getTrackers method', () {
        // Arrange
        final event = QcLoginEvent();

        // Assert
        expect(event.getTrackers, isNotNull);
      });

      test('getTrackers should return non-empty list', () {
        // Arrange
        final event = QcLoginEvent();

        // Act
        final trackers = event.getTrackers();

        // Assert
        expect(trackers, isNotEmpty);
      });
    });

    group('event key format', () {
      test('subordinate key should not contain spaces', () {
        // Arrange
        final event = QcLoginEvent();

        // Act
        final key = event.getSubordinateKey();

        // Assert
        expect(key.contains(' '), isFalse);
      });

      test('event key should not contain spaces', () {
        // Arrange
        final event = QcLoginEvent();

        // Act
        final key = event.getEventKey();

        // Assert
        expect(key.contains(' '), isFalse);
      });

      test('subordinate key should be lowercase', () {
        // Arrange
        final event = QcLoginEvent();

        // Act
        final key = event.getSubordinateKey();

        // Assert
        expect(key, equals(key.toLowerCase()));
      });

      test('event key should be lowercase', () {
        // Arrange
        final event = QcLoginEvent();

        // Act
        final key = event.getEventKey();

        // Assert
        expect(key, equals(key.toLowerCase()));
      });
    });

    group('arguments content', () {
      test('arguments should contain timestamp', () async {
        // Arrange
        final event = QcLoginEvent();

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.hitTimeStamp], isNotNull);
      });

      test('arguments should be a map', () async {
        // Arrange
        final event = QcLoginEvent();

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments, isA<Map<String, dynamic>>());
      });
    });
  });
}
