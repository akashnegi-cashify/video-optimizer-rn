import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/interceptors/interceptors_helper.dart';

/// Unit tests for [InterceptorsHelper] class.
///
/// Tests cover:
/// - Global interceptors retrieval
void main() {
  group('InterceptorsHelper', () {
    group('getGlobalInterceptors', () {
      test('should return a Map', () {
        // Act
        final result = InterceptorsHelper.getGlobalInterceptors();

        // Assert
        expect(result, isA<Map>());
      });

      test('should return empty map (as per current implementation)', () {
        // Act
        final result = InterceptorsHelper.getGlobalInterceptors();

        // Assert
        // Note: The AuthHeaderInterceptor is commented out in the current implementation
        expect(result.isEmpty, isTrue);
      });

      test('should return new map instance on each call', () {
        // Act
        final result1 = InterceptorsHelper.getGlobalInterceptors();
        final result2 = InterceptorsHelper.getGlobalInterceptors();

        // Assert - Each call creates a new map
        expect(identical(result1, result2), isFalse);
      });

      test('returned map should be mutable', () {
        // Act
        final result = InterceptorsHelper.getGlobalInterceptors();

        // Assert - Can modify the returned map (it's not const)
        expect(() => result['test'] = () => throw UnimplementedError(), returnsNormally);
      });
    });
  });
}
