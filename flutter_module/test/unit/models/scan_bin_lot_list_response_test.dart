import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_out/resources/scan_bin_lot_list_response.dart';

void main() {
  group('ScanBinLotListResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'data': [
            {
              'barcode': 'BC-001',
              'lotItemLocation': 'A1-B2-C3',
              'storagePosition': 5,
              'productTitle': 'iPhone 13 Pro',
            },
          ],
        };

        // Act
        final response = ScanBinLotListResponse.fromJson(json);

        // Assert
        expect(response.lotList, isNotNull);
        expect(response.lotList!.length, 1);
        expect(response.lotList![0]?.barcode, 'BC-001');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = ScanBinLotListResponse.fromJson(json);

        // Assert
        expect(response.lotList, isNull);
      });

      test('should handle empty data array', () {
        // Arrange
        final json = {
          'data': <Map<String, dynamic>>[],
        };

        // Act
        final response = ScanBinLotListResponse.fromJson(json);

        // Assert
        expect(response.lotList, isEmpty);
      });

      test('should parse multiple bin lot items', () {
        // Arrange
        final json = {
          'data': [
            {'barcode': 'BC-001', 'productTitle': 'Product 1'},
            {'barcode': 'BC-002', 'productTitle': 'Product 2'},
            {'barcode': 'BC-003', 'productTitle': 'Product 3'},
          ],
        };

        // Act
        final response = ScanBinLotListResponse.fromJson(json);

        // Assert
        expect(response.lotList!.length, 3);
        expect(response.lotList![0]?.barcode, 'BC-001');
        expect(response.lotList![1]?.barcode, 'BC-002');
        expect(response.lotList![2]?.barcode, 'BC-003');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final item = ScanBinLotItem(
          barcode: 'BC-TEST',
          itemLocBarCode: 'LOC-001',
          storagePosition: 10,
          productTitle: 'Test Product',
        );
        final response = ScanBinLotListResponse(lotList: [item]);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['data'], isA<List>());
        expect((json['data'] as List).length, 1);
      });

      test('should serialize null lotList correctly', () {
        // Arrange
        final response = ScanBinLotListResponse();

        // Act
        final json = response.toJson();

        // Assert
        expect(json['data'], isNull);
      });
    });

    group('constructor', () {
      test('should create instance with lotList parameter', () {
        // Arrange
        final items = [
          ScanBinLotItem(barcode: 'BC-001'),
          ScanBinLotItem(barcode: 'BC-002'),
        ];

        // Act
        final response = ScanBinLotListResponse(lotList: items);

        // Assert
        expect(response.lotList!.length, 2);
      });

      test('should create instance with null lotList', () {
        // Act
        final response = ScanBinLotListResponse();

        // Assert
        expect(response.lotList, isNull);
      });
    });
  });

  group('ScanBinLotItem', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'barcode': 'BARCODE-12345',
          'lotItemLocation': 'Warehouse-A1-R2-S3',
          'storagePosition': 15,
          'productTitle': 'Samsung Galaxy S22 Ultra',
        };

        // Act
        final item = ScanBinLotItem.fromJson(json);

        // Assert
        expect(item.barcode, 'BARCODE-12345');
        expect(item.itemLocBarCode, 'Warehouse-A1-R2-S3');
        expect(item.storagePosition, 15);
        expect(item.productTitle, 'Samsung Galaxy S22 Ultra');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final item = ScanBinLotItem.fromJson(json);

        // Assert
        expect(item.barcode, isNull);
        expect(item.itemLocBarCode, isNull);
        expect(item.storagePosition, isNull);
        expect(item.productTitle, isNull);
      });

      test('should handle partial fields', () {
        // Arrange
        final json = {
          'barcode': 'PARTIAL-BC',
          'storagePosition': 7,
        };

        // Act
        final item = ScanBinLotItem.fromJson(json);

        // Assert
        expect(item.barcode, 'PARTIAL-BC');
        expect(item.storagePosition, 7);
        expect(item.itemLocBarCode, isNull);
        expect(item.productTitle, isNull);
      });

      test('should parse storagePosition as 0', () {
        // Arrange
        final json = {
          'barcode': 'ZERO-POS',
          'storagePosition': 0,
        };

        // Act
        final item = ScanBinLotItem.fromJson(json);

        // Assert
        expect(item.storagePosition, 0);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly with includeIfNull false', () {
        // Arrange
        final item = ScanBinLotItem(
          barcode: 'TOJSON-BC',
          itemLocBarCode: 'TOJSON-LOC',
          storagePosition: 20,
          productTitle: 'ToJson Test Product',
        );

        // Act
        final json = item.toJson();

        // Assert
        expect(json['barcode'], 'TOJSON-BC');
        expect(json['lotItemLocation'], 'TOJSON-LOC');
        expect(json['storagePosition'], 20);
        expect(json['productTitle'], 'ToJson Test Product');
      });

      test('should not include null fields due to includeIfNull false', () {
        // Arrange
        final item = ScanBinLotItem(
          barcode: 'ONLY-BC',
        );

        // Act
        final json = item.toJson();

        // Assert
        expect(json['barcode'], 'ONLY-BC');
        // Due to includeIfNull: false, null fields should not be present
        expect(json.containsKey('lotItemLocation'), false);
        expect(json.containsKey('storagePosition'), false);
        expect(json.containsKey('productTitle'), false);
      });

      test('should serialize storagePosition as 0', () {
        // Arrange
        final item = ScanBinLotItem(
          barcode: 'ZERO-TEST',
          storagePosition: 0,
        );

        // Act
        final json = item.toJson();

        // Assert
        expect(json['storagePosition'], 0);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final item = ScanBinLotItem(
          storagePosition: 25,
          barcode: 'CONSTRUCTOR-BC',
          itemLocBarCode: 'CONSTRUCTOR-LOC',
          productTitle: 'Constructor Test',
        );

        // Assert
        expect(item.storagePosition, 25);
        expect(item.barcode, 'CONSTRUCTOR-BC');
        expect(item.itemLocBarCode, 'CONSTRUCTOR-LOC');
        expect(item.productTitle, 'Constructor Test');
      });

      test('should create instance with minimal parameters', () {
        // Act
        final item = ScanBinLotItem();

        // Assert
        expect(item.barcode, isNull);
        expect(item.storagePosition, isNull);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'barcode': 'ROUNDTRIP-BARCODE',
          'lotItemLocation': 'ROUNDTRIP-LOCATION',
          'storagePosition': 30,
          'productTitle': 'Roundtrip Test Product',
        };

        // Act
        final item = ScanBinLotItem.fromJson(originalJson);
        final serializedJson = item.toJson();

        // Assert
        expect(serializedJson['barcode'], originalJson['barcode']);
        expect(serializedJson['lotItemLocation'], originalJson['lotItemLocation']);
        expect(serializedJson['storagePosition'], originalJson['storagePosition']);
        expect(serializedJson['productTitle'], originalJson['productTitle']);
      });
    });
  });
}
