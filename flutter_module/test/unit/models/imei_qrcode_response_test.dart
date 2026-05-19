import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/imei_validator/resources/imei_qrcode_response.dart';

void main() {
  group('ImeiQrcodeResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'imei1': '123456789012345',
          'imei2': '543210987654321',
          'awb_number': 'AWB-2024-001',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.imei1, '123456789012345');
        expect(response.imei2, '543210987654321');
        expect(response.awbNumber, 'AWB-2024-001');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.imei1, isNull);
        expect(response.imei2, isNull);
        expect(response.awbNumber, isNull);
      });

      test('should handle partial fields - only imei1', () {
        // Arrange
        final json = {
          'imei1': '111111111111111',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.imei1, '111111111111111');
        expect(response.imei2, isNull);
        expect(response.awbNumber, isNull);
      });

      test('should handle partial fields - only imei2', () {
        // Arrange
        final json = {
          'imei2': '222222222222222',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.imei1, isNull);
        expect(response.imei2, '222222222222222');
        expect(response.awbNumber, isNull);
      });

      test('should handle partial fields - only awb_number', () {
        // Arrange
        final json = {
          'awb_number': 'AWB-PARTIAL',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.imei1, isNull);
        expect(response.imei2, isNull);
        expect(response.awbNumber, 'AWB-PARTIAL');
      });

      test('should handle single SIM device (only imei1)', () {
        // Arrange
        final json = {
          'imei1': '123456789012345',
          'imei2': null,
          'awb_number': 'AWB-SINGLE-SIM',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.imei1, '123456789012345');
        expect(response.imei2, isNull);
        expect(response.awbNumber, 'AWB-SINGLE-SIM');
      });

      test('should handle dual SIM device', () {
        // Arrange
        final json = {
          'imei1': '111111111111111',
          'imei2': '222222222222222',
          'awb_number': 'AWB-DUAL-SIM',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.imei1, '111111111111111');
        expect(response.imei2, '222222222222222');
        expect(response.awbNumber, 'AWB-DUAL-SIM');
      });

      test('should handle explicit null values', () {
        // Arrange
        final json = {
          'imei1': null,
          'imei2': null,
          'awb_number': null,
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.imei1, isNull);
        expect(response.imei2, isNull);
        expect(response.awbNumber, isNull);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          'imei1': '123456789012345',
          'imei2': '543210987654321',
          'awb_number': 'AWB-SERIALIZE',
        };
        final response = ImeiQrcodeResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['imei1'], '123456789012345');
        expect(serialized['imei2'], '543210987654321');
        expect(serialized['awb_number'], 'AWB-SERIALIZE');
      });

      test('should serialize null fields correctly', () {
        // Arrange
        final response = ImeiQrcodeResponse.fromJson(<String, dynamic>{});

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['imei1'], isNull);
        expect(serialized['imei2'], isNull);
        expect(serialized['awb_number'], isNull);
      });

      test('should serialize partial data correctly', () {
        // Arrange
        final json = {
          'imei1': 'IMEI-ONLY',
        };
        final response = ImeiQrcodeResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['imei1'], 'IMEI-ONLY');
        expect(serialized['imei2'], isNull);
        expect(serialized['awb_number'], isNull);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle with all fields',
          () {
        // Arrange
        final originalJson = {
          'imei1': '999888777666555',
          'imei2': '111222333444555',
          'awb_number': 'AWB-ROUNDTRIP-001',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(originalJson);
        final serializedJson = response.toJson();
        final deserializedResponse =
            ImeiQrcodeResponse.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.imei1, response.imei1);
        expect(deserializedResponse.imei2, response.imei2);
        expect(deserializedResponse.awbNumber, response.awbNumber);
      });

      test('should handle roundtrip with null fields', () {
        // Arrange
        final originalJson = <String, dynamic>{};

        // Act
        final response = ImeiQrcodeResponse.fromJson(originalJson);
        final serializedJson = response.toJson();
        final deserializedResponse =
            ImeiQrcodeResponse.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.imei1, isNull);
        expect(deserializedResponse.imei2, isNull);
        expect(deserializedResponse.awbNumber, isNull);
      });

      test('should handle roundtrip with partial fields', () {
        // Arrange
        final originalJson = {
          'imei1': 'PARTIAL-IMEI',
          'awb_number': 'PARTIAL-AWB',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(originalJson);
        final serializedJson = response.toJson();
        final deserializedResponse =
            ImeiQrcodeResponse.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.imei1, 'PARTIAL-IMEI');
        expect(deserializedResponse.imei2, isNull);
        expect(deserializedResponse.awbNumber, 'PARTIAL-AWB');
      });
    });

    group('edge cases', () {
      test('should handle standard 15-digit IMEI', () {
        // Arrange
        final json = {
          'imei1': '123456789012345',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.imei1, '123456789012345');
        expect(response.imei1!.length, 15);
      });

      test('should handle very long IMEI values (non-standard)', () {
        // Arrange
        final json = {
          'imei1': '12345678901234567890',
          'imei2': '09876543210987654321',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.imei1, '12345678901234567890');
        expect(response.imei2, '09876543210987654321');
      });

      test('should handle short IMEI values', () {
        // Arrange
        final json = {
          'imei1': '12345',
          'imei2': '67890',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.imei1, '12345');
        expect(response.imei2, '67890');
      });

      test('should handle empty string values', () {
        // Arrange
        final json = {
          'imei1': '',
          'imei2': '',
          'awb_number': '',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.imei1, '');
        expect(response.imei2, '');
        expect(response.awbNumber, '');
      });

      test('should handle AWB number with different formats', () {
        // Arrange
        final formats = [
          'AWB123456789',
          'AWB-2024-001',
          'AWB_NUMBER_123',
          '1234567890',
          'DELHYD123456',
        ];

        for (final awbFormat in formats) {
          final json = {'awb_number': awbFormat};

          // Act
          final response = ImeiQrcodeResponse.fromJson(json);

          // Assert
          expect(response.awbNumber, awbFormat);
        }
      });

      test('should handle special characters in AWB number', () {
        // Arrange
        final json = {
          'awb_number': 'AWB-123/456@789',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.awbNumber, 'AWB-123/456@789');
      });

      test('should handle whitespace in strings', () {
        // Arrange
        final json = {
          'imei1': '  123456789012345  ',
          'awb_number': '  AWB-WHITESPACE  ',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.imei1, '  123456789012345  ');
        expect(response.awbNumber, '  AWB-WHITESPACE  ');
      });

      test('should handle IMEI with alphanumeric characters (non-standard)', () {
        // Arrange
        final json = {
          'imei1': 'IMEI123ABC456',
          'imei2': 'XYZ987654321',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.imei1, 'IMEI123ABC456');
        expect(response.imei2, 'XYZ987654321');
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'awb_number': 'AWB-运单号-001',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.awbNumber, 'AWB-运单号-001');
      });

      test('should handle newlines and tabs in strings', () {
        // Arrange
        final json = {
          'awb_number': 'AWB\n123\t456',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.awbNumber, 'AWB\n123\t456');
      });
    });

    group('typical usage scenarios', () {
      test('should represent QR code scan result for single SIM phone', () {
        // Arrange
        final json = {
          'imei1': '356789012345678',
          'imei2': null,
          'awb_number': 'BLRDEL123456789',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.imei1, isNotNull);
        expect(response.imei2, isNull);
        expect(response.awbNumber, isNotNull);
      });

      test('should represent QR code scan result for dual SIM phone', () {
        // Arrange
        final json = {
          'imei1': '356789012345678',
          'imei2': '867890123456789',
          'awb_number': 'MUMBAI2024001',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.imei1, isNotNull);
        expect(response.imei2, isNotNull);
        expect(response.awbNumber, isNotNull);
      });

      test('should represent IMEI validation without AWB', () {
        // Arrange
        final json = {
          'imei1': '123456789012345',
          'imei2': '543210987654321',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.imei1, '123456789012345');
        expect(response.imei2, '543210987654321');
        expect(response.awbNumber, isNull);
      });

      test('should represent AWB lookup without device IMEI', () {
        // Arrange
        final json = {
          'awb_number': 'AWB-LOOKUP-2024',
        };

        // Act
        final response = ImeiQrcodeResponse.fromJson(json);

        // Assert
        expect(response.imei1, isNull);
        expect(response.imei2, isNull);
        expect(response.awbNumber, 'AWB-LOOKUP-2024');
      });
    });

    group('JSON key naming', () {
      test('should use correct JSON key names', () {
        // Arrange
        final json = {
          'imei1': 'TEST_IMEI1',
          'imei2': 'TEST_IMEI2',
          'awb_number': 'TEST_AWB',
        };
        final response = ImeiQrcodeResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert - verify key names are preserved
        expect(serialized.containsKey('imei1'), true);
        expect(serialized.containsKey('imei2'), true);
        expect(serialized.containsKey('awb_number'), true);
      });
    });
  });
}
