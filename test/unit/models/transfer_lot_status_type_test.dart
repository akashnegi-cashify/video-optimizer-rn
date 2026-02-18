import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/transfer_lot_status_type.dart';

/// Tests for TransferLotStatusType enum.
/// Focus: Testing enum values, code property, and name property.
void main() {
  group('TransferLotStatusType', () {
    group('enum values', () {
      test('should have 12 values', () {
        expect(TransferLotStatusType.values.length, 12);
      });

      test('should contain NEW', () {
        expect(TransferLotStatusType.values, contains(TransferLotStatusType.NEW));
      });

      test('should contain IN_PROCESS', () {
        expect(TransferLotStatusType.values, contains(TransferLotStatusType.IN_PROCESS));
      });

      test('should contain LOCKED', () {
        expect(TransferLotStatusType.values, contains(TransferLotStatusType.LOCKED));
      });

      test('should contain APPROVE', () {
        expect(TransferLotStatusType.values, contains(TransferLotStatusType.APPROVE));
      });

      test('should contain DISPATCH', () {
        expect(TransferLotStatusType.values, contains(TransferLotStatusType.DISPATCH));
      });

      test('should contain REJECT', () {
        expect(TransferLotStatusType.values, contains(TransferLotStatusType.REJECT));
      });

      test('should contain RECEIVE', () {
        expect(TransferLotStatusType.values, contains(TransferLotStatusType.RECEIVE));
      });

      test('should contain BULK_RECEIVE_INIT', () {
        expect(TransferLotStatusType.values, contains(TransferLotStatusType.BULK_RECEIVE_INIT));
      });

      test('should contain COMPLETE', () {
        expect(TransferLotStatusType.values, contains(TransferLotStatusType.COMPLETE));
      });

      test('should contain STORE_OUT_PENDING', () {
        expect(TransferLotStatusType.values, contains(TransferLotStatusType.STORE_OUT_PENDING));
      });

      test('should contain READY_TO_SHIP', () {
        expect(TransferLotStatusType.values, contains(TransferLotStatusType.READY_TO_SHIP));
      });

      test('should contain DELETE', () {
        expect(TransferLotStatusType.values, contains(TransferLotStatusType.DELETE));
      });
    });

    group('code property', () {
      test('NEW should have code 0', () {
        expect(TransferLotStatusType.NEW.code, 0);
      });

      test('IN_PROCESS should have code 1', () {
        expect(TransferLotStatusType.IN_PROCESS.code, 1);
      });

      test('LOCKED should have code 2', () {
        expect(TransferLotStatusType.LOCKED.code, 2);
      });

      test('APPROVE should have code 3', () {
        expect(TransferLotStatusType.APPROVE.code, 3);
      });

      test('DISPATCH should have code 4', () {
        expect(TransferLotStatusType.DISPATCH.code, 4);
      });

      test('REJECT should have code 5', () {
        expect(TransferLotStatusType.REJECT.code, 5);
      });

      test('RECEIVE should have code 6', () {
        expect(TransferLotStatusType.RECEIVE.code, 6);
      });

      test('BULK_RECEIVE_INIT should have code 67', () {
        expect(TransferLotStatusType.BULK_RECEIVE_INIT.code, 67);
      });

      test('COMPLETE should have code 7', () {
        expect(TransferLotStatusType.COMPLETE.code, 7);
      });

      test('STORE_OUT_PENDING should have code 8', () {
        expect(TransferLotStatusType.STORE_OUT_PENDING.code, 8);
      });

      test('READY_TO_SHIP should have code 9', () {
        expect(TransferLotStatusType.READY_TO_SHIP.code, 9);
      });

      test('DELETE should have code -1', () {
        expect(TransferLotStatusType.DELETE.code, -1);
      });
    });

    group('name property', () {
      test('NEW should have name "New"', () {
        expect(TransferLotStatusType.NEW.name, 'New');
      });

      test('IN_PROCESS should have name "In progress"', () {
        expect(TransferLotStatusType.IN_PROCESS.name, 'In progress');
      });

      test('LOCKED should have name "Lock"', () {
        expect(TransferLotStatusType.LOCKED.name, 'Lock');
      });

      test('APPROVE should have name "Approve"', () {
        expect(TransferLotStatusType.APPROVE.name, 'Approve');
      });

      test('DISPATCH should have name "Dispatch"', () {
        expect(TransferLotStatusType.DISPATCH.name, 'Dispatch');
      });

      test('REJECT should have name "Reject"', () {
        expect(TransferLotStatusType.REJECT.name, 'Reject');
      });

      test('RECEIVE should have name "Receive"', () {
        expect(TransferLotStatusType.RECEIVE.name, 'Receive');
      });

      test('BULK_RECEIVE_INIT should have name "Bulk Receive Init"', () {
        expect(TransferLotStatusType.BULK_RECEIVE_INIT.name, 'Bulk Receive Init');
      });

      test('COMPLETE should have name "Complete"', () {
        expect(TransferLotStatusType.COMPLETE.name, 'Complete');
      });

      test('STORE_OUT_PENDING should have name "Store Out Pending"', () {
        expect(TransferLotStatusType.STORE_OUT_PENDING.name, 'Store Out Pending');
      });

      test('READY_TO_SHIP should have name "Ready To Ship"', () {
        expect(TransferLotStatusType.READY_TO_SHIP.name, 'Ready To Ship');
      });

      test('DELETE should have name "Delete"', () {
        expect(TransferLotStatusType.DELETE.name, 'Delete');
      });
    });

    group('enum index', () {
      test('NEW should have index 0', () {
        expect(TransferLotStatusType.NEW.index, 0);
      });

      test('IN_PROCESS should have index 1', () {
        expect(TransferLotStatusType.IN_PROCESS.index, 1);
      });

      test('LOCKED should have index 2', () {
        expect(TransferLotStatusType.LOCKED.index, 2);
      });

      test('APPROVE should have index 3', () {
        expect(TransferLotStatusType.APPROVE.index, 3);
      });

      test('DISPATCH should have index 4', () {
        expect(TransferLotStatusType.DISPATCH.index, 4);
      });

      test('REJECT should have index 5', () {
        expect(TransferLotStatusType.REJECT.index, 5);
      });

      test('RECEIVE should have index 6', () {
        expect(TransferLotStatusType.RECEIVE.index, 6);
      });

      test('BULK_RECEIVE_INIT should have index 7', () {
        expect(TransferLotStatusType.BULK_RECEIVE_INIT.index, 7);
      });

      test('COMPLETE should have index 8', () {
        expect(TransferLotStatusType.COMPLETE.index, 8);
      });

      test('STORE_OUT_PENDING should have index 9', () {
        expect(TransferLotStatusType.STORE_OUT_PENDING.index, 9);
      });

      test('READY_TO_SHIP should have index 10', () {
        expect(TransferLotStatusType.READY_TO_SHIP.index, 10);
      });

      test('DELETE should have index 11', () {
        expect(TransferLotStatusType.DELETE.index, 11);
      });
    });

    group('unique codes', () {
      test('all codes should be unique', () {
        final codes = TransferLotStatusType.values.map((e) => e.code).toList();
        final uniqueCodes = codes.toSet();
        expect(uniqueCodes.length, codes.length);
      });
    });

    group('unique names', () {
      test('all names should be unique', () {
        final names = TransferLotStatusType.values.map((e) => e.name).toList();
        final uniqueNames = names.toSet();
        expect(uniqueNames.length, names.length);
      });
    });

    group('special values', () {
      test('DELETE should have negative code', () {
        expect(TransferLotStatusType.DELETE.code, isNegative);
      });

      test('BULK_RECEIVE_INIT should have code 67 (non-sequential)', () {
        expect(TransferLotStatusType.BULK_RECEIVE_INIT.code, 67);
      });
    });

    group('status flow', () {
      test('NEW should come before IN_PROCESS by index', () {
        expect(TransferLotStatusType.NEW.index, lessThan(TransferLotStatusType.IN_PROCESS.index));
      });

      test('DISPATCH should come after APPROVE by index', () {
        expect(TransferLotStatusType.DISPATCH.index, greaterThan(TransferLotStatusType.APPROVE.index));
      });

      test('COMPLETE should come after RECEIVE by index', () {
        expect(TransferLotStatusType.COMPLETE.index, greaterThan(TransferLotStatusType.RECEIVE.index));
      });
    });
  });
}
