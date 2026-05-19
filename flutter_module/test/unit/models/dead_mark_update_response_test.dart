import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dead_repair/resources/dead_mark_update_response.dart';

void main() {
  group('DeadMarkUpdateResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'mr': 'Device marked as dead successfully',
          'qr_code': 'QR-DEAD-12345',
          'id': 123,
        };

        // Act
        final response = DeadMarkUpdateResponse.fromJson(json);

        // Assert
        expect(response.markResponse, 'Device marked as dead successfully');
        expect(response.qrCode, 'QR-DEAD-12345');
        expect(response.id, 123);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = DeadMarkUpdateResponse.fromJson(json);

        // Assert
        expect(response.markResponse, isNull);
        expect(response.qrCode, isNull);
        expect(response.id, isNull);
      });

      test('should handle partial fields - only markResponse', () {
        // Arrange
        final json = {
          'mr': 'Partial response',
        };

        // Act
        final response = DeadMarkUpdateResponse.fromJson(json);

        // Assert
        expect(response.markResponse, 'Partial response');
        expect(response.qrCode, isNull);
        expect(response.id, isNull);
      });

      test('should handle partial fields - only qrCode', () {
        // Arrange
        final json = {
          'qr_code': 'QR-ONLY',
        };

        // Act
        final response = DeadMarkUpdateResponse.fromJson(json);

        // Assert
        expect(response.markResponse, isNull);
        expect(response.qrCode, 'QR-ONLY');
        expect(response.id, isNull);
      });

      test('should handle partial fields - only id', () {
        // Arrange
        final json = {
          'id': 456,
        };

        // Act
        final response = DeadMarkUpdateResponse.fromJson(json);

        // Assert
        expect(response.markResponse, isNull);
        expect(response.qrCode, isNull);
        expect(response.id, 456);
      });

      test('should handle zero id', () {
        // Arrange
        final json = {
          'id': 0,
        };

        // Act
        final response = DeadMarkUpdateResponse.fromJson(json);

        // Assert
        expect(response.id, 0);
      });

      test('should handle empty string values', () {
        // Arrange
        final json = {
          'mr': '',
          'qr_code': '',
        };

        // Act
        final response = DeadMarkUpdateResponse.fromJson(json);

        // Assert
        expect(response.markResponse, '');
        expect(response.qrCode, '');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = DeadMarkUpdateResponse(
          markResponse: 'Marked successfully',
          qrCode: 'QR-SERIALIZE',
          id: 789,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['mr'], 'Marked successfully');
        expect(json['qr_code'], 'QR-SERIALIZE');
        expect(json['id'], 789);
      });

      test('should serialize null fields correctly', () {
        // Arrange
        final response = DeadMarkUpdateResponse();

        // Act
        final json = response.toJson();

        // Assert
        expect(json['mr'], isNull);
        expect(json['qr_code'], isNull);
        expect(json['id'], isNull);
      });

      test('should serialize only markResponse', () {
        // Arrange
        final response = DeadMarkUpdateResponse(
          markResponse: 'Only mark response',
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['mr'], 'Only mark response');
        expect(json['qr_code'], isNull);
        expect(json['id'], isNull);
      });

      test('should serialize empty string values', () {
        // Arrange
        final response = DeadMarkUpdateResponse(
          markResponse: '',
          qrCode: '',
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['mr'], '');
        expect(json['qr_code'], '');
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final response = DeadMarkUpdateResponse(
          markResponse: 'Constructor test',
          qrCode: 'QR-CONSTRUCTOR',
          id: 999,
        );

        // Assert
        expect(response.markResponse, 'Constructor test');
        expect(response.qrCode, 'QR-CONSTRUCTOR');
        expect(response.id, 999);
      });

      test('should create instance with no parameters', () {
        // Act
        final response = DeadMarkUpdateResponse();

        // Assert
        expect(response.markResponse, isNull);
        expect(response.qrCode, isNull);
        expect(response.id, isNull);
      });

      test('should create instance with named parameters', () {
        // Act
        final response = DeadMarkUpdateResponse(
          id: 100,
          markResponse: 'Named param test',
        );

        // Assert
        expect(response.markResponse, 'Named param test');
        expect(response.qrCode, isNull);
        expect(response.id, 100);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle with all fields', () {
        // Arrange
        final originalJson = {
          'mr': 'Roundtrip message',
          'qr_code': 'QR-ROUNDTRIP',
          'id': 555,
        };

        // Act
        final response = DeadMarkUpdateResponse.fromJson(originalJson);
        final serializedJson = response.toJson();
        final deserializedResponse = DeadMarkUpdateResponse.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.markResponse, response.markResponse);
        expect(deserializedResponse.qrCode, response.qrCode);
        expect(deserializedResponse.id, response.id);
      });

      test('should maintain data through roundtrip with partial fields', () {
        // Arrange
        final originalJson = {
          'mr': 'Partial roundtrip',
        };

        // Act
        final response = DeadMarkUpdateResponse.fromJson(originalJson);
        final serializedJson = response.toJson();
        final deserializedResponse = DeadMarkUpdateResponse.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.markResponse, 'Partial roundtrip');
        expect(deserializedResponse.qrCode, isNull);
        expect(deserializedResponse.id, isNull);
      });

      test('should handle roundtrip from constructor', () {
        // Arrange
        final original = DeadMarkUpdateResponse(
          markResponse: 'From constructor',
          qrCode: 'QR-FROM-CTOR',
          id: 777,
        );

        // Act
        final json = original.toJson();
        final restored = DeadMarkUpdateResponse.fromJson(json);

        // Assert
        expect(restored.markResponse, original.markResponse);
        expect(restored.qrCode, original.qrCode);
        expect(restored.id, original.id);
      });

      test('should handle roundtrip with empty JSON', () {
        // Arrange
        final originalJson = <String, dynamic>{};

        // Act
        final response = DeadMarkUpdateResponse.fromJson(originalJson);
        final serializedJson = response.toJson();
        final deserializedResponse = DeadMarkUpdateResponse.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.markResponse, isNull);
        expect(deserializedResponse.qrCode, isNull);
        expect(deserializedResponse.id, isNull);
      });
    });

    group('edge cases', () {
      test('should handle very large id', () {
        // Arrange
        final json = {
          'id': 9999999999,
        };

        // Act
        final response = DeadMarkUpdateResponse.fromJson(json);

        // Assert
        expect(response.id, 9999999999);
      });

      test('should handle negative id', () {
        // Arrange
        final json = {
          'id': -1,
        };

        // Act
        final response = DeadMarkUpdateResponse.fromJson(json);

        // Assert
        expect(response.id, -1);
      });

      test('should handle special characters in strings', () {
        // Arrange
        final json = {
          'mr': 'Message with !@#\$%^&*() special chars',
          'qr_code': 'QR-!@#\$%^&*()',
        };

        // Act
        final response = DeadMarkUpdateResponse.fromJson(json);

        // Assert
        expect(response.markResponse, 'Message with !@#\$%^&*() special chars');
        expect(response.qrCode, 'QR-!@#\$%^&*()');
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'mr': '设备标记为死机',
          'qr_code': 'QR-日本語',
        };

        // Act
        final response = DeadMarkUpdateResponse.fromJson(json);

        // Assert
        expect(response.markResponse, '设备标记为死机');
        expect(response.qrCode, 'QR-日本語');
      });

      test('should handle long string values', () {
        // Arrange
        final longString = 'A' * 1000;
        final json = {
          'mr': longString,
          'qr_code': longString,
        };

        // Act
        final response = DeadMarkUpdateResponse.fromJson(json);

        // Assert
        expect(response.markResponse!.length, 1000);
        expect(response.qrCode!.length, 1000);
      });

      test('should handle whitespace in strings', () {
        // Arrange
        final json = {
          'mr': '  Message with spaces  ',
          'qr_code': '\tQR\nCode\t',
        };

        // Act
        final response = DeadMarkUpdateResponse.fromJson(json);

        // Assert
        expect(response.markResponse, '  Message with spaces  ');
        expect(response.qrCode, '\tQR\nCode\t');
      });

      test('should handle newlines in markResponse', () {
        // Arrange
        final json = {
          'mr': 'Line 1\nLine 2\nLine 3',
        };

        // Act
        final response = DeadMarkUpdateResponse.fromJson(json);

        // Assert
        expect(response.markResponse, 'Line 1\nLine 2\nLine 3');
      });
    });

    group('typical usage scenarios', () {
      test('should represent successful dead mark', () {
        // Arrange
        final json = {
          'mr': 'Device successfully marked as dead',
          'qr_code': 'DEV-2024-DEAD-001',
          'id': 12345,
        };

        // Act
        final response = DeadMarkUpdateResponse.fromJson(json);

        // Assert
        expect(response.markResponse, 'Device successfully marked as dead');
        expect(response.qrCode, 'DEV-2024-DEAD-001');
        expect(response.id, 12345);
      });

      test('should represent dead mark update', () {
        // Arrange
        final json = {
          'mr': 'Dead status updated',
          'qr_code': 'DEV-UPDATE-001',
          'id': 67890,
        };

        // Act
        final response = DeadMarkUpdateResponse.fromJson(json);

        // Assert
        expect(response.markResponse, 'Dead status updated');
        expect(response.id, 67890);
      });

      test('should represent error response', () {
        // Arrange
        final json = {
          'mr': 'Error: Device not found',
          'qr_code': 'INVALID-QR',
        };

        // Act
        final response = DeadMarkUpdateResponse.fromJson(json);

        // Assert
        expect(response.markResponse, 'Error: Device not found');
        expect(response.qrCode, 'INVALID-QR');
        expect(response.id, isNull);
      });

      test('should represent response with only id for update', () {
        // Arrange
        final json = {
          'id': 11111,
        };

        // Act
        final response = DeadMarkUpdateResponse.fromJson(json);

        // Assert
        expect(response.id, 11111);
        expect(response.markResponse, isNull);
        expect(response.qrCode, isNull);
      });
    });
  });
}
