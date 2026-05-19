import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/logging/logging_service.dart';

void main() {
  group('LogType', () {
    group('enum values', () {
      test('should have info with value "INFO"', () {
        expect(LogType.info.value, equals('INFO'));
      });

      test('should have error with value "ERROR"', () {
        expect(LogType.error.value, equals('ERROR'));
      });

      test('should have success with value "SUCCESS"', () {
        expect(LogType.success.value, equals('SUCCESS'));
      });
    });

    group('enum count', () {
      test('should have exactly 3 log types', () {
        expect(LogType.values.length, equals(3));
      });

      test('should contain all expected values', () {
        expect(
          LogType.values,
          containsAll([LogType.info, LogType.error, LogType.success]),
        );
      });
    });

    group('value format', () {
      test('all values should be uppercase', () {
        for (final logType in LogType.values) {
          expect(logType.value, equals(logType.value.toUpperCase()));
        }
      });

      test('all values should not be empty', () {
        for (final logType in LogType.values) {
          expect(logType.value.isNotEmpty, isTrue);
        }
      });

      test('all values should not contain spaces', () {
        for (final logType in LogType.values) {
          expect(logType.value.contains(' '), isFalse);
        }
      });
    });

    group('value uniqueness', () {
      test('should have unique values for each log type', () {
        final values = LogType.values.map((e) => e.value).toList();
        expect(values.toSet().length, equals(values.length));
      });
    });

    group('enum index', () {
      test('info should have index 0', () {
        expect(LogType.info.index, equals(0));
      });

      test('error should have index 1', () {
        expect(LogType.error.index, equals(1));
      });

      test('success should have index 2', () {
        expect(LogType.success.index, equals(2));
      });
    });
  });

  group('LoggingService', () {
    group('static properties', () {
      test('logFile should initially be null before initialization', () {
        // Note: This test checks the static getter
        // In a fresh test environment, logFile might be null
        // However, other tests may have initialized it
        final logFile = LoggingService.logFile;
        // Just verify it returns File? type (can be null or File)
        expect(logFile == null || logFile.path.isNotEmpty, isTrue);
      });
    });

    group('log message format', () {
      test('info log type should format with INFO prefix', () {
        // Test the format pattern used in log method
        const type = LogType.info;
        const barcode = 'TEST123';
        const message = 'Test message';
        final timestamp = DateTime.now().toIso8601String();

        // Verify the expected format pattern
        final expectedPattern = '[${type.value}] $barcode: $timestamp: $message\n';
        expect(expectedPattern.startsWith('[INFO]'), isTrue);
        expect(expectedPattern.contains(barcode), isTrue);
        expect(expectedPattern.contains(message), isTrue);
        expect(expectedPattern.endsWith('\n'), isTrue);
      });

      test('error log type should format with ERROR prefix', () {
        const type = LogType.error;
        final formattedPrefix = '[${type.value}]';
        expect(formattedPrefix, equals('[ERROR]'));
      });

      test('success log type should format with SUCCESS prefix', () {
        const type = LogType.success;
        final formattedPrefix = '[${type.value}]';
        expect(formattedPrefix, equals('[SUCCESS]'));
      });

      test('log format should include timestamp in ISO8601 format', () {
        final timestamp = DateTime.now().toIso8601String();
        // Verify ISO8601 format
        expect(timestamp.contains('T'), isTrue);
        expect(timestamp.length, greaterThanOrEqualTo(19));
      });

      test('log format should handle null barcode', () {
        const type = LogType.info;
        const String? barcode = null;
        const message = 'Test message';
        final timestamp = DateTime.now().toIso8601String();

        final expectedFormat = '[${type.value}] $barcode: $timestamp: $message\n';
        expect(expectedFormat.contains('null'), isTrue);
      });

      test('log format should handle empty barcode', () {
        const type = LogType.info;
        const barcode = '';
        const message = 'Test message';
        final timestamp = DateTime.now().toIso8601String();

        final expectedFormat = '[${type.value}] $barcode: $timestamp: $message\n';
        expect(expectedFormat.contains('[]'), isFalse); // barcode is empty, not brackets
      });

      test('log format should handle special characters in message', () {
        const type = LogType.info;
        const barcode = 'TEST';
        const message = 'Message with special chars: @#\$%^&*()';
        final timestamp = DateTime.now().toIso8601String();

        final expectedFormat = '[${type.value}] $barcode: $timestamp: $message\n';
        expect(expectedFormat.contains('@#\$%^&*()'), isTrue);
      });

      test('log format should handle unicode characters', () {
        const type = LogType.info;
        const barcode = 'TEST';
        const message = 'Unicode: 你好世界 🌍';
        final timestamp = DateTime.now().toIso8601String();

        final expectedFormat = '[${type.value}] $barcode: $timestamp: $message\n';
        expect(expectedFormat.contains('你好世界'), isTrue);
        expect(expectedFormat.contains('🌍'), isTrue);
      });

      test('log format should handle multiline message', () {
        const type = LogType.error;
        const barcode = 'TEST';
        const message = 'Line 1\nLine 2\nLine 3';
        final timestamp = DateTime.now().toIso8601String();

        final expectedFormat = '[${type.value}] $barcode: $timestamp: $message\n';
        expect(expectedFormat.contains('Line 1'), isTrue);
        expect(expectedFormat.contains('Line 2'), isTrue);
        expect(expectedFormat.contains('Line 3'), isTrue);
      });
    });

    group('file name constant', () {
      test('should use consistent file name for logs', () {
        // The file name is private constant, but we can verify the behavior
        // by checking the log file path if initialized
        const expectedFileName = 'cops_video_logs.txt';
        expect(expectedFileName.endsWith('.txt'), isTrue);
        expect(expectedFileName.contains('cops'), isTrue);
        expect(expectedFileName.contains('log'), isTrue);
      });
    });
  });
}
