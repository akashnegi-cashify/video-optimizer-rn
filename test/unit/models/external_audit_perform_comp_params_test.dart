import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/external_audit/models/external_audit_enum.dart';
import 'package:flutter_trc/qc/modules/external_audit/models/external_audit_perform_comp_params.dart';

void main() {
  group('ExternalAuditPerformCompParam', () {
    group('constructor', () {
      test('should create instance with receiveStock audit type', () {
        // Act
        final param = ExternalAuditPerformCompParam(
          auditType: ExternalAuditEnum.receiveStock,
        );

        // Assert
        expect(param.auditType, ExternalAuditEnum.receiveStock);
      });

      test('should create instance with receiveReturn audit type', () {
        // Act
        final param = ExternalAuditPerformCompParam(
          auditType: ExternalAuditEnum.receiveReturn,
        );

        // Assert
        expect(param.auditType, ExternalAuditEnum.receiveReturn);
      });

      test('should create instance with dispatch audit type', () {
        // Act
        final param = ExternalAuditPerformCompParam(
          auditType: ExternalAuditEnum.dispatch,
        );

        // Assert
        expect(param.auditType, ExternalAuditEnum.dispatch);
      });
    });

    group('auditType property', () {
      test('auditType should be required parameter', () {
        // This test verifies the required nature through compilation
        // If auditType wasn't required, this would fail at compile time
        final param = ExternalAuditPerformCompParam(
          auditType: ExternalAuditEnum.receiveStock,
        );
        expect(param.auditType, isNotNull);
      });

      test('should access auditType val property', () {
        // Arrange
        final param = ExternalAuditPerformCompParam(
          auditType: ExternalAuditEnum.dispatch,
        );

        // Assert
        expect(param.auditType.val, 1);
      });

      test('should access auditType name property', () {
        // Arrange
        final param = ExternalAuditPerformCompParam(
          auditType: ExternalAuditEnum.receiveReturn,
        );

        // Assert
        expect(param.auditType.name, 'receiveReturn');
      });
    });

    group('typical usage scenarios', () {
      test('should create param for stock receive audit', () {
        // Arrange & Act
        final param = ExternalAuditPerformCompParam(
          auditType: ExternalAuditEnum.receiveStock,
        );

        // Assert
        expect(param.auditType, ExternalAuditEnum.receiveStock);
        expect(param.auditType.val, 0);
      });

      test('should create param for return receive audit', () {
        // Arrange & Act
        final param = ExternalAuditPerformCompParam(
          auditType: ExternalAuditEnum.receiveReturn,
        );

        // Assert
        expect(param.auditType, ExternalAuditEnum.receiveReturn);
        expect(param.auditType.val, 0);
      });

      test('should create param for dispatch audit', () {
        // Arrange & Act
        final param = ExternalAuditPerformCompParam(
          auditType: ExternalAuditEnum.dispatch,
        );

        // Assert
        expect(param.auditType, ExternalAuditEnum.dispatch);
        expect(param.auditType.val, 1);
      });

      test('should distinguish between audit types', () {
        // Arrange
        final stockParam = ExternalAuditPerformCompParam(
          auditType: ExternalAuditEnum.receiveStock,
        );
        final returnParam = ExternalAuditPerformCompParam(
          auditType: ExternalAuditEnum.receiveReturn,
        );
        final dispatchParam = ExternalAuditPerformCompParam(
          auditType: ExternalAuditEnum.dispatch,
        );

        // Assert
        expect(stockParam.auditType, isNot(returnParam.auditType));
        expect(stockParam.auditType, isNot(dispatchParam.auditType));
        expect(returnParam.auditType, isNot(dispatchParam.auditType));
      });
    });

    group('list operations', () {
      test('should work in list context', () {
        // Arrange
        final params = [
          ExternalAuditPerformCompParam(auditType: ExternalAuditEnum.receiveStock),
          ExternalAuditPerformCompParam(auditType: ExternalAuditEnum.dispatch),
        ];

        // Assert
        expect(params.length, 2);
        expect(params[0].auditType, ExternalAuditEnum.receiveStock);
        expect(params[1].auditType, ExternalAuditEnum.dispatch);
      });

      test('should filter by audit type', () {
        // Arrange
        final params = [
          ExternalAuditPerformCompParam(auditType: ExternalAuditEnum.receiveStock),
          ExternalAuditPerformCompParam(auditType: ExternalAuditEnum.receiveReturn),
          ExternalAuditPerformCompParam(auditType: ExternalAuditEnum.dispatch),
        ];

        // Act
        final receiveParams = params.where((p) => p.auditType.val == 0).toList();
        final dispatchParams = params.where((p) => p.auditType.val == 1).toList();

        // Assert
        expect(receiveParams.length, 2);
        expect(dispatchParams.length, 1);
      });
    });
  });

  group('ExternalAuditPerformCompParamKeys', () {
    test('externalAuditType should have value "auditType"', () {
      expect(ExternalAuditPerformCompParamKeys.externalAuditType.value, 'auditType');
    });

    test('should have exactly 1 key', () {
      expect(ExternalAuditPerformCompParamKeys.values.length, 1);
    });

    test('externalAuditType should have correct name', () {
      expect(ExternalAuditPerformCompParamKeys.externalAuditType.name, 'externalAuditType');
    });

    test('should support enum iteration', () {
      var count = 0;
      for (final key in ExternalAuditPerformCompParamKeys.values) {
        count++;
        expect(key, isA<ExternalAuditPerformCompParamKeys>());
      }
      expect(count, 1);
    });

    test('should support map as key', () {
      final map = {
        ExternalAuditPerformCompParamKeys.externalAuditType: 'audit_type_value',
      };
      expect(map[ExternalAuditPerformCompParamKeys.externalAuditType], 'audit_type_value');
    });
  });
}
