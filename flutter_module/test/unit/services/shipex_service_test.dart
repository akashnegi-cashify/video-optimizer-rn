import 'package:flutter_test/flutter_test.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty;
import 'package:flutter_trc/shipex/shipex_service.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

void main() {
  group('ShipexService', () {
    late ShipexService sut;

    setUp(() {
      sut = ShipexService();
    });

    group('constructor', () {
      test('should create instance with default addAuthorization as false', () {
        // Arrange & Act
        final service = ShipexService();

        // Assert
        expect(service.isToAddAuthorization(), isFalse);
      });

      test('should create instance with addAuthorization as true', () {
        // Arrange & Act
        final service = ShipexService(addAuthorization: true);

        // Assert
        expect(service.isToAddAuthorization(), isTrue);
      });

      test('should create instance with addAuthorization as false when specified', () {
        // Arrange & Act
        final service = ShipexService(addAuthorization: false);

        // Assert
        expect(service.isToAddAuthorization(), isFalse);
      });
    });

    group('getServiceGroup', () {
      test('should return TRCServiceGroups.supersalesOms', () {
        // Act
        final result = sut.getServiceGroup();

        // Assert
        expect(result, TRCServiceGroups.supersalesOms);
      });

      test('should return supersalesOms regardless of addAuthorization value', () {
        // Arrange
        final serviceWithAuth = ShipexService(addAuthorization: true);
        final serviceWithoutAuth = ShipexService(addAuthorization: false);

        // Act & Assert
        expect(serviceWithAuth.getServiceGroup(), TRCServiceGroups.supersalesOms);
        expect(serviceWithoutAuth.getServiceGroup(), TRCServiceGroups.supersalesOms);
      });

      test('service group value should be "supersales-oms"', () {
        // Act
        final result = sut.getServiceGroup();

        // Assert
        expect(result.value, 'supersales-oms');
      });
    });

    group('isToAddUserAuth', () {
      test('should always return true', () {
        // Act
        final result = sut.isToAddUserAuth();

        // Assert
        expect(result, isTrue);
      });

      test('should return true regardless of addAuthorization constructor value', () {
        // Arrange
        final serviceWithAuth = ShipexService(addAuthorization: true);
        final serviceWithoutAuth = ShipexService(addAuthorization: false);

        // Act & Assert
        expect(serviceWithAuth.isToAddUserAuth(), isTrue);
        expect(serviceWithoutAuth.isToAddUserAuth(), isTrue);
      });
    });

    group('isToAddAuthorization', () {
      test('should return false when constructed without parameter', () {
        // Act
        final result = sut.isToAddAuthorization();

        // Assert
        expect(result, isFalse);
      });

      test('should return true when constructed with addAuthorization: true', () {
        // Arrange
        final service = ShipexService(addAuthorization: true);

        // Act
        final result = service.isToAddAuthorization();

        // Assert
        expect(result, isTrue);
      });

      test('should return false when constructed with addAuthorization: false', () {
        // Arrange
        final service = ShipexService(addAuthorization: false);

        // Act
        final result = service.isToAddAuthorization();

        // Assert
        expect(result, isFalse);
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

      test('should be consistent across multiple calls with same parameter', () {
        // Act
        final result1 = sut.getHeaders(true);
        final result2 = sut.getHeaders(true);
        final result3 = sut.getHeaders(false);
        final result4 = sut.getHeaders(false);

        // Assert
        expect(result1, equals(result2));
        expect(result3, equals(result4));
      });
    });

    group('inheritance', () {
      test('should be an instance of BaseService', () {
        // Assert
        expect(sut, isA<BaseService>());
      });
    });

    group('multiple instances', () {
      test('should have independent authorization settings', () {
        // Arrange
        final service1 = ShipexService(addAuthorization: true);
        final service2 = ShipexService(addAuthorization: false);

        // Assert
        expect(service1.isToAddAuthorization(), isTrue);
        expect(service2.isToAddAuthorization(), isFalse);
      });

      test('different instances should return same service group', () {
        // Arrange
        final service1 = ShipexService();
        final service2 = ShipexService(addAuthorization: true);
        final service3 = ShipexService(addAuthorization: false);

        // Assert
        expect(service1.getServiceGroup(), service2.getServiceGroup());
        expect(service2.getServiceGroup(), service3.getServiceGroup());
      });
    });
  });
}
