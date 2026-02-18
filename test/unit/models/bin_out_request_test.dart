import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_out/resources/bin_out_request.dart';

void main() {
  group('BinOutRequest', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'stockBarcode': 'STOCK-BC-001',
          'locBarcode': 'LOC-BC-001',
        };

        // Act
        final request = BinOutRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, 'STOCK-BC-001');
        expect(request.locBarcode, 'LOC-BC-001');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final request = BinOutRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, isNull);
        expect(request.locBarcode, isNull);
      });

      test('should parse only stockBarcode', () {
        // Arrange
        final json = {
          'stockBarcode': 'ONLY-STOCK-BC',
        };

        // Act
        final request = BinOutRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, 'ONLY-STOCK-BC');
        expect(request.locBarcode, isNull);
      });

      test('should parse only locBarcode', () {
        // Arrange
        final json = {
          'locBarcode': 'ONLY-LOC-BC',
        };

        // Act
        final request = BinOutRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, isNull);
        expect(request.locBarcode, 'ONLY-LOC-BC');
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          'stockBarcode': '',
          'locBarcode': '',
        };

        // Act
        final request = BinOutRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, '');
        expect(request.locBarcode, '');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final request = BinOutRequest(
          stockBarcode: 'STOCK-TOJSON',
          locBarcode: 'LOC-TOJSON',
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['stockBarcode'], 'STOCK-TOJSON');
        expect(json['locBarcode'], 'LOC-TOJSON');
      });

      test('should serialize null fields correctly', () {
        // Arrange
        final request = BinOutRequest();

        // Act
        final json = request.toJson();

        // Assert
        expect(json['stockBarcode'], isNull);
        expect(json['locBarcode'], isNull);
      });

      test('should serialize only stockBarcode', () {
        // Arrange
        final request = BinOutRequest(stockBarcode: 'ONLY-STOCK');

        // Act
        final json = request.toJson();

        // Assert
        expect(json['stockBarcode'], 'ONLY-STOCK');
        expect(json['locBarcode'], isNull);
      });

      test('should serialize empty strings', () {
        // Arrange
        final request = BinOutRequest(
          stockBarcode: '',
          locBarcode: '',
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['stockBarcode'], '');
        expect(json['locBarcode'], '');
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final request = BinOutRequest(
          stockBarcode: 'CONSTRUCTOR-STOCK',
          locBarcode: 'CONSTRUCTOR-LOC',
        );

        // Assert
        expect(request.stockBarcode, 'CONSTRUCTOR-STOCK');
        expect(request.locBarcode, 'CONSTRUCTOR-LOC');
      });

      test('should create instance with null parameters', () {
        // Act
        final request = BinOutRequest();

        // Assert
        expect(request.stockBarcode, isNull);
        expect(request.locBarcode, isNull);
      });

      test('should create instance with only stockBarcode', () {
        // Act
        final request = BinOutRequest(stockBarcode: 'STOCK-ONLY');

        // Assert
        expect(request.stockBarcode, 'STOCK-ONLY');
        expect(request.locBarcode, isNull);
      });

      test('should create instance with only locBarcode', () {
        // Act
        final request = BinOutRequest(locBarcode: 'LOC-ONLY');

        // Assert
        expect(request.stockBarcode, isNull);
        expect(request.locBarcode, 'LOC-ONLY');
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'stockBarcode': 'ROUNDTRIP-STOCK',
          'locBarcode': 'ROUNDTRIP-LOC',
        };

        // Act
        final request = BinOutRequest.fromJson(originalJson);
        final serializedJson = request.toJson();

        // Assert
        expect(serializedJson['stockBarcode'], originalJson['stockBarcode']);
        expect(serializedJson['locBarcode'], originalJson['locBarcode']);
      });

      test('should maintain null values through roundtrip', () {
        // Arrange
        final originalJson = <String, dynamic>{};

        // Act
        final request = BinOutRequest.fromJson(originalJson);
        final serializedJson = request.toJson();

        // Assert
        expect(serializedJson['stockBarcode'], isNull);
        expect(serializedJson['locBarcode'], isNull);
      });

      test('should maintain partial data through roundtrip', () {
        // Arrange
        final originalJson = {
          'stockBarcode': 'PARTIAL-STOCK',
        };

        // Act
        final request = BinOutRequest.fromJson(originalJson);
        final serializedJson = request.toJson();

        // Assert
        expect(serializedJson['stockBarcode'], 'PARTIAL-STOCK');
        expect(serializedJson['locBarcode'], isNull);
      });
    });

    group('field names', () {
      test('should use correct field names in JSON output', () {
        // Arrange
        final request = BinOutRequest(
          stockBarcode: 'TEST-STOCK',
          locBarcode: 'TEST-LOC',
        );

        // Act
        final json = request.toJson();

        // Assert - verify exact key names
        expect(json.containsKey('stockBarcode'), true);
        expect(json.containsKey('locBarcode'), true);
        expect(json.keys.length, 2);
      });
    });

    group('edge cases', () {
      test('should handle very long barcode strings', () {
        // Arrange
        final longBarcode = 'A' * 1000;
        final request = BinOutRequest(
          stockBarcode: longBarcode,
          locBarcode: longBarcode,
        );

        // Act
        final json = request.toJson();
        final recreated = BinOutRequest.fromJson(json);

        // Assert
        expect(recreated.stockBarcode, longBarcode);
        expect(recreated.locBarcode, longBarcode);
      });

      test('should handle special characters in barcodes', () {
        // Arrange
        final request = BinOutRequest(
          stockBarcode: 'STOCK-BC_123-ABC/456',
          locBarcode: 'LOC-BC#789@XYZ',
        );

        // Act
        final json = request.toJson();
        final recreated = BinOutRequest.fromJson(json);

        // Assert
        expect(recreated.stockBarcode, 'STOCK-BC_123-ABC/456');
        expect(recreated.locBarcode, 'LOC-BC#789@XYZ');
      });

      test('should handle unicode characters in barcodes', () {
        // Arrange
        final request = BinOutRequest(
          stockBarcode: 'STOCK-日本語-BC',
          locBarcode: 'LOC-हिंदी-BC',
        );

        // Act
        final json = request.toJson();
        final recreated = BinOutRequest.fromJson(json);

        // Assert
        expect(recreated.stockBarcode, 'STOCK-日本語-BC');
        expect(recreated.locBarcode, 'LOC-हिंदी-BC');
      });
    });
  });
}
