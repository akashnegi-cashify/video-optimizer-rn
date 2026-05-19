import 'package:flutter_test/flutter_test.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty, ConsoleService;
import 'package:flutter_trc/src/services/console_service.dart';

void main() {
  group('ConsoleService', () {
    late ConsoleService sut;

    setUp(() {
      sut = ConsoleService();
    });

    group('constructor', () {
      test('should create instance with default addAuthorization as true', () {
        // Arrange & Act
        final service = ConsoleService();

        // Assert
        // ConsoleService defaults to addAuthorization: true (unlike other services)
        expect(service.isToAddAuthorization(), isTrue);
      });

      test('should create instance with addAuthorization as true when specified', () {
        // Arrange & Act
        final service = ConsoleService(addAuthorization: true);

        // Assert
        expect(service.isToAddAuthorization(), isTrue);
      });

      test('should create instance with addAuthorization as false when specified', () {
        // Arrange & Act
        final service = ConsoleService(addAuthorization: false);

        // Assert
        expect(service.isToAddAuthorization(), isFalse);
      });
    });

    group('getServiceGroup', () {
      test('should return ServiceGroups.console', () {
        // Act
        final result = sut.getServiceGroup();

        // Assert
        expect(result, ServiceGroups.console);
      });

      test('should return console regardless of addAuthorization value', () {
        // Arrange
        final serviceWithAuth = ConsoleService(addAuthorization: true);
        final serviceWithoutAuth = ConsoleService(addAuthorization: false);

        // Act & Assert
        expect(serviceWithAuth.getServiceGroup(), ServiceGroups.console);
        expect(serviceWithoutAuth.getServiceGroup(), ServiceGroups.console);
      });

      test('service group value should be "console-manager"', () {
        // Act
        final result = sut.getServiceGroup();

        // Assert
        expect(result.value, 'console-manager');
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
        final serviceWithAuth = ConsoleService(addAuthorization: true);
        final serviceWithoutAuth = ConsoleService(addAuthorization: false);

        // Act & Assert
        expect(serviceWithAuth.isToAddUserAuth(), isTrue);
        expect(serviceWithoutAuth.isToAddUserAuth(), isTrue);
      });
    });

    group('isToAddAuthorization', () {
      test('should return true when constructed without parameter (default)', () {
        // Act
        final result = sut.isToAddAuthorization();

        // Assert
        // ConsoleService defaults to addAuthorization: true
        expect(result, isTrue);
      });

      test('should return true when constructed with addAuthorization: true', () {
        // Arrange
        final service = ConsoleService(addAuthorization: true);

        // Act
        final result = service.isToAddAuthorization();

        // Assert
        expect(result, isTrue);
      });

      test('should return false when constructed with addAuthorization: false', () {
        // Arrange
        final service = ConsoleService(addAuthorization: false);

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
        final service1 = ConsoleService(addAuthorization: true);
        final service2 = ConsoleService(addAuthorization: false);

        // Assert
        expect(service1.isToAddAuthorization(), isTrue);
        expect(service2.isToAddAuthorization(), isFalse);
      });

      test('different instances should return same service group', () {
        // Arrange
        final service1 = ConsoleService();
        final service2 = ConsoleService(addAuthorization: true);
        final service3 = ConsoleService(addAuthorization: false);

        // Assert
        expect(service1.getServiceGroup(), service2.getServiceGroup());
        expect(service2.getServiceGroup(), service3.getServiceGroup());
      });
    });

    group('default behavior difference', () {
      test('ConsoleService should default to addAuthorization: true unlike other services', () {
        // This test documents the intentional difference in ConsoleService
        // Most services default to addAuthorization: false, but ConsoleService defaults to true
        final consoleService = ConsoleService();

        expect(consoleService.isToAddAuthorization(), isTrue,
            reason: 'ConsoleService should default to addAuthorization: true');
      });
    });
  });
}
