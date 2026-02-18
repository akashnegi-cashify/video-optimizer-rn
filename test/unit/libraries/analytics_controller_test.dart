import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/base_tracking_event.dart';

/// Test implementation of BaseTrackingEvent
class TestEvent extends BaseTrackingEvent {
  final List<AnalyticTrackers> _trackers;
  final String _subordinateKey;
  final String _eventKey;
  final Map<String, dynamic>? _arguments;

  TestEvent({
    List<AnalyticTrackers>? trackers,
    String subordinateKey = 'test_subordinate',
    String eventKey = 'test_event',
    Map<String, dynamic>? arguments,
  })  : _trackers = trackers ?? [AnalyticTrackers.CASHIFY],
        _subordinateKey = subordinateKey,
        _eventKey = eventKey,
        _arguments = arguments;

  @override
  List<AnalyticTrackers> getTrackers() => _trackers;

  @override
  String getSubordinateKey() => _subordinateKey;

  @override
  String getEventKey() => _eventKey;

  @override
  Future<Map<String, dynamic>?> getArguments() async => _arguments;
}

/// Event with no trackers
class EmptyTrackersEvent extends BaseTrackingEvent {
  @override
  List<AnalyticTrackers> getTrackers() => [];

  @override
  String getSubordinateKey() => 'empty';

  @override
  String getEventKey() => 'empty_event';
}

/// Mock for BaseTrackingEvent
class MockBaseTrackingEvent extends Mock implements BaseTrackingEvent {}

void main() {
  group('AnalyticsController', () {
    group('getTrackers', () {
      test('should return a list of AnalyticTrackers', () {
        // Act
        final trackers = AnalyticsController.getTrackers();

        // Assert
        expect(trackers, isA<List<AnalyticTrackers>>());
      });

      test('should include CASHIFY tracker', () {
        // Act
        final trackers = AnalyticsController.getTrackers();

        // Assert
        expect(trackers, contains(AnalyticTrackers.CASHIFY));
      });

      test('should return non-empty list', () {
        // Act
        final trackers = AnalyticsController.getTrackers();

        // Assert
        expect(trackers.isNotEmpty, isTrue);
      });

      test('should return a new list instance each time', () {
        // Act
        final trackers1 = AnalyticsController.getTrackers();
        final trackers2 = AnalyticsController.getTrackers();

        // Assert
        expect(identical(trackers1, trackers2), isFalse);
      });

      test('should return modifiable list', () {
        // Act
        final trackers = AnalyticsController.getTrackers();
        final originalLength = trackers.length;

        // Modify the returned list
        trackers.add(AnalyticTrackers.FIRE_BASE);

        // Assert - original should not be affected
        final trackersAgain = AnalyticsController.getTrackers();
        expect(trackersAgain.length, equals(originalLength));
      });
    });

    group('logEvent', () {
      test('should complete without error for event with CASHIFY tracker', () async {
        // Arrange
        final event = TestEvent(
          trackers: [AnalyticTrackers.CASHIFY],
          eventKey: 'test_button_click',
        );

        // Act & Assert - should not throw
        await expectLater(
          AnalyticsController.logEvent(event),
          completes,
        );
      });

      test('should complete without error for event with FIRE_BASE tracker', () async {
        // Arrange
        final event = TestEvent(
          trackers: [AnalyticTrackers.FIRE_BASE],
          eventKey: 'test_screen_view',
        );

        // Act & Assert - should not throw
        await expectLater(
          AnalyticsController.logEvent(event),
          completes,
        );
      });

      test('should complete without error for event with multiple trackers', () async {
        // Arrange
        final event = TestEvent(
          trackers: [AnalyticTrackers.CASHIFY, AnalyticTrackers.FIRE_BASE],
          eventKey: 'test_conversion',
        );

        // Act & Assert - should not throw
        await expectLater(
          AnalyticsController.logEvent(event),
          completes,
        );
      });

      test('should return early when event has no trackers', () async {
        // Arrange
        final event = EmptyTrackersEvent();

        // Act & Assert - should complete without error
        await expectLater(
          AnalyticsController.logEvent(event),
          completes,
        );
      });

      test('should handle event with null arguments', () async {
        // Arrange
        final event = TestEvent(
          trackers: [AnalyticTrackers.CASHIFY],
          arguments: null,
        );

        // Act & Assert
        await expectLater(
          AnalyticsController.logEvent(event),
          completes,
        );
      });

      test('should handle event with empty arguments', () async {
        // Arrange
        final event = TestEvent(
          trackers: [AnalyticTrackers.CASHIFY],
          arguments: {},
        );

        // Act & Assert
        await expectLater(
          AnalyticsController.logEvent(event),
          completes,
        );
      });

      test('should handle event with complex arguments', () async {
        // Arrange
        final event = TestEvent(
          trackers: [AnalyticTrackers.CASHIFY],
          arguments: {
            'string_param': 'value',
            'int_param': 123,
            'bool_param': true,
            'double_param': 1.5,
            'list_param': [1, 2, 3],
            'map_param': {'nested': 'value'},
          },
        );

        // Act & Assert
        await expectLater(
          AnalyticsController.logEvent(event),
          completes,
        );
      });

      test('should handle multiple sequential log events', () async {
        // Arrange
        final event1 = TestEvent(eventKey: 'event_1');
        final event2 = TestEvent(eventKey: 'event_2');
        final event3 = TestEvent(eventKey: 'event_3');

        // Act & Assert
        await AnalyticsController.logEvent(event1);
        await AnalyticsController.logEvent(event2);
        await AnalyticsController.logEvent(event3);
        // Should complete without error
      });
    });

    group('init', () {
      test('should complete initialization', () async {
        // Act & Assert
        await expectLater(
          AnalyticsController.init(),
          completes,
        );
      });

      test('should be callable multiple times', () async {
        // Act & Assert
        await AnalyticsController.init();
        await AnalyticsController.init();
        // Should not throw
      });
    });
  });

  group('BaseTrackingEvent interface', () {
    late MockBaseTrackingEvent mockEvent;

    setUp(() {
      mockEvent = MockBaseTrackingEvent();
    });

    test('should call getTrackers when logging event', () async {
      // Arrange
      when(() => mockEvent.getTrackers()).thenReturn([]);
      when(() => mockEvent.getArguments()).thenAnswer((_) async => null);

      // Act
      await AnalyticsController.logEvent(mockEvent);

      // Assert
      verify(() => mockEvent.getTrackers()).called(1);
    });

    test('should not call getArguments when trackers is empty', () async {
      // Arrange
      when(() => mockEvent.getTrackers()).thenReturn([]);
      when(() => mockEvent.getArguments()).thenAnswer((_) async => null);

      // Act
      await AnalyticsController.logEvent(mockEvent);

      // Assert
      verify(() => mockEvent.getTrackers()).called(1);
      verifyNever(() => mockEvent.getArguments());
    });

    test('should call getArguments when trackers is not empty', () async {
      // Arrange
      when(() => mockEvent.getTrackers()).thenReturn([AnalyticTrackers.CASHIFY]);
      when(() => mockEvent.getArguments()).thenAnswer((_) async => {'key': 'value'});
      when(() => mockEvent.getSubordinateKey()).thenReturn('subordinate');
      when(() => mockEvent.getEventKey()).thenReturn('event');

      // Act
      await AnalyticsController.logEvent(mockEvent);

      // Assert
      verify(() => mockEvent.getArguments()).called(1);
    });
  });
}
