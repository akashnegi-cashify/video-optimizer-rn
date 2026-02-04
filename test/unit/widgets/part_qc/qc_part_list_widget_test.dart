import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;

// Actual widget import
import 'package:flutter_trc/src/modules/part_qc/widgets/qc_part_list_widget.dart';
import 'package:flutter_trc/src/modules/part_qc/models/qc_parts_list_response.dart';

void main() {
  group('QcPartListItemWidget', () {
    group('unit tests', () {
      test('QcPartListItemWidget class exists', () {
        expect(QcPartListItemWidget, isNotNull);
      });

      test('widget is a StatelessWidget', () {
        const widget = QcPartListItemWidget(onCardClicked: _dummyCallback);
        expect(widget, isA<StatelessWidget>());
      });

      test('can be instantiated with default constructor', () {
        const widget = QcPartListItemWidget(onCardClicked: _dummyCallback);
        expect(widget, isNotNull);
      });

      test('can be instantiated with a key', () {
        const key = Key('qc_part_list_item_key');
        const widget = QcPartListItemWidget(
          key: key,
          onCardClicked: _dummyCallback,
        );
        expect(widget.key, equals(key));
      });

      test('accepts null dataModel', () {
        const widget = QcPartListItemWidget(
          dataModel: null,
          onCardClicked: _dummyCallback,
        );
        expect(widget.dataModel, isNull);
      });

      test('accepts non-null dataModel', () {
        final dataModel = QcPartListData(
          prid: 123,
          sku: 'SKU-001',
          partName: 'Test Part',
        );
        final widget = QcPartListItemWidget(
          dataModel: dataModel,
          onCardClicked: _dummyCallback,
        );
        expect(widget.dataModel, isNotNull);
        expect(widget.dataModel?.prid, 123);
      });

      test('dataModel can have all fields populated', () {
        final dataModel = QcPartListData(
          prid: 123,
          sku: 'SKU-001',
          partName: 'Test Part',
          partBarcode: 'PB-001',
          partVariantName: 'Variant A',
          status: 'Pending',
          statusCode: 1,
          requestedQuantity: 5,
          isDamaged: false,
          isBulk: true,
        );
        expect(dataModel.prid, 123);
        expect(dataModel.sku, 'SKU-001');
        expect(dataModel.partName, 'Test Part');
        expect(dataModel.partBarcode, 'PB-001');
        expect(dataModel.partVariantName, 'Variant A');
        expect(dataModel.status, 'Pending');
        expect(dataModel.statusCode, 1);
        expect(dataModel.requestedQuantity, 5);
        expect(dataModel.isDamaged, false);
        expect(dataModel.isBulk, true);
      });

      test('multiple instances can be created independently', () {
        const widget1 = QcPartListItemWidget(
          key: Key('widget1'),
          onCardClicked: _dummyCallback,
        );
        const widget2 = QcPartListItemWidget(
          key: Key('widget2'),
          onCardClicked: _dummyCallback,
        );
        expect(widget1.key, isNot(equals(widget2.key)));
      });
    });

    group('widget type tests', () {
      test('QcPartListItemWidget is a StatelessWidget', () {
        const widget = QcPartListItemWidget(onCardClicked: _dummyCallback);
        expect(widget, isA<StatelessWidget>());
      });

      test('QcPartListItemWidget is not a StatefulWidget', () {
        const widget = QcPartListItemWidget(onCardClicked: _dummyCallback);
        expect(widget, isNot(isA<StatefulWidget>()));
      });
    });

    group('QcPartListData model tests', () {
      test('QcPartListData can be created with minimal fields', () {
        final data = QcPartListData(prid: 1);
        expect(data.prid, 1);
        expect(data.sku, isNull);
        expect(data.partName, isNull);
      });

      test('QcPartListData can be serialized to JSON', () {
        final data = QcPartListData(
          prid: 123,
          sku: 'SKU-001',
          partName: 'Test Part',
        );
        final json = data.toJson();
        expect(json, isA<Map<String, dynamic>>());
        expect(json['prid'], 123);
        expect(json['sku'], 'SKU-001');
        expect(json['pn'], 'Test Part');
      });

      test('QcPartListData can be deserialized from JSON', () {
        final json = {
          'prid': 123,
          'sku': 'SKU-001',
          'pn': 'Test Part',
          'pbr': 'PB-001',
          'pvn': 'Variant A',
        };
        final data = QcPartListData.fromJson(json);
        expect(data.prid, 123);
        expect(data.sku, 'SKU-001');
        expect(data.partName, 'Test Part');
        expect(data.partBarcode, 'PB-001');
        expect(data.partVariantName, 'Variant A');
      });

      test('QcPartListData handles null JSON values', () {
        final json = <String, dynamic>{
          'prid': null,
          'sku': null,
          'pn': null,
        };
        final data = QcPartListData.fromJson(json);
        expect(data.prid, isNull);
        expect(data.sku, isNull);
        expect(data.partName, isNull);
      });
    });

    group('callback tests', () {
      test('onCardClicked callback is required', () {
        // This test verifies the callback is a required parameter
        // by checking that the widget can be created with a callback
        bool callbackCalled = false;
        final widget = QcPartListItemWidget(
          onCardClicked: (isFaulty) {
            callbackCalled = true;
          },
        );
        expect(widget.onCardClicked, isNotNull);
      });

      test('onCardClicked receives boolean parameter', () {
        bool? receivedValue;
        void callback(bool isFaulty) {
          receivedValue = isFaulty;
        }

        final widget = QcPartListItemWidget(onCardClicked: callback);
        // Simulate calling the callback
        widget.onCardClicked(true);
        expect(receivedValue, true);

        widget.onCardClicked(false);
        expect(receivedValue, false);
      });
    });
  });
}

// Dummy callback for unit tests
void _dummyCallback(bool isFaulty) {}
