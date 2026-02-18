import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dispatch_lot/resources/dispatch_lots_response.dart';

/// Tests for DispatchLotsResponse and Lot models.
/// Focus: Testing JsonSerializable fromJson/toJson with field mapping.
void main() {
  group('DispatchLotsResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly with populated data list', () {
        // Arrange
        final json = {
          'dt': [
            {
              'lotGroupName': 'GROUP001',
              'lotName': 'LOT001',
              'invoiceNo': 'INV-2024-001',
              'invoiceDate': 1704067200000,
              'deviceCount': 100,
              'vendorCode': 'VND001',
              'vendorName': 'Test Vendor',
            },
            {
              'lotGroupName': 'GROUP002',
              'lotName': 'LOT002',
              'invoiceNo': 'INV-2024-002',
              'invoiceDate': 1704153600000,
              'deviceCount': 50,
              'vendorCode': 'VND002',
              'vendorName': 'Another Vendor',
            },
          ],
          'tc': 150,
          's': true,
        };

        // Act
        final response = DispatchLotsResponse.fromJson(json);

        // Assert
        expect(response.lots, isNotNull);
        expect(response.lots?.length, 2);
        expect(response.totalLot, 150);
        expect(response.isSuccess, true);

        final firstLot = response.lots?[0];
        expect(firstLot?.lotGroupName, 'GROUP001');
        expect(firstLot?.lotName, 'LOT001');
        expect(firstLot?.invoiceNumber, 'INV-2024-001');
        expect(firstLot?.invoiceDate, 1704067200000);
        expect(firstLot?.deviceQty, 100);
        expect(firstLot?.vendorCode, 'VND001');
        expect(firstLot?.vendorName, 'Test Vendor');

        final secondLot = response.lots?[1];
        expect(secondLot?.lotGroupName, 'GROUP002');
        expect(secondLot?.lotName, 'LOT002');
        expect(secondLot?.invoiceNumber, 'INV-2024-002');
        expect(secondLot?.deviceQty, 50);
      });

      test('should handle null dt field', () {
        // Arrange
        final json = <String, dynamic>{
          'dt': null,
          'tc': null,
          's': null,
        };

        // Act
        final response = DispatchLotsResponse.fromJson(json);

        // Assert
        expect(response.lots, null);
        expect(response.totalLot, null);
        expect(response.isSuccess, null);
      });

      test('should handle empty dt list', () {
        // Arrange
        final json = {
          'dt': <Map<String, dynamic>>[],
          'tc': 0,
          's': true,
        };

        // Act
        final response = DispatchLotsResponse.fromJson(json);

        // Assert
        expect(response.lots, isNotNull);
        expect(response.lots, isEmpty);
        expect(response.totalLot, 0);
        expect(response.isSuccess, true);
      });

      test('should handle missing fields in JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = DispatchLotsResponse.fromJson(json);

        // Assert
        expect(response.lots, null);
        expect(response.totalLot, null);
        expect(response.isSuccess, null);
      });

      test('should handle false isSuccess', () {
        // Arrange
        final json = {
          'dt': null,
          'tc': 0,
          's': false,
        };

        // Act
        final response = DispatchLotsResponse.fromJson(json);

        // Assert
        expect(response.isSuccess, false);
      });

      test('should handle list with null lot items', () {
        // Arrange
        final json = {
          'dt': [
            null,
            {
              'lotGroupName': 'GROUP001',
              'lotName': 'LOT001',
            },
            null,
          ],
          'tc': 1,
          's': true,
        };

        // Act
        final response = DispatchLotsResponse.fromJson(json);

        // Assert
        expect(response.lots, isNotNull);
        expect(response.lots?.length, 3);
        expect(response.lots?[0], null);
        expect(response.lots?[1]?.lotGroupName, 'GROUP001');
        expect(response.lots?[2], null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = DispatchLotsResponse(
          lots: [
            Lot(
              lotGroupName: 'GROUP001',
              lotName: 'LOT001',
              invoiceNumber: 'INV-001',
              invoiceDate: 1704067200000,
              deviceQty: 100,
              vendorCode: 'VND001',
              vendorName: 'Test Vendor',
            ),
          ],
          totalLot: 100,
          isSuccess: true,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['tc'], 100);
        expect(json['s'], true);
        expect(json['dt'], isNotNull);
        expect((json['dt'] as List).length, 1);
      });

      test('should handle null lots list in serialization', () {
        // Arrange
        final response = DispatchLotsResponse(
          lots: null,
          totalLot: 0,
          isSuccess: false,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], null);
        expect(json['tc'], 0);
        expect(json['s'], false);
      });

      test('should handle empty lots list in serialization', () {
        // Arrange
        final response = DispatchLotsResponse(
          lots: [],
          totalLot: 0,
          isSuccess: true,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], isNotNull);
        expect((json['dt'] as List), isEmpty);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'dt': [
            {
              'lotGroupName': 'ROUND-TRIP-GROUP',
              'lotName': 'ROUND-TRIP-LOT',
              'invoiceNo': 'RT-INV-001',
              'invoiceDate': 1704067200000,
              'deviceCount': 250,
              'vendorCode': 'RT-VND',
              'vendorName': 'Round Trip Vendor',
            },
          ],
          'tc': 250,
          's': true,
        };

        // Act
        final response = DispatchLotsResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['tc'], originalJson['tc']);
        expect(serializedJson['s'], originalJson['s']);
        expect((serializedJson['dt'] as List).length, 1);
      });
    });

    group('edge cases', () {
      test('should handle large totalLot value', () {
        // Arrange
        final json = {
          'dt': [],
          'tc': 2147483647,
          's': true,
        };

        // Act
        final response = DispatchLotsResponse.fromJson(json);

        // Assert
        expect(response.totalLot, 2147483647);
      });

      test('should handle zero totalLot', () {
        // Arrange
        final json = {
          'dt': [],
          'tc': 0,
          's': true,
        };

        // Act
        final response = DispatchLotsResponse.fromJson(json);

        // Assert
        expect(response.totalLot, 0);
      });
    });
  });

  group('Lot', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'lotGroupName': 'GROUP001',
          'lotName': 'LOT001',
          'invoiceNo': 'INV-2024-001',
          'invoiceDate': 1704067200000,
          'deviceCount': 100,
          'vendorCode': 'VND001',
          'vendorName': 'Test Vendor Inc.',
        };

        // Act
        final lot = Lot.fromJson(json);

        // Assert
        expect(lot.lotGroupName, 'GROUP001');
        expect(lot.lotName, 'LOT001');
        expect(lot.invoiceNumber, 'INV-2024-001');
        expect(lot.invoiceDate, 1704067200000);
        expect(lot.deviceQty, 100);
        expect(lot.vendorCode, 'VND001');
        expect(lot.vendorName, 'Test Vendor Inc.');
      });

      test('should handle all null fields', () {
        // Arrange
        final json = <String, dynamic>{
          'lotGroupName': null,
          'lotName': null,
          'invoiceNo': null,
          'invoiceDate': null,
          'deviceCount': null,
          'vendorCode': null,
          'vendorName': null,
        };

        // Act
        final lot = Lot.fromJson(json);

        // Assert
        expect(lot.lotGroupName, null);
        expect(lot.lotName, null);
        expect(lot.invoiceNumber, null);
        expect(lot.invoiceDate, null);
        expect(lot.deviceQty, null);
        expect(lot.vendorCode, null);
        expect(lot.vendorName, null);
      });

      test('should handle empty JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final lot = Lot.fromJson(json);

        // Assert
        expect(lot.lotGroupName, null);
        expect(lot.lotName, null);
        expect(lot.invoiceNumber, null);
        expect(lot.invoiceDate, null);
        expect(lot.deviceQty, null);
        expect(lot.vendorCode, null);
        expect(lot.vendorName, null);
      });

      test('should handle partial data', () {
        // Arrange
        final json = {
          'lotGroupName': 'GROUP001',
          'lotName': 'LOT001',
          'deviceCount': 50,
        };

        // Act
        final lot = Lot.fromJson(json);

        // Assert
        expect(lot.lotGroupName, 'GROUP001');
        expect(lot.lotName, 'LOT001');
        expect(lot.deviceQty, 50);
        expect(lot.invoiceNumber, null);
        expect(lot.invoiceDate, null);
        expect(lot.vendorCode, null);
        expect(lot.vendorName, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields with correct JSON keys', () {
        // Arrange
        final lot = Lot(
          lotGroupName: 'GROUP001',
          lotName: 'LOT001',
          invoiceNumber: 'INV-001',
          invoiceDate: 1704067200000,
          deviceQty: 100,
          vendorCode: 'VND001',
          vendorName: 'Test Vendor',
        );

        // Act
        final json = lot.toJson();

        // Assert
        expect(json['lotGroupName'], 'GROUP001');
        expect(json['lotName'], 'LOT001');
        expect(json['invoiceNo'], 'INV-001');
        expect(json['invoiceDate'], 1704067200000);
        expect(json['deviceCount'], 100);
        expect(json['vendorCode'], 'VND001');
        expect(json['vendorName'], 'Test Vendor');
      });

      test('should serialize null fields', () {
        // Arrange
        final lot = Lot(
          lotGroupName: null,
          lotName: null,
          invoiceNumber: null,
          invoiceDate: null,
          deviceQty: null,
          vendorCode: null,
          vendorName: null,
        );

        // Act
        final json = lot.toJson();

        // Assert
        expect(json['lotGroupName'], null);
        expect(json['lotName'], null);
        expect(json['invoiceNo'], null);
        expect(json['invoiceDate'], null);
        expect(json['deviceCount'], null);
        expect(json['vendorCode'], null);
        expect(json['vendorName'], null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'lotGroupName': 'ROUND-TRIP-GROUP',
          'lotName': 'ROUND-TRIP-LOT',
          'invoiceNo': 'RT-INV-001',
          'invoiceDate': 1704067200000,
          'deviceCount': 250,
          'vendorCode': 'RT-VND',
          'vendorName': 'Round Trip Vendor',
        };

        // Act
        final lot = Lot.fromJson(originalJson);
        final serializedJson = lot.toJson();

        // Assert
        expect(serializedJson['lotGroupName'], originalJson['lotGroupName']);
        expect(serializedJson['lotName'], originalJson['lotName']);
        expect(serializedJson['invoiceNo'], originalJson['invoiceNo']);
        expect(serializedJson['invoiceDate'], originalJson['invoiceDate']);
        expect(serializedJson['deviceCount'], originalJson['deviceCount']);
        expect(serializedJson['vendorCode'], originalJson['vendorCode']);
        expect(serializedJson['vendorName'], originalJson['vendorName']);
      });
    });

    group('edge cases', () {
      test('should handle special characters in string fields', () {
        // Arrange
        final json = {
          'lotGroupName': 'GROUP-001_SPECIAL',
          'lotName': 'LOT/2024/001-XYZ',
          'invoiceNo': 'INV#2024@001',
          'vendorCode': 'VND-001/A',
          'vendorName': 'Test Vendor (Private) Ltd.',
        };

        // Act
        final lot = Lot.fromJson(json);

        // Assert
        expect(lot.lotGroupName, 'GROUP-001_SPECIAL');
        expect(lot.lotName, 'LOT/2024/001-XYZ');
        expect(lot.invoiceNumber, 'INV#2024@001');
        expect(lot.vendorCode, 'VND-001/A');
        expect(lot.vendorName, 'Test Vendor (Private) Ltd.');
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'vendorName': 'テスト ベンダー 🏭',
          'lotName': 'लॉट-001',
        };

        // Act
        final lot = Lot.fromJson(json);

        // Assert
        expect(lot.vendorName, 'テスト ベンダー 🏭');
        expect(lot.lotName, 'लॉट-001');
      });

      test('should handle large numeric values', () {
        // Arrange
        final json = {
          'invoiceDate': 9999999999999,
          'deviceCount': 2147483647,
        };

        // Act
        final lot = Lot.fromJson(json);

        // Assert
        expect(lot.invoiceDate, 9999999999999);
        expect(lot.deviceQty, 2147483647);
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          'lotGroupName': '',
          'lotName': '',
          'invoiceNo': '',
          'vendorCode': '',
          'vendorName': '',
        };

        // Act
        final lot = Lot.fromJson(json);

        // Assert
        expect(lot.lotGroupName, '');
        expect(lot.lotName, '');
        expect(lot.invoiceNumber, '');
        expect(lot.vendorCode, '');
        expect(lot.vendorName, '');
      });

      test('should handle zero values for integers', () {
        // Arrange
        final json = {
          'invoiceDate': 0,
          'deviceCount': 0,
        };

        // Act
        final lot = Lot.fromJson(json);

        // Assert
        expect(lot.invoiceDate, 0);
        expect(lot.deviceQty, 0);
      });

      test('should handle negative values for integers', () {
        // Arrange
        final json = {
          'invoiceDate': -1,
          'deviceCount': -100,
        };

        // Act
        final lot = Lot.fromJson(json);

        // Assert
        expect(lot.invoiceDate, -1);
        expect(lot.deviceQty, -100);
      });
    });
  });
}
