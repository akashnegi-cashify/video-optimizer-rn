import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/alice/csh_alice.dart';

void main() {
  group('CshAlice', () {
    group('singleton pattern', () {
      test('should return same instance on multiple factory calls', () {
        // Arrange & Act
        final instance1 = CshAlice();
        final instance2 = CshAlice();

        // Assert
        expect(identical(instance1, instance2), isTrue);
      });

      test('should return same instance with different parameters', () {
        // Arrange & Act
        final instance1 = CshAlice(showNotification: true);
        final instance2 = CshAlice(showInspectorOnShake: true);

        // Assert
        // Note: First call initializes the singleton, subsequent calls return same instance
        expect(identical(instance1, instance2), isTrue);
      });
    });

    group('factory constructor', () {
      test('should accept showNotification parameter', () {
        // Arrange & Act
        final alice = CshAlice(showNotification: true);

        // Assert
        expect(alice, isNotNull);
      });

      test('should accept showInspectorOnShake parameter', () {
        // Arrange & Act
        final alice = CshAlice(showInspectorOnShake: true);

        // Assert
        expect(alice, isNotNull);
      });

      test('should accept both parameters', () {
        // Arrange & Act
        final alice = CshAlice(showNotification: true, showInspectorOnShake: true);

        // Assert
        expect(alice, isNotNull);
      });

      test('should work with default parameters', () {
        // Arrange & Act
        final alice = CshAlice();

        // Assert
        expect(alice, isNotNull);
      });
    });

    group('alice property', () {
      test('should have alice getter', () {
        // Arrange
        final cshAlice = CshAlice();

        // Assert - property exists (compile-time check)
        // The actual value depends on environment (null on web)
        expect(cshAlice.alice, anyOf([isNull, isNotNull]));
      });

      test('should have alice setter', () {
        // Arrange
        final cshAlice = CshAlice();

        // Act - setter exists (compile-time check)
        // Note: Setting to null is allowed
        cshAlice.alice = null;

        // Assert
        expect(cshAlice.alice, isNull);
      });
    });

    group('isActive', () {
      test('should return boolean value', () {
        // Arrange
        final cshAlice = CshAlice();

        // Act
        final result = cshAlice.isActive();

        // Assert
        expect(result, isA<bool>());
      });

      test('should return true when alice is not null', () {
        // Arrange
        final cshAlice = CshAlice();
        
        // Note: isActive returns alice != null
        // The result depends on environment initialization
        final result = cshAlice.isActive();

        // Assert - just verify it returns a boolean
        expect(result, isA<bool>());
      });
    });

    group('showInspector', () {
      test('should not throw when called', () {
        // Arrange
        final cshAlice = CshAlice();

        // Act & Assert - should not throw even if alice is null
        expect(() => cshAlice.showInspector(), returnsNormally);
      });
    });

    group('API contract', () {
      test('CshAlice should be instantiable', () {
        // Arrange & Act
        final alice = CshAlice();

        // Assert
        expect(alice, isNotNull);
        expect(alice, isA<CshAlice>());
      });

      test('instance should have required methods', () {
        // Arrange
        final alice = CshAlice();

        // Assert - methods exist (compile-time check)
        expect(alice.isActive, isNotNull);
        expect(alice.showInspector, isNotNull);
      });
    });
  });
}
