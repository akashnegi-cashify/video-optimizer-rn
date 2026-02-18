import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/model/device_part.dart';

void main() {
  group('DevicePart', () {
    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = {
          'sku': 'SKU-12345',
          'pn': 'Battery',
          'pbr': 'PART-001',
          'dna': 'iPhone 13',
          'dbr': 'DEV-123',
          'pid': 42,
          'pcl': 'Black',
          'isBulk': true,
          'isUrgent': false,
          'prid': 100,
          'isService': true,
          'ac': 'REPLACE',
          'cc': 'PHONE',
          'pvn': 'Standard',
          'rpd': {'key': 'value'},
        };

        final part = DevicePart.fromJson(json);

        expect(part.sku, 'SKU-12345');
        expect(part.partName, 'Battery');
        expect(part.partBarcode, 'PART-001');
        expect(part.deviceName, 'iPhone 13');
        expect(part.deviceBarcode, 'DEV-123');
        expect(part.partId, 42);
        expect(part.partColor, 'Black');
        expect(part.isBulk, true);
        expect(part.isUrgent, false);
        expect(part.prId, 100);
        expect(part.isService, true);
        expect(part.action, 'REPLACE');
        expect(part.categoryCode, 'PHONE');
        expect(part.partVariantName, 'Standard');
        expect(part.retrievedPartData, {'key': 'value'});
      });

      test('handles null fields', () {
        final json = <String, dynamic>{
          'sku': null,
          'pn': null,
          'pbr': null,
          'dna': null,
          'dbr': null,
          'pid': null,
          'pcl': null,
          'isBulk': null,
          'isUrgent': null,
          'prid': null,
          'isService': null,
          'ac': null,
          'cc': null,
          'pvn': null,
          'rpd': null,
        };

        final part = DevicePart.fromJson(json);

        expect(part.sku, isNull);
        expect(part.partName, isNull);
        expect(part.partBarcode, isNull);
        expect(part.deviceName, isNull);
        expect(part.deviceBarcode, isNull);
        expect(part.partId, isNull);
        expect(part.partColor, isNull);
        expect(part.isBulk, isNull);
        expect(part.isUrgent, isNull);
        expect(part.prId, isNull);
        expect(part.isService, isNull);
        expect(part.action, isNull);
        expect(part.categoryCode, isNull);
        expect(part.partVariantName, isNull);
        expect(part.retrievedPartData, isNull);
      });

      test('handles missing fields', () {
        final json = <String, dynamic>{};

        final part = DevicePart.fromJson(json);

        expect(part.sku, isNull);
        expect(part.partId, isNull);
      });

      test('parses boolean fields correctly', () {
        final jsonAllTrue = {
          'isBulk': true,
          'isUrgent': true,
          'isService': true,
        };
        final jsonAllFalse = {
          'isBulk': false,
          'isUrgent': false,
          'isService': false,
        };

        final partTrue = DevicePart.fromJson(jsonAllTrue);
        final partFalse = DevicePart.fromJson(jsonAllFalse);

        expect(partTrue.isBulk, true);
        expect(partTrue.isUrgent, true);
        expect(partTrue.isService, true);

        expect(partFalse.isBulk, false);
        expect(partFalse.isUrgent, false);
        expect(partFalse.isService, false);
      });

      test('parses retrievedPartData map', () {
        final json = {
          'rpd': {
            'field1': 'value1',
            'field2': 123,
            'nested': {'a': 'b'},
          },
        };

        final part = DevicePart.fromJson(json);

        expect(part.retrievedPartData, isA<Map<String, dynamic>>());
        expect(part.retrievedPartData?['field1'], 'value1');
        expect(part.retrievedPartData?['field2'], 123);
        expect(part.retrievedPartData?['nested'], {'a': 'b'});
      });
    });

    group('toJson', () {
      test('serializes all fields correctly', () {
        final part = DevicePart.fromJson({
          'sku': 'SKU-TEST',
          'pn': 'Screen',
          'pbr': 'PART-TEST',
          'dna': 'Samsung S21',
          'dbr': 'DEV-TEST',
          'pid': 99,
          'pcl': 'White',
          'isBulk': false,
          'isUrgent': true,
          'prid': 200,
          'isService': false,
          'ac': 'REPAIR',
          'cc': 'TABLET',
          'pvn': 'Premium',
          'rpd': {'test': 'data'},
        });

        final json = part.toJson();

        expect(json['sku'], 'SKU-TEST');
        expect(json['pn'], 'Screen');
        expect(json['pbr'], 'PART-TEST');
        expect(json['dna'], 'Samsung S21');
        expect(json['dbr'], 'DEV-TEST');
        expect(json['pid'], 99);
        expect(json['pcl'], 'White');
        expect(json['isBulk'], false);
        expect(json['isUrgent'], true);
        expect(json['prid'], 200);
        expect(json['isService'], false);
        expect(json['ac'], 'REPAIR');
        expect(json['cc'], 'TABLET');
        expect(json['pvn'], 'Premium');
        expect(json['rpd'], {'test': 'data'});
      });

      test('serializes null values', () {
        final part = DevicePart.fromJson(<String, dynamic>{});

        final json = part.toJson();

        expect(json['sku'], isNull);
        expect(json['pn'], isNull);
        expect(json['pid'], isNull);
      });
    });

    group('JSON key mapping', () {
      test('partName maps to pn', () {
        final part = DevicePart.fromJson({'pn': 'Test Part'});

        expect(part.partName, 'Test Part');
        expect(part.toJson()['pn'], 'Test Part');
      });

      test('partBarcode maps to pbr', () {
        final part = DevicePart.fromJson({'pbr': 'BARCODE-123'});

        expect(part.partBarcode, 'BARCODE-123');
        expect(part.toJson()['pbr'], 'BARCODE-123');
      });

      test('deviceName maps to dna', () {
        final part = DevicePart.fromJson({'dna': 'Device Name'});

        expect(part.deviceName, 'Device Name');
        expect(part.toJson()['dna'], 'Device Name');
      });

      test('deviceBarcode maps to dbr', () {
        final part = DevicePart.fromJson({'dbr': 'DEV-BARCODE'});

        expect(part.deviceBarcode, 'DEV-BARCODE');
        expect(part.toJson()['dbr'], 'DEV-BARCODE');
      });

      test('partId maps to pid', () {
        final part = DevicePart.fromJson({'pid': 50});

        expect(part.partId, 50);
        expect(part.toJson()['pid'], 50);
      });

      test('partColor maps to pcl', () {
        final part = DevicePart.fromJson({'pcl': 'Red'});

        expect(part.partColor, 'Red');
        expect(part.toJson()['pcl'], 'Red');
      });

      test('prId maps to prid', () {
        final part = DevicePart.fromJson({'prid': 75});

        expect(part.prId, 75);
        expect(part.toJson()['prid'], 75);
      });

      test('action maps to ac', () {
        final part = DevicePart.fromJson({'ac': 'ACTION_CODE'});

        expect(part.action, 'ACTION_CODE');
        expect(part.toJson()['ac'], 'ACTION_CODE');
      });

      test('categoryCode maps to cc', () {
        final part = DevicePart.fromJson({'cc': 'CAT_CODE'});

        expect(part.categoryCode, 'CAT_CODE');
        expect(part.toJson()['cc'], 'CAT_CODE');
      });

      test('partVariantName maps to pvn', () {
        final part = DevicePart.fromJson({'pvn': 'Variant'});

        expect(part.partVariantName, 'Variant');
        expect(part.toJson()['pvn'], 'Variant');
      });

      test('retrievedPartData maps to rpd', () {
        final part = DevicePart.fromJson({'rpd': {'key': 'value'}});

        expect(part.retrievedPartData, {'key': 'value'});
        expect(part.toJson()['rpd'], {'key': 'value'});
      });
    });

    group('round-trip serialization', () {
      test('fromJson then toJson preserves all data', () {
        final originalJson = {
          'sku': 'ROUND-TRIP-SKU',
          'pn': 'Round Trip Part',
          'pbr': 'RT-PART',
          'dna': 'Round Trip Device',
          'dbr': 'RT-DEV',
          'pid': 123,
          'pcl': 'Blue',
          'isBulk': true,
          'isUrgent': true,
          'prid': 456,
          'isService': true,
          'ac': 'RT_ACTION',
          'cc': 'RT_CAT',
          'pvn': 'RT Variant',
          'rpd': {'nested': 'data'},
        };

        final part = DevicePart.fromJson(originalJson);
        final resultJson = part.toJson();

        expect(resultJson['sku'], originalJson['sku']);
        expect(resultJson['pn'], originalJson['pn']);
        expect(resultJson['pbr'], originalJson['pbr']);
        expect(resultJson['dna'], originalJson['dna']);
        expect(resultJson['dbr'], originalJson['dbr']);
        expect(resultJson['pid'], originalJson['pid']);
        expect(resultJson['pcl'], originalJson['pcl']);
        expect(resultJson['isBulk'], originalJson['isBulk']);
        expect(resultJson['isUrgent'], originalJson['isUrgent']);
        expect(resultJson['prid'], originalJson['prid']);
        expect(resultJson['isService'], originalJson['isService']);
        expect(resultJson['ac'], originalJson['ac']);
        expect(resultJson['cc'], originalJson['cc']);
        expect(resultJson['pvn'], originalJson['pvn']);
        expect(resultJson['rpd'], originalJson['rpd']);
      });
    });
  });
}
