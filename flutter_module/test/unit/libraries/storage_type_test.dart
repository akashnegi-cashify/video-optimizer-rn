import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/get_storage/storage_type.dart';

void main() {
  group('StorageType', () {
    group('enum values', () {
      test('should have appStorage with value "GetStorage"', () {
        // Arrange & Act
        final storageType = StorageType.appStorage;

        // Assert
        expect(storageType.value, equals('GetStorage'));
      });

      test('should have qcStorage with value "QcStorage"', () {
        // Arrange & Act
        final storageType = StorageType.qcStorage;

        // Assert
        expect(storageType.value, equals('QcStorage'));
      });
    });

    group('enum count', () {
      test('should have exactly 2 storage types', () {
        // Assert
        expect(StorageType.values.length, equals(2));
      });

      test('should contain all expected values', () {
        // Assert
        expect(
          StorageType.values,
          containsAll([StorageType.appStorage, StorageType.qcStorage]),
        );
      });
    });

    group('value uniqueness', () {
      test('should have unique values for each storage type', () {
        // Arrange
        final values = StorageType.values.map((e) => e.value).toList();

        // Assert
        expect(values.toSet().length, equals(values.length));
      });
    });

    group('enum name', () {
      test('appStorage should have correct name', () {
        expect(StorageType.appStorage.name, equals('appStorage'));
      });

      test('qcStorage should have correct name', () {
        expect(StorageType.qcStorage.name, equals('qcStorage'));
      });
    });
  });
}
