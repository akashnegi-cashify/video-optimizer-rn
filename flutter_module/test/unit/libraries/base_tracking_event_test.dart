import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/base_tracking_event.dart';

/// Test implementation of BaseTrackingEvent for testing purposes
class TestableTrackingEvent extends BaseTrackingEvent {
  final List<AnalyticTrackers> trackers;
  final String subordinateKey;
  final String eventKey;
  final Map<String, dynamic>? arguments;

  TestableTrackingEvent({
    required this.trackers,
    required this.subordinateKey,
    required this.eventKey,
    this.arguments,
  });

  @override
  List<AnalyticTrackers> getTrackers() => trackers;

  @override
  String getSubordinateKey() => subordinateKey;

  @override
  String getEventKey() => eventKey;

  @override
  Future<Map<String, dynamic>?> getArguments() async => arguments;
}

/// Test implementation with no arguments
class MinimalTrackingEvent extends BaseTrackingEvent {
  @override
  List<AnalyticTrackers> getTrackers() => [];

  @override
  String getSubordinateKey() => 'minimal';

  @override
  String getEventKey() => 'test_event';
}

void main() {
  group('BaseTrackingEvent', () {
    group('getTrackers', () {
      test('should return configured trackers list', () {
        // Arrange
        final event = TestableTrackingEvent(
          trackers: [AnalyticTrackers.CASHIFY, AnalyticTrackers.FIRE_BASE],
          subordinateKey: 'test',
          eventKey: 'event',
        );

        // Act
        final result = event.getTrackers();

        // Assert
        expect(result.length, equals(2));
        expect(result, contains(AnalyticTrackers.CASHIFY));
        expect(result, contains(AnalyticTrackers.FIRE_BASE));
      });

      test('should return empty list when no trackers configured', () {
        // Arrange
        final event = TestableTrackingEvent(
          trackers: [],
          subordinateKey: 'test',
          eventKey: 'event',
        );

        // Act
        final result = event.getTrackers();

        // Assert
        expect(result, isEmpty);
      });

      test('should return single tracker when only one is configured', () {
        // Arrange
        final event = TestableTrackingEvent(
          trackers: [AnalyticTrackers.CASHIFY],
          subordinateKey: 'test',
          eventKey: 'event',
        );

        // Act
        final result = event.getTrackers();

        // Assert
        expect(result.length, equals(1));
        expect(result.first, equals(AnalyticTrackers.CASHIFY));
      });
    });

    group('getSubordinateKey', () {
      test('should return configured subordinate key', () {
        // Arrange
        final event = TestableTrackingEvent(
          trackers: [],
          subordinateKey: 'my_subordinate_key',
          eventKey: 'event',
        );

        // Act
        final result = event.getSubordinateKey();

        // Assert
        expect(result, equals('my_subordinate_key'));
      });

      test('should return empty string when configured as empty', () {
        // Arrange
        final event = TestableTrackingEvent(
          trackers: [],
          subordinateKey: '',
          eventKey: 'event',
        );

        // Act
        final result = event.getSubordinateKey();

        // Assert
        expect(result, isEmpty);
      });
    });

    group('getEventKey', () {
      test('should return configured event key', () {
        // Arrange
        final event = TestableTrackingEvent(
          trackers: [],
          subordinateKey: 'test',
          eventKey: 'button_click',
        );

        // Act
        final result = event.getEventKey();

        // Assert
        expect(result, equals('button_click'));
      });

      test('should return event key with special characters', () {
        // Arrange
        final event = TestableTrackingEvent(
          trackers: [],
          subordinateKey: 'test',
          eventKey: 'screen_view_123',
        );

        // Act
        final result = event.getEventKey();

        // Assert
        expect(result, equals('screen_view_123'));
      });
    });

    group('getArguments', () {
      test('should return null when no arguments configured', () async {
        // Arrange
        final event = TestableTrackingEvent(
          trackers: [],
          subordinateKey: 'test',
          eventKey: 'event',
          arguments: null,
        );

        // Act
        final result = await event.getArguments();

        // Assert
        expect(result, isNull);
      });

      test('should return configured arguments map', () async {
        // Arrange
        final arguments = {
          'param1': 'value1',
          'param2': 123,
          'param3': true,
        };
        final event = TestableTrackingEvent(
          trackers: [],
          subordinateKey: 'test',
          eventKey: 'event',
          arguments: arguments,
        );

        // Act
        final result = await event.getArguments();

        // Assert
        expect(result, isNotNull);
        expect(result!['param1'], equals('value1'));
        expect(result['param2'], equals(123));
        expect(result['param3'], equals(true));
      });

      test('should return empty map when configured as empty', () async {
        // Arrange
        final event = TestableTrackingEvent(
          trackers: [],
          subordinateKey: 'test',
          eventKey: 'event',
          arguments: {},
        );

        // Act
        final result = await event.getArguments();

        // Assert
        expect(result, isNotNull);
        expect(result, isEmpty);
      });

      test('should handle nested map arguments', () async {
        // Arrange
        final arguments = {
          'user': {
            'id': 1,
            'name': 'Test User',
          },
          'metadata': {
            'version': '1.0.0',
          },
        };
        final event = TestableTrackingEvent(
          trackers: [],
          subordinateKey: 'test',
          eventKey: 'event',
          arguments: arguments,
        );

        // Act
        final result = await event.getArguments();

        // Assert
        expect(result, isNotNull);
        expect(result!['user'], isA<Map>());
        expect(result['user']['id'], equals(1));
      });

      test('should handle list arguments', () async {
        // Arrange
        final arguments = {
          'items': ['item1', 'item2', 'item3'],
          'count': 3,
        };
        final event = TestableTrackingEvent(
          trackers: [],
          subordinateKey: 'test',
          eventKey: 'event',
          arguments: arguments,
        );

        // Act
        final result = await event.getArguments();

        // Assert
        expect(result, isNotNull);
        expect(result!['items'], isA<List>());
        expect((result['items'] as List).length, equals(3));
      });
    });

    group('default implementation', () {
      test('getArguments should return null by default from base class', () async {
        // Arrange
        final event = MinimalTrackingEvent();

        // Act
        final result = await event.getArguments();

        // Assert
        expect(result, isNull);
      });

      test('minimal event should have empty trackers', () {
        // Arrange
        final event = MinimalTrackingEvent();

        // Act
        final result = event.getTrackers();

        // Assert
        expect(result, isEmpty);
      });

      test('minimal event should have correct subordinate key', () {
        // Arrange
        final event = MinimalTrackingEvent();

        // Act
        final result = event.getSubordinateKey();

        // Assert
        expect(result, equals('minimal'));
      });

      test('minimal event should have correct event key', () {
        // Arrange
        final event = MinimalTrackingEvent();

        // Act
        final result = event.getEventKey();

        // Assert
        expect(result, equals('test_event'));
      });
    });
  });
}
