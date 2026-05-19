import 'package:flutter_test/flutter_test.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty;
import 'package:flutter_trc/src/services/qc_service.dart';
import 'package:flutter_trc/src/services/qc_erazer_service.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

void main() {
  group('QcErazerService', () {
    late QcErazerService sut;

    setUp(() {
      sut = QcErazerService();
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
      test('should return TRCServiceGroups.qcErazer', () {
        // Act
        final result = sut.getServiceGroup();

        // Assert
        expect(result, TRCServiceGroups.qcErazer);
      });

      test('service group value should be "qc-data-erazer"', () {
        // Act
        final result = sut.getServiceGroup();

        // Assert
        expect(result.value, 'qc-data-erazer');
      });

      test('should override parent class service group', () {
        // Arrange
        final parentService = QcService();

        // Act
        final parentGroup = parentService.getServiceGroup();
        final childGroup = sut.getServiceGroup();

        // Assert - QcErazerService should use qcErazer, not qcConsole
        expect(parentGroup, TRCServiceGroups.qcConsole);
        expect(childGroup, TRCServiceGroups.qcErazer);
        expect(parentGroup, isNot(equals(childGroup)));
      });
    });

    group('isToAddUserAuth', () {
      test('should inherit from parent and return true', () {
        // Act
        final result = sut.isToAddUserAuth();

        // Assert
        expect(result, isTrue);
      });
    });

    group('getHeaders', () {
      test('should return SSO token headers when isToAddAuth is null (uses default)', () {
        // Act
        final result = sut.getHeaders(null);

        // Assert
        expect(result, isA<Map<String, String>>());
        expect(result, equals(CoreHeaders.xSSOToken));
      });

      test('should return SSO token headers when isToAddAuth is true', () {
        // Act
        final result = sut.getHeaders(true);

        // Assert
        expect(result, isA<Map<String, String>>());
        expect(result, equals(CoreHeaders.xSSOToken));
      });

      test('should return empty headers when isToAddAuth is false', () {
        // Act
        final result = sut.getHeaders(false);

        // Assert
        expect(result, isA<Map<String, String>>());
        expect(result, isEmpty);
      });

      test('should behave same as parent class for headers', () {
        // Arrange
        final parentService = QcService();

        // Act
        final parentHeadersNull = parentService.getHeaders(null);
        final childHeadersNull = sut.getHeaders(null);
        final parentHeadersTrue = parentService.getHeaders(true);
        final childHeadersTrue = sut.getHeaders(true);
        final parentHeadersFalse = parentService.getHeaders(false);
        final childHeadersFalse = sut.getHeaders(false);

        // Assert
        expect(parentHeadersNull, equals(childHeadersNull));
        expect(parentHeadersTrue, equals(childHeadersTrue));
        expect(parentHeadersFalse, equals(childHeadersFalse));
      });
    });

    group('isToAddAuthorization', () {
      test('should inherit default value (false) from parent', () {
        // Act
        final result = sut.isToAddAuthorization();

        // Assert - inherits from QcService which defaults to false
        expect(result, isFalse);
      });
    });

    group('data erasure service specific behavior', () {
      test('should be identifiable as data erasure service by group value', () {
        // Act
        final groupValue = sut.getServiceGroup().value;

        // Assert
        expect(groupValue, contains('erazer'));
        expect(groupValue, contains('data'));
      });

      test('multiple instances should have same service group', () {
        // Arrange
        final service1 = QcErazerService();
        final service2 = QcErazerService();

        // Assert
        expect(service1.getServiceGroup(), service2.getServiceGroup());
      });
    });
  });
}
