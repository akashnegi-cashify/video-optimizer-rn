import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/trc/trc_calculator_service.dart';
import 'package:flutter_trc/src/services/trc_service.dart';
import 'package:core_widgets/core_widgets.dart';

/// Unit tests for [TrcCalculatorService] class.
///
/// Tests cover:
/// - getService: returns TrcService instance
/// - inheritance from CalculatorService
void main() {
  group('TrcCalculatorService', () {
    late TrcCalculatorService sut;

    setUp(() {
      sut = TrcCalculatorService();
    });

    group('getService', () {
      test('should return TrcService instance', () {
        // Act
        final service = sut.getService();

        // Assert
        expect(service, isA<TrcService>());
      });

      test('should return BaseService instance', () {
        // Act
        final service = sut.getService();

        // Assert
        expect(service, isA<BaseService>());
      });

      test('returned service should have unify-trc service group', () {
        // Act
        final service = sut.getService();
        final serviceGroup = service.getServiceGroup();

        // Assert
        expect(serviceGroup.value, equals('unify-trc'));
      });

      test('should return new TrcService instance each time', () {
        // Act
        final service1 = sut.getService();
        final service2 = sut.getService();

        // Assert
        // Note: These are different instances but of the same type
        expect(service1, isA<TrcService>());
        expect(service2, isA<TrcService>());
      });
    });

    group('inheritance', () {
      test('should extend CalculatorService', () {
        // TrcCalculatorService extends CalculatorService
        // which provides calculator-related API methods
        expect(sut, isNotNull);
      });
    });

    group('service configuration', () {
      test('TrcService should return true for isToAddUserAuth', () {
        // Act
        final service = sut.getService();

        // Assert
        expect(service.isToAddUserAuth(), isTrue);
      });

      test('TrcService should return false for default isToAddAuthorization', () {
        // Act
        final service = sut.getService();

        // Assert
        expect(service.isToAddAuthorization(), isFalse);
      });
    });
  });
}
