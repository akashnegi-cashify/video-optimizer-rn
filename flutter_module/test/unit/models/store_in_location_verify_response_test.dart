import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_in/resources/store_in_location_verify_response.dart';

/// Tests for StoreInLocationVerifyResponse model.
/// Focus: Testing multi-format handling (QC vs TRC) and boolean-to-int conversion.
void main() {
  group('StoreInLocationVerifyResponse', () {
    group('fromJson - QC format', () {
      test('should parse QC format with standard field names', () {
        // Arrange
        final json = {
          'verifyBarcodeStatus': 1,
          'availableCapacity': 50,
          'totalCapacity': 100,
          'message': 'Location verified successfully',
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.verifyBarcodeStatus, 1);
        expect(response.availableSpace, 50);
        expect(response.totalSpace, 100);
        expect(response.message, 'Location verified successfully');
      });

      test('should handle null fields in QC format', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.verifyBarcodeStatus, null);
        expect(response.availableSpace, null);
        expect(response.totalSpace, null);
        expect(response.message, null);
        expect(response.requestId, null);
      });

      test('should handle zero status', () {
        // Arrange
        final json = {
          'verifyBarcodeStatus': 0,
          'availableCapacity': 0,
          'totalCapacity': 0,
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.verifyBarcodeStatus, 0);
        expect(response.availableSpace, 0);
        expect(response.totalSpace, 0);
      });
    });

    group('fromJson - TRC format', () {
      test('should parse TRC format with dt wrapper', () {
        // Arrange
        final json = {
          's': true,
          'dt': {
            'r_id': 'req-123-456',
            's': 1,
            'ac': 75,
            'tc': 150,
            'message': 'TRC location verified',
          },
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.requestId, 'req-123-456');
        expect(response.verifyBarcodeStatus, 1);
        expect(response.availableSpace, 75);
        expect(response.totalSpace, 150);
        expect(response.message, 'TRC location verified');
      });

      test('should convert boolean true status to int 1', () {
        // Arrange
        final json = {
          'dt': {
            's': true,
            'ac': 10,
            'tc': 20,
          },
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.verifyBarcodeStatus, 1);
      });

      test('should convert boolean false status to int 0', () {
        // Arrange
        final json = {
          'dt': {
            's': false,
            'ac': 0,
            'tc': 50,
          },
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.verifyBarcodeStatus, 0);
      });

      test('should handle int status directly', () {
        // Arrange
        final json = {
          'dt': {
            's': 2,
            'ac': 100,
            'tc': 200,
          },
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.verifyBarcodeStatus, 2);
      });

      test('should handle null fields in TRC format', () {
        // Arrange
        final json = {
          'dt': <String, dynamic>{},
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.requestId, null);
        expect(response.verifyBarcodeStatus, 0); // false converted to 0
        expect(response.availableSpace, null);
        expect(response.totalSpace, null);
      });

      test('should handle numeric values as doubles', () {
        // Arrange
        final json = {
          'dt': {
            's': 1,
            'ac': 50.0,
            'tc': 100.5,
          },
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.availableSpace, 50);
        expect(response.totalSpace, 100);
      });
    });

    group('format detection', () {
      test('should detect TRC format when dt is a Map', () {
        // Arrange
        final json = {
          'dt': {
            's': 1,
            'ac': 25,
            'tc': 50,
          },
          'availableCapacity': 999, // Should be ignored
          'totalCapacity': 999, // Should be ignored
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.availableSpace, 25);
        expect(response.totalSpace, 50);
      });

      test('should fall back to QC format when dt is not a Map', () {
        // Arrange
        final json = {
          'dt': 'not a map',
          'availableCapacity': 30,
          'totalCapacity': 60,
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.availableSpace, 30);
        expect(response.totalSpace, 60);
      });

      test('should use QC format when dt key is missing', () {
        // Arrange
        final json = {
          'verifyBarcodeStatus': 1,
          'availableCapacity': 40,
          'totalCapacity': 80,
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.availableSpace, 40);
        expect(response.totalSpace, 80);
      });
    });

    group('constructor', () {
      test('should create instance with all named parameters', () {
        // Arrange & Act
        final response = StoreInLocationVerifyResponse(
          availableSpace: 100,
          totalSpace: 200,
          verifyBarcodeStatus: 1,
          message: 'Test message',
          requestId: 'req-abc-123',
        );

        // Assert
        expect(response.availableSpace, 100);
        expect(response.totalSpace, 200);
        expect(response.verifyBarcodeStatus, 1);
        expect(response.message, 'Test message');
        expect(response.requestId, 'req-abc-123');
      });

      test('should create instance with null parameters', () {
        // Arrange & Act
        final response = StoreInLocationVerifyResponse();

        // Assert
        expect(response.availableSpace, null);
        expect(response.totalSpace, null);
        expect(response.verifyBarcodeStatus, null);
        expect(response.message, null);
        expect(response.requestId, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = StoreInLocationVerifyResponse(
          availableSpace: 50,
          totalSpace: 100,
          verifyBarcodeStatus: 1,
          message: 'Success',
          requestId: 'req-123',
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['availableCapacity'], 50);
        expect(json['totalCapacity'], 100);
        expect(json['verifyBarcodeStatus'], 1);
        expect(json['message'], 'Success');
        expect(json['r_id'], 'req-123');
      });

      test('should handle null fields in serialization', () {
        // Arrange
        final response = StoreInLocationVerifyResponse();

        // Act
        final json = response.toJson();

        // Assert
        expect(json['availableCapacity'], null);
        expect(json['totalCapacity'], null);
        expect(json['verifyBarcodeStatus'], null);
      });
    });

    group('edge cases', () {
      test('should handle very large capacity values', () {
        // Arrange
        final json = {
          'dt': {
            's': 1,
            'ac': 999999999,
            'tc': 9999999999,
          },
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.availableSpace, 999999999);
        expect(response.totalSpace, 9999999999);
      });

      test('should handle negative capacity values', () {
        // Arrange
        final json = {
          'availableCapacity': -10,
          'totalCapacity': -20,
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.availableSpace, -10);
        expect(response.totalSpace, -20);
      });

      test('should handle empty message', () {
        // Arrange
        final json = {
          'dt': {
            'message': '',
          },
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.message, '');
      });

      test('should handle unicode in message', () {
        // Arrange
        final json = {
          'dt': {
            'message': 'Location verified ✓ 日本語メッセージ',
          },
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.message, 'Location verified ✓ 日本語メッセージ');
      });

      test('should handle request ID with special characters', () {
        // Arrange
        final json = {
          'dt': {
            'r_id': 'req-123-abc-XYZ_456',
          },
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.requestId, 'req-123-abc-XYZ_456');
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle for QC format', () {
        // Arrange
        final originalJson = {
          'availableCapacity': 75,
          'totalCapacity': 150,
          'verifyBarcodeStatus': 1,
          'message': 'Test message',
          'r_id': 'req-test-123',
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['availableCapacity'], 75);
        expect(serializedJson['totalCapacity'], 150);
        expect(serializedJson['verifyBarcodeStatus'], 1);
        expect(serializedJson['message'], 'Test message');
        expect(serializedJson['r_id'], 'req-test-123');
      });

      test('should convert TRC format to QC format in serialization', () {
        // Arrange
        final trcJson = {
          'dt': {
            'r_id': 'trc-req-456',
            's': true,
            'ac': 60,
            'tc': 120,
          },
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(trcJson);
        final serialized = response.toJson();

        // Assert - should serialize to QC format
        expect(serialized['availableCapacity'], 60);
        expect(serialized['totalCapacity'], 120);
        expect(serialized['verifyBarcodeStatus'], 1);
        expect(serialized['r_id'], 'trc-req-456');
      });
    });

    group('boolean to int conversion logic', () {
      test('should convert true to 1', () {
        // Arrange
        final json = {
          'dt': {'s': true},
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.verifyBarcodeStatus, 1);
      });

      test('should convert false to 0', () {
        // Arrange
        final json = {
          'dt': {'s': false},
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.verifyBarcodeStatus, 0);
      });

      test('should preserve int values as-is', () {
        // Arrange
        final json = {
          'dt': {'s': 5},
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        expect(response.verifyBarcodeStatus, 5);
      });

      test('should convert null status with false default to 0', () {
        // Arrange
        final json = {
          'dt': {'s': null},
        };

        // Act
        final response = StoreInLocationVerifyResponse.fromJson(json);

        // Assert
        // null is neither int nor true, so it becomes (null == true ? 1 : 0) = 0
        expect(response.verifyBarcodeStatus, 0);
      });
    });
  });

  group('VerifyBarcode', () {
    group('fromJson', () {
      test('should parse qrCode correctly', () {
        // Arrange
        final json = {
          'qrCode': 'QR123456789',
        };

        // Act
        final verifyBarcode = VerifyBarcode.fromJson(json);

        // Assert
        expect(verifyBarcode.qrCode, 'QR123456789');
      });

      test('should handle null qrCode', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final verifyBarcode = VerifyBarcode.fromJson(json);

        // Assert
        expect(verifyBarcode.qrCode, null);
      });
    });

    group('constructor', () {
      test('should create instance with qrCode', () {
        // Arrange & Act
        final verifyBarcode = VerifyBarcode(qrCode: 'TEST-QR-CODE');

        // Assert
        expect(verifyBarcode.qrCode, 'TEST-QR-CODE');
      });

      test('should create instance with null qrCode', () {
        // Arrange & Act
        final verifyBarcode = VerifyBarcode();

        // Assert
        expect(verifyBarcode.qrCode, null);
      });
    });

    group('toJson', () {
      test('should serialize qrCode correctly', () {
        // Arrange
        final verifyBarcode = VerifyBarcode(qrCode: 'QR-SERIALIZE-TEST');

        // Act
        final json = verifyBarcode.toJson();

        // Assert
        expect(json['qrCode'], 'QR-SERIALIZE-TEST');
      });

      test('should handle null qrCode in serialization', () {
        // Arrange
        final verifyBarcode = VerifyBarcode();

        // Act
        final json = verifyBarcode.toJson();

        // Assert
        expect(json['qrCode'], null);
      });
    });
  });
}
