import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dead_repair/resources/add_remove_part_request.dart';

void main() {
  group('AddRemovePartRequest', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'sku': 'SKU-SCREEN-12345',
          'id': 123,
        };

        // Act
        final request = AddRemovePartRequest.fromJson(json);

        // Assert
        expect(request.sku, 'SKU-SCREEN-12345');
        expect(request.id, 123);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final request = AddRemovePartRequest.fromJson(json);

        // Assert
        expect(request.sku, isNull);
        expect(request.id, isNull);
      });

      test('should handle partial fields - only sku', () {
        // Arrange
        final json = {
          'sku': 'SKU-ONLY',
        };

        // Act
        final request = AddRemovePartRequest.fromJson(json);

        // Assert
        expect(request.sku, 'SKU-ONLY');
        expect(request.id, isNull);
      });

      test('should handle partial fields - only id', () {
        // Arrange
        final json = {
          'id': 456,
        };

        // Act
        final request = AddRemovePartRequest.fromJson(json);

        // Assert
        expect(request.sku, isNull);
        expect(request.id, 456);
      });

      test('should handle zero id', () {
        // Arrange
        final json = {
          'id': 0,
        };

        // Act
        final request = AddRemovePartRequest.fromJson(json);

        // Assert
        expect(request.id, 0);
      });

      test('should handle empty string sku', () {
        // Arrange
        final json = {
          'sku': '',
        };

        // Act
        final request = AddRemovePartRequest.fromJson(json);

        // Assert
        expect(request.sku, '');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final request = AddRemovePartRequest(
          sku: 'SKU-SERIALIZE',
          id: 789,
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['sku'], 'SKU-SERIALIZE');
        expect(json['id'], 789);
      });

      test('should serialize null fields correctly', () {
        // Arrange
        final request = AddRemovePartRequest();

        // Act
        final json = request.toJson();

        // Assert
        expect(json['sku'], isNull);
        expect(json['id'], isNull);
      });

      test('should serialize only sku', () {
        // Arrange
        final request = AddRemovePartRequest(
          sku: 'ONLY-SKU',
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['sku'], 'ONLY-SKU');
        expect(json['id'], isNull);
      });

      test('should serialize only id', () {
        // Arrange
        final request = AddRemovePartRequest(
          id: 999,
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['sku'], isNull);
        expect(json['id'], 999);
      });

      test('should serialize empty string sku', () {
        // Arrange
        final request = AddRemovePartRequest(
          sku: '',
          id: 100,
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['sku'], '');
        expect(json['id'], 100);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final request = AddRemovePartRequest(
          sku: 'CTOR-SKU',
          id: 111,
        );

        // Assert
        expect(request.sku, 'CTOR-SKU');
        expect(request.id, 111);
      });

      test('should create instance with no parameters', () {
        // Act
        final request = AddRemovePartRequest();

        // Assert
        expect(request.sku, isNull);
        expect(request.id, isNull);
      });

      test('should create instance with only sku', () {
        // Act
        final request = AddRemovePartRequest(sku: 'SKU-ONLY');

        // Assert
        expect(request.sku, 'SKU-ONLY');
        expect(request.id, isNull);
      });

      test('should create instance with only id', () {
        // Act
        final request = AddRemovePartRequest(id: 222);

        // Assert
        expect(request.sku, isNull);
        expect(request.id, 222);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle with all fields', () {
        // Arrange
        final originalJson = {
          'sku': 'RT-SKU-123',
          'id': 333,
        };

        // Act
        final request = AddRemovePartRequest.fromJson(originalJson);
        final serializedJson = request.toJson();
        final deserializedRequest = AddRemovePartRequest.fromJson(serializedJson);

        // Assert
        expect(deserializedRequest.sku, request.sku);
        expect(deserializedRequest.id, request.id);
      });

      test('should maintain data through roundtrip with partial fields', () {
        // Arrange
        final originalJson = {
          'sku': 'PARTIAL-SKU',
        };

        // Act
        final request = AddRemovePartRequest.fromJson(originalJson);
        final serializedJson = request.toJson();
        final deserializedRequest = AddRemovePartRequest.fromJson(serializedJson);

        // Assert
        expect(deserializedRequest.sku, 'PARTIAL-SKU');
        expect(deserializedRequest.id, isNull);
      });

      test('should handle roundtrip from constructor', () {
        // Arrange
        final original = AddRemovePartRequest(
          sku: 'FROM-CTOR-SKU',
          id: 444,
        );

        // Act
        final json = original.toJson();
        final restored = AddRemovePartRequest.fromJson(json);

        // Assert
        expect(restored.sku, original.sku);
        expect(restored.id, original.id);
      });

      test('should handle roundtrip with empty JSON', () {
        // Arrange
        final originalJson = <String, dynamic>{};

        // Act
        final request = AddRemovePartRequest.fromJson(originalJson);
        final serializedJson = request.toJson();
        final deserializedRequest = AddRemovePartRequest.fromJson(serializedJson);

        // Assert
        expect(deserializedRequest.sku, isNull);
        expect(deserializedRequest.id, isNull);
      });
    });

    group('edge cases', () {
      test('should handle very large id', () {
        // Arrange
        final json = {
          'id': 9999999999,
        };

        // Act
        final request = AddRemovePartRequest.fromJson(json);

        // Assert
        expect(request.id, 9999999999);
      });

      test('should handle negative id', () {
        // Arrange
        final json = {
          'id': -1,
        };

        // Act
        final request = AddRemovePartRequest.fromJson(json);

        // Assert
        expect(request.id, -1);
      });

      test('should handle special characters in sku', () {
        // Arrange
        final json = {
          'sku': 'SKU-!@#\$%^&*()-+=',
        };

        // Act
        final request = AddRemovePartRequest.fromJson(json);

        // Assert
        expect(request.sku, 'SKU-!@#\$%^&*()-+=');
      });

      test('should handle unicode characters in sku', () {
        // Arrange
        final json = {
          'sku': 'SKU-日本語-中文',
        };

        // Act
        final request = AddRemovePartRequest.fromJson(json);

        // Assert
        expect(request.sku, 'SKU-日本語-中文');
      });

      test('should handle long sku value', () {
        // Arrange
        final longSku = 'SKU-' + 'A' * 500;
        final json = {
          'sku': longSku,
        };

        // Act
        final request = AddRemovePartRequest.fromJson(json);

        // Assert
        expect(request.sku!.length, 504);
      });

      test('should handle whitespace in sku', () {
        // Arrange
        final json = {
          'sku': '  SKU WITH SPACES  ',
        };

        // Act
        final request = AddRemovePartRequest.fromJson(json);

        // Assert
        expect(request.sku, '  SKU WITH SPACES  ');
      });

      test('should handle numeric-like sku string', () {
        // Arrange
        final json = {
          'sku': '1234567890',
        };

        // Act
        final request = AddRemovePartRequest.fromJson(json);

        // Assert
        expect(request.sku, '1234567890');
      });

      test('should handle sku with slashes and backslashes', () {
        // Arrange
        final json = {
          'sku': 'SKU/SCREEN\\PART',
        };

        // Act
        final request = AddRemovePartRequest.fromJson(json);

        // Assert
        expect(request.sku, 'SKU/SCREEN\\PART');
      });
    });

    group('typical usage scenarios', () {
      test('should create request for adding screen part', () {
        // Arrange & Act
        final request = AddRemovePartRequest(
          sku: 'SCREEN-IPHONE-14-PRO',
          id: 12345,
        );
        final json = request.toJson();

        // Assert
        expect(json['sku'], 'SCREEN-IPHONE-14-PRO');
        expect(json['id'], 12345);
      });

      test('should create request for adding battery part', () {
        // Arrange & Act
        final request = AddRemovePartRequest(
          sku: 'BATTERY-SAMSUNG-S23',
          id: 67890,
        );
        final json = request.toJson();

        // Assert
        expect(json['sku'], 'BATTERY-SAMSUNG-S23');
        expect(json['id'], 67890);
      });

      test('should create request for removing part', () {
        // Arrange & Act
        final request = AddRemovePartRequest(
          sku: 'CHARGER-PORT-PIXEL-7',
          id: 11111,
        );
        final json = request.toJson();

        // Assert
        expect(json['sku'], 'CHARGER-PORT-PIXEL-7');
        expect(json['id'], 11111);
      });

      test('should create request with only device id for part lookup', () {
        // Arrange & Act
        final request = AddRemovePartRequest(
          id: 22222,
        );
        final json = request.toJson();

        // Assert
        expect(json['id'], 22222);
        expect(json['sku'], isNull);
      });

      test('should create request with only sku for part search', () {
        // Arrange & Act
        final request = AddRemovePartRequest(
          sku: 'MOTHERBOARD-ONEPLUS-11',
        );
        final json = request.toJson();

        // Assert
        expect(json['sku'], 'MOTHERBOARD-ONEPLUS-11');
        expect(json['id'], isNull);
      });

      test('should handle typical SKU format', () {
        // Arrange
        final json = {
          'sku': 'LCD-DISPLAY-XIAOMI-13-PRO-BLACK',
          'id': 33333,
        };

        // Act
        final request = AddRemovePartRequest.fromJson(json);

        // Assert
        expect(request.sku, 'LCD-DISPLAY-XIAOMI-13-PRO-BLACK');
        expect(request.id, 33333);
      });
    });
  });
}
