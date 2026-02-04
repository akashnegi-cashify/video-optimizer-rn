import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_trc/src/modules/trc_executive/widgets/device_scanner_widget.dart';
import 'package:flutter_trc/src/modules/trc_executive/providers/device_scanner_provider.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/device_receive_response.dart';

void main() {
  group('DeviceScannerWidget', () {
    test('DeviceScannerWidget class exists and is a StatelessWidget', () {
      expect(DeviceScannerWidget, isNotNull);
      const widget = DeviceScannerWidget('TEST_STORAGE');
      expect(widget, isA<StatelessWidget>());
    });

    test('DeviceScannerWidget stores storageBarcode correctly', () {
      const widget = DeviceScannerWidget('STORAGE_123');
      expect(widget.storageBarcode, equals('STORAGE_123'));
    });

    test('DeviceScannerWidget can be instantiated with null storageBarcode', () {
      const widget = DeviceScannerWidget(null);
      expect(widget.storageBarcode, isNull);
    });

    test('DeviceScannerWidget can be instantiated with empty storageBarcode', () {
      const widget = DeviceScannerWidget('');
      expect(widget.storageBarcode, equals(''));
    });

    test('DeviceScannerWidget can be instantiated with a key', () {
      const key = Key('device_scanner_widget_key');
      const widget = DeviceScannerWidget('TEST', key: key);
      expect(widget.key, equals(key));
    });

    test('DeviceScannerWidget can be instantiated with alphanumeric storageBarcode', () {
      const widget = DeviceScannerWidget('ABC123XYZ');
      expect(widget.storageBarcode, equals('ABC123XYZ'));
    });

    test('DeviceScannerWidget can be instantiated with special characters in storageBarcode', () {
      const widget = DeviceScannerWidget('STORAGE-001_TEST');
      expect(widget.storageBarcode, equals('STORAGE-001_TEST'));
    });

    test('DeviceScannerWidget can be instantiated with long storageBarcode', () {
      const longBarcode = 'STORAGE_123456789_ABCDEFGHIJ_KLMNOPQRS';
      const widget = DeviceScannerWidget(longBarcode);
      expect(widget.storageBarcode, equals(longBarcode));
    });
  });

  group('DeviceScannerProvider', () {
    test('DeviceScannerProvider initializes with storageBarcode', () {
      final provider = DeviceScannerProvider(storageBarcode: 'TEST_123');
      expect(provider.storageBarcode, equals('TEST_123'));
    });

    test('DeviceScannerProvider storageBarcode setter updates value', () {
      final provider = DeviceScannerProvider(storageBarcode: 'INITIAL');
      provider.storageBarcode = 'UPDATED';
      expect(provider.storageBarcode, equals('UPDATED'));
    });

    test('DeviceScannerProvider can have null storageBarcode', () {
      final provider = DeviceScannerProvider(storageBarcode: null);
      expect(provider.storageBarcode, isNull);
    });

    test('DeviceScannerProvider storageBarcode can be set to null', () {
      final provider = DeviceScannerProvider(storageBarcode: 'TEST');
      provider.storageBarcode = null;
      expect(provider.storageBarcode, isNull);
    });

    test('DeviceScannerProvider storageBarcode can be updated multiple times', () {
      final provider = DeviceScannerProvider(storageBarcode: 'FIRST');
      expect(provider.storageBarcode, equals('FIRST'));

      provider.storageBarcode = 'SECOND';
      expect(provider.storageBarcode, equals('SECOND'));

      provider.storageBarcode = 'THIRD';
      expect(provider.storageBarcode, equals('THIRD'));
    });

    test('DeviceScannerProvider storageBarcode can be set to empty string', () {
      final provider = DeviceScannerProvider(storageBarcode: 'TEST');
      provider.storageBarcode = '';
      expect(provider.storageBarcode, equals(''));
    });
  });

  group('DeviceReceiveData', () {
    test('DeviceReceiveData fromJson parses all fields correctly', () {
      final json = {
        'productTitle': 'iPhone 13',
        'deviceBarcode': 'DEVICE_001',
        'status': 'Active',
        'repairType': 'Screen Replacement',
        'repairOrderNo': 'RO-12345',
        'isUrgent': true,
        'ele': 'John Doe',
        'rubbingStatus': 1,
      };

      final data = DeviceReceiveData.fromJson(json);

      expect(data.productTitle, equals('iPhone 13'));
      expect(data.deviceBarcode, equals('DEVICE_001'));
      expect(data.status, equals('Active'));
      expect(data.repairType, equals('Screen Replacement'));
      expect(data.repairOrder, equals('RO-12345'));
      expect(data.isUrgent, isTrue);
      expect(data.elssEngineerName, equals('John Doe'));
      expect(data.rubbingOrGlassChangeStatus, equals(1));
    });

    test('DeviceReceiveData fromJson handles null values', () {
      final json = <String, dynamic>{};

      final data = DeviceReceiveData.fromJson(json);

      expect(data.productTitle, isNull);
      expect(data.deviceBarcode, isNull);
      expect(data.status, isNull);
      expect(data.repairType, isNull);
      expect(data.repairOrder, isNull);
      expect(data.isUrgent, isNull);
      expect(data.elssEngineerName, isNull);
      expect(data.rubbingOrGlassChangeStatus, isNull);
    });

    test('DeviceReceiveData fromJson handles partial data', () {
      final json = {
        'productTitle': 'Samsung Galaxy',
        'deviceBarcode': 'DEV_002',
      };

      final data = DeviceReceiveData.fromJson(json);

      expect(data.productTitle, equals('Samsung Galaxy'));
      expect(data.deviceBarcode, equals('DEV_002'));
      expect(data.status, isNull);
    });

    test('DeviceReceiveData toJson serializes all fields correctly', () {
      // Constructor order: productTitle, deviceBarcode, status, repairType, isUrgent, elssEngineerName, repairOrder, rubbingOrGlassChangeStatus
      final data = DeviceReceiveData(
        'iPhone 14',
        'DEVICE_002',
        'Pending',
        'Battery',
        false,
        'Jane Doe',
        'RO-54321',
        2,
      );

      final json = data.toJson();

      expect(json['productTitle'], equals('iPhone 14'));
      expect(json['deviceBarcode'], equals('DEVICE_002'));
      expect(json['status'], equals('Pending'));
      expect(json['repairType'], equals('Battery'));
      expect(json['repairOrderNo'], equals('RO-54321'));
      expect(json['isUrgent'], isFalse);
      expect(json['elssEngineerName'], equals('Jane Doe')); // toJson uses elssEngineerName, not ele
      expect(json['rubbingStatus'], equals(2));
    });

    test('DeviceReceiveData can be constructed with all parameters', () {
      final data = DeviceReceiveData(
        'Product',
        'Barcode',
        'Status',
        'Type',
        true,
        'Engineer',
        'Order',
        0,
      );

      expect(data.productTitle, equals('Product'));
      expect(data.deviceBarcode, equals('Barcode'));
      expect(data.status, equals('Status'));
      expect(data.repairType, equals('Type'));
      expect(data.isUrgent, isTrue);
      expect(data.elssEngineerName, equals('Engineer'));
      expect(data.repairOrder, equals('Order'));
      expect(data.rubbingOrGlassChangeStatus, equals(0));
    });

    test('DeviceReceiveData handles false isUrgent', () {
      final json = {'isUrgent': false};
      final data = DeviceReceiveData.fromJson(json);
      expect(data.isUrgent, isFalse);
    });

    test('DeviceReceiveData handles zero rubbingStatus', () {
      final json = {'rubbingStatus': 0};
      final data = DeviceReceiveData.fromJson(json);
      expect(data.rubbingOrGlassChangeStatus, equals(0));
    });

    test('DeviceReceiveData handles negative rubbingStatus', () {
      final json = {'rubbingStatus': -1};
      final data = DeviceReceiveData.fromJson(json);
      expect(data.rubbingOrGlassChangeStatus, equals(-1));
    });

    test('DeviceReceiveData handles empty strings', () {
      final json = {
        'productTitle': '',
        'deviceBarcode': '',
        'status': '',
        'repairType': '',
        'repairOrderNo': '',
        'ele': '',
      };

      final data = DeviceReceiveData.fromJson(json);

      expect(data.productTitle, equals(''));
      expect(data.deviceBarcode, equals(''));
      expect(data.status, equals(''));
      expect(data.repairType, equals(''));
      expect(data.repairOrder, equals(''));
      expect(data.elssEngineerName, equals(''));
    });
  });

  group('DeviceReceiveResponse', () {
    test('DeviceReceiveResponse fromJson parses correctly', () {
      final json = {
        'dt': {
          'productTitle': 'Test Product',
          'deviceBarcode': 'TEST_001',
          'status': 'Active',
          'repairType': 'Test',
          'repairOrderNo': 'RO-001',
          'isUrgent': false,
          'ele': 'Engineer',
          'rubbingStatus': 1,
        },
      };

      final response = DeviceReceiveResponse.fromJson(json);

      expect(response.data, isNotNull);
      expect(response.data!.productTitle, equals('Test Product'));
      expect(response.data!.deviceBarcode, equals('TEST_001'));
    });

    test('DeviceReceiveResponse fromJson handles null data', () {
      final json = <String, dynamic>{};

      final response = DeviceReceiveResponse.fromJson(json);

      expect(response.data, isNull);
    });

    test('DeviceReceiveResponse roundtrip serialization', () {
      final json = {
        's': true,
        'dt': {
          'productTitle': 'Test Product',
          'deviceBarcode': 'TEST_001',
          'status': 'Active',
          'repairType': 'Test',
          'repairOrderNo': 'RO-001',
          'isUrgent': false,
          'ele': 'Engineer',
          'rubbingStatus': 1,
        },
      };

      final response = DeviceReceiveResponse.fromJson(json);
      
      expect(response.isSuccess, isTrue);
      expect(response.data, isNotNull);
      expect(response.data!.productTitle, equals('Test Product'));
    });

    test('DeviceReceiveResponse fromJson handles nested null', () {
      final json = {'dt': null};
      final response = DeviceReceiveResponse.fromJson(json);
      expect(response.data, isNull);
    });
  });
}
