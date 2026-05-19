import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/utils/time_utils.dart';

void main() {
  group('TimeUtils extension on int', () {
    group('formatInReadableTimeDiff', () {
      test('formats zero milliseconds', () {
        const ms = 0;
        expect(ms.formatInReadableTimeDiff(), '0 Seconds');
      });

      test('formats only seconds', () {
        const ms = 5000; // 5 seconds
        expect(ms.formatInReadableTimeDiff(), '5 Seconds');
      });

      test('formats minutes and seconds', () {
        const ms = 125000; // 2 minutes 5 seconds
        expect(ms.formatInReadableTimeDiff(), '2 Minutes 5 Seconds');
      });

      test('formats hours, minutes, and seconds', () {
        const ms = 3725000; // 1 hour 2 minutes 5 seconds
        expect(ms.formatInReadableTimeDiff(), '1 Hours 2 Minutes 5 Seconds');
      });

      test('formats exactly one hour', () {
        const ms = 3600000; // 1 hour
        expect(ms.formatInReadableTimeDiff(), '1 Hours 0 Seconds');
      });

      test('formats exactly one minute', () {
        const ms = 60000; // 1 minute
        expect(ms.formatInReadableTimeDiff(), '1 Minutes 0 Seconds');
      });

      test('formats multiple hours', () {
        const ms = 7325000; // 2 hours 2 minutes 5 seconds
        expect(ms.formatInReadableTimeDiff(), '2 Hours 2 Minutes 5 Seconds');
      });

      test('handles edge case with 59 seconds', () {
        const ms = 59000; // 59 seconds
        expect(ms.formatInReadableTimeDiff(), '59 Seconds');
      });

      test('handles edge case with 59 minutes 59 seconds', () {
        const ms = 3599000; // 59 minutes 59 seconds
        expect(ms.formatInReadableTimeDiff(), '59 Minutes 59 Seconds');
      });

      test('handles 23 hours 59 minutes 59 seconds', () {
        const ms = 86399000; // 23:59:59
        expect(ms.formatInReadableTimeDiff(), '23 Hours 59 Minutes 59 Seconds');
      });

      test('wraps around after 24 hours', () {
        const ms = 90061000; // 25 hours 1 minute 1 second -> wraps to 1:1:1
        expect(ms.formatInReadableTimeDiff(), '1 Hours 1 Minutes 1 Seconds');
      });
    });
  });

  group('DateTimeFormat extension on DateTime', () {
    group('formatToSimpleDate', () {
      test('formats date correctly', () {
        final date = DateTime(2024, 1, 15);
        expect(date.formatToSimpleDate(), '15/01/2024');
      });

      test('formats single digit day and month with leading zeros', () {
        final date = DateTime(2024, 3, 5);
        expect(date.formatToSimpleDate(), '05/03/2024');
      });

      test('formats December 31st', () {
        final date = DateTime(2023, 12, 31);
        expect(date.formatToSimpleDate(), '31/12/2023');
      });

      test('formats January 1st', () {
        final date = DateTime(2024, 1, 1);
        expect(date.formatToSimpleDate(), '01/01/2024');
      });

      test('ignores time component', () {
        final date = DateTime(2024, 6, 15, 14, 30, 45);
        expect(date.formatToSimpleDate(), '15/06/2024');
      });
    });
  });

  group('previousNthDayStart', () {
    test('returns start of previous day (n=1)', () {
      final result = previousNthDayStart(1);
      final expected = DateTime.now().subtract(const Duration(days: 1));
      
      expect(result.year, expected.year);
      expect(result.month, expected.month);
      expect(result.day, expected.day);
      expect(result.hour, 0);
      expect(result.minute, 0);
      expect(result.second, 0);
    });

    test('returns start of 7 days ago (n=7)', () {
      final result = previousNthDayStart(7);
      final expected = DateTime.now().subtract(const Duration(days: 7));
      
      expect(result.year, expected.year);
      expect(result.month, expected.month);
      expect(result.day, expected.day);
      expect(result.hour, 0);
      expect(result.minute, 0);
      expect(result.second, 0);
    });

    test('returns today start for n=0', () {
      final result = previousNthDayStart(0);
      final now = DateTime.now();
      
      expect(result.year, now.year);
      expect(result.month, now.month);
      expect(result.day, now.day);
      expect(result.hour, 0);
      expect(result.minute, 0);
      expect(result.second, 0);
    });
  });

  group('previousNthDayEnd', () {
    test('returns end of previous day (n=1)', () {
      final result = previousNthDayEnd(1);
      final expected = DateTime.now().subtract(const Duration(days: 1));
      
      expect(result.year, expected.year);
      expect(result.month, expected.month);
      expect(result.day, expected.day);
      expect(result.hour, 23);
      expect(result.minute, 59);
      expect(result.second, 59);
    });

    test('returns end of 7 days ago (n=7)', () {
      final result = previousNthDayEnd(7);
      final expected = DateTime.now().subtract(const Duration(days: 7));
      
      expect(result.year, expected.year);
      expect(result.month, expected.month);
      expect(result.day, expected.day);
      expect(result.hour, 23);
      expect(result.minute, 59);
      expect(result.second, 59);
    });
  });

  group('thisMonthStart', () {
    test('returns first day of current month at midnight', () {
      final result = thisMonthStart();
      final now = DateTime.now();
      
      expect(result.year, now.year);
      expect(result.month, now.month);
      expect(result.day, 1);
      expect(result.hour, 0);
      expect(result.minute, 0);
      expect(result.second, 0);
    });
  });

  group('lastMonthStart', () {
    test('returns first day of last month at midnight', () {
      final result = lastMonthStart();
      final now = DateTime.now();
      
      // Calculate expected month (handle January -> December wrap)
      int expectedMonth = now.month - 1;
      int expectedYear = now.year;
      if (expectedMonth == 0) {
        expectedMonth = 12;
        expectedYear = now.year - 1;
      }
      
      expect(result.year, expectedYear);
      expect(result.month, expectedMonth);
      expect(result.day, 1);
      expect(result.hour, 0);
      expect(result.minute, 0);
      expect(result.second, 0);
    });
  });

  group('lastMonthEnd', () {
    test('returns last second of last month', () {
      final result = lastMonthEnd();
      final now = DateTime.now();
      final firstOfThisMonth = DateTime(now.year, now.month, 1);
      final lastSecondOfPrevMonth = firstOfThisMonth.subtract(const Duration(seconds: 1));
      
      expect(result.year, lastSecondOfPrevMonth.year);
      expect(result.month, lastSecondOfPrevMonth.month);
      expect(result.day, lastSecondOfPrevMonth.day);
      expect(result.hour, 23);
      expect(result.minute, 59);
      expect(result.second, 59);
    });
  });
}
