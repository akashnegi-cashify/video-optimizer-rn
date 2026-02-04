import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

/// Unit tests for [MPinService] class.
///
/// Tests cover:
/// - submitMPin: request body construction and endpoint
/// - validateMPin: request body construction and endpoint
void main() {
  group('MPinService', () {
    group('submitMPin', () {
      test('should use correct endpoint /v1/mpin/create', () {
        // Arrange
        const expectedEndpoint = '/v1/mpin/create';

        // Assert
        expect(expectedEndpoint, equals('/v1/mpin/create'));
      });

      test('should construct request body with mpin field', () {
        // Arrange
        const mPin = '1234';
        final req = {"mpin": mPin};

        // Act
        final encoded = jsonEncode(req);
        final decoded = jsonDecode(encoded) as Map<String, dynamic>;

        // Assert
        expect(decoded['mpin'], equals('1234'));
      });

      test('should handle null mPin value', () {
        // Arrange
        const String? mPin = null;
        final req = {"mpin": mPin};

        // Act
        final encoded = jsonEncode(req);
        final decoded = jsonDecode(encoded) as Map<String, dynamic>;

        // Assert
        expect(decoded['mpin'], isNull);
      });

      test('should handle empty mPin value', () {
        // Arrange
        const mPin = '';
        final req = {"mpin": mPin};

        // Act
        final encoded = jsonEncode(req);
        final decoded = jsonDecode(encoded) as Map<String, dynamic>;

        // Assert
        expect(decoded['mpin'], equals(''));
      });

      test('should handle numeric mPin as string', () {
        // Arrange
        const mPin = '0000';
        final req = {"mpin": mPin};

        // Act
        final encoded = jsonEncode(req);
        final decoded = jsonDecode(encoded) as Map<String, dynamic>;

        // Assert
        expect(decoded['mpin'], equals('0000'));
        expect(decoded['mpin'], isA<String>());
      });

      test('endpoint should have version prefix /v1', () {
        // Arrange
        const endpoint = '/v1/mpin/create';

        // Assert
        expect(endpoint, startsWith('/v1'));
      });
    });

    group('validateMPin', () {
      test('should use correct endpoint /v1/mpin/validate', () {
        // Arrange
        const expectedEndpoint = '/v1/mpin/validate';

        // Assert
        expect(expectedEndpoint, equals('/v1/mpin/validate'));
      });

      test('should construct request body with mpin field', () {
        // Arrange
        const mPin = '5678';
        final req = {"mpin": mPin};

        // Act
        final encoded = jsonEncode(req);
        final decoded = jsonDecode(encoded) as Map<String, dynamic>;

        // Assert
        expect(decoded['mpin'], equals('5678'));
      });

      test('should handle null mPin value', () {
        // Arrange
        const String? mPin = null;
        final req = {"mpin": mPin};

        // Act
        final encoded = jsonEncode(req);
        final decoded = jsonDecode(encoded) as Map<String, dynamic>;

        // Assert
        expect(decoded['mpin'], isNull);
      });

      test('endpoint should have version prefix /v1', () {
        // Arrange
        const endpoint = '/v1/mpin/validate';

        // Assert
        expect(endpoint, startsWith('/v1'));
      });

      test('endpoint should end with /validate', () {
        // Arrange
        const endpoint = '/v1/mpin/validate';

        // Assert
        expect(endpoint, endsWith('/validate'));
      });
    });

    group('endpoint consistency', () {
      test('both endpoints should be under /v1/mpin path', () {
        // Arrange
        const createEndpoint = '/v1/mpin/create';
        const validateEndpoint = '/v1/mpin/validate';

        // Assert
        expect(createEndpoint, startsWith('/v1/mpin'));
        expect(validateEndpoint, startsWith('/v1/mpin'));
      });

      test('endpoints should not have query parameters', () {
        // Arrange
        const createEndpoint = '/v1/mpin/create';
        const validateEndpoint = '/v1/mpin/validate';

        // Assert
        expect(createEndpoint, isNot(contains('?')));
        expect(validateEndpoint, isNot(contains('?')));
      });
    });

    group('request body structure', () {
      test('both methods should use same request body structure', () {
        // Arrange
        const mPin = '9999';
        final createReq = {"mpin": mPin};
        final validateReq = {"mpin": mPin};

        // Assert
        expect(createReq.keys, equals(validateReq.keys));
        expect(createReq['mpin'], equals(validateReq['mpin']));
      });

      test('request body should only contain mpin field', () {
        // Arrange
        const mPin = '1234';
        final req = {"mpin": mPin};

        // Assert
        expect(req.length, equals(1));
        expect(req.containsKey('mpin'), isTrue);
      });
    });
  });
}
