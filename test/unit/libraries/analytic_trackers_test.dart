import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';

void main() {
  group('AnalyticTrackers', () {
    group('enum values', () {
      test('should have FIRE_BASE tracker', () {
        // Assert
        expect(AnalyticTrackers.FIRE_BASE, isNotNull);
        expect(AnalyticTrackers.FIRE_BASE.name, equals('FIRE_BASE'));
      });

      test('should have CASHIFY tracker', () {
        // Assert
        expect(AnalyticTrackers.CASHIFY, isNotNull);
        expect(AnalyticTrackers.CASHIFY.name, equals('CASHIFY'));
      });
    });

    group('enum count', () {
      test('should have exactly 2 trackers', () {
        // Assert
        expect(AnalyticTrackers.values.length, equals(2));
      });

      test('should contain all expected trackers', () {
        // Assert
        expect(
          AnalyticTrackers.values,
          containsAll([AnalyticTrackers.FIRE_BASE, AnalyticTrackers.CASHIFY]),
        );
      });
    });

    group('enum index', () {
      test('FIRE_BASE should have index 0', () {
        expect(AnalyticTrackers.FIRE_BASE.index, equals(0));
      });

      test('CASHIFY should have index 1', () {
        expect(AnalyticTrackers.CASHIFY.index, equals(1));
      });
    });
  });

  group('AnalyticsController', () {
    group('getTrackers', () {
      test('should return list of trackers', () {
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

      test('should return new list instance on each call', () {
        // Act
        final trackers1 = AnalyticsController.getTrackers();
        final trackers2 = AnalyticsController.getTrackers();

        // Assert - should be equal in content but different instances
        expect(trackers1, equals(trackers2));
        expect(identical(trackers1, trackers2), isFalse);
      });
    });
  });
}
