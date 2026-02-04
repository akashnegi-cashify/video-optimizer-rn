import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Widget imports
import 'package:flutter_trc/src/modules/engineer/retreived_parts/widgets/retrieved_parts_data_details_widget.dart';
import 'package:flutter_trc/src/modules/engineer/retreived_parts/providers/retrieved_part_data_provider.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';

/// Mock for RetrievedPartsDataProviders
class MockRetrievedPartsDataProviders extends Mock implements RetrievedPartsDataProviders {
  @override
  EngineerPartInfo? partInfo;

  @override
  VoidCallback? onSuccess;

  MockRetrievedPartsDataProviders({
    this.partInfo,
    this.onSuccess,
  });

  @override
  bool isMandatoryFieldsSubmitted() => true;

  @override
  Future<void> updateRetrievedPartWithDeviceReceive(String? partBarcode) async {}
}

void main() {
  group('RetrievedPartsDataDetailsWidget', () {
    group('unit tests', () {
      test('RetrievedPartsDataDetailsWidget is a StatefulWidget', () {
        const widget = RetrievedPartsDataDetailsWidget();
        expect(widget, isA<StatefulWidget>());
      });

      test('RetrievedPartsDataDetailsWidget can be instantiated with default constructor', () {
        const widget = RetrievedPartsDataDetailsWidget();
        expect(widget, isNotNull);
        expect(widget.key, isNull);
      });

      test('RetrievedPartsDataDetailsWidget can be instantiated with a key', () {
        const key = Key('retrieved_parts_data_details_widget_key');
        const widget = RetrievedPartsDataDetailsWidget(key: key);
        expect(widget.key, equals(key));
      });

      test('RetrievedPartsDataDetailsWidget creates state correctly', () {
        const widget = RetrievedPartsDataDetailsWidget();
        final element = widget.createElement();
        expect(element, isNotNull);
      });

      test('multiple instances can be created independently', () {
        const widget1 = RetrievedPartsDataDetailsWidget(key: Key('widget1'));
        const widget2 = RetrievedPartsDataDetailsWidget(key: Key('widget2'));
        expect(widget1.key, isNot(equals(widget2.key)));
      });

      test('createState returns non-null state', () {
        const widget = RetrievedPartsDataDetailsWidget();
        final state = widget.createState();
        expect(state, isNotNull);
      });
    });
  });

  group('MockRetrievedPartsDataProviders', () {
    test('can be instantiated with default values', () {
      final provider = MockRetrievedPartsDataProviders();
      expect(provider, isNotNull);
      expect(provider.partInfo, isNull);
      expect(provider.onSuccess, isNull);
    });

    test('can be instantiated with part info', () {
      final partJson = <String, dynamic>{
        'pn': 'Screen',
        'pb': 'BARCODE123',
        'sku': 'SKU123',
        'prId': 1,
      };
      final partInfo = EngineerPartInfo.fromJson(partJson);
      final provider = MockRetrievedPartsDataProviders(partInfo: partInfo);
      expect(provider.partInfo, isNotNull);
      expect(provider.partInfo?.partName, 'Screen');
    });

    test('can be instantiated with onSuccess callback', () {
      var callbackInvoked = false;
      final provider = MockRetrievedPartsDataProviders(
        onSuccess: () => callbackInvoked = true,
      );
      provider.onSuccess?.call();
      expect(callbackInvoked, true);
    });

    test('isMandatoryFieldsSubmitted returns true by default', () {
      final provider = MockRetrievedPartsDataProviders();
      expect(provider.isMandatoryFieldsSubmitted(), true);
    });

    test('updateRetrievedPartWithDeviceReceive completes successfully', () async {
      final provider = MockRetrievedPartsDataProviders();
      await expectLater(provider.updateRetrievedPartWithDeviceReceive('BARCODE123'), completes);
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
      final info = EngineerPartInfo.fromJson(json);

      expect(info, isNotNull);
      expect(info.partName, 'Screen');
      expect(info.partBarcode, 'BARCODE123');
      expect(info.sku, 'SKU123');
      expect(info.status, 'Assigned');
      expect(info.statusCode, 12);
    });

    test('EngineerPartInfo handles null values in json', () {
      final json = <String, dynamic>{};
      final info = EngineerPartInfo.fromJson(json);

      expect(info, isNotNull);
      expect(info.partName, isNull);
      expect(info.partBarcode, isNull);
      expect(info.sku, isNull);
      expect(info.status, isNull);
      expect(info.statusCode, isNull);
    });

    test('EngineerPartInfo with retrieved image count', () {
      final json = <String, dynamic>{
        'pn': 'Screen',
        'rvc': 3,
      };
      final info = EngineerPartInfo.fromJson(json);

      expect(info.partName, 'Screen');
      expect(info.retrievedImageCount, 3);
    });

    test('EngineerPartInfo with isRetrievedPartAssign flag', () {
      final json = <String, dynamic>{
        'pn': 'Screen',
        'isrpa': true,
      };
      final info = EngineerPartInfo.fromJson(json);

      expect(info.partName, 'Screen');
      expect(info.isRetrievedPartAssign, true);
    });
  });

  group('StatusCode enum', () {
    test('availableStatusCode has value 12', () {
      expect(StatusCode.availableStatusCode.value, 12);
    });

    test('notAvailableStatusCode has value 13', () {
      expect(StatusCode.notAvailableStatusCode.value, 13);
    });

    test('requestedStatusCode has value 11', () {
      expect(StatusCode.requestedStatusCode.value, 11);
    });

    test('allottedStatusCode has value 22', () {
      expect(StatusCode.allottedStatusCode.value, 22);
    });

    test('riderDeliveryPickedStatusCode has value 25', () {
      expect(StatusCode.riderDeliveryPickedStatusCode.value, 25);
    });

    test('receiveStatusCode has value 33', () {
      expect(StatusCode.receiveStatusCode.value, 33);
    });

    test('consumedStatusCode has value 99', () {
      expect(StatusCode.consumedStatusCode.value, 99);
    });

    test('initiated has value 0', () {
      expect(StatusCode.initiated.value, 0);
    });
  });
}
