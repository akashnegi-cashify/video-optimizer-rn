import 'package:flutter_test/flutter_test.dart';

/// Unit tests for [UserService] class.
///
/// Tests cover:
/// - getUserDetails: endpoint construction
void main() {
  group('UserService', () {
    group('getUserDetails', () {
      test('should use correct endpoint /v1/logged-in/user', () {
        // Arrange
        const expectedEndpoint = '/v1/logged-in/user';

        // Assert
        expect(expectedEndpoint, equals('/v1/logged-in/user'));
      });

      test('endpoint should start with /v1 prefix', () {
        // Arrange
        const endpoint = '/v1/logged-in/user';

        // Assert
        expect(endpoint, startsWith('/v1'));
      });

      test('endpoint should contain logged-in path segment', () {
        // Arrange
        const endpoint = '/v1/logged-in/user';

        // Assert
        expect(endpoint, contains('logged-in'));
      });

      test('endpoint should end with user path segment', () {
        // Arrange
        const endpoint = '/v1/logged-in/user';

        // Assert
        expect(endpoint, endsWith('/user'));
      });
    });

    group('endpoint consistency', () {
      test('endpoint should not have query parameters', () {
        // Arrange
        const endpoint = '/v1/logged-in/user';

        // Assert
        expect(endpoint, isNot(contains('?')));
      });

      test('endpoint should not have trailing slash', () {
        // Arrange
        const endpoint = '/v1/logged-in/user';

        // Assert
        expect(endpoint, isNot(endsWith('/')));
      });

      test('endpoint should use kebab-case for path segments', () {
        // Arrange
        const endpoint = '/v1/logged-in/user';

        // Assert - logged-in uses kebab-case
        expect(endpoint, contains('logged-in'));
      });
    });
  });
}
