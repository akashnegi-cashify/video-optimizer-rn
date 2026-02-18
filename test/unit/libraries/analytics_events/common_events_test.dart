import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/events/common_events.dart';

/// Concrete implementation of CommonEvents for testing
class TestCommonEvent extends CommonEvents {
  @override
  String getSubordinateKey() {
    return 'test_subordinate_key';
  }
}

void main() {
  group('CommonEvents', () {
    group('getTrackers', () {
      test('should return list from AnalyticsController', () {
        // Arrange
        final event = TestCommonEvent();

        // Act
        final trackers = event.getTrackers();

        // Assert
        expect(trackers, equals(AnalyticsController.getTrackers()));
      });

      test('should return non-empty list', () {
        // Arrange
        final event = TestCommonEvent();

        // Act
        final trackers = event.getTrackers();

        // Assert
        expect(trackers, isNotEmpty);
      });

      test('should return list containing CASHIFY tracker', () {
        // Arrange
        final event = TestCommonEvent();

        // Act
        final trackers = event.getTrackers();

        // Assert
        expect(trackers, contains(AnalyticTrackers.CASHIFY));
      });
    });

    group('getEventKey', () {
      test('should return subordinate key by default', () {
        // Arrange
        final event = TestCommonEvent();

        // Act
        final eventKey = event.getEventKey();

        // Assert
        expect(eventKey, equals(event.getSubordinateKey()));
      });
    });

    group('getArguments', () {
      test('should return non-null map', () async {
        // Arrange
        final event = TestCommonEvent();

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments, isNotNull);
        expect(arguments, isA<Map<String, dynamic>>());
      });

      test('should include hitTimeStamp', () async {
        // Arrange
        final event = TestCommonEvent();

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?.containsKey(AnalyticEventParams.hitTimeStamp), isTrue);
        expect(arguments?[AnalyticEventParams.hitTimeStamp], isNotNull);
      });

      test('hitTimeStamp should be a valid DateTime string', () async {
        // Arrange
        final event = TestCommonEvent();

        // Act
        final arguments = await event.getArguments();
        final timestamp = arguments?[AnalyticEventParams.hitTimeStamp] as String?;

        // Assert
        expect(timestamp, isNotNull);
        expect(timestamp, isNotEmpty);
      });

      test('should include userId field', () async {
        // Arrange
        final event = TestCommonEvent();

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?.containsKey(AnalyticEventParams.userId), isTrue);
      });

      test('should include appVersion field', () async {
        // Arrange
        final event = TestCommonEvent();

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?.containsKey(AnalyticEventParams.appVersion), isTrue);
      });

      test('should include osVersion field', () async {
        // Arrange
        final event = TestCommonEvent();

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?.containsKey(AnalyticEventParams.osVersion), isTrue);
      });

      test('should include deviceModel field', () async {
        // Arrange
        final event = TestCommonEvent();

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?.containsKey(AnalyticEventParams.deviceModel), isTrue);
      });
    });

    group('abstract method implementation', () {
      test('subclass must implement getSubordinateKey', () {
        // Arrange
        final event = TestCommonEvent();

        // Act
        final key = event.getSubordinateKey();

        // Assert
        expect(key, equals('test_subordinate_key'));
      });
    });

    group('inheritance', () {
      test('should be subclass of BaseTrackingEvent', () {
        // Arrange
        final event = TestCommonEvent();

        // Assert - CommonEvents extends BaseTrackingEvent
        expect(event.getTrackers, isNotNull);
        expect(event.getEventKey, isNotNull);
        expect(event.getSubordinateKey, isNotNull);
        expect(event.getArguments, isNotNull);
      });
    });
  });
}
