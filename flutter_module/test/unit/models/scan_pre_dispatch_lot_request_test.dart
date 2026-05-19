import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/pre_dispatch/resources/scan_pre_dispatch_lot_request.dart';

void main() {
  group('ScanPreDispatchRequest', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'lotGroupName': 'LOT-GROUP-001',
          'qrCode': 'QR-DEVICE-12345',
        };

        // Act
        final request = ScanPreDispatchRequest.fromJson(json);

        // Assert
        expect(request.lotGroupName, 'LOT-GROUP-001');
        expect(request.qrCode, 'QR-DEVICE-12345');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final request = ScanPreDispatchRequest.fromJson(json);

        // Assert
        expect(request.lotGroupName, isNull);
        expect(request.qrCode, isNull);
      });

      test('should handle partial fields - only lotGroupName', () {
        // Arrange
        final json = {
          'lotGroupName': 'LOT-ONLY',
        };

        // Act
        final request = ScanPreDispatchRequest.fromJson(json);

        // Assert
        expect(request.lotGroupName, 'LOT-ONLY');
        expect(request.qrCode, isNull);
      });

      test('should handle partial fields - only qrCode', () {
        // Arrange
        final json = {
          'qrCode': 'QR-ONLY-CODE',
        };

        // Act
        final request = ScanPreDispatchRequest.fromJson(json);

        // Assert
        expect(request.lotGroupName, isNull);
        expect(request.qrCode, 'QR-ONLY-CODE');
      });

      test('should handle empty string values', () {
        // Arrange
        final json = {
          'lotGroupName': '',
          'qrCode': '',
        };

        // Act
        final request = ScanPreDispatchRequest.fromJson(json);

        // Assert
        expect(request.lotGroupName, '');
        expect(request.qrCode, '');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final request = ScanPreDispatchRequest(
          lotGroupName: 'SERIALIZE-LOT-GROUP',
          qrCode: 'SERIALIZE-QR-CODE',
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['lotGroupName'], 'SERIALIZE-LOT-GROUP');
        expect(json['qrCode'], 'SERIALIZE-QR-CODE');
      });

      test('should not include null fields due to includeIfNull false', () {
        // Arrange
        final request = ScanPreDispatchRequest();

        // Act
        final json = request.toJson();

        // Assert
        // Due to includeIfNull: false, null fields should not be present in JSON
        expect(json.containsKey('lotGroupName'), false);
        expect(json.containsKey('qrCode'), false);
      });

      test('should not include null lotGroupName', () {
        // Arrange
        final request = ScanPreDispatchRequest(
          qrCode: 'ONLY-QR',
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json.containsKey('lotGroupName'), false);
        expect(json['qrCode'], 'ONLY-QR');
      });

      test('should not include null qrCode', () {
        // Arrange
        final request = ScanPreDispatchRequest(
          lotGroupName: 'ONLY-LOT',
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['lotGroupName'], 'ONLY-LOT');
        expect(json.containsKey('qrCode'), false);
      });

      test('should include empty string values', () {
        // Arrange
        final request = ScanPreDispatchRequest(
          lotGroupName: '',
          qrCode: '',
        );

        // Act
        final json = request.toJson();

        // Assert
        // Empty strings are not null, so they should be included
        expect(json['lotGroupName'], '');
        expect(json['qrCode'], '');
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final request = ScanPreDispatchRequest(
          lotGroupName: 'CONSTRUCTOR-LOT',
          qrCode: 'CONSTRUCTOR-QR',
        );

        // Assert
        expect(request.lotGroupName, 'CONSTRUCTOR-LOT');
        expect(request.qrCode, 'CONSTRUCTOR-QR');
      });

      test('should create instance with no parameters', () {
        // Act
        final request = ScanPreDispatchRequest();

        // Assert
        expect(request.lotGroupName, isNull);
        expect(request.qrCode, isNull);
      });

      test('should create instance with only lotGroupName', () {
        // Act
        final request = ScanPreDispatchRequest(lotGroupName: 'LOT-ONLY');

        // Assert
        expect(request.lotGroupName, 'LOT-ONLY');
        expect(request.qrCode, isNull);
      });

      test('should create instance with only qrCode', () {
        // Act
        final request = ScanPreDispatchRequest(qrCode: 'QR-ONLY');

        // Assert
        expect(request.lotGroupName, isNull);
        expect(request.qrCode, 'QR-ONLY');
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle with all fields', () {
        // Arrange
        final originalJson = {
          'lotGroupName': 'ROUNDTRIP-LOT',
          'qrCode': 'ROUNDTRIP-QR',
        };

        // Act
        final request = ScanPreDispatchRequest.fromJson(originalJson);
        final serializedJson = request.toJson();

        // Assert
        expect(serializedJson['lotGroupName'], originalJson['lotGroupName']);
        expect(serializedJson['qrCode'], originalJson['qrCode']);
      });

      test('should maintain data through roundtrip with partial fields', () {
        // Arrange
        final originalJson = {
          'lotGroupName': 'PARTIAL-ROUNDTRIP',
        };

        // Act
        final request = ScanPreDispatchRequest.fromJson(originalJson);
        final serializedJson = request.toJson();

        // Assert
        expect(serializedJson['lotGroupName'], 'PARTIAL-ROUNDTRIP');
        expect(serializedJson.containsKey('qrCode'), false);
      });

      test('should handle roundtrip from constructor', () {
        // Arrange
        final original = ScanPreDispatchRequest(
          lotGroupName: 'FROM-CONSTRUCTOR',
          qrCode: 'CONSTRUCTOR-QR-CODE',
        );

        // Act
        final json = original.toJson();
        final restored = ScanPreDispatchRequest.fromJson(json);

        // Assert
        expect(restored.lotGroupName, original.lotGroupName);
        expect(restored.qrCode, original.qrCode);
      });
    });

    group('edge cases', () {
      test('should handle long string values', () {
        // Arrange
        final longLotName = 'A' * 500;
        final longQrCode = 'B' * 500;
        final json = {
          'lotGroupName': longLotName,
          'qrCode': longQrCode,
        };

        // Act
        final request = ScanPreDispatchRequest.fromJson(json);

        // Assert
        expect(request.lotGroupName!.length, 500);
        expect(request.qrCode!.length, 500);
      });

      test('should handle special characters in lotGroupName', () {
        // Arrange
        final json = {
          'lotGroupName': 'LOT-!@#\$%^&*()_+',
          'qrCode': 'QR-Code/With\\Slashes',
        };

        // Act
        final request = ScanPreDispatchRequest.fromJson(json);

        // Assert
        expect(request.lotGroupName, 'LOT-!@#\$%^&*()_+');
        expect(request.qrCode, 'QR-Code/With\\Slashes');
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'lotGroupName': 'LOT-日本語',
          'qrCode': 'QR-中文字符',
        };

        // Act
        final request = ScanPreDispatchRequest.fromJson(json);

        // Assert
        expect(request.lotGroupName, 'LOT-日本語');
        expect(request.qrCode, 'QR-中文字符');
      });

      test('should handle whitespace in strings', () {
        // Arrange
        final json = {
          'lotGroupName': '  LOT WITH SPACES  ',
          'qrCode': '\tQR\nWITH\tTABS\n',
        };

        // Act
        final request = ScanPreDispatchRequest.fromJson(json);

        // Assert
        expect(request.lotGroupName, '  LOT WITH SPACES  ');
        expect(request.qrCode, '\tQR\nWITH\tTABS\n');
      });

      test('should handle numeric-like strings', () {
        // Arrange
        final json = {
          'lotGroupName': '12345',
          'qrCode': '67890',
        };

        // Act
        final request = ScanPreDispatchRequest.fromJson(json);

        // Assert
        expect(request.lotGroupName, '12345');
        expect(request.qrCode, '67890');
      });

      test('should serialize empty strings (not null)', () {
        // Arrange
        final request = ScanPreDispatchRequest(
          lotGroupName: '',
          qrCode: '',
        );

        // Act
        final json = request.toJson();

        // Assert
        // Empty strings are included because they're not null
        expect(json['lotGroupName'], '');
        expect(json['qrCode'], '');
        expect(json.length, 2);
      });
    });

    group('typical usage scenarios', () {
      test('should create request for scanning device in lot', () {
        // Arrange & Act
        final request = ScanPreDispatchRequest(
          lotGroupName: 'PRE-DISPATCH-2024-001',
          qrCode: 'DEVICE-BC-12345678',
        );
        final json = request.toJson();

        // Assert
        expect(json['lotGroupName'], 'PRE-DISPATCH-2024-001');
        expect(json['qrCode'], 'DEVICE-BC-12345678');
      });

      test('should create request for searching lot only', () {
        // Arrange & Act
        final request = ScanPreDispatchRequest(
          lotGroupName: 'LOT-SEARCH-QUERY',
        );
        final json = request.toJson();

        // Assert
        expect(json['lotGroupName'], 'LOT-SEARCH-QUERY');
        expect(json.containsKey('qrCode'), false);
      });

      test('should create request for device lookup only', () {
        // Arrange & Act
        final request = ScanPreDispatchRequest(
          qrCode: 'DEVICE-LOOKUP-QR',
        );
        final json = request.toJson();

        // Assert
        expect(json.containsKey('lotGroupName'), false);
        expect(json['qrCode'], 'DEVICE-LOOKUP-QR');
      });
    });
  });
}
