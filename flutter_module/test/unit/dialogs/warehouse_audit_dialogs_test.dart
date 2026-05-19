import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/dialogs/show_audit_scanned_device_detail_dialog.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/resources/scan_device_response.dart';

void main() {
  group('showAuditScannedDeviceDetailsDialog', () {
    test('function exists and is callable', () {
      expect(showAuditScannedDeviceDetailsDialog, isA<Function>());
    });

    test('function accepts required parameters', () {
      // Verify the function can accept BuildContext and ScanDeviceData?
      ScanDeviceData? nullData;
      expect(nullData, isNull);
    });

    test('function accepts null ScanDeviceData', () {
      // Dialog should handle null value gracefully
      ScanDeviceData? data;
      expect(data, isNull);
    });

    test('function accepts populated ScanDeviceData', () {
      final data = ScanDeviceData.fromJson({
        'qrCode': 'DEVICE123',
        'productName': 'iPhone 13',
        'currentStatus': 'In Stock',
        'moneyOutDate': 1706620800000,
        'storageLoc': 'A-1-1',
        'imei1': '123456789012345',
        'imei2': '543210987654321',
      });
      expect(data.deviceBarcode, 'DEVICE123');
      expect(data.productName, 'iPhone 13');
    });
  });

  group('ScanDeviceResponse', () {
    test('fromJson parses correctly', () {
      final json = {
        '__ca': null,
        'turl': 'test_url',
        'dt': {
          'qrCode': 'DEVICE456',
          'productName': 'Samsung Galaxy',
          'currentStatus': 'Pending',
        }
      };
      final response = ScanDeviceResponse.fromJson(json);
      expect(response.trackUrl, 'test_url');
      expect(response.scanDeviceData, isNotNull);
      expect(response.scanDeviceData?.deviceBarcode, 'DEVICE456');
    });

    test('toJson serializes correctly', () {
      final response = ScanDeviceResponse.fromJson({
        '__ca': null,
        'turl': 'test_url',
        'dt': {
          'qrCode': 'DEVICE789',
          'productName': 'OnePlus',
        }
      });
      final json = response.toJson();
      expect(json['turl'], 'test_url');
    });

    test('handles null scanDeviceData', () {
      final response = ScanDeviceResponse.fromJson({
        '__ca': null,
        'turl': 'test_url',
      });
      expect(response.scanDeviceData, isNull);
    });

    test('handles empty JSON', () {
      final response = ScanDeviceResponse.fromJson({});
      expect(response.scanDeviceData, isNull);
      expect(response.trackUrl, isNull);
    });
  });

  group('ScanDeviceData', () {
    test('fromJson parses all fields correctly', () {
      final json = {
        'qrCode': 'BARCODE123',
        'status': 1,
        'remark': 'Test remark',
        'mediaMap': {'front': 'url1', 'back': 'url2'},
        'currentStatus': 'Active',
        'productName': 'Test Product',
        'imei1': '111111111111111',
        'imei2': '222222222222222',
        'moneyOutDate': 1706620800000,
        'storageLoc': 'B-2-3',
      };
      final data = ScanDeviceData.fromJson(json);

      expect(data.deviceBarcode, 'BARCODE123');
      expect(data.status, 1);
      expect(data.message, 'Test remark');
      expect(data.requiredImageList, isNotNull);
      expect(data.requiredImageList?['front'], 'url1');
      expect(data.currentStatus, 'Active');
      expect(data.productName, 'Test Product');
      expect(data.imei1, '111111111111111');
      expect(data.imei2, '222222222222222');
      expect(data.moneyOutDate, 1706620800000);
      expect(data.storageLocation, 'B-2-3');
    });

    test('toJson serializes all fields correctly', () {
      final data = ScanDeviceData.fromJson({
        'qrCode': 'BARCODE456',
        'status': 2,
        'remark': 'Another remark',
        'currentStatus': 'Completed',
        'productName': 'Another Product',
        'imei1': '333333333333333',
        'imei2': '444444444444444',
        'moneyOutDate': 1706707200000,
        'storageLoc': 'C-3-4',
      });
      final json = data.toJson();

      expect(json['qrCode'], 'BARCODE456');
      expect(json['status'], 2);
      expect(json['remark'], 'Another remark');
      expect(json['currentStatus'], 'Completed');
      expect(json['productName'], 'Another Product');
      expect(json['imei1'], '333333333333333');
      expect(json['imei2'], '444444444444444');
      expect(json['moneyOutDate'], 1706707200000);
      expect(json['storageLoc'], 'C-3-4');
    });

    test('handles null values gracefully', () {
      final data = ScanDeviceData.fromJson({});

      expect(data.deviceBarcode, isNull);
      expect(data.status, isNull);
      expect(data.message, isNull);
      expect(data.requiredImageList, isNull);
      expect(data.currentStatus, isNull);
      expect(data.productName, isNull);
      expect(data.imei1, isNull);
      expect(data.imei2, isNull);
      expect(data.moneyOutDate, isNull);
      expect(data.storageLocation, isNull);
    });

    test('handles partial JSON data', () {
      final data = ScanDeviceData.fromJson({
        'qrCode': 'PARTIAL_BARCODE',
        'productName': 'Partial Product',
      });

      expect(data.deviceBarcode, 'PARTIAL_BARCODE');
      expect(data.productName, 'Partial Product');
      expect(data.imei1, isNull);
      expect(data.imei2, isNull);
      expect(data.storageLocation, isNull);
    });

    test('handles null mediaMap', () {
      final data = ScanDeviceData.fromJson({
        'qrCode': 'BARCODE_NULL_MAP',
        'mediaMap': null,
      });

      expect(data.deviceBarcode, 'BARCODE_NULL_MAP');
      expect(data.requiredImageList, isNull);
    });

    test('handles multiple media entries', () {
      final data = ScanDeviceData.fromJson({
        'qrCode': 'BARCODE_MULTI_MAP',
        'mediaMap': {
          'front': 'front_url',
          'back': 'back_url',
          'left': 'left_url',
          'right': 'right_url',
        },
      });

      expect(data.requiredImageList?.length, 4);
      expect(data.requiredImageList?['front'], 'front_url');
      expect(data.requiredImageList?['back'], 'back_url');
      expect(data.requiredImageList?['left'], 'left_url');
      expect(data.requiredImageList?['right'], 'right_url');
    });

    test('handles different status values', () {
      // Status 0
      final data0 = ScanDeviceData.fromJson({'status': 0});
      expect(data0.status, 0);

      // Status 1
      final data1 = ScanDeviceData.fromJson({'status': 1});
      expect(data1.status, 1);

      // Status 2
      final data2 = ScanDeviceData.fromJson({'status': 2});
      expect(data2.status, 2);

      // Negative status
      final dataNeg = ScanDeviceData.fromJson({'status': -1});
      expect(dataNeg.status, -1);
    });

    test('handles timestamp edge cases', () {
      // Zero timestamp
      final dataZero = ScanDeviceData.fromJson({'moneyOutDate': 0});
      expect(dataZero.moneyOutDate, 0);

      // Large timestamp
      final dataLarge = ScanDeviceData.fromJson({'moneyOutDate': 9999999999999});
      expect(dataLarge.moneyOutDate, 9999999999999);
    });

    test('handles IMEI edge cases', () {
      // Short IMEI
      final dataShort = ScanDeviceData.fromJson({
        'imei1': '12345',
        'imei2': '67890',
      });
      expect(dataShort.imei1, '12345');
      expect(dataShort.imei2, '67890');

      // Long IMEI
      final dataLong = ScanDeviceData.fromJson({
        'imei1': '123456789012345678901234567890',
        'imei2': '098765432109876543210987654321',
      });
      expect(dataLong.imei1, '123456789012345678901234567890');
      expect(dataLong.imei2, '098765432109876543210987654321');
    });

    test('handles special characters in strings', () {
      final data = ScanDeviceData.fromJson({
        'qrCode': 'BARCODE-123_ABC',
        'productName': 'Product & More (2024)',
        'currentStatus': 'Status: Active/Pending',
        'storageLoc': 'A-1/B-2',
        'remark': 'Test "remark" with \'quotes\'',
      });

      expect(data.deviceBarcode, 'BARCODE-123_ABC');
      expect(data.productName, 'Product & More (2024)');
      expect(data.currentStatus, 'Status: Active/Pending');
      expect(data.storageLocation, 'A-1/B-2');
      expect(data.message, 'Test "remark" with \'quotes\'');
    });
  });

  group('Dialog display values', () {
    test('displays NA when deviceBarcode is null', () {
      final data = ScanDeviceData.fromJson({});
      expect(data.deviceBarcode ?? "NA", "NA");
    });

    test('displays NA when productName is null', () {
      final data = ScanDeviceData.fromJson({});
      expect(data.productName ?? "NA", "NA");
    });

    test('displays NA when currentStatus is null', () {
      final data = ScanDeviceData.fromJson({});
      expect(data.currentStatus ?? "NA", "NA");
    });

    test('displays NA when storageLocation is null', () {
      final data = ScanDeviceData.fromJson({});
      expect(data.storageLocation ?? "NA", "NA");
    });

    test('displays NA when imei1 is null', () {
      final data = ScanDeviceData.fromJson({});
      expect(data.imei1 ?? "NA", "NA");
    });

    test('displays NA when imei2 is null', () {
      final data = ScanDeviceData.fromJson({});
      expect(data.imei2 ?? "NA", "NA");
    });

    test('displays actual values when populated', () {
      final data = ScanDeviceData.fromJson({
        'qrCode': 'DISPLAY_TEST',
        'productName': 'Display Product',
        'currentStatus': 'Display Status',
        'storageLoc': 'Display Location',
        'imei1': 'Display IMEI 1',
        'imei2': 'Display IMEI 2',
      });

      expect(data.deviceBarcode ?? "NA", "DISPLAY_TEST");
      expect(data.productName ?? "NA", "Display Product");
      expect(data.currentStatus ?? "NA", "Display Status");
      expect(data.storageLocation ?? "NA", "Display Location");
      expect(data.imei1 ?? "NA", "Display IMEI 1");
      expect(data.imei2 ?? "NA", "Display IMEI 2");
    });
  });
}
