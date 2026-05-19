import 'package:flutter_test/flutter_test.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty;
import 'package:flutter_trc/src/services/qc_service.dart';
import 'package:flutter_trc/src/services/qc_transfer_service.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

void main() {
  group('QcTransferService', () {
    late QcTransferService sut;

    setUp(() {
      sut = QcTransferService();
    });

    group('inheritance', () {
      test('should extend QcService', () {
        // Assert
        expect(sut, isA<QcService>());
      });

      test('should be an instance of BaseService', () {
        // Assert
        expect(sut, isA<BaseService>());
      });
    });

    group('getServiceGroup', () {
      test('should return TRCServiceGroups.qcTransferLot', () {
        // Act
        final result = sut.getServiceGroup();

        // Assert
        expect(result, TRCServiceGroups.qcTransferLot);
      });

      test('service group value should be "qc-transfer-lot"', () {
        // Act
        final result = sut.getServiceGroup();

        // Assert
        expect(result.value, 'qc-transfer-lot');
      });

      test('should override parent class service group', () {
        // Arrange
        final parentService = QcService();

        // Act
        final parentGroup = parentService.getServiceGroup();
        final childGroup = sut.getServiceGroup();

        // Assert - QcTransferService should use qcTransferLot, not qcConsole
        expect(parentGroup, TRCServiceGroups.qcConsole);
        expect(childGroup, TRCServiceGroups.qcTransferLot);
        expect(parentGroup, isNot(equals(childGroup)));
      });
    });

    group('inherited behavior from QcService', () {
      test('isToAddUserAuth should return true (inherited)', () {
        // Act
        final result = sut.isToAddUserAuth();

        // Assert
        expect(result, isTrue);
      });

      test('isToAddAuthorization should return false (inherited default)', () {
        // Act
        final result = sut.isToAddAuthorization();

        // Assert
        expect(result, isFalse);
      });

      test('getHeaders with null should return SSO token headers (inherited)', () {
        // Act
        final result = sut.getHeaders(null);

        // Assert
        expect(result, isA<Map<String, String>>());
        expect(result, equals(CoreHeaders.xSSOToken));
      });

      test('getHeaders with true should return SSO token headers (inherited)', () {
        // Act
        final result = sut.getHeaders(true);

        // Assert
        expect(result, isA<Map<String, String>>());
        expect(result, equals(CoreHeaders.xSSOToken));
      });

      test('getHeaders with false should return empty headers (inherited)', () {
        // Act
        final result = sut.getHeaders(false);

        // Assert
        expect(result, isA<Map<String, String>>());
        expect(result, isEmpty);
      });
    });

    group('stock transfer service specific behavior', () {
      test('should be identifiable as transfer service by group value', () {
        // Act
        final groupValue = sut.getServiceGroup().value;

        // Assert
        expect(groupValue, contains('transfer'));
        expect(groupValue, contains('lot'));
      });

      test('multiple instances should have same service group', () {
        // Arrange
        final service1 = QcTransferService();
        final service2 = QcTransferService();

        // Assert
        expect(service1.getServiceGroup(), service2.getServiceGroup());
      });
    });

    group('comparison with sibling services', () {
      test('should have different service group than QcErazerService', () {
        // This test is for documentation purposes and verifying service isolation
        // QcTransferService and QcErazerService are siblings extending QcService
        
        // Act
        final transferGroup = sut.getServiceGroup();

        // Assert - transfer service uses qcTransferLot, not qcErazer
        expect(transferGroup, isNot(TRCServiceGroups.qcErazer));
        expect(transferGroup, isNot(TRCServiceGroups.qcConsole));
        expect(transferGroup, TRCServiceGroups.qcTransferLot);
      });
    });
  });
}
