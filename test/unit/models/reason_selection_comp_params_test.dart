import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dead_repair/models/reason_selection_comp_params.dart';

void main() {
  group('ReasonSelectionCompParam', () {
    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final param = ReasonSelectionCompParam(
          header: 'Select Reason',
          code: 'QR-12345',
          reasonList: ['Screen Damage', 'Battery Issue', 'Water Damage'],
          roleType: 1,
          markId: 100,
        );

        // Assert
        expect(param.header, 'Select Reason');
        expect(param.code, 'QR-12345');
        expect(param.reasonList, ['Screen Damage', 'Battery Issue', 'Water Damage']);
        expect(param.roleType, 1);
        expect(param.markId, 100);
      });

      test('should create instance with no parameters', () {
        // Act
        final param = ReasonSelectionCompParam();

        // Assert
        expect(param.header, isNull);
        expect(param.code, isNull);
        expect(param.reasonList, isNull);
        expect(param.roleType, isNull);
        expect(param.markId, isNull);
      });

      test('should create instance with only header', () {
        // Act
        final param = ReasonSelectionCompParam(
          header: 'Header Only',
        );

        // Assert
        expect(param.header, 'Header Only');
        expect(param.code, isNull);
        expect(param.reasonList, isNull);
      });

      test('should create instance with only code', () {
        // Act
        final param = ReasonSelectionCompParam(
          code: 'CODE-001',
        );

        // Assert
        expect(param.code, 'CODE-001');
        expect(param.header, isNull);
      });

      test('should create instance with only reasonList', () {
        // Act
        final param = ReasonSelectionCompParam(
          reasonList: ['Reason 1', 'Reason 2'],
        );

        // Assert
        expect(param.reasonList!.length, 2);
        expect(param.reasonList![0], 'Reason 1');
      });

      test('should create instance with only roleType', () {
        // Act
        final param = ReasonSelectionCompParam(
          roleType: 2,
        );

        // Assert
        expect(param.roleType, 2);
      });

      test('should create instance with only markId', () {
        // Act
        final param = ReasonSelectionCompParam(
          markId: 999,
        );

        // Assert
        expect(param.markId, 999);
      });
    });

    group('header property', () {
      test('should handle empty header string', () {
        // Act
        final param = ReasonSelectionCompParam(
          header: '',
        );

        // Assert
        expect(param.header, '');
      });

      test('should handle header with special characters', () {
        // Act
        final param = ReasonSelectionCompParam(
          header: 'Select Reason !@#\$%',
        );

        // Assert
        expect(param.header, 'Select Reason !@#\$%');
      });

      test('should handle header with unicode', () {
        // Act
        final param = ReasonSelectionCompParam(
          header: 'कारण चुनें',
        );

        // Assert
        expect(param.header, 'कारण चुनें');
      });
    });

    group('code property', () {
      test('should handle empty code string', () {
        // Act
        final param = ReasonSelectionCompParam(
          code: '',
        );

        // Assert
        expect(param.code, '');
      });

      test('should handle typical QR code format', () {
        // Act
        final param = ReasonSelectionCompParam(
          code: 'DEV-2024-001-XYZ',
        );

        // Assert
        expect(param.code, 'DEV-2024-001-XYZ');
      });

      test('should handle code with special characters', () {
        // Act
        final param = ReasonSelectionCompParam(
          code: 'QR/2024/001',
        );

        // Assert
        expect(param.code, 'QR/2024/001');
      });
    });

    group('reasonList property', () {
      test('should handle empty reason list', () {
        // Act
        final param = ReasonSelectionCompParam(
          reasonList: [],
        );

        // Assert
        expect(param.reasonList, isNotNull);
        expect(param.reasonList!.isEmpty, true);
      });

      test('should handle single reason', () {
        // Act
        final param = ReasonSelectionCompParam(
          reasonList: ['Single Reason'],
        );

        // Assert
        expect(param.reasonList!.length, 1);
      });

      test('should handle many reasons', () {
        // Arrange
        final manyReasons = List.generate(50, (i) => 'Reason $i');

        // Act
        final param = ReasonSelectionCompParam(
          reasonList: manyReasons,
        );

        // Assert
        expect(param.reasonList!.length, 50);
      });

      test('should handle reasons with duplicates', () {
        // Act
        final param = ReasonSelectionCompParam(
          reasonList: ['Reason 1', 'Reason 1', 'Reason 2'],
        );

        // Assert
        expect(param.reasonList!.length, 3);
      });

      test('should handle reasons with empty strings', () {
        // Act
        final param = ReasonSelectionCompParam(
          reasonList: ['', 'Valid Reason', ''],
        );

        // Assert
        expect(param.reasonList!.length, 3);
      });
    });

    group('roleType property', () {
      test('should handle roleType 1 (REPAIR_DEVICE)', () {
        // Act
        final param = ReasonSelectionCompParam(
          roleType: 1,
        );

        // Assert
        expect(param.roleType, 1);
      });

      test('should handle roleType 2 (DEAD_DEVICE)', () {
        // Act
        final param = ReasonSelectionCompParam(
          roleType: 2,
        );

        // Assert
        expect(param.roleType, 2);
      });

      test('should handle roleType 3 (ACCEPT_REJECT_DEAD_DEVICE)', () {
        // Act
        final param = ReasonSelectionCompParam(
          roleType: 3,
        );

        // Assert
        expect(param.roleType, 3);
      });

      test('should handle zero roleType', () {
        // Act
        final param = ReasonSelectionCompParam(
          roleType: 0,
        );

        // Assert
        expect(param.roleType, 0);
      });

      test('should handle negative roleType', () {
        // Act
        final param = ReasonSelectionCompParam(
          roleType: -1,
        );

        // Assert
        expect(param.roleType, -1);
      });
    });

    group('markId property', () {
      test('should handle zero markId', () {
        // Act
        final param = ReasonSelectionCompParam(
          markId: 0,
        );

        // Assert
        expect(param.markId, 0);
      });

      test('should handle large markId', () {
        // Act
        final param = ReasonSelectionCompParam(
          markId: 999999999,
        );

        // Assert
        expect(param.markId, 999999999);
      });

      test('should handle negative markId', () {
        // Act
        final param = ReasonSelectionCompParam(
          markId: -100,
        );

        // Assert
        expect(param.markId, -100);
      });
    });

    group('typical usage scenarios', () {
      test('should create param for dead device reason selection', () {
        // Arrange & Act
        final param = ReasonSelectionCompParam(
          header: 'Select Dead Device Reason',
          code: 'DEAD-DEV-001',
          reasonList: ['Water Damage', 'Physical Damage', 'Motherboard Failure'],
          roleType: 2,
          markId: 12345,
        );

        // Assert
        expect(param.header, 'Select Dead Device Reason');
        expect(param.roleType, 2);
        expect(param.reasonList!.length, 3);
      });

      test('should create param for repair device reason selection', () {
        // Arrange & Act
        final param = ReasonSelectionCompParam(
          header: 'Select Repair Reason',
          code: 'REP-DEV-001',
          reasonList: ['Screen Replacement', 'Battery Replacement', 'Speaker Issue'],
          roleType: 1,
        );

        // Assert
        expect(param.header, 'Select Repair Reason');
        expect(param.roleType, 1);
        expect(param.reasonList!.contains('Screen Replacement'), true);
      });

      test('should create param for accept/reject reason selection', () {
        // Arrange & Act
        final param = ReasonSelectionCompParam(
          header: 'Accept/Reject Device',
          code: 'AR-DEV-001',
          reasonList: ['Approved', 'Rejected - Not Repairable', 'Rejected - Cost Too High'],
          roleType: 3,
          markId: 67890,
        );

        // Assert
        expect(param.roleType, 3);
        expect(param.markId, 67890);
      });
    });

    group('edge cases', () {
      test('should handle long reason strings', () {
        // Arrange
        final longReason = 'A' * 500;

        // Act
        final param = ReasonSelectionCompParam(
          reasonList: [longReason],
        );

        // Assert
        expect(param.reasonList![0].length, 500);
      });

      test('should handle unicode in reasons', () {
        // Act
        final param = ReasonSelectionCompParam(
          reasonList: ['スクリーンの損傷', '电池问题', 'Повреждение экрана'],
        );

        // Assert
        expect(param.reasonList!.length, 3);
      });

      test('should handle special characters in code', () {
        // Act
        final param = ReasonSelectionCompParam(
          code: 'DEV/2024/001-ABC_XYZ',
        );

        // Assert
        expect(param.code, 'DEV/2024/001-ABC_XYZ');
      });
    });
  });

  group('ReasonSelectionCompParamKeys', () {
    test('header should have value "h"', () {
      expect(ReasonSelectionCompParamKeys.header.value, 'h');
    });

    test('code should have value "code"', () {
      expect(ReasonSelectionCompParamKeys.code.value, 'code');
    });

    test('roleType should have value "rt"', () {
      expect(ReasonSelectionCompParamKeys.roleType.value, 'rt');
    });

    test('markId should have value "mi"', () {
      expect(ReasonSelectionCompParamKeys.markId.value, 'mi');
    });

    test('reasonList should have value "rl"', () {
      expect(ReasonSelectionCompParamKeys.reasonList.value, 'rl');
    });

    test('should have exactly 5 keys', () {
      expect(ReasonSelectionCompParamKeys.values.length, 5);
    });

    group('enum names', () {
      test('all keys should have correct names', () {
        expect(ReasonSelectionCompParamKeys.header.name, 'header');
        expect(ReasonSelectionCompParamKeys.code.name, 'code');
        expect(ReasonSelectionCompParamKeys.roleType.name, 'roleType');
        expect(ReasonSelectionCompParamKeys.markId.name, 'markId');
        expect(ReasonSelectionCompParamKeys.reasonList.name, 'reasonList');
      });
    });

    group('enum order', () {
      test('values should be in expected order', () {
        final values = ReasonSelectionCompParamKeys.values;
        expect(values[0], ReasonSelectionCompParamKeys.header);
        expect(values[1], ReasonSelectionCompParamKeys.code);
        expect(values[2], ReasonSelectionCompParamKeys.roleType);
        expect(values[3], ReasonSelectionCompParamKeys.markId);
        expect(values[4], ReasonSelectionCompParamKeys.reasonList);
      });
    });

    group('typical usage', () {
      test('should support map as key', () {
        final map = {
          ReasonSelectionCompParamKeys.header: 'Select Reason',
          ReasonSelectionCompParamKeys.code: 'CODE-001',
          ReasonSelectionCompParamKeys.roleType: 1,
          ReasonSelectionCompParamKeys.markId: 123,
          ReasonSelectionCompParamKeys.reasonList: ['R1', 'R2'],
        };
        expect(map[ReasonSelectionCompParamKeys.header], 'Select Reason');
        expect(map[ReasonSelectionCompParamKeys.roleType], 1);
      });

      test('should iterate over all values', () {
        var count = 0;
        for (final key in ReasonSelectionCompParamKeys.values) {
          count++;
          expect(key, isA<ReasonSelectionCompParamKeys>());
        }
        expect(count, 5);
      });
    });
  });
}
