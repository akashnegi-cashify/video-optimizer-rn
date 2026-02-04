import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Widget imports
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/widgets/order_part_widget.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/providers/order_part_provider.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/order_engineer_part.dart';

/// Mock for OrderPartProvider
class MockOrderPartProvider extends Mock implements OrderPartProvider {
  @override
  List<OrderEngineerPart> get partsList => [];

  @override
  bool get isLoading => false;

  @override
  String? get errorMessage => null;
}

void main() {
  group('OrderPartScreen', () {
    group('unit tests', () {
      test('OrderPartScreen is a StatelessWidget', () {
        const widget = OrderPartScreen();
        expect(widget, isA<StatelessWidget>());
      });

      test('OrderPartScreen can be instantiated with default constructor', () {
        const widget = OrderPartScreen();
        expect(widget, isNotNull);
        expect(widget.key, isNull);
      });

      test('OrderPartScreen can be instantiated with a key', () {
        const key = Key('order_part_screen_key');
        const widget = OrderPartScreen(key: key);
        expect(widget.key, equals(key));
      });

      test('OrderPartScreen has correct route', () {
        expect(OrderPartScreen.route, 'engineer/part/order-part');
      });
    });
  });

  group('OrderPartScreenArg', () {
    test('can be instantiated with device barcode', () {
      final arg = OrderPartScreenArg('DEVICE123');
      expect(arg, isNotNull);
      expect(arg.deviceBarcode, 'DEVICE123');
    });

    test('can be instantiated with null device barcode', () {
      final arg = OrderPartScreenArg(null);
      expect(arg, isNotNull);
      expect(arg.deviceBarcode, isNull);
    });
  });

  group('OrderEngineerPart model', () {
    test('OrderEngineerPart can be instantiated with required parameter', () {
      final part = OrderEngineerPart(1);
      expect(part, isNotNull);
      expect(part.orderQuantity, 1);
    });

    test('OrderEngineerPart can be instantiated with version', () {
      final part = OrderEngineerPart(2, version: 1);
      expect(part, isNotNull);
      expect(part.orderQuantity, 2);
      expect(part.version, 1);
    });

    test('OrderEngineerPart reasonId can be set', () {
      final part = OrderEngineerPart(1);
      part.reasonId = 5;
      expect(part.reasonId, 5);
    });

    test('OrderEngineerPart imageList can be set', () {
      final part = OrderEngineerPart(1);
      part.imageList = ['http://image1.url', 'http://image2.url'];
      expect(part.imageList, ['http://image1.url', 'http://image2.url']);
    });

    test('OrderEngineerPart fromJson works', () {
      final json = {
        'pn': 'Screen',
        'sku': 'SKU123',
        'pcl': 'Black',
        'action': 1,
        'cc': 'SCREEN',
        'qty': 2,
        '_v': 0,
      };

      final part = OrderEngineerPart.fromJson(json);

      expect(part.partName, 'Screen');
      expect(part.sku, 'SKU123');
      expect(part.partColor, 'Black');
      expect(part.orderQuantity, 2);
    });

    test('OrderEngineerPart toJson works', () {
      final part = OrderEngineerPart(1);
      part.reasonId = 5;
      part.imageList = ['http://image.url'];

      final json = part.toJson();

      expect(json['qty'], 1);
      expect(json['rrid'], 5);
      expect(json['imgs'], ['http://image.url']);
    });

    test('OrderEngineerPart selectedPartType setter works', () {
      final part = OrderEngineerPart(0);
      expect(part.selectedPartType, isNull);
      
      final dropDownItem = DropDownItem<dynamic>('1', 'Repair Required');
      part.selectedPartType = dropDownItem;
      
      expect(part.selectedPartType, equals(dropDownItem));
      expect(part.partType, 1);
      expect(part.orderQuantity, 1);
    });

    test('OrderEngineerPart selectedPartType setter with null clears partType', () {
      final part = OrderEngineerPart(1);
      part.selectedPartType = DropDownItem<dynamic>('1', 'Test');
      expect(part.partType, 1);
      
      part.selectedPartType = null;
      expect(part.partType, isNull);
    });
  });

  group('MockOrderPartProvider', () {
    test('MockOrderPartProvider can be instantiated', () {
      final mockProvider = MockOrderPartProvider();
      expect(mockProvider, isNotNull);
    });

    test('MockOrderPartProvider returns empty partsList', () {
      final mockProvider = MockOrderPartProvider();
      expect(mockProvider.partsList, isEmpty);
    });

    test('MockOrderPartProvider isLoading returns false', () {
      final mockProvider = MockOrderPartProvider();
      expect(mockProvider.isLoading, false);
    });

    test('MockOrderPartProvider errorMessage returns null', () {
      final mockProvider = MockOrderPartProvider();
      expect(mockProvider.errorMessage, isNull);
    });
  });
}
