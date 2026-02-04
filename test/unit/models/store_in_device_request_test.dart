import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_in/resources/store_in_device_request.dart';

/// Tests for StoreInDeviceRequest model.
/// Focus: Testing fromJson/toJson for store-in device request with stock and location barcodes.
void main() {
  group('StoreInDeviceRequest', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'stockBarcode': 'STK-001-ABC',
          'locBarcode': 'LOC-A1-R01',
        };

        // Act
        final request = StoreInDeviceRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, 'STK-001-ABC');
        expect(request.locBarcode, 'LOC-A1-R01');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final request = StoreInDeviceRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, null);
        expect(request.locBarcode, null);
      });

      test('should handle null stockBarcode only', () {
        // Arrange
        final json = {
          'stockBarcode': null,
          'locBarcode': 'LOC-B2-R05',
        };

        // Act
        final request = StoreInDeviceRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, null);
        expect(request.locBarcode, 'LOC-B2-R05');
      });

      test('should handle null locBarcode only', () {
        // Arrange
        final json = {
          'stockBarcode': 'STK-002-DEF',
          'locBarcode': null,
        };

        // Act
        final request = StoreInDeviceRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, 'STK-002-DEF');
        expect(request.locBarcode, null);
      });

      test('should handle explicit null values', () {
        // Arrange
        final json = <String, dynamic>{
          'stockBarcode': null,
          'locBarcode': null,
        };

        // Act
        final request = StoreInDeviceRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, null);
        expect(request.locBarcode, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final request = StoreInDeviceRequest(
          stockBarcode: 'STK-003-GHI',
          locBarcode: 'LOC-C3-R10',
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['stockBarcode'], 'STK-003-GHI');
        expect(json['locBarcode'], 'LOC-C3-R10');
      });

      test('should handle null fields in serialization', () {
        // Arrange
        final request = StoreInDeviceRequest();

        // Act
        final json = request.toJson();

        // Assert
        expect(json['stockBarcode'], null);
        expect(json['locBarcode'], null);
      });

      test('should serialize partial data with stockBarcode only', () {
        // Arrange
        final request = StoreInDeviceRequest(
          stockBarcode: 'STK-004-JKL',
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['stockBarcode'], 'STK-004-JKL');
        expect(json['locBarcode'], null);
      });

      test('should serialize partial data with locBarcode only', () {
        // Arrange
        final request = StoreInDeviceRequest(
          locBarcode: 'LOC-D4-R15',
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['stockBarcode'], null);
        expect(json['locBarcode'], 'LOC-D4-R15');
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final request = StoreInDeviceRequest(
          stockBarcode: 'STK-CONST-001',
          locBarcode: 'LOC-CONST-A1',
        );

        // Assert
        expect(request.stockBarcode, 'STK-CONST-001');
        expect(request.locBarcode, 'LOC-CONST-A1');
      });

      test('should create instance with no parameters', () {
        // Act
        final request = StoreInDeviceRequest();

        // Assert
        expect(request.stockBarcode, null);
        expect(request.locBarcode, null);
      });

      test('should create instance with stockBarcode only', () {
        // Act
        final request = StoreInDeviceRequest(stockBarcode: 'STK-ONLY-001');

        // Assert
        expect(request.stockBarcode, 'STK-ONLY-001');
        expect(request.locBarcode, null);
      });

      test('should create instance with locBarcode only', () {
        // Act
        final request = StoreInDeviceRequest(locBarcode: 'LOC-ONLY-B2');

        // Assert
        expect(request.stockBarcode, null);
        expect(request.locBarcode, 'LOC-ONLY-B2');
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'stockBarcode': 'STK-ROUND-001',
          'locBarcode': 'LOC-ROUND-A1',
        };

        // Act
        final request = StoreInDeviceRequest.fromJson(originalJson);
        final serialized = request.toJson();

        // Assert
        expect(serialized['stockBarcode'], originalJson['stockBarcode']);
        expect(serialized['locBarcode'], originalJson['locBarcode']);
      });

      test('should maintain null values through cycle', () {
        // Arrange
        final originalJson = <String, dynamic>{
          'stockBarcode': null,
          'locBarcode': null,
        };

        // Act
        final request = StoreInDeviceRequest.fromJson(originalJson);
        final serialized = request.toJson();

        // Assert
        expect(serialized['stockBarcode'], null);
        expect(serialized['locBarcode'], null);
      });

      test('should maintain partial data through cycle', () {
        // Arrange
        final originalJson = {
          'stockBarcode': 'STK-PARTIAL-001',
        };

        // Act
        final request = StoreInDeviceRequest.fromJson(originalJson);
        final serialized = request.toJson();

        // Assert
        expect(serialized['stockBarcode'], 'STK-PARTIAL-001');
        expect(serialized['locBarcode'], null);
      });
    });

    group('edge cases', () {
      test('should handle empty string stockBarcode', () {
        // Arrange
        final json = {
          'stockBarcode': '',
          'locBarcode': 'LOC-VALID-001',
        };

        // Act
        final request = StoreInDeviceRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, '');
        expect(request.locBarcode, 'LOC-VALID-001');
      });

      test('should handle empty string locBarcode', () {
        // Arrange
        final json = {
          'stockBarcode': 'STK-VALID-001',
          'locBarcode': '',
        };

        // Act
        final request = StoreInDeviceRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, 'STK-VALID-001');
        expect(request.locBarcode, '');
      });

      test('should handle long barcode strings', () {
        // Arrange
        final longStockBarcode = 'STK-' + 'A' * 200;
        final longLocBarcode = 'LOC-' + 'B' * 200;
        final json = {
          'stockBarcode': longStockBarcode,
          'locBarcode': longLocBarcode,
        };

        // Act
        final request = StoreInDeviceRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode!.length, 204);
        expect(request.locBarcode!.length, 204);
      });

      test('should handle special characters in stockBarcode', () {
        // Arrange
        final json = {
          'stockBarcode': 'STK-001_ABC-DEF/GHI.123',
        };

        // Act
        final request = StoreInDeviceRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, 'STK-001_ABC-DEF/GHI.123');
      });

      test('should handle special characters in locBarcode', () {
        // Arrange
        final json = {
          'locBarcode': 'LOC-A1_R01-S02/B03.456',
        };

        // Act
        final request = StoreInDeviceRequest.fromJson(json);

        // Assert
        expect(request.locBarcode, 'LOC-A1_R01-S02/B03.456');
      });

      test('should handle whitespace-only stockBarcode', () {
        // Arrange
        final json = {
          'stockBarcode': '   ',
        };

        // Act
        final request = StoreInDeviceRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, '   ');
      });

      test('should handle whitespace-only locBarcode', () {
        // Arrange
        final json = {
          'locBarcode': '   ',
        };

        // Act
        final request = StoreInDeviceRequest.fromJson(json);

        // Assert
        expect(request.locBarcode, '   ');
      });

      test('should handle numeric barcodes as strings', () {
        // Arrange
        final json = {
          'stockBarcode': '1234567890',
          'locBarcode': '9876543210',
        };

        // Act
        final request = StoreInDeviceRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, '1234567890');
        expect(request.locBarcode, '9876543210');
      });

      test('should handle alphanumeric barcodes', () {
        // Arrange
        final json = {
          'stockBarcode': 'ABC123DEF456',
          'locBarcode': 'XYZ789UVW012',
        };

        // Act
        final request = StoreInDeviceRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, 'ABC123DEF456');
        expect(request.locBarcode, 'XYZ789UVW012');
      });

      test('should handle unicode in barcodes', () {
        // Arrange
        final json = {
          'stockBarcode': 'STK-日本語-001',
          'locBarcode': 'LOC-中文-A1',
        };

        // Act
        final request = StoreInDeviceRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, 'STK-日本語-001');
        expect(request.locBarcode, 'LOC-中文-A1');
      });

      test('should handle barcodes with leading/trailing spaces', () {
        // Arrange
        final json = {
          'stockBarcode': '  STK-001  ',
          'locBarcode': '  LOC-A1  ',
        };

        // Act
        final request = StoreInDeviceRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, '  STK-001  ');
        expect(request.locBarcode, '  LOC-A1  ');
      });

      test('should handle typical warehouse barcode format', () {
        // Arrange
        final json = {
          'stockBarcode': 'WH-DEL-RACK-A1-SHELF-01-BIN-003',
          'locBarcode': 'DELHI-WH1-ZONE-A-ROW-15-COL-08',
        };

        // Act
        final request = StoreInDeviceRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, 'WH-DEL-RACK-A1-SHELF-01-BIN-003');
        expect(request.locBarcode, 'DELHI-WH1-ZONE-A-ROW-15-COL-08');
      });
    });
  });
}
