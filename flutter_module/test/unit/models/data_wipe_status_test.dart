import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_status.dart';

/// Tests for DataWipeStatus enum.
/// Focus: Testing getStatus method with various status codes.
void main() {
  group('DataWipeStatus', () {
    group('enum values', () {
      test('should have 3 values', () {
        expect(DataWipeStatus.values.length, 3);
      });

      test('should contain init', () {
        expect(DataWipeStatus.values, contains(DataWipeStatus.init));
      });

      test('should contain success', () {
        expect(DataWipeStatus.values, contains(DataWipeStatus.success));
      });

      test('should contain error', () {
        expect(DataWipeStatus.values, contains(DataWipeStatus.error));
      });
    });

    group('getStatus', () {
      group('error status', () {
        test('should return error for negative status code -1', () {
          expect(DataWipeStatus.getStatus(-1), DataWipeStatus.error);
        });

        test('should return error for negative status code -5', () {
          expect(DataWipeStatus.getStatus(-5), DataWipeStatus.error);
        });

        test('should return error for negative status code -100', () {
          expect(DataWipeStatus.getStatus(-100), DataWipeStatus.error);
        });

        test('should return error for large negative status code', () {
          expect(DataWipeStatus.getStatus(-2147483648), DataWipeStatus.error);
        });

        test('should return error for null status code (treated as 0)', () {
          // null is treated as 0, which is >= 0 and != 44, so it's init
          expect(DataWipeStatus.getStatus(null), DataWipeStatus.init);
        });
      });

      group('success status', () {
        test('should return success for status code 44', () {
          expect(DataWipeStatus.getStatus(44), DataWipeStatus.success);
        });
      });

      group('init status', () {
        test('should return init for status code 0', () {
          expect(DataWipeStatus.getStatus(0), DataWipeStatus.init);
        });

        test('should return init for status code 1', () {
          expect(DataWipeStatus.getStatus(1), DataWipeStatus.init);
        });

        test('should return init for status code 10', () {
          expect(DataWipeStatus.getStatus(10), DataWipeStatus.init);
        });

        test('should return init for status code 43', () {
          expect(DataWipeStatus.getStatus(43), DataWipeStatus.init);
        });

        test('should return init for status code 45', () {
          expect(DataWipeStatus.getStatus(45), DataWipeStatus.init);
        });

        test('should return init for status code 100', () {
          expect(DataWipeStatus.getStatus(100), DataWipeStatus.init);
        });

        test('should return init for large positive status code', () {
          expect(DataWipeStatus.getStatus(2147483647), DataWipeStatus.init);
        });
      });
    });

    group('edge cases', () {
      test('should handle boundary between error and init (0)', () {
        expect(DataWipeStatus.getStatus(0), DataWipeStatus.init);
        expect(DataWipeStatus.getStatus(-1), DataWipeStatus.error);
      });

      test('should handle boundary around success (44)', () {
        expect(DataWipeStatus.getStatus(43), DataWipeStatus.init);
        expect(DataWipeStatus.getStatus(44), DataWipeStatus.success);
        expect(DataWipeStatus.getStatus(45), DataWipeStatus.init);
      });
    });

    group('enum properties', () {
      test('init should be accessible', () {
        const status = DataWipeStatus.init;
        expect(status.name, 'init');
      });

      test('success should be accessible', () {
        const status = DataWipeStatus.success;
        expect(status.name, 'success');
      });

      test('error should be accessible', () {
        const status = DataWipeStatus.error;
        expect(status.name, 'error');
      });
    });

    group('enum index', () {
      test('init should have index 0', () {
        expect(DataWipeStatus.init.index, 0);
      });

      test('success should have index 1', () {
        expect(DataWipeStatus.success.index, 1);
      });

      test('error should have index 2', () {
        expect(DataWipeStatus.error.index, 2);
      });
    });
  });
}
