import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/assiged_device_details_widget.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/assigned_device_details.dart';

void main() {
  group('AssignedDeviceDetailsWidget', () {
    test('is a StatelessWidget', () {
      const widget = AssignedDeviceDetailsWidget(
        isLoading: false,
        dataModel: null,
      );
      expect(widget, isA<StatelessWidget>());
    });

    test('accepts isLoading parameter', () {
      const widget = AssignedDeviceDetailsWidget(
        isLoading: true,
        dataModel: null,
      );
      expect(widget.isLoading, true);
    });

    test('accepts null dataModel', () {
      const widget = AssignedDeviceDetailsWidget(
        isLoading: false,
        dataModel: null,
      );
      expect(widget.dataModel, isNull);
    });

    test('accepts AssignDeviceDetailsData model', () {
      final dataModel = AssignDeviceDetailsData(
        deviceBarcode: 'DEV-001',
        productName: 'iPhone 12',
      );
      final widget = AssignedDeviceDetailsWidget(
        isLoading: false,
        dataModel: dataModel,
      );
      expect(widget.dataModel?.deviceBarcode, 'DEV-001');
      expect(widget.dataModel?.productName, 'iPhone 12');
    });

    test('accepts errorMessage parameter', () {
      const widget = AssignedDeviceDetailsWidget(
        isLoading: false,
        dataModel: null,
        errorMessage: 'Test error',
      );
      expect(widget.errorMessage, 'Test error');
    });

    test('accepts null errorMessage', () {
      const widget = AssignedDeviceDetailsWidget(
        isLoading: false,
        dataModel: null,
        errorMessage: null,
      );
      expect(widget.errorMessage, isNull);
    });

    test('stores all data model properties', () {
      final dataModel = AssignDeviceDetailsData(
        deviceBarcode: 'DEV-002',
        productName: 'Galaxy S21',
        engineerName: 'Engineer John',
        lc: 'Location B',
      );
      final widget = AssignedDeviceDetailsWidget(
        isLoading: false,
        dataModel: dataModel,
      );
      expect(widget.dataModel?.deviceBarcode, 'DEV-002');
      expect(widget.dataModel?.productName, 'Galaxy S21');
      expect(widget.dataModel?.engineerName, 'Engineer John');
      expect(widget.dataModel?.lc, 'Location B');
    });
  });
}
