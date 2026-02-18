import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/external_audit/models/external_audit_enum.dart';

void main() {
  group('ExternalAuditEnum', () {
    group('enum values', () {
      test('receiveStock should have value 0', () {
        expect(ExternalAuditEnum.receiveStock.val, 0);
      });

      test('receiveReturn should have value 0', () {
        expect(ExternalAuditEnum.receiveReturn.val, 0);
      });

      test('dispatch should have value 1', () {
        expect(ExternalAuditEnum.dispatch.val, 1);
      });

      test('should have exactly 3 enum values', () {
        expect(ExternalAuditEnum.values.length, 3);
      });
    });

    group('enum names', () {
      test('receiveStock should have correct name', () {
        expect(ExternalAuditEnum.receiveStock.name, 'receiveStock');
      });

      test('receiveReturn should have correct name', () {
        expect(ExternalAuditEnum.receiveReturn.name, 'receiveReturn');
      });

      test('dispatch should have correct name', () {
        expect(ExternalAuditEnum.dispatch.name, 'dispatch');
      });
    });

    group('enum order', () {
      test('values should be in expected order', () {
        final values = ExternalAuditEnum.values;
        expect(values[0], ExternalAuditEnum.receiveStock);
        expect(values[1], ExternalAuditEnum.receiveReturn);
        expect(values[2], ExternalAuditEnum.dispatch);
      });
    });

    group('enum indices', () {
      test('receiveStock should have index 0', () {
        expect(ExternalAuditEnum.receiveStock.index, 0);
      });

      test('receiveReturn should have index 1', () {
        expect(ExternalAuditEnum.receiveReturn.index, 1);
      });

      test('dispatch should have index 2', () {
        expect(ExternalAuditEnum.dispatch.index, 2);
      });
    });

    group('value grouping', () {
      test('receiveStock and receiveReturn should have same val', () {
        expect(ExternalAuditEnum.receiveStock.val, ExternalAuditEnum.receiveReturn.val);
      });

      test('dispatch should have different val than receive operations', () {
        expect(ExternalAuditEnum.dispatch.val, isNot(ExternalAuditEnum.receiveStock.val));
      });
    });

    group('typical usage scenarios', () {
      test('should identify receive operations by val', () {
        final receiveOperations = ExternalAuditEnum.values.where((e) => e.val == 0).toList();
        expect(receiveOperations.length, 2);
        expect(receiveOperations.contains(ExternalAuditEnum.receiveStock), true);
        expect(receiveOperations.contains(ExternalAuditEnum.receiveReturn), true);
      });

      test('should identify dispatch operation by val', () {
        final dispatchOperations = ExternalAuditEnum.values.where((e) => e.val == 1).toList();
        expect(dispatchOperations.length, 1);
        expect(dispatchOperations.first, ExternalAuditEnum.dispatch);
      });

      test('should use enum in switch statement', () {
        String getOperationType(ExternalAuditEnum type) {
          switch (type) {
            case ExternalAuditEnum.receiveStock:
              return 'stock_receive';
            case ExternalAuditEnum.receiveReturn:
              return 'return_receive';
            case ExternalAuditEnum.dispatch:
              return 'dispatch';
          }
        }

        expect(getOperationType(ExternalAuditEnum.receiveStock), 'stock_receive');
        expect(getOperationType(ExternalAuditEnum.receiveReturn), 'return_receive');
        expect(getOperationType(ExternalAuditEnum.dispatch), 'dispatch');
      });

      test('should compare enums correctly', () {
        expect(ExternalAuditEnum.receiveStock == ExternalAuditEnum.receiveStock, true);
        expect(ExternalAuditEnum.receiveStock == ExternalAuditEnum.receiveReturn, false);
        expect(ExternalAuditEnum.dispatch == ExternalAuditEnum.dispatch, true);
      });
    });

    group('edge cases', () {
      test('should be able to iterate over all values', () {
        var count = 0;
        for (final value in ExternalAuditEnum.values) {
          count++;
          expect(value, isA<ExternalAuditEnum>());
        }
        expect(count, 3);
      });

      test('should support list operations', () {
        final list = [
          ExternalAuditEnum.receiveStock,
          ExternalAuditEnum.dispatch,
        ];
        expect(list.contains(ExternalAuditEnum.receiveStock), true);
        expect(list.contains(ExternalAuditEnum.receiveReturn), false);
        expect(list.indexOf(ExternalAuditEnum.dispatch), 1);
      });

      test('should support set operations', () {
        final set = {
          ExternalAuditEnum.receiveStock,
          ExternalAuditEnum.receiveStock,
          ExternalAuditEnum.dispatch,
        };
        expect(set.length, 2); // Duplicates removed
      });

      test('should support map as key', () {
        final map = {
          ExternalAuditEnum.receiveStock: 'Stock Receive',
          ExternalAuditEnum.receiveReturn: 'Return Receive',
          ExternalAuditEnum.dispatch: 'Dispatch',
        };
        expect(map[ExternalAuditEnum.receiveStock], 'Stock Receive');
        expect(map[ExternalAuditEnum.dispatch], 'Dispatch');
      });
    });
  });
}
