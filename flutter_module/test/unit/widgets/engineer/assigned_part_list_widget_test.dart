import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Widget imports
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/widgets/assigned_part_list_widget.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_info.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';

void main() {
  group('AssignedPartListWidget', () {
    group('unit tests', () {
      test('AssignedPartListWidget is a StatefulWidget', () {
        final json = {'deviceId': 1, 'deviceBarcode': 'TEST123'};
        final deviceInfo = EngineerDeviceInfo.fromJson(json);
        final widget = AssignedPartListWidget(deviceInfo: deviceInfo);
        expect(widget, isA<StatefulWidget>());
      });

      test('AssignedPartListWidget can be instantiated with required parameters', () {
        final json = {'deviceId': 1, 'deviceBarcode': 'TEST123'};
        final deviceInfo = EngineerDeviceInfo.fromJson(json);
        final widget = AssignedPartListWidget(deviceInfo: deviceInfo);
        expect(widget, isNotNull);
      });

      test('AssignedPartListWidget can be instantiated with a key', () {
        const key = Key('assigned_part_list_widget_key');
        final json = {'deviceId': 1, 'deviceBarcode': 'TEST123'};
        final deviceInfo = EngineerDeviceInfo.fromJson(json);
        final widget = AssignedPartListWidget(
          key: key,
          deviceInfo: deviceInfo,
        );
        expect(widget.key, equals(key));
      });

      test('AssignedPartListWidget stores device info correctly', () {
        final json = {
          'deviceId': 1,
          'deviceBarcode': 'MY_BARCODE',
          'productTitle': 'iPhone 12',
        };
        final deviceInfo = EngineerDeviceInfo.fromJson(json);
        final widget = AssignedPartListWidget(deviceInfo: deviceInfo);
        expect(widget.deviceInfo.deviceBarcode, 'MY_BARCODE');
        expect(widget.deviceInfo.productTitle, 'iPhone 12');
      });
    });
  });

  group('ItemPartWidget', () {
    test('ItemPartWidget is a StatelessWidget', () {
      final deviceJson = {'deviceId': 1, 'deviceBarcode': 'TEST123'};
      final partJson = <String, dynamic>{'pn': 'Screen', 'pb': 'PART123'};
      final deviceInfo = EngineerDeviceInfo.fromJson(deviceJson);
      final partInfo = EngineerPartInfo.fromJson(partJson);
      final widget = ItemPartWidget(
        part: partInfo,
        deviceInfo: deviceInfo,
      );
      expect(widget, isA<StatelessWidget>());
    });

    test('ItemPartWidget can be instantiated with optional callback', () {
      final deviceJson = {'deviceId': 1, 'deviceBarcode': 'TEST123'};
      final partJson = <String, dynamic>{'pn': 'Screen', 'pb': 'PART123'};
      final deviceInfo = EngineerDeviceInfo.fromJson(deviceJson);
      final partInfo = EngineerPartInfo.fromJson(partJson);
      final widget = ItemPartWidget(
        part: partInfo,
        deviceInfo: deviceInfo,
        onBottomSheetClosed: () {},
      );
      expect(widget, isNotNull);
    });

    test('ItemPartWidget can be instantiated with a key', () {
      const key = Key('item_part_widget_key');
      final deviceJson = {'deviceId': 1, 'deviceBarcode': 'TEST123'};
      final partJson = <String, dynamic>{'pn': 'Screen', 'pb': 'PART123'};
      final deviceInfo = EngineerDeviceInfo.fromJson(deviceJson);
      final partInfo = EngineerPartInfo.fromJson(partJson);
      final widget = ItemPartWidget(
        key: key,
        part: partInfo,
        deviceInfo: deviceInfo,
      );
      expect(widget.key, equals(key));
    });
  });

  group('EngineerPartInfo model', () {
    test('EngineerPartInfo can be instantiated from json', () {
      final json = <String, dynamic>{
        'pn': 'Screen',
        'pbr': 'BARCODE123',
        'sku': 'SKU123',
        'st': 'Assigned',
        'stc': 12,
      };
      final partInfo = EngineerPartInfo.fromJson(json);

      expect(partInfo, isNotNull);
      expect(partInfo.partName, 'Screen');
      expect(partInfo.partBarcode, 'BARCODE123');
      expect(partInfo.sku, 'SKU123');
      expect(partInfo.status, 'Assigned');
      expect(partInfo.statusCode, 12);
    });

    test('EngineerPartInfo handles null values in json', () {
      final json = <String, dynamic>{};
      final partInfo = EngineerPartInfo.fromJson(json);

      expect(partInfo, isNotNull);
      expect(partInfo.partName, isNull);
      expect(partInfo.partBarcode, isNull);
      expect(partInfo.sku, isNull);
      expect(partInfo.status, isNull);
      expect(partInfo.statusCode, isNull);
    });

    test('EngineerPartInfo with variant name', () {
      final json = <String, dynamic>{
        'pn': 'Screen',
        'pvn': 'Variant A',
      };
      final partInfo = EngineerPartInfo.fromJson(json);

      expect(partInfo.partName, 'Screen');
      expect(partInfo.partVariantName, 'Variant A');
    });

    test('EngineerPartInfo with action', () {
      final json = <String, dynamic>{
        'pn': 'Screen',
        'ac': 'Replace',
      };
      final partInfo = EngineerPartInfo.fromJson(json);

      expect(partInfo.partName, 'Screen');
      expect(partInfo.action, 'Replace');
    });

    test('EngineerPartInfo toJson works correctly', () {
      final json = <String, dynamic>{
        'pn': 'Screen',
        'pbr': 'BARCODE123',
        'sku': 'SKU123',
        'st': 'Assigned',
        'stc': 12,
      };
      final partInfo = EngineerPartInfo.fromJson(json);
      final outputJson = partInfo.toJson();

      expect(outputJson['pn'], 'Screen');
      expect(outputJson['pbr'], 'BARCODE123');
      expect(outputJson['sku'], 'SKU123');
      expect(outputJson['st'], 'Assigned');
      expect(outputJson['stc'], 12);
    });
  });
}
