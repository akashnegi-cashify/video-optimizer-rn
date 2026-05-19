import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/logging/logging_service.dart';

void main() {
  group('LogType', () {
    group('enum values', () {
      test('should have info with value "INFO"', () {
        // Arrange & Act
        final logType = LogType.info;

        // Assert
        expect(logType.value, equals('INFO'));
      });

      test('should have error with value "ERROR"', () {
        // Arrange & Act
        final logType = LogType.error;

        // Assert
        expect(logType.value, equals('ERROR'));
      });

      test('should have success with value "SUCCESS"', () {
        // Arrange & Act
        final logType = LogType.success;

        // Assert
        expect(logType.value, equals('SUCCESS'));
      });
    });

    group('enum count', () {
      test('should have exactly 3 log types', () {
        // Assert
        expect(LogType.values.length, equals(3));
      });

      test('should contain all expected values', () {
        // Assert
        expect(
          LogType.values,
          containsAll([LogType.info, LogType.error, LogType.success]),
        );
      });
    });

    group('value uniqueness', () {
      test('should have unique values for each log type', () {
        // Arrange
        final values = LogType.values.map((e) => e.value).toList();

        // Assert
        expect(values.toSet().length, equals(values.length));
      });
    });

    group('value format', () {
      test('all values should be uppercase strings', () {
        // Assert
        for (final logType in LogType.values) {
          expect(logType.value, equals(logType.value.toUpperCase()));
        }
      });

      test('values should not be empty', () {
        // Assert
        for (final logType in LogType.values) {
          expect(logType.value.isNotEmpty, isTrue);
        }
      });
    });

    group('enum name', () {
      test('info should have correct name', () {
        expect(LogType.info.name, equals('info'));
      });

      test('error should have correct name', () {
        expect(LogType.error.name, equals('error'));
      });

      test('success should have correct name', () {
        expect(LogType.success.name, equals('success'));
      });
    });
  });
}
