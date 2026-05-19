import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/utils/string_utils.dart';

void main() {
  group('StringUtil Extension', () {
    group('containsIgnoreCase', () {
      test('should return true when string contains query (same case)', () {
        // Arrange
        const String testString = 'Hello World';
        const String query = 'World';

        // Act
        final result = testString.containsIgnoreCase(query);

        // Assert
        expect(result, isTrue);
      });

      test('should return true when string contains query (different case)', () {
        // Arrange
        const String testString = 'Hello World';
        const String query = 'world';

        // Act
        final result = testString.containsIgnoreCase(query);

        // Assert
        expect(result, isTrue);
      });

      test('should return true when string contains query (uppercase query)', () {
        // Arrange
        const String testString = 'Hello World';
        const String query = 'HELLO';

        // Act
        final result = testString.containsIgnoreCase(query);

        // Assert
        expect(result, isTrue);
      });

      test('should return true when string contains query (mixed case)', () {
        // Arrange
        const String testString = 'HeLLo WoRlD';
        const String query = 'hello world';

        // Act
        final result = testString.containsIgnoreCase(query);

        // Assert
        expect(result, isTrue);
      });

      test('should return false when string does not contain query', () {
        // Arrange
        const String testString = 'Hello World';
        const String query = 'Goodbye';

        // Act
        final result = testString.containsIgnoreCase(query);

        // Assert
        expect(result, isFalse);
      });

      test('should return true when query is empty string', () {
        // Arrange
        const String testString = 'Hello World';
        const String query = '';

        // Act
        final result = testString.containsIgnoreCase(query);

        // Assert
        expect(result, isTrue);
      });

      test('should return true when both strings are empty', () {
        // Arrange
        const String testString = '';
        const String query = '';

        // Act
        final result = testString.containsIgnoreCase(query);

        // Assert
        expect(result, isTrue);
      });

      test('should return false when string is empty but query is not', () {
        // Arrange
        const String testString = '';
        const String query = 'test';

        // Act
        final result = testString.containsIgnoreCase(query);

        // Assert
        expect(result, isFalse);
      });

      test('should return true when null string contains null query', () {
        // Arrange
        const String? testString = null;
        const String? query = null;

        // Act
        final result = testString.containsIgnoreCase(query);

        // Assert
        expect(result, isTrue);
      });

      test('should return true when null string and empty query', () {
        // Arrange
        const String? testString = null;
        const String query = '';

        // Act
        final result = testString.containsIgnoreCase(query);

        // Assert
        expect(result, isTrue);
      });

      test('should return false when null string and non-empty query', () {
        // Arrange
        const String? testString = null;
        const String query = 'test';

        // Act
        final result = testString.containsIgnoreCase(query);

        // Assert
        expect(result, isFalse);
      });

      test('should handle special characters correctly', () {
        // Arrange
        const String testString = 'Hello! @#\$%^&*()';
        const String query = '@#\$%';

        // Act
        final result = testString.containsIgnoreCase(query);

        // Assert
        expect(result, isTrue);
      });

      test('should handle unicode characters correctly', () {
        // Arrange
        const String testString = 'Héllo Wörld';
        const String query = 'wörld';

        // Act
        final result = testString.containsIgnoreCase(query);

        // Assert
        expect(result, isTrue);
      });

      test('should handle numeric strings correctly', () {
        // Arrange
        const String testString = '123456789';
        const String query = '456';

        // Act
        final result = testString.containsIgnoreCase(query);

        // Assert
        expect(result, isTrue);
      });

      test('should handle whitespace correctly', () {
        // Arrange
        const String testString = '  hello  world  ';
        const String query = 'hello  world';

        // Act
        final result = testString.containsIgnoreCase(query);

        // Assert
        expect(result, isTrue);
      });

      test('should handle query at the beginning of string', () {
        // Arrange
        const String testString = 'Hello World';
        const String query = 'hello';

        // Act
        final result = testString.containsIgnoreCase(query);

        // Assert
        expect(result, isTrue);
      });

      test('should handle query at the end of string', () {
        // Arrange
        const String testString = 'Hello World';
        const String query = 'WORLD';

        // Act
        final result = testString.containsIgnoreCase(query);

        // Assert
        expect(result, isTrue);
      });

      test('should handle single character search', () {
        // Arrange
        const String testString = 'Hello';
        const String query = 'E';

        // Act
        final result = testString.containsIgnoreCase(query);

        // Assert
        expect(result, isTrue);
      });

      test('should return false for single character not in string', () {
        // Arrange
        const String testString = 'Hello';
        const String query = 'Z';

        // Act
        final result = testString.containsIgnoreCase(query);

        // Assert
        expect(result, isFalse);
      });
    });
  });
}
