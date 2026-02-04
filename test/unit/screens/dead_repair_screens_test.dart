import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dead_repair/screens/device_dead_repair_screen.dart';
import 'package:flutter_trc/qc/modules/dead_repair/screens/device_dead_accept_reject_screen.dart';
import 'package:flutter_trc/qc/modules/dead_repair/screens/reason_selection_screen.dart';

void main() {
  group('DeviceDeadRepairScreen', () {
    test('has correct pageKey', () {
      expect(DeviceDeadRepairScreen.pageKey, 'QC_qc_device_dead_repair');
    });

    test('has correct route', () {
      expect(DeviceDeadRepairScreen.route, '/qc-device-dead-repair');
    });

    test('can be instantiated', () {
      const screen = DeviceDeadRepairScreen();
      expect(screen, isNotNull);
    });
  });

  group('DeviceDeadRepairScreenArgs', () {
    test('creates arguments with pageKey', () {
      final args = DeviceDeadRepairScreenArgs('test_page_key');
      expect(args, isNotNull);
    });
  });

  group('DeviceDeadAcceptRejectScreen', () {
    test('has correct pageKey', () {
      expect(DeviceDeadAcceptRejectScreen.pageKey, 'QC_qc_device_dead_accept_reject');
    });

    test('has correct route', () {
      expect(DeviceDeadAcceptRejectScreen.route, '/qc-device-dead-accept-reject');
    });

    test('can be instantiated', () {
      const screen = DeviceDeadAcceptRejectScreen();
      expect(screen, isNotNull);
    });
  });

  group('DeviceDeadAcceptRejectScreenArgs', () {
    test('creates arguments with all params', () {
      final args = DeviceDeadAcceptRejectScreenArgs(
        'test_page_key',
        header: 'Test Header',
        selectedReason: 'Reason',
        code: 'CODE123',
        markId: 1,
      );
      expect(args.header, 'Test Header');
      expect(args.selectedReason, 'Reason');
      expect(args.code, 'CODE123');
      expect(args.markId, 1);
    });
  });

  group('ReasonSelectionScreen', () {
    test('has correct pageKey', () {
      expect(ReasonSelectionScreen.pageKey, 'QC_qc_reason_selection');
    });

    test('has correct route', () {
      expect(ReasonSelectionScreen.route, '/qc-reason-selection');
    });

    test('can be instantiated', () {
      const screen = ReasonSelectionScreen();
      expect(screen, isNotNull);
    });
  });

  group('ReasonSelectionScreenArgs', () {
    test('creates arguments with all params', () {
      final args = ReasonSelectionScreenArgs(
        'test_page_key',
        'Test Header',
        1,
        ['reason1', 'reason2'],
        'CODE123',
        1,
      );
      expect(args.header, 'Test Header');
      expect(args.status, 1);
      expect(args.reasonList, ['reason1', 'reason2']);
      expect(args.code, 'CODE123');
      expect(args.markId, 1);
    });
  });
}
