import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/part_qc/models/qc_parts_list_response.dart';
import 'package:flutter_trc/src/modules/part_qc/models/general_response.dart';

/// Tests for Part QC module models.
/// Focus: Testing fromJson/toJson serialization and model properties.
void main() {
  group('QcPartsListResponse', () {
    group('fromJson', () {
      test('should parse complete response correctly', () {
        final json = {
          'r_id': 'REF123',
          's': true,
          'dt': [
            {
              'prid': 1,
              'sku': 'SKU001',
              'pn': 'Screen',
              'st': 'Available',
              'stc': 1,
              'rqty': 5,
              'pbr': 'PART001',
              'pc': 'Black',
              'pvn': 'Original',
            },
            {
              'prid': 2,
              'sku': 'SKU002',
              'pn': 'Battery',
              'st': 'Pending',
              'stc': 2,
              'rqty': 3,
              'pbr': 'PART002',
              'pc': 'N/A',
              'pvn': 'Replacement',
            },
          ],
        };

        final result = QcPartsListResponse.fromJson(json);

        expect(result.refId, 'REF123');
        expect(result.isSuccess, true);
        expect(result.dataList, isNotNull);
        expect(result.dataList?.length, 2);
      });

      test('should handle empty data list', () {
        final json = {
          'r_id': 'REF456',
          's': true,
          'dt': <Map<String, dynamic>>[],
        };

        final result = QcPartsListResponse.fromJson(json);

        expect(result.isSuccess, true);
        expect(result.dataList, isEmpty);
      });

      test('should handle null data list', () {
        final json = {
          'r_id': 'REF789',
          's': false,
          'dt': null,
        };

        final result = QcPartsListResponse.fromJson(json);

        expect(result.isSuccess, false);
        expect(result.dataList, isNull);
      });

      test('should handle missing fields', () {
        final json = <String, dynamic>{};

        final result = QcPartsListResponse.fromJson(json);

        expect(result.refId, isNull);
        expect(result.isSuccess, isNull);
        expect(result.dataList, isNull);
      });
    });

    group('toJson', () {
      test('should serialize response to JSON correctly', () {
        final response = QcPartsListResponse(
          refId: 'REF123',
          isSuccess: true,
          dataList: [],
        );

        final json = response.toJson();

        expect(json['r_id'], 'REF123');
        expect(json['s'], true);
        expect(json['dt'], isA<List>());
      });
    });
  });

  group('QcPartListData', () {
    group('fromJson', () {
      test('should parse complete part data correctly', () {
        final json = {
          'prid': 123,
          'sku': 'SKU-TEST-001',
          'pn': 'LCD Screen',
          'st': 'In Stock',
          'stc': 1,
          'rqty': 10,
          'pbr': 'BARCODE123',
          'pc': 'White',
          'pvn': 'Original OEM',
        };

        final result = QcPartListData.fromJson(json);

        expect(result.prid, 123);
        expect(result.sku, 'SKU-TEST-001');
        expect(result.partName, 'LCD Screen');
        expect(result.status, 'In Stock');
        expect(result.statusCode, 1);
        expect(result.requestedQuantity, 10);
        expect(result.partBarcode, 'BARCODE123');
        expect(result.partColor, 'White');
        expect(result.partVariantName, 'Original OEM');
      });

      test('should handle null fields', () {
        final json = <String, dynamic>{};

        final result = QcPartListData.fromJson(json);

        expect(result.prid, isNull);
        expect(result.sku, isNull);
        expect(result.partName, isNull);
        expect(result.status, isNull);
        expect(result.statusCode, isNull);
        expect(result.requestedQuantity, isNull);
        expect(result.partBarcode, isNull);
        expect(result.partColor, isNull);
        expect(result.partVariantName, isNull);
      });

      test('should handle partial data', () {
        final json = {
          'prid': 456,
          'pn': 'Battery',
        };

        final result = QcPartListData.fromJson(json);

        expect(result.prid, 456);
        expect(result.partName, 'Battery');
        expect(result.sku, isNull);
      });
    });

    group('toJson', () {
      test('should serialize part data to JSON correctly', () {
        final part = QcPartListData(
          prid: 789,
          sku: 'SKU789',
          partName: 'Charger',
          status: 'Available',
          statusCode: 1,
          requestedQuantity: 5,
        );

        final json = part.toJson();

        expect(json['prid'], 789);
        expect(json['sku'], 'SKU789');
        expect(json['pn'], 'Charger');
        expect(json['st'], 'Available');
        expect(json['stc'], 1);
        expect(json['rqty'], 5);
      });
    });

    group('additional properties', () {
      test('should allow setting isDamaged', () {
        final part = QcPartListData(prid: 1);
        part.isDamaged = true;
        expect(part.isDamaged, true);
      });

      test('should allow setting isBulk', () {
        final part = QcPartListData(prid: 1);
        part.isBulk = true;
        expect(part.isBulk, true);
      });

      test('should default isDamaged to null', () {
        final part = QcPartListData(prid: 1);
        expect(part.isDamaged, isNull);
      });

      test('should default isBulk to null', () {
        final part = QcPartListData(prid: 1);
        expect(part.isBulk, isNull);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        final part = QcPartListData(
          prid: 100,
          sku: 'SKU100',
          partName: 'Test Part',
          status: 'Test Status',
          statusCode: 5,
          requestedQuantity: 15,
          partBarcode: 'BARCODE100',
          partVariantName: 'Variant',
          isDamaged: false,
          isBulk: true,
        );

        expect(part.prid, 100);
        expect(part.sku, 'SKU100');
        expect(part.partName, 'Test Part');
        expect(part.status, 'Test Status');
        expect(part.statusCode, 5);
        expect(part.requestedQuantity, 15);
        expect(part.partBarcode, 'BARCODE100');
        expect(part.partVariantName, 'Variant');
        expect(part.isDamaged, false);
        expect(part.isBulk, true);
      });
    });
  });

  group('GeneralResponse', () {
    group('fromJson', () {
      test('should parse success response correctly', () {
        final json = {
          'r_id': 'REF123',
          's': true,
        };

        final result = GeneralResponse.fromJson(json);

        expect(result.refId, 'REF123');
        expect(result.isSuccess, true);
      });

      test('should parse failure response correctly', () {
        final json = {
          'r_id': 'REF456',
          's': false,
        };

        final result = GeneralResponse.fromJson(json);

        expect(result.refId, 'REF456');
        expect(result.isSuccess, false);
      });

      test('should handle missing fields', () {
        final json = <String, dynamic>{};

        final result = GeneralResponse.fromJson(json);

        expect(result.refId, isNull);
        expect(result.isSuccess, isNull);
      });
    });

    group('toJson', () {
      test('should serialize response to JSON correctly', () {
        final response = GeneralResponse(
          refId: 'REF789',
          isSuccess: true,
        );

        final json = response.toJson();

        expect(json['r_id'], 'REF789');
        expect(json['s'], true);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        final response = GeneralResponse(
          refId: 'TEST',
          isSuccess: true,
        );

        expect(response.refId, 'TEST');
        expect(response.isSuccess, true);
      });

      test('should create instance with null parameters', () {
        final response = GeneralResponse();

        expect(response.refId, isNull);
        expect(response.isSuccess, isNull);
      });
    });
  });
}
