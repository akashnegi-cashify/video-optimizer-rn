import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/utils/time_utils.dart';

void main() {
  group('TimeUtils Extension on int', () {
    group('formatInReadableTimeDiff', () {
      test('should format 0 milliseconds correctly', () {
        // Arrange
        const int milliseconds = 0;

        // Act
        final result = milliseconds.formatInReadableTimeDiff();

        // Assert
        expect(result, '0 Seconds');
      });

      test('should format seconds only correctly', () {
        // Arrange
        const int milliseconds = 30000; // 30 seconds

        // Act
        final result = milliseconds.formatInReadableTimeDiff();

        // Assert
        expect(result, '30 Seconds');
      });

      test('should format minutes and seconds correctly', () {
        // Arrange
        const int milliseconds = 90000; // 1 minute 30 seconds

        // Act
        final result = milliseconds.formatInReadableTimeDiff();

        // Assert
        expect(result, '1 Minutes 30 Seconds');
      });

      test('should format hours minutes and seconds correctly', () {
        // Arrange
        const int milliseconds = 3661000; // 1 hour, 1 minute, 1 second

        // Act
        final result = milliseconds.formatInReadableTimeDiff();

        // Assert
        expect(result, '1 Hours 1 Minutes 1 Seconds');
      });

      test('should format exact minutes correctly (no seconds)', () {
        // Arrange
        const int milliseconds = 60000; // 1 minute

        // Act
        final result = milliseconds.formatInReadableTimeDiff();

        // Assert
        expect(result, '1 Minutes 0 Seconds');
      });

      test('should format exact hours correctly (no minutes, no seconds)', () {
        // Arrange
        const int milliseconds = 3600000; // 1 hour

        // Act
        final result = milliseconds.formatInReadableTimeDiff();

        // Assert
        expect(result, '1 Hours 0 Seconds');
      });

      test('should format hours and seconds (no minutes) correctly', () {
        // Arrange
        const int milliseconds = 3630000; // 1 hour, 0 minutes, 30 seconds

        // Act
        final result = milliseconds.formatInReadableTimeDiff();

        // Assert
        expect(result, '1 Hours 30 Seconds');
      });

      test('should format multiple hours correctly', () {
        // Arrange
        const int milliseconds = 10800000; // 3 hours

        // Act
        final result = milliseconds.formatInReadableTimeDiff();

        // Assert
        expect(result, '3 Hours 0 Seconds');
      });

      test('should handle 59 seconds correctly', () {
        // Arrange
        const int milliseconds = 59000; // 59 seconds

        // Act
        final result = milliseconds.formatInReadableTimeDiff();

        // Assert
        expect(result, '59 Seconds');
      });

      test('should handle 59 minutes 59 seconds correctly', () {
        // Arrange
        const int milliseconds = 3599000; // 59 minutes 59 seconds

        // Act
        final result = milliseconds.formatInReadableTimeDiff();

        // Assert
        expect(result, '59 Minutes 59 Seconds');
      });

      test('should handle 23 hours 59 minutes 59 seconds correctly', () {
        // Arrange
        const int milliseconds = 86399000; // 23 hours 59 minutes 59 seconds

        // Act
        final result = milliseconds.formatInReadableTimeDiff();

        // Assert
        expect(result, '23 Hours 59 Minutes 59 Seconds');
      });

      test('should wrap hours at 24 (modulo 24)', () {
        // Arrange
        const int milliseconds = 90000000; // 25 hours

        // Act
        final result = milliseconds.formatInReadableTimeDiff();

        // Assert
        expect(result, '1 Hours 0 Seconds'); // 25 % 24 = 1 hour
      });
    });
  });

  group('DateTimeFormat Extension', () {
    group('formatToSimpleDate', () {
      test('should format date correctly with single digit day and month', () {
        // Arrange
        final dateTime = DateTime(2024, 1, 5);

        // Act
        final result = dateTime.formatToSimpleDate();

        // Assert
        expect(result, '05/01/2024');
      });

      test('should format date correctly with double digit day and month', () {
        // Arrange
        final dateTime = DateTime(2024, 12, 25);

        // Act
        final result = dateTime.formatToSimpleDate();

        // Assert
        expect(result, '25/12/2024');
      });

      test('should format date correctly for leap year date', () {
        // Arrange
        final dateTime = DateTime(2024, 2, 29);

        // Act
        final result = dateTime.formatToSimpleDate();

        // Assert
        expect(result, '29/02/2024');
      });

      test('should format first day of year correctly', () {
        // Arrange
        final dateTime = DateTime(2024, 1, 1);

        // Act
        final result = dateTime.formatToSimpleDate();

        // Assert
        expect(result, '01/01/2024');
      });

      test('should format last day of year correctly', () {
        // Arrange
        final dateTime = DateTime(2024, 12, 31);

        // Act
        final result = dateTime.formatToSimpleDate();

        // Assert
        expect(result, '31/12/2024');
      });

      test('should ignore time component', () {
        // Arrange
        final dateTime = DateTime(2024, 6, 15, 14, 30, 45);

        // Act
        final result = dateTime.formatToSimpleDate();

        // Assert
        expect(result, '15/06/2024');
      });
    });
  });

  group('Time Utility Functions', () {
    group('previousNthDayStart', () {
      test('should return start of today when n is 0', () {
        // Act
        final result = previousNthDayStart(0);
        final now = DateTime.now();

        // Assert
        expect(result.year, now.year);
        expect(result.month, now.month);
        expect(result.day, now.day);
        expect(result.hour, 0);
        expect(result.minute, 0);
        expect(result.second, 0);
      });

      test('should return start of yesterday when n is 1', () {
        // Act
        final result = previousNthDayStart(1);
        final yesterday = DateTime.now().subtract(const Duration(days: 1));

        // Assert
        expect(result.year, yesterday.year);
        expect(result.month, yesterday.month);
        expect(result.day, yesterday.day);
        expect(result.hour, 0);
        expect(result.minute, 0);
        expect(result.second, 0);
      });

      test('should return start of 7 days ago when n is 7', () {
        // Act
        final result = previousNthDayStart(7);
        final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));

        // Assert
        expect(result.year, sevenDaysAgo.year);
        expect(result.month, sevenDaysAgo.month);
        expect(result.day, sevenDaysAgo.day);
        expect(result.hour, 0);
        expect(result.minute, 0);
        expect(result.second, 0);
      });

      test('should return start of 30 days ago when n is 30', () {
        // Act
        final result = previousNthDayStart(30);
        final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));

        // Assert
        expect(result.year, thirtyDaysAgo.year);
        expect(result.month, thirtyDaysAgo.month);
        expect(result.day, thirtyDaysAgo.day);
        expect(result.hour, 0);
        expect(result.minute, 0);
        expect(result.second, 0);
      });
    });

    group('previousNthDayEnd', () {
      test('should return end of today when n is 0', () {
        // Act
        final result = previousNthDayEnd(0);
        final now = DateTime.now();

        // Assert
        expect(result.year, now.year);
        expect(result.month, now.month);
        expect(result.day, now.day);
        expect(result.hour, 23);
        expect(result.minute, 59);
        expect(result.second, 59);
      });

      test('should return end of yesterday when n is 1', () {
        // Act
        final result = previousNthDayEnd(1);
        final yesterday = DateTime.now().subtract(const Duration(days: 1));

        // Assert
        expect(result.year, yesterday.year);
        expect(result.month, yesterday.month);
        expect(result.day, yesterday.day);
        expect(result.hour, 23);
        expect(result.minute, 59);
        expect(result.second, 59);
      });

      test('should return end of 7 days ago when n is 7', () {
        // Act
        final result = previousNthDayEnd(7);
        final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));

        // Assert
        expect(result.year, sevenDaysAgo.year);
        expect(result.month, sevenDaysAgo.month);
        expect(result.day, sevenDaysAgo.day);
        expect(result.hour, 23);
        expect(result.minute, 59);
        expect(result.second, 59);
      });
    });

    group('thisMonthStart', () {
      test('should return first day of current month', () {
        // Act
        final result = thisMonthStart();
        final now = DateTime.now();

        // Assert
        expect(result.year, now.year);
        expect(result.month, now.month);
        expect(result.day, 1);
        expect(result.hour, 0);
        expect(result.minute, 0);
        expect(result.second, 0);
      });
    });

    group('lastMonthStart', () {
      test('should return first day of last month', () {
        // Act
        final result = lastMonthStart();
        final now = DateTime.now();

        // Calculate expected last month
        int expectedYear = now.year;
        int expectedMonth = now.month - 1;
        if (expectedMonth == 0) {
          expectedMonth = 12;
          expectedYear = now.year - 1;
        }

        // Assert
        expect(result.year, expectedYear);
        expect(result.month, expectedMonth);
        expect(result.day, 1);
        expect(result.hour, 0);
        expect(result.minute, 0);
        expect(result.second, 0);
      });
    });

    group('lastMonthEnd', () {
      test('should return last second of previous month', () {
        // Act
        final result = lastMonthEnd();
        final now = DateTime.now();

        // The last month end is 1 second before the start of current month
        final currentMonthStart = DateTime(now.year, now.month);
        final expectedEnd = currentMonthStart.subtract(const Duration(seconds: 1));

        // Assert
        expect(result.year, expectedEnd.year);
        expect(result.month, expectedEnd.month);
        expect(result.day, expectedEnd.day);
        expect(result.hour, 23);
        expect(result.minute, 59);
        expect(result.second, 59);
      });

      test('should be 1 second before thisMonthStart', () {
        // Act
        final lastEnd = lastMonthEnd();
        final thisStart = thisMonthStart();

        // Assert - lastMonthEnd should be 1 second before thisMonthStart
        final difference = thisStart.difference(lastEnd);
        expect(difference.inSeconds, 1);
      });
    });
  });
}
