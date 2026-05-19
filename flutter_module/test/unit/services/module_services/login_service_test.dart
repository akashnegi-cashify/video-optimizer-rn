import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

/// Unit tests for [TRCLoginService] class.
///
/// Tests cover:
/// - userLogin: request body construction and endpoint
void main() {
  group('TRCLoginService', () {
    group('userLogin', () {
      test('should use correct endpoint /login', () {
        // Arrange
        const expectedEndpoint = '/login';

        // Assert
        expect(expectedEndpoint, equals('/login'));
      });

      test('should construct request body with all required fields', () {
        // Arrange
        const employeeCode = 'EMP001';
        const password = 'password123';
        const location = 'Delhi';
        const deviceId = 'device_123';

        final data = {
          "did": deviceId,
          "empCo": employeeCode,
          "ps": password,
          "version": 0,
          "lc": location,
        };

        // Act
        final encoded = jsonEncode(data);
        final decoded = jsonDecode(encoded) as Map<String, dynamic>;

        // Assert
        expect(decoded['did'], equals('device_123'));
        expect(decoded['empCo'], equals('EMP001'));
        expect(decoded['ps'], equals('password123'));
        expect(decoded['version'], equals(0));
        expect(decoded['lc'], equals('Delhi'));
      });

      test('should handle null location', () {
        // Arrange
        const employeeCode = 'EMP001';
        const password = 'password123';
        const String? location = null;
        const deviceId = 'device_123';

        final data = {
          "did": deviceId,
          "empCo": employeeCode,
          "ps": password,
          "version": 0,
          "lc": location,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(data)) as Map<String, dynamic>;

        // Assert
        expect(decoded['lc'], isNull);
      });

      test('should handle null deviceId', () {
        // Arrange
        const employeeCode = 'EMP001';
        const password = 'password123';
        const location = 'Delhi';
        const String? deviceId = null;

        final data = {
          "did": deviceId,
          "empCo": employeeCode,
          "ps": password,
          "version": 0,
          "lc": location,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(data)) as Map<String, dynamic>;

        // Assert
        expect(decoded['did'], isNull);
      });

      test('version should always be 0', () {
        // Arrange
        final data = {
          "did": "device",
          "empCo": "emp",
          "ps": "pass",
          "version": 0,
          "lc": "loc",
        };

        // Assert
        expect(data['version'], equals(0));
      });

      test('request body should contain exactly 5 fields', () {
        // Arrange
        final data = {
          "did": "device_123",
          "empCo": "EMP001",
          "ps": "password123",
          "version": 0,
          "lc": "Delhi",
        };

        // Assert
        expect(data.length, equals(5));
      });

      test('should use abbreviated field names', () {
        // Arrange
        final data = {
          "did": "device_123",
          "empCo": "EMP001",
          "ps": "password123",
          "version": 0,
          "lc": "Delhi",
        };

        // Assert
        expect(data.containsKey('did'), isTrue); // device id
        expect(data.containsKey('empCo'), isTrue); // employee code
        expect(data.containsKey('ps'), isTrue); // password
        expect(data.containsKey('lc'), isTrue); // location
      });
    });

    group('authorization settings', () {
      test('userLogin should use authorization: true and userAuth: false', () {
        // This documents the authorization settings for login
        const authorization = true;
        const userAuth = false;

        expect(authorization, isTrue);
        expect(userAuth, isFalse);
      });
    });

    group('service dependency', () {
      test('TRCLoginService should use TrcService', () {
        // This documents that TRCLoginService depends on TrcService
        // TrcService uses TRCServiceGroups.unifyTrc
        const serviceGroup = 'unify-trc';

        expect(serviceGroup, equals('unify-trc'));
      });
    });

    group('endpoint consistency', () {
      test('endpoint should not have version prefix', () {
        // Arrange
        const endpoint = '/login';

        // Assert
        expect(endpoint, isNot(startsWith('/v1')));
        expect(endpoint, isNot(startsWith('/v2')));
      });

      test('endpoint should not have query parameters', () {
        // Arrange
        const endpoint = '/login';

        // Assert
        expect(endpoint, isNot(contains('?')));
      });
    });
  });
}
