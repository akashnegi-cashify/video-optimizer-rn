import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dead_repair/providers/dead_device_accept_reject_provider.dart';
import 'package:flutter_trc/qc/modules/dead_repair/resources/add_remove_part_response.dart';
import 'package:flutter_trc/qc/modules/dead_repair/resources/accept_reject_dead_request.dart';
import 'package:flutter_trc/qc/modules/dead_repair/type.dart';
import 'package:flutter_trc/src/common/resources/device_mark_response.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty;
import '../../helpers/provider_test_helpers.dart';

/// Tests for DeviceDeadAcceptRejectProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('DeviceDeadAcceptRejectProvider', () {
    late DeviceDeadAcceptRejectProvider provider;

    setUp(() {
      provider = DeviceDeadAcceptRejectProvider(
        markId: 123,
        barcode: 'TEST_BARCODE_001',
        preSelectedRemark: null,
      );
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should store markId', () {
        expect(provider.markId, 123);
      });

      test('should store barcode', () {
        expect(provider.barcode, 'TEST_BARCODE_001');
      });

      test('should initialize with null preSelectedRemark', () {
        expect(provider.preSelectedRemark, isNull);
      });

      test('should accept preSelectedRemark', () {
        final providerWithRemark = DeviceDeadAcceptRejectProvider(
          markId: 456,
          barcode: 'BARCODE_002',
          preSelectedRemark: 'Pre-selected remark',
        );
        expect(providerWithRemark.preSelectedRemark, 'Pre-selected remark');
        providerWithRemark.dispose();
      });

      test('should create with default constructor values', () {
        final defaultProvider = DeviceDeadAcceptRejectProvider();
        expect(defaultProvider.markId, isNull);
        expect(defaultProvider.barcode, isNull);
        expect(defaultProvider.preSelectedRemark, isNull);
        defaultProvider.dispose();
      });
    });

    group('initial state', () {
      test('skuList should initially be empty', () {
        expect(provider.skuList.length, 0);
      });

      test('remarkList should initially be empty', () {
        expect(provider.remarkList.length, 0);
      });

      test('isTextFieldEmpty should initially be true', () {
        expect(provider.isTextFieldEmpty, true);
      });

      test('skuTextEditingController should be initialized', () {
        expect(provider.skuTextEditingController, isNotNull);
      });

      test('level should have 4 items', () {
        expect(provider.level.length, 4);
      });

      test('first level item should have null id', () {
        expect(provider.level[0].id, isNull);
      });

      test('second level item should be Send to L1', () {
        expect(provider.level[1].id, 'Send to L1');
      });

      test('third level item should be Send to L2', () {
        expect(provider.level[2].id, 'Send to L2');
      });

      test('fourth level item should be Send to L3', () {
        expect(provider.level[3].id, 'Send to L3');
      });
    });

    group('level dropdown items', () {
      test('should have correct extraData for default selection', () {
        // First item (Select engineer) should be selected by default
        expect(provider.level[0].extraData, true);
        // Other items should not be selected
        expect(provider.level[1].extraData, false);
        expect(provider.level[2].extraData, false);
        expect(provider.level[3].extraData, false);
      });
    });

    group('isTextFieldEmpty setter', () {
      test('should update value when changed', () {
        provider.isTextFieldEmpty = false;
        expect(provider.isTextFieldEmpty, false);
      });

      test('should notify listeners when value changes', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.isTextFieldEmpty = false;

        expect(tracker.callCount, 1);
      });

      test('should not notify listeners when value stays same', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        // Already true, setting to true again
        provider.isTextFieldEmpty = true;

        expect(tracker.callCount, 0);
      });
    });

    group('skuList management', () {
      test('addSku should add item to list', () {
        provider.addSku('SKU_001');
        expect(provider.skuList, contains('SKU_001'));
        expect(provider.skuList.length, 1);
      });

      test('addSku should allow multiple items', () {
        provider.addSku('SKU_001');
        provider.addSku('SKU_002');
        provider.addSku('SKU_003');
        expect(provider.skuList.length, 3);
      });

      test('addSku should notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.addSku('SKU_001');

        expect(tracker.callCount, 1);
      });

      test('removeSku should remove item from list', () {
        provider.addSku('SKU_001');
        provider.addSku('SKU_002');

        provider.removeSku('SKU_001');

        expect(provider.skuList, isNot(contains('SKU_001')));
        expect(provider.skuList.length, 1);
      });

      test('removeSku should notify listeners', () {
        provider.addSku('SKU_001');

        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.removeSku('SKU_001');

        expect(tracker.callCount, 1);
      });
    });

    group('onLevelChange', () {
      test('should update selected level', () {
        final l2Item = provider.level[2]; // Send to L2

        provider.onLevelChange(l2Item);

        expect(l2Item.extraData, true);
      });

      test('should deselect previous level', () {
        final selectEngItem = provider.level[0];
        final l2Item = provider.level[2];

        // Initial state - first item is selected
        expect(selectEngItem.extraData, true);

        provider.onLevelChange(l2Item);

        expect(selectEngItem.extraData, false);
        expect(l2Item.extraData, true);
      });

      test('should notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.onLevelChange(provider.level[1]);

        expect(tracker.callCount, 1);
      });
    });

    group('getSelectedLevel', () {
      test('should return default selected level', () {
        final selected = provider.getSelectedLevel();
        expect(selected.id, isNull); // Select engineer has null id
      });

      test('should return updated level after change', () {
        final l1Item = provider.level[1]; // Send to L1
        provider.onLevelChange(l1Item);

        final selected = provider.getSelectedLevel();
        expect(selected.id, 'Send to L1');
      });
    });

    group('onRemarkChange', () {
      test('should notify listeners', () {
        // First add a remark item to the list
        final remarkItem = RadioListItem('Test', 'Test', false);
        provider.remarkList.add(remarkItem);

        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.onRemarkChange(remarkItem);

        expect(tracker.callCount, 1);
      });

      test('should set isSelected to true on item', () {
        final remarkItem = RadioListItem('Test', 'Test', false);
        provider.remarkList.add(remarkItem);

        provider.onRemarkChange(remarkItem);

        expect(remarkItem.isSelected, true);
      });

      test('should deselect previously selected remark', () {
        final remark1 = RadioListItem('Remark1', 'Remark1', true);
        final remark2 = RadioListItem('Remark2', 'Remark2', false);
        provider.remarkList.addAll([remark1, remark2]);

        provider.onRemarkChange(remark2);

        expect(remark1.isSelected, false);
        expect(remark2.isSelected, true);
      });
    });

    group('getSelectedRemark', () {
      test('should return null when no remark is selected', () {
        expect(provider.getSelectedRemark(), isNull);
      });

      test('should return selected remark', () {
        final remark1 = RadioListItem('Remark1', 'Remark1', false);
        final remark2 = RadioListItem('Remark2', 'Remark2', true);
        provider.remarkList.addAll([remark1, remark2]);

        final selected = provider.getSelectedRemark();

        expect(selected, isNotNull);
        expect(selected?.id, 'Remark2');
      });
    });

    group('addRemovePart method', () {
      test('should return a Stream for add part', () {
        final stream = provider.addRemovePart('SKU_001', true);
        expect(stream, isA<Stream<AddRemovePartResponse?>>());
      });

      test('should return a Stream for remove part', () {
        final stream = provider.addRemovePart('SKU_001', false);
        expect(stream, isA<Stream<AddRemovePartResponse?>>());
      });
    });

    group('submitDeadDeviceRequest method', () {
      test('should return a Stream for ACCEPT_DEAD request', () {
        final request = AcceptRejectDeadRequest(
          markId: 123,
          remark: 'Test remark',
          requestType: DeadDeviceRequestType.ACCEPT_DEAD,
        );
        final stream = provider.submitDeadDeviceRequest(request);
        expect(stream, isA<Stream<DeviceMarkResponse?>>());
      });

      test('should return a Stream for REPAIR_REJECT request', () {
        final request = AcceptRejectDeadRequest(
          markId: 123,
          remark: 'Test remark',
          requestType: DeadDeviceRequestType.REPAIR_REJECT,
        );
        final stream = provider.submitDeadDeviceRequest(request);
        expect(stream, isA<Stream<DeviceMarkResponse?>>());
      });

      test('should return a Stream for REPAIR_DONE request', () {
        final request = AcceptRejectDeadRequest(
          markId: 123,
          remark: 'Test remark',
          requestType: DeadDeviceRequestType.REPAIR_DONE,
        );
        final stream = provider.submitDeadDeviceRequest(request);
        expect(stream, isA<Stream<DeviceMarkResponse?>>());
      });
    });

    group('deadReasonList', () {
      test('should be initialized', () {
        expect(provider.deadReasonList, isNotNull);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(DeviceDeadAcceptRejectProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = DeviceDeadAcceptRejectProvider(markId: 999);
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
