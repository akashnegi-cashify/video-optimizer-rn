import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/assinged_device_alloted_parts_list_widget.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/device_alloted_parts_response.dart';

void main() {
  group('AssignedDeviceAllottedPartsList', () {
    test('is a StatelessWidget', () {
      const widget = AssignedDeviceAllottedPartsList(
        isLoading: false,
        dataModel: null,
        errorMessage: null,
      );
      expect(widget, isA<StatelessWidget>());
    });

    test('accepts isLoading parameter', () {
      const widget = AssignedDeviceAllottedPartsList(
        isLoading: true,
        dataModel: null,
        errorMessage: null,
      );
      expect(widget.isLoading, true);
    });

    test('accepts null dataModel', () {
      const widget = AssignedDeviceAllottedPartsList(
        isLoading: false,
        dataModel: null,
        errorMessage: null,
      );
      expect(widget.dataModel, isNull);
    });

    test('accepts DeviceAllottedPartsResponse model', () {
      final dataModel = DeviceAllottedPartsResponse(
        allottedPartsList: [
          DeviceAllottedPartsData(productName: 'Part 1', prid: 1),
        ],
      );
      final widget = AssignedDeviceAllottedPartsList(
        isLoading: false,
        dataModel: dataModel,
        errorMessage: null,
      );
      expect(widget.dataModel?.allottedPartsList?.length, 1);
    });

    test('accepts errorMessage parameter', () {
      const widget = AssignedDeviceAllottedPartsList(
        isLoading: false,
        dataModel: null,
        errorMessage: 'Test Error',
      );
      expect(widget.errorMessage, 'Test Error');
    });

    test('accepts null errorMessage', () {
      const widget = AssignedDeviceAllottedPartsList(
        isLoading: false,
        dataModel: null,
        errorMessage: null,
      );
      expect(widget.errorMessage, isNull);
    });

    test('handles empty allottedPartsList', () {
      final dataModel = DeviceAllottedPartsResponse(
        allottedPartsList: [],
      );
      final widget = AssignedDeviceAllottedPartsList(
        isLoading: false,
        dataModel: dataModel,
        errorMessage: null,
      );
      expect(widget.dataModel?.allottedPartsList, isEmpty);
    });

    test('handles null allottedPartsList', () {
      final dataModel = DeviceAllottedPartsResponse(
        allottedPartsList: null,
      );
      final widget = AssignedDeviceAllottedPartsList(
        isLoading: false,
        dataModel: dataModel,
        errorMessage: null,
      );
      expect(widget.dataModel?.allottedPartsList, isNull);
    });

    test('stores multiple allotted parts', () {
      final dataModel = DeviceAllottedPartsResponse(
        allottedPartsList: [
          DeviceAllottedPartsData(productName: 'Part A', prid: 1),
          DeviceAllottedPartsData(productName: 'Part B', prid: 2),
          DeviceAllottedPartsData(productName: 'Part C', prid: 3),
        ],
      );
      final widget = AssignedDeviceAllottedPartsList(
        isLoading: false,
        dataModel: dataModel,
        errorMessage: null,
      );
      expect(widget.dataModel?.allottedPartsList?.length, 3);
    });
  });
}
