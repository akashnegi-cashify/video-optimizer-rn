import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Widget imports
import 'package:flutter_trc/src/modules/engineer/widgets/part_request_reasons_widget.dart';
import 'package:flutter_trc/src/modules/engineer/providers/part_request_reasons_provider.dart';
import 'package:flutter_trc/src/modules/engineer/models/reason_list_response.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/order_engineer_part.dart';

/// Mock for PartRequestReasonsProvider
class MockPartRequestReasonsProvider extends Mock implements PartRequestReasonsProvider {
  @override
  List<OrderEngineerPart> partRequestList;

  @override
  bool isPageLoading;

  @override
  String? reasonListError;

  MockPartRequestReasonsProvider({
    List<OrderEngineerPart>? partList,
    this.isPageLoading = false,
    this.reasonListError,
  }) : partRequestList = partList ?? [];

  @override
  bool isReasonRequired(OrderEngineerPart item) => false;

  @override
  bool isAllReasonsSelected() => true;

  @override
  List<OrderEngineerPart> filterRequestedPartList() => partRequestList;

  @override
  List<DropDownItem<ReasonListData>>? getReasonsAccToCategoryCode(String categoryCode) => [];
}

void main() {
  group('PartRequestReasonsWidget', () {
    group('unit tests', () {
      test('PartRequestReasonsWidget is a StatelessWidget', () {
        const widget = PartRequestReasonsWidget(null);
        expect(widget, isA<StatelessWidget>());
      });

      test('PartRequestReasonsWidget can be instantiated with null callback', () {
        const widget = PartRequestReasonsWidget(null);
        expect(widget, isNotNull);
      });

      test('PartRequestReasonsWidget can be instantiated with callback', () {
        void callback(List<OrderEngineerPart> partList) {}
        final widget = PartRequestReasonsWidget(callback);
        expect(widget, isNotNull);
      });

      test('PartRequestReasonsWidget can be instantiated with key', () {
        const key = Key('part_request_reasons_widget_key');
        const widget = PartRequestReasonsWidget(null, key: key);
        expect(widget.key, equals(key));
      });

      test('PartRequestReasonsWidget implements PartRequestReasonInterface', () {
        const widget = PartRequestReasonsWidget(null);
        expect(widget, isA<PartRequestReasonInterface>());
      });
    });
  });

  group('MockPartRequestReasonsProvider', () {
    test('can be instantiated with default values', () {
      final provider = MockPartRequestReasonsProvider();
      expect(provider, isNotNull);
      expect(provider.partRequestList, isEmpty);
      expect(provider.isPageLoading, false);
      expect(provider.reasonListError, isNull);
    });

    test('can be instantiated with custom partList', () {
      final partList = [OrderEngineerPart(1)];
      final provider = MockPartRequestReasonsProvider(partList: partList);
      expect(provider.partRequestList.length, 1);
    });

    test('can be instantiated with isPageLoading true', () {
      final provider = MockPartRequestReasonsProvider(isPageLoading: true);
      expect(provider.isPageLoading, true);
    });

    test('can be instantiated with reasonListError', () {
      final provider = MockPartRequestReasonsProvider(
        reasonListError: 'Error loading reasons',
      );
      expect(provider.reasonListError, 'Error loading reasons');
    });

    test('isReasonRequired returns false by default', () {
      final provider = MockPartRequestReasonsProvider();
      final part = OrderEngineerPart(1);
      expect(provider.isReasonRequired(part), false);
    });

    test('isAllReasonsSelected returns true by default', () {
      final provider = MockPartRequestReasonsProvider();
      expect(provider.isAllReasonsSelected(), true);
    });

    test('filterRequestedPartList returns partRequestList', () {
      final partList = [OrderEngineerPart(1), OrderEngineerPart(2)];
      final provider = MockPartRequestReasonsProvider(partList: partList);
      expect(provider.filterRequestedPartList(), equals(partList));
    });

    test('getReasonsAccToCategoryCode returns empty list', () {
      final provider = MockPartRequestReasonsProvider();
      expect(provider.getReasonsAccToCategoryCode('SCREEN'), isEmpty);
    });
  });

  group('PartRequestReasonInterface', () {
    test('PartRequestReasonsWidget implements noReasonRequired method', () {
      final partList = [OrderEngineerPart(1)];
      List<OrderEngineerPart>? receivedPartList;
      
      final widget = PartRequestReasonsWidget((list) {
        receivedPartList = list;
      });
      
      widget.noReasonRequired(partList);
      expect(receivedPartList, equals(partList));
    });

    test('noReasonRequired with null callback does not throw', () {
      const widget = PartRequestReasonsWidget(null);
      final partList = [OrderEngineerPart(1)];
      
      // Should not throw
      expect(() => widget.noReasonRequired(partList), returnsNormally);
    });
  });
}
