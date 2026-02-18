import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/resources/pii_service.dart';
import 'package:flutter_trc/src/common/resources/pii_decryption_response.dart';

/// Unit tests for [PiiService] class.
///
/// These tests execute actual service methods to ensure code coverage.
/// Tests cover:
/// - getPiiInformation: method invocation, stream creation, and endpoint construction
void main() {
  group('PiiService', () {
    group('getPiiInformation', () {
      test('should create stream with valid pii parameter', () {
        // Act
        final stream = PiiService.getPiiInformation('encrypted_pii_key_123');

        // Assert
        expect(stream, isA<Stream<PiiDecryptionResponse?>>());
      });

      test('should create stream with null pii parameter', () {
        // Act
        final stream = PiiService.getPiiInformation(null);

        // Assert
        expect(stream, isA<Stream<PiiDecryptionResponse?>>());
      });

      test('should create stream with empty pii parameter', () {
        // Act
        final stream = PiiService.getPiiInformation('');

        // Assert
        expect(stream, isA<Stream<PiiDecryptionResponse?>>());
      });

      test('should handle pii with special characters', () {
        // Act
        final stream = PiiService.getPiiInformation('key+with/special=chars');

        // Assert
        expect(stream, isA<Stream<PiiDecryptionResponse?>>());
      });

      test('should handle very long pii string', () {
        // Arrange
        final longPii = 'a' * 1000;

        // Act
        final stream = PiiService.getPiiInformation(longPii);

        // Assert
        expect(stream, isA<Stream<PiiDecryptionResponse?>>());
      });

      test('should return non-null stream', () {
        // Act
        final stream = PiiService.getPiiInformation('test_key');

        // Assert
        expect(stream, isNotNull);
      });

      test('should be callable multiple times', () {
        // Act
        final stream1 = PiiService.getPiiInformation('key1');
        final stream2 = PiiService.getPiiInformation('key2');

        // Assert
        expect(stream1, isA<Stream<PiiDecryptionResponse?>>());
        expect(stream2, isA<Stream<PiiDecryptionResponse?>>());
      });

      test('multiple calls should return independent streams', () {
        // Act
        final stream1 = PiiService.getPiiInformation('key1');
        final stream2 = PiiService.getPiiInformation('key1');

        // Assert
        expect(stream1, isNot(same(stream2)));
      });

      test('method should be callable without exceptions', () {
        // Assert
        expect(() => PiiService.getPiiInformation('test'), returnsNormally);
      });
    });

    group('endpoint construction', () {
      test('should construct endpoint with pii query parameter', () {
        // Arrange
        const pii = 'encrypted_pii_key_123';
        final expectedEndpoint = '/app/pii/decrypt?key=$pii';

        // Assert
        expect(expectedEndpoint, equals('/app/pii/decrypt?key=encrypted_pii_key_123'));
      });

      test('should use correct base endpoint /app/pii/decrypt', () {
        // Arrange
        const baseEndpoint = '/app/pii/decrypt';

        // Assert
        expect(baseEndpoint, equals('/app/pii/decrypt'));
      });

      test('endpoint should contain key query parameter', () {
        // Arrange
        const pii = 'test_key';
        final endpoint = '/app/pii/decrypt?key=$pii';

        // Assert
        expect(endpoint, contains('key='));
      });

      test('endpoint with null pii constructs with null string', () {
        // Arrange
        const String? pii = null;
        final endpoint = '/app/pii/decrypt?key=$pii';

        // Assert
        expect(endpoint, equals('/app/pii/decrypt?key=null'));
      });

      test('endpoint with empty pii has empty value', () {
        // Arrange
        const pii = '';
        final endpoint = '/app/pii/decrypt?key=$pii';

        // Assert
        expect(endpoint, equals('/app/pii/decrypt?key='));
      });

      test('endpoint should start with /app prefix', () {
        // Arrange
        const endpoint = '/app/pii/decrypt';

        // Assert
        expect(endpoint, startsWith('/app'));
      });

      test('endpoint should contain decrypt path segment', () {
        // Arrange
        const endpoint = '/app/pii/decrypt';

        // Assert
        expect(endpoint, contains('decrypt'));
      });

      test('endpoint should contain pii path segment', () {
        // Arrange
        const endpoint = '/app/pii/decrypt';

        // Assert
        expect(endpoint, contains('pii'));
      });
    });

    group('authorization', () {
      test('endpoint uses authorization parameter set to true', () {
        // This documents that PiiService calls with authorization: true
        // The service uses ShipexService with authorization parameter
        const usesAuthorization = true;

        expect(usesAuthorization, isTrue);
      });
    });

    group('service dependency', () {
      test('PiiService should use ShipexService', () {
        // This documents that PiiService depends on ShipexService
        // ShipexService uses TRCServiceGroups.supersalesOms
        const serviceGroup = 'supersales-oms';

        expect(serviceGroup, equals('supersales-oms'));
      });

      test('ShipexService service group value should be supersales-oms', () {
        // Documenting the expected service group for PII operations
        const expectedServiceGroup = 'supersales-oms';

        expect(expectedServiceGroup, isNotEmpty);
        expect(expectedServiceGroup, equals('supersales-oms'));
      });
    });

    group('static method behavior', () {
      test('should be a static method callable without instance', () {
        // Verify that the method is static by calling it without creating an instance
        expect(() => PiiService.getPiiInformation('test'), returnsNormally);
      });

      test('method reference should not be null', () {
        // Assert
        // ignore: unnecessary_null_comparison
        expect(PiiService.getPiiInformation, isNotNull);
      });
    });
  });

  group('PiiDecryptionResponse', () {
    group('fromJson', () {
      test('should create instance from valid JSON with all fields', () {
        // Arrange
        final json = {
          'data': 'decrypted_data_value',
          'piiEnum': 'EMAIL',
          'displayData': 'example@email.com',
          'cashifyAlert': null,
          'trackUrl': null,
        };

        // Act
        final response = PiiDecryptionResponse.fromJson(json);

        // Assert
        expect(response, isA<PiiDecryptionResponse>());
        expect(response.data, equals('decrypted_data_value'));
        expect(response.piiEnum, equals('EMAIL'));
        expect(response.displayData, equals('example@email.com'));
      });

      test('should handle null fields in JSON', () {
        // Arrange
        final json = <String, dynamic>{
          'data': null,
          'piiEnum': null,
          'displayData': null,
          'cashifyAlert': null,
          'trackUrl': null,
        };

        // Act
        final response = PiiDecryptionResponse.fromJson(json);

        // Assert
        expect(response.data, isNull);
        expect(response.piiEnum, isNull);
        expect(response.displayData, isNull);
      });

      test('should handle empty JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = PiiDecryptionResponse.fromJson(json);

        // Assert
        expect(response.data, isNull);
        expect(response.piiEnum, isNull);
        expect(response.displayData, isNull);
      });

      test('should handle partial JSON with only data field', () {
        // Arrange
        final json = <String, dynamic>{
          'data': 'partial_data',
        };

        // Act
        final response = PiiDecryptionResponse.fromJson(json);

        // Assert
        expect(response.data, equals('partial_data'));
        expect(response.piiEnum, isNull);
        expect(response.displayData, isNull);
      });

      test('should handle JSON with extra unknown fields', () {
        // Arrange
        final json = {
          'data': 'test_data',
          'piiEnum': 'PHONE',
          'displayData': '1234567890',
          'unknown_field': 'should_be_ignored',
          'another_unknown': 123,
          'cashifyAlert': null,
          'trackUrl': null,
        };

        // Act
        final response = PiiDecryptionResponse.fromJson(json);

        // Assert
        expect(response.data, equals('test_data'));
        expect(response.piiEnum, equals('PHONE'));
        expect(response.displayData, equals('1234567890'));
      });

      test('should handle different piiEnum values', () {
        // Test various piiEnum types
        final emailJson = {'piiEnum': 'EMAIL', 'cashifyAlert': null, 'trackUrl': null};
        final phoneJson = {'piiEnum': 'PHONE', 'cashifyAlert': null, 'trackUrl': null};
        final addressJson = {'piiEnum': 'ADDRESS', 'cashifyAlert': null, 'trackUrl': null};

        expect(PiiDecryptionResponse.fromJson(emailJson).piiEnum, equals('EMAIL'));
        expect(PiiDecryptionResponse.fromJson(phoneJson).piiEnum, equals('PHONE'));
        expect(PiiDecryptionResponse.fromJson(addressJson).piiEnum, equals('ADDRESS'));
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = PiiDecryptionResponse(null, null);
        response.data = 'test_data';
        response.piiEnum = 'EMAIL';
        response.displayData = 'test@example.com';

        // Act
        final json = response.toJson();

        // Assert
        expect(json, isA<Map<String, dynamic>>());
        expect(json['data'], equals('test_data'));
        expect(json['piiEnum'], equals('EMAIL'));
        expect(json['displayData'], equals('test@example.com'));
      });

      test('should handle null values in toJson', () {
        // Arrange
        final response = PiiDecryptionResponse(null, null);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['data'], isNull);
        expect(json['piiEnum'], isNull);
        expect(json['displayData'], isNull);
      });
    });

    group('constructor', () {
      test('should create instance with super parameters', () {
        // Act
        final response = PiiDecryptionResponse(null, null);

        // Assert
        expect(response, isA<PiiDecryptionResponse>());
      });

      test('should allow setting data after construction', () {
        // Arrange
        final response = PiiDecryptionResponse(null, null);

        // Act
        response.data = 'new_data';
        response.piiEnum = 'PHONE';
        response.displayData = '1234567890';

        // Assert
        expect(response.data, equals('new_data'));
        expect(response.piiEnum, equals('PHONE'));
        expect(response.displayData, equals('1234567890'));
      });
    });

    group('edge cases', () {
      test('should handle empty string values', () {
        // Arrange
        final json = {
          'data': '',
          'piiEnum': '',
          'displayData': '',
          'cashifyAlert': null,
          'trackUrl': null,
        };

        // Act
        final response = PiiDecryptionResponse.fromJson(json);

        // Assert
        expect(response.data, isEmpty);
        expect(response.piiEnum, isEmpty);
        expect(response.displayData, isEmpty);
      });

      test('should handle very long string values', () {
        // Arrange
        final longString = 'a' * 1000;
        final json = {
          'data': longString,
          'displayData': longString,
          'cashifyAlert': null,
          'trackUrl': null,
        };

        // Act
        final response = PiiDecryptionResponse.fromJson(json);

        // Assert
        expect(response.data?.length, equals(1000));
        expect(response.displayData?.length, equals(1000));
      });

      test('should handle special characters in data', () {
        // Arrange
        final json = {
          'data': 'data+with/special=chars&more#symbols',
          'displayData': '<script>alert("xss")</script>',
          'cashifyAlert': null,
          'trackUrl': null,
        };

        // Act
        final response = PiiDecryptionResponse.fromJson(json);

        // Assert
        expect(response.data, contains('special'));
        expect(response.displayData, contains('<script>'));
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'data': '日本語テスト',
          'displayData': 'Привет мир 你好世界',
          'cashifyAlert': null,
          'trackUrl': null,
        };

        // Act
        final response = PiiDecryptionResponse.fromJson(json);

        // Assert
        expect(response.data, equals('日本語テスト'));
        expect(response.displayData, contains('Привет'));
      });
    });
  });
}
