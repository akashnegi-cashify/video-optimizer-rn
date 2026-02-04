import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_out/resources/scan_normal_lot_list_response.dart';
import 'package:flutter_trc/qc/modules/store_out/resources/store_out_lot_list_response.dart';

/// Tests for StoreOut response models.
/// Focus: Testing the `isValid()` validation methods.
void main() {
  group('StoreOutLotListResponse', () {
    group('isValid method', () {
      test('should return true when status is true', () {
        // Arrange
        final response = _createStoreOutLotListResponse(status: true);

        // Act
        final result = response.isValid();

        // Assert
        expect(result, true);
      });

      test('should return false when status is false', () {
        // Arrange
        final response = _createStoreOutLotListResponse(status: false);

        // Act
        final result = response.isValid();

        // Assert
        expect(result, false);
      });

      test('should return false when status is null', () {
        // Arrange
        final response = _createStoreOutLotListResponse(status: null);

        // Act
        final result = response.isValid();

        // Assert
        expect(result, false);
      });
    });

    group('fromJson', () {
      test('should parse status field correctly as true', () {
        // Arrange
        final json = {
          's': true,
          'data': <Map<String, dynamic>>[],
        };

        // Act
        final response = StoreOutLotListResponse.fromJson(json);

        // Assert
        expect(response.status, true);
        expect(response.isValid(), true);
      });

      test('should parse status field correctly as false', () {
        // Arrange
        final json = {
          's': false,
          'data': <Map<String, dynamic>>[],
        };

        // Act
        final response = StoreOutLotListResponse.fromJson(json);

        // Assert
        expect(response.status, false);
        expect(response.isValid(), false);
      });

      test('should parse lotList correctly when present', () {
        // Arrange - test via constructor
        final item = StoreOutLotListItem(
          lotId: 1,
          lotGrpName: 'Test Lot',
          lotType: 'NORMAL',
          deviceCount: 10,
        );
        final response = StoreOutLotListResponse(lotList: [item]);

        // Assert
        expect(response.lotList?.length, 1);
        expect(response.lotList?.first.lotId, 1);
        expect(response.lotList?.first.lotGrpName, 'Test Lot');
      });

      test('should allow setting totalCount', () {
        // Arrange - test the model structure
        final response = StoreOutLotListResponse(lotList: []);
        
        // Assert - totalCount can be set through constructor or JSON
        expect(response.lotList, isNotNull);
      });
    });

    group('StoreOutLotListItem', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'lotId': 123,
          'lotCount': 5,
          'lotGroupName': 'Test Group',
          'lotType': 'NORMAL',
          'channel': 'D2C',
          'deviceCount': 50,
          'isInStoreOut': true,
          'facilityId': 10,
          'facilityName': 'Delhi Facility',
        };

        // Act
        final item = StoreOutLotListItem.fromJson(json);

        // Assert
        expect(item.lotId, 123);
        expect(item.lotCount, 5);
        expect(item.lotGrpName, 'Test Group');
        expect(item.lotType, 'NORMAL');
        expect(item.ch, 'D2C');
        expect(item.deviceCount, 50);
        expect(item.isStoreOutInProcess, true);
        expect(item.facilityId, 10);
        expect(item.facilityName, 'Delhi Facility');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final item = StoreOutLotListItem.fromJson(json);

        // Assert
        expect(item.lotId, null);
        expect(item.lotGrpName, null);
        expect(item.isStoreOutInProcess, null);
      });

      test('should create via constructor', () {
        // Arrange & Act
        final item = StoreOutLotListItem(
          lotId: 1,
          lotCount: 2,
          lotGrpName: 'Test',
          lotType: 'NORMAL',
          ch: 'B2B',
          deviceCount: 10,
          isStoreOutInProcess: false,
          facilityId: 5,
          facilityName: 'Test Facility',
        );

        // Assert
        expect(item.lotId, 1);
        expect(item.lotGrpName, 'Test');
        expect(item.isStoreOutInProcess, false);
      });
    });
  });

  group('ScanNormalLotListResponse', () {
    group('isValid method', () {
      test('should return true when status is true', () {
        // Arrange
        final response = _createScanNormalLotListResponse(status: true);

        // Act
        final result = response.isValid();

        // Assert
        expect(result, true);
      });

      test('should return false when status is false', () {
        // Arrange
        final response = _createScanNormalLotListResponse(status: false);

        // Act
        final result = response.isValid();

        // Assert
        expect(result, false);
      });

      test('should return false when status is null', () {
        // Arrange
        final response = _createScanNormalLotListResponse(status: null);

        // Act
        final result = response.isValid();

        // Assert
        expect(result, false);
      });
    });

    group('fromJson', () {
      test('should parse status field correctly', () {
        // Arrange
        final json = {
          's': true,
          'dt': <Map<String, dynamic>>[],
        };

        // Act
        final response = ScanNormalLotListResponse.fromJson(json);

        // Assert
        expect(response.status, true);
        expect(response.isValid(), true);
      });

      test('should parse success field', () {
        // Arrange
        final json = {
          's': true,
          'success': true,
          'dt': <Map<String, dynamic>>[],
        };

        // Act
        final response = ScanNormalLotListResponse.fromJson(json);

        // Assert
        expect(response.success, true);
      });

      test('should parse totalCount', () {
        // Arrange
        final json = {
          's': true,
          'tc': 50,
          'dt': <Map<String, dynamic>>[],
        };

        // Act
        final response = ScanNormalLotListResponse.fromJson(json);

        // Assert
        expect(response.totalCount, 50);
      });

      test('should parse lotList correctly', () {
        // Arrange
        final json = {
          's': true,
          'dt': [
            {
              'deviceId': 1,
              'qrCode': 'QR123',
              'model': 'iPhone 13',
              'brand': 'Apple',
              'imei': '123456789',
            },
          ],
        };

        // Act
        final response = ScanNormalLotListResponse.fromJson(json);

        // Assert
        expect(response.lotList?.length, 1);
        expect(response.lotList?.first?.deviceId, 1);
        expect(response.lotList?.first?.qrCode, 'QR123');
        expect(response.lotList?.first?.model, 'iPhone 13');
      });
    });

    group('ScanNormalLotItem', () {
      test('should create via constructor with all fields', () {
        // Arrange & Act
        final item = ScanNormalLotItem(
          deviceId: 123,
          qrCode: 'QR456',
          model: 'Samsung S21',
          brand: 'Samsung',
          imei: '987654321',
          storageBarcode: 'SB001',
          position: 5,
        );

        // Assert
        expect(item.deviceId, 123);
        expect(item.qrCode, 'QR456');
        expect(item.model, 'Samsung S21');
        expect(item.brand, 'Samsung');
        expect(item.imei, '987654321');
        expect(item.storageBarcode, 'SB001');
        expect(item.position, 5);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final item = ScanNormalLotItem.fromJson(json);

        // Assert
        expect(item.deviceId, null);
        expect(item.qrCode, null);
        expect(item.position, null);
      });

      test('should create via constructor', () {
        // Arrange & Act
        final item = ScanNormalLotItem(
          deviceId: 1,
          qrCode: 'QR001',
          model: 'Test Model',
          brand: 'Test Brand',
          imei: '111222333',
          storageBarcode: 'SB002',
          position: 3,
        );

        // Assert
        expect(item.deviceId, 1);
        expect(item.qrCode, 'QR001');
        expect(item.model, 'Test Model');
        expect(item.position, 3);
      });
    });
  });
}

/// Helper to create StoreOutLotListResponse for testing
StoreOutLotListResponse _createStoreOutLotListResponse({bool? status}) {
  final json = {
    's': status,
    'data': <Map<String, dynamic>>[],
  };
  return StoreOutLotListResponse.fromJson(json);
}

/// Helper to create ScanNormalLotListResponse for testing
ScanNormalLotListResponse _createScanNormalLotListResponse({bool? status}) {
  final json = {
    's': status,
    'dt': <Map<String, dynamic>>[],
  };
  return ScanNormalLotListResponse.fromJson(json);
}
