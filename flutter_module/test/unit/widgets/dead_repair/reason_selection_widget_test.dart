import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Actual widget import
import 'package:flutter_trc/qc/modules/dead_repair/widgets/reason_selection_widget.dart';
import 'package:flutter_trc/qc/modules/dead_repair/type.dart';

void main() {
  group('ReasonSelectionWidget', () {
    test('ReasonSelectionWidget class exists and is a StatefulWidget', () {
      expect(ReasonSelectionWidget, isNotNull);
      final widget = ReasonSelectionWidget(
        roleType: RoleType.DEAD_DEVICE.value,
        reasonList: const ['Reason 1', 'Reason 2'],
      );
      expect(widget, isA<StatefulWidget>());
    });

    test('ReasonSelectionWidget can be instantiated with required parameters', () {
      final widget = ReasonSelectionWidget(
        roleType: RoleType.DEAD_DEVICE.value,
        reasonList: const ['Screen Broken', 'Battery Issue'],
      );
      expect(widget, isNotNull);
      expect(widget.roleType, equals(RoleType.DEAD_DEVICE.value));
      expect(widget.reasonList.length, equals(2));
    });

    test('ReasonSelectionWidget can be instantiated with code parameter', () {
      final widget = ReasonSelectionWidget(
        roleType: RoleType.DEAD_DEVICE.value,
        reasonList: const ['Reason 1'],
        code: 'DEVICE_CODE_123',
      );
      expect(widget.code, equals('DEVICE_CODE_123'));
    });

    test('ReasonSelectionWidget can be instantiated with markId parameter', () {
      final widget = ReasonSelectionWidget(
        roleType: RoleType.ACCEPT_REJECT_DEAD_DEVICE.value,
        reasonList: const ['Reason 1'],
        markId: 789,
      );
      expect(widget.markId, equals(789));
    });

    test('ReasonSelectionWidget can be instantiated with all parameters', () {
      final widget = ReasonSelectionWidget(
        roleType: RoleType.REPAIR_DEVICE.value,
        reasonList: const ['Repair 1', 'Repair 2', 'Repair 3'],
        code: 'REPAIR_CODE',
        markId: 100,
      );
      expect(widget.roleType, equals(RoleType.REPAIR_DEVICE.value));
      expect(widget.reasonList.length, equals(3));
      expect(widget.code, equals('REPAIR_CODE'));
      expect(widget.markId, equals(100));
    });

    test('ReasonSelectionWidget can be instantiated with empty reason list', () {
      final widget = ReasonSelectionWidget(
        roleType: RoleType.DEAD_DEVICE.value,
        reasonList: const [],
      );
      expect(widget.reasonList.isEmpty, isTrue);
    });

    test('ReasonSelectionWidget can be instantiated with a key', () {
      const key = Key('reason_selection_widget_key');
      final widget = ReasonSelectionWidget(
        roleType: RoleType.DEAD_DEVICE.value,
        reasonList: const [],
        key: key,
      );
      expect(widget.key, equals(key));
    });

    test('ReasonSelectionWidget creates state correctly', () {
      final widget = ReasonSelectionWidget(
        roleType: RoleType.DEAD_DEVICE.value,
        reasonList: const [],
      );
      final element = widget.createElement();
      expect(element, isNotNull);
    });
  });
}
