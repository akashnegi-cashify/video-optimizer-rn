import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_out/resources/normal_lot_out_request.dart';

void main() {
  group('NormalLotOutRequest', () {
    group('fromJson', () {
      test('should parse all JSON fields correctly', () {
        // Arrange
        final json = {
          'qr_code': 'STOCK-BARCODE-001',
          'stbr': 'LOC-BARCODE-001',
          'lgn': 'LOT-NAME-001',
        };

        // Act
        final request = NormalLotOutRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, 'STOCK-BARCODE-001');
        expect(request.locBarcode, 'LOC-BARCODE-001');
        expect(request.lotName, 'LOT-NAME-001');
        // lotId is excluded from JSON (includeFromJson: false)
        expect(request.lotId, isNull);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final request = NormalLotOutRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, isNull);
        expect(request.locBarcode, isNull);
        expect(request.lotName, isNull);
        expect(request.lotId, isNull);
      });

      test('should parse only stockBarcode', () {
        // Arrange
        final json = {
          'qr_code': 'ONLY-STOCK',
        };

        // Act
        final request = NormalLotOutRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, 'ONLY-STOCK');
        expect(request.locBarcode, isNull);
        expect(request.lotName, isNull);
      });

      test('should parse only locBarcode', () {
        // Arrange
        final json = {
          'stbr': 'ONLY-LOC',
        };

        // Act
        final request = NormalLotOutRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, isNull);
        expect(request.locBarcode, 'ONLY-LOC');
      });

      test('should ignore lotId from JSON', () {
        // Arrange - lotId should be ignored in fromJson
        final json = {
          'qr_code': 'STOCK-001',
          'stbr': 'LOC-001',
          'lgn': 'LOT-001',
          'lotId': 12345, // This should be ignored
        };

        // Act
        final request = NormalLotOutRequest.fromJson(json);

        // Assert
        expect(request.lotId, isNull); // Should be null as it's excluded from JSON
      });
    });

    group('toJson', () {
      test('should serialize JSON fields correctly', () {
        // Arrange
        final request = NormalLotOutRequest(
          stockBarcode: 'STOCK-TO-JSON',
          locBarcode: 'LOC-TO-JSON',
          lotName: 'LOT-TO-JSON',
          lotId: 999, // This should NOT appear in JSON
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['qr_code'], 'STOCK-TO-JSON');
        expect(json['stbr'], 'LOC-TO-JSON');
        expect(json['lgn'], 'LOT-TO-JSON');
        // lotId is excluded from JSON (includeToJson: false)
        expect(json.containsKey('lotId'), false);
      });

      test('should serialize null fields correctly', () {
        // Arrange
        final request = NormalLotOutRequest();

        // Act
        final json = request.toJson();

        // Assert
        expect(json['qr_code'], isNull);
        expect(json['stbr'], isNull);
        expect(json['lgn'], isNull);
      });

      test('should not include lotId in serialized JSON', () {
        // Arrange
        final request = NormalLotOutRequest(lotId: 12345);

        // Act
        final json = request.toJson();

        // Assert
        expect(json.containsKey('lotId'), false);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final request = NormalLotOutRequest(
          stockBarcode: 'CONSTRUCTOR-STOCK',
          locBarcode: 'CONSTRUCTOR-LOC',
          lotName: 'CONSTRUCTOR-LOT',
          lotId: 555,
        );

        // Assert
        expect(request.stockBarcode, 'CONSTRUCTOR-STOCK');
        expect(request.locBarcode, 'CONSTRUCTOR-LOC');
        expect(request.lotName, 'CONSTRUCTOR-LOT');
        expect(request.lotId, 555);
      });

      test('should create instance with null parameters', () {
        // Act
        final request = NormalLotOutRequest();

        // Assert
        expect(request.stockBarcode, isNull);
        expect(request.locBarcode, isNull);
        expect(request.lotName, isNull);
        expect(request.lotId, isNull);
      });

      test('should create instance with only stockBarcode', () {
        // Act
        final request = NormalLotOutRequest(stockBarcode: 'ONLY-STOCK');

        // Assert
        expect(request.stockBarcode, 'ONLY-STOCK');
        expect(request.locBarcode, isNull);
        expect(request.lotName, isNull);
        expect(request.lotId, isNull);
      });

      test('should create instance with only lotId', () {
        // Act
        final request = NormalLotOutRequest(lotId: 777);

        // Assert
        expect(request.lotId, 777);
        expect(request.stockBarcode, isNull);
      });
    });

    group('roundtrip', () {
      test('should maintain JSON-serializable data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'qr_code': 'ROUNDTRIP-STOCK',
          'stbr': 'ROUNDTRIP-LOC',
          'lgn': 'ROUNDTRIP-LOT',
        };

        // Act
        final request = NormalLotOutRequest.fromJson(originalJson);
        final serializedJson = request.toJson();

        // Assert
        expect(serializedJson['qr_code'], originalJson['qr_code']);
        expect(serializedJson['stbr'], originalJson['stbr']);
        expect(serializedJson['lgn'], originalJson['lgn']);
      });
    });

    group('lotId exclusion', () {
      test('lotId should be accessible via constructor but not in JSON', () {
        // Arrange
        final request = NormalLotOutRequest(
          stockBarcode: 'STOCK-001',
          lotId: 12345,
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(request.lotId, 12345); // Accessible on object
        expect(json.containsKey('lotId'), false); // Not in JSON
      });

      test('lotId should remain null when parsing JSON', () {
        // Arrange
        final json = {
          'qr_code': 'STOCK-001',
          'lotId': 99999, // Trying to set lotId via JSON
        };

        // Act
        final request = NormalLotOutRequest.fromJson(json);

        // Assert
        expect(request.lotId, isNull);
      });
    });

    group('field mapping', () {
      test('should use correct JSON keys for serialization', () {
        // Arrange
        final request = NormalLotOutRequest(
          stockBarcode: 'TEST-STOCK',
          locBarcode: 'TEST-LOC',
          lotName: 'TEST-LOT',
        );

        // Act
        final json = request.toJson();

        // Assert - verify the exact JSON keys
        expect(json.containsKey('qr_code'), true);
        expect(json.containsKey('stbr'), true);
        expect(json.containsKey('lgn'), true);
        // Verify internal field names are NOT used
        expect(json.containsKey('stockBarcode'), false);
        expect(json.containsKey('locBarcode'), false);
        expect(json.containsKey('lotName'), false);
      });

      test('should parse from correct JSON keys', () {
        // Arrange - use API keys, not Dart field names
        final json = {
          'qr_code': 'API-STOCK',
          'stbr': 'API-LOC',
          'lgn': 'API-LOT',
        };

        // Act
        final request = NormalLotOutRequest.fromJson(json);

        // Assert
        expect(request.stockBarcode, 'API-STOCK');
        expect(request.locBarcode, 'API-LOC');
        expect(request.lotName, 'API-LOT');
      });
    });
  });
}
