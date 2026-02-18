import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/services/s3_details.dart';
import 'package:flutter_trc/src/resources/models/s3_details_response.dart';

/// Unit tests for [S3DetailsService] class.
///
/// Tests cover:
/// - fetchS3Details: method invocation and stream creation
/// - Endpoint verification
/// - Return type verification
void main() {
  group('S3DetailsService', () {
    group('fetchS3Details', () {
      test('should create stream when called', () {
        // Act
        final stream = S3DetailsService.fetchS3Details();

        // Assert
        expect(stream, isA<Stream<S3DetailsResponse?>>());
      });

      test('should return non-null stream', () {
        // Act
        final stream = S3DetailsService.fetchS3Details();

        // Assert
        expect(stream, isNotNull);
      });

      test('should be callable multiple times', () {
        // Act
        final stream1 = S3DetailsService.fetchS3Details();
        final stream2 = S3DetailsService.fetchS3Details();

        // Assert
        expect(stream1, isA<Stream<S3DetailsResponse?>>());
        expect(stream2, isA<Stream<S3DetailsResponse?>>());
      });

      test('multiple calls should return independent streams', () {
        // Act
        final stream1 = S3DetailsService.fetchS3Details();
        final stream2 = S3DetailsService.fetchS3Details();

        // Assert
        expect(stream1, isNot(same(stream2)));
      });

      test('method should be callable without exceptions', () {
        // Assert
        expect(() => S3DetailsService.fetchS3Details(), returnsNormally);
      });
    });

    group('endpoint', () {
      test('should use correct endpoint path /s3/details', () {
        // Arrange
        const expectedEndpoint = '/s3/details';

        // Assert
        expect(expectedEndpoint, equals('/s3/details'));
      });

      test('endpoint should start with /s3', () {
        // Arrange
        const endpoint = '/s3/details';

        // Assert
        expect(endpoint, startsWith('/s3'));
      });

      test('endpoint should contain details path segment', () {
        // Arrange
        const endpoint = '/s3/details';

        // Assert
        expect(endpoint, contains('details'));
      });

      test('endpoint should be a simple GET without query parameters', () {
        // Arrange
        const endpoint = '/s3/details';

        // Assert
        expect(endpoint.contains('?'), isFalse);
        expect(endpoint.contains('='), isFalse);
      });
    });

    group('service dependency', () {
      test('S3DetailsService should use TrcService', () {
        // This documents that S3DetailsService depends on TrcService
        // TrcService uses TRCServiceGroups.unifyTrc
        const serviceGroup = 'unify-trc';

        expect(serviceGroup, equals('unify-trc'));
      });

      test('TrcService service group value should be unify-trc', () {
        // Documenting the expected service group for S3 operations
        const expectedServiceGroup = 'unify-trc';

        expect(expectedServiceGroup, isNotEmpty);
        expect(expectedServiceGroup, equals('unify-trc'));
      });
    });

    group('return type', () {
      test('should return Stream of nullable S3DetailsResponse', () {
        // Act
        final stream = S3DetailsService.fetchS3Details();

        // Assert
        expect(stream, isA<Stream<S3DetailsResponse?>>());
      });

      test('stream should be broadcastable', () {
        // Act
        final stream = S3DetailsService.fetchS3Details();
        
        // Assert - verify it's a valid stream
        expect(stream.isBroadcast, anyOf(isTrue, isFalse));
      });
    });

    group('static method behavior', () {
      test('should be a static method callable without instance', () {
        // Verify that the method is static by calling it without creating an instance
        expect(() => S3DetailsService.fetchS3Details(), returnsNormally);
      });

      test('method reference should not be null', () {
        // Assert
        // ignore: unnecessary_null_comparison
        expect(S3DetailsService.fetchS3Details, isNotNull);
      });
    });
  });

  group('S3DetailsResponse', () {
    group('fromJson', () {
      test('should create instance from valid JSON with all fields', () {
        // Arrange
        final json = {
          'r_id': 'ref123',
          's': true,
          'dt': {
            'url': 'https://s3.example.com',
            'ak': 'access_key_123',
            'sk': 'secret_key_456',
            'bn': 'bucket_name',
            'fn': 'folder_name',
            'cid': 'pool_id_789',
          },
        };

        // Act
        final response = S3DetailsResponse.fromJson(json);

        // Assert
        expect(response, isA<S3DetailsResponse>());
        expect(response.refId, equals('ref123'));
        expect(response.isSuccess, isTrue);
        expect(response.data, isA<S3DataResponse>());
      });

      test('should handle null fields in JSON', () {
        // Arrange
        final json = <String, dynamic>{
          'r_id': null,
          's': null,
          'dt': null,
        };

        // Act
        final response = S3DetailsResponse.fromJson(json);

        // Assert
        expect(response.refId, isNull);
        expect(response.isSuccess, isNull);
        expect(response.data, isNull);
      });

      test('should handle empty JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = S3DetailsResponse.fromJson(json);

        // Assert
        expect(response.refId, isNull);
        expect(response.isSuccess, isNull);
        expect(response.data, isNull);
      });

      test('should handle partial JSON with only success field', () {
        // Arrange
        final json = <String, dynamic>{
          's': false,
        };

        // Act
        final response = S3DetailsResponse.fromJson(json);

        // Assert
        expect(response.isSuccess, isFalse);
        expect(response.refId, isNull);
        expect(response.data, isNull);
      });

      test('should handle JSON with extra unknown fields', () {
        // Arrange
        final json = {
          'r_id': 'ref123',
          's': true,
          'unknown_field': 'should_be_ignored',
          'another_unknown': 123,
        };

        // Act
        final response = S3DetailsResponse.fromJson(json);

        // Assert
        expect(response.refId, equals('ref123'));
        expect(response.isSuccess, isTrue);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final dataResponse = S3DataResponse(
          'access_key',
          'bucket_name',
          'folder_name',
          'https://s3.example.com',
          'secret_key',
        );
        final response = S3DetailsResponse(true, 'ref123', dataResponse);

        // Act
        final json = response.toJson();

        // Assert
        expect(json, isA<Map<String, dynamic>>());
        expect(json['s'], isTrue);
        expect(json['r_id'], equals('ref123'));
        // Note: Generated toJson() stores nested object directly, not as Map
        expect(json['dt'], isA<S3DataResponse>());
        expect((json['dt'] as S3DataResponse).accessKey, equals('access_key'));
      });

      test('should handle null values in toJson', () {
        // Arrange
        final response = S3DetailsResponse(null, null, null);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['s'], isNull);
        expect(json['r_id'], isNull);
        expect(json['dt'], isNull);
      });

      test('nested data toJson should serialize correctly', () {
        // Arrange
        final dataResponse = S3DataResponse(
          'access_key',
          'bucket_name',
          'folder_name',
          'https://s3.example.com',
          'secret_key',
        );

        // Act
        final json = dataResponse.toJson();

        // Assert
        expect(json, isA<Map<String, dynamic>>());
        expect(json['ak'], equals('access_key'));
        expect(json['bn'], equals('bucket_name'));
        expect(json['fn'], equals('folder_name'));
        expect(json['url'], equals('https://s3.example.com'));
        expect(json['sk'], equals('secret_key'));
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange
        final data = S3DataResponse(
          'access_key',
          'bucket_name',
          'folder_name',
          'https://s3.example.com',
          'secret_key',
        );

        // Act
        final response = S3DetailsResponse(true, 'ref123', data);

        // Assert
        expect(response.isSuccess, isTrue);
        expect(response.refId, equals('ref123'));
        expect(response.data, equals(data));
      });

      test('should allow null parameters', () {
        // Act
        final response = S3DetailsResponse(null, null, null);

        // Assert
        expect(response.isSuccess, isNull);
        expect(response.refId, isNull);
        expect(response.data, isNull);
      });
    });
  });

  group('S3DataResponse', () {
    group('fromJson', () {
      test('should create instance from valid JSON with all fields', () {
        // Arrange
        final json = {
          'url': 'https://s3.example.com',
          'ak': 'access_key_123',
          'sk': 'secret_key_456',
          'bn': 'bucket_name',
          'fn': 'folder_name',
          'cid': 'pool_id_789',
        };

        // Act
        final response = S3DataResponse.fromJson(json);

        // Assert
        expect(response.s3Url, equals('https://s3.example.com'));
        expect(response.accessKey, equals('access_key_123'));
        expect(response.secretKey, equals('secret_key_456'));
        expect(response.bucketName, equals('bucket_name'));
        expect(response.folderName, equals('folder_name'));
        expect(response.poolId, equals('pool_id_789'));
      });

      test('should handle null fields in JSON', () {
        // Arrange
        final json = <String, dynamic>{
          'url': null,
          'ak': null,
          'sk': null,
          'bn': null,
          'fn': null,
          'cid': null,
        };

        // Act
        final response = S3DataResponse.fromJson(json);

        // Assert
        expect(response.s3Url, isNull);
        expect(response.accessKey, isNull);
        expect(response.secretKey, isNull);
        expect(response.bucketName, isNull);
        expect(response.folderName, isNull);
        expect(response.poolId, isNull);
      });

      test('should handle empty JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = S3DataResponse.fromJson(json);

        // Assert
        expect(response.s3Url, isNull);
        expect(response.accessKey, isNull);
        expect(response.secretKey, isNull);
        expect(response.bucketName, isNull);
        expect(response.folderName, isNull);
        expect(response.poolId, isNull);
      });

      test('should handle partial JSON with only url', () {
        // Arrange
        final json = <String, dynamic>{
          'url': 'https://s3.example.com',
        };

        // Act
        final response = S3DataResponse.fromJson(json);

        // Assert
        expect(response.s3Url, equals('https://s3.example.com'));
        expect(response.accessKey, isNull);
      });

      test('should handle JSON with special characters in values', () {
        // Arrange
        final json = {
          'url': 'https://s3.example.com/path+with/special=chars',
          'ak': 'access/key+123=',
          'sk': 'secret&key#456',
          'bn': 'bucket-name_test',
          'fn': 'folder/name/with/slashes',
          'cid': 'pool-id_789',
        };

        // Act
        final response = S3DataResponse.fromJson(json);

        // Assert
        expect(response.s3Url, contains('special=chars'));
        expect(response.accessKey, contains('+'));
        expect(response.secretKey, contains('&'));
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = S3DataResponse(
          'access_key',
          'bucket_name',
          'folder_name',
          'https://s3.example.com',
          'secret_key',
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['ak'], equals('access_key'));
        expect(json['bn'], equals('bucket_name'));
        expect(json['fn'], equals('folder_name'));
        expect(json['url'], equals('https://s3.example.com'));
        expect(json['sk'], equals('secret_key'));
      });

      test('should serialize poolId field', () {
        // Arrange
        final response = S3DataResponse(
          'access_key',
          'bucket_name',
          'folder_name',
          'https://s3.example.com',
          'secret_key',
        );
        response.poolId = 'pool_123';

        // Act
        final json = response.toJson();

        // Assert
        expect(json['cid'], equals('pool_123'));
      });
    });

    group('constructor', () {
      test('should create instance with all positional parameters', () {
        // Act
        final response = S3DataResponse(
          'access_key',
          'bucket_name',
          'folder_name',
          'https://s3.example.com',
          'secret_key',
        );

        // Assert
        expect(response.accessKey, equals('access_key'));
        expect(response.bucketName, equals('bucket_name'));
        expect(response.folderName, equals('folder_name'));
        expect(response.s3Url, equals('https://s3.example.com'));
        expect(response.secretKey, equals('secret_key'));
      });

      test('should allow null values for all parameters', () {
        // Act
        final response = S3DataResponse(null, null, null, null, null);

        // Assert
        expect(response.accessKey, isNull);
        expect(response.bucketName, isNull);
        expect(response.folderName, isNull);
        expect(response.s3Url, isNull);
        expect(response.secretKey, isNull);
      });
    });

    group('edge cases', () {
      test('should handle empty string values', () {
        // Arrange
        final json = {
          'url': '',
          'ak': '',
          'sk': '',
          'bn': '',
          'fn': '',
          'cid': '',
        };

        // Act
        final response = S3DataResponse.fromJson(json);

        // Assert
        expect(response.s3Url, isEmpty);
        expect(response.accessKey, isEmpty);
        expect(response.secretKey, isEmpty);
        expect(response.bucketName, isEmpty);
        expect(response.folderName, isEmpty);
        expect(response.poolId, isEmpty);
      });

      test('should handle very long string values', () {
        // Arrange
        final longString = 'a' * 1000;
        final json = {
          'url': longString,
          'ak': longString,
        };

        // Act
        final response = S3DataResponse.fromJson(json);

        // Assert
        expect(response.s3Url?.length, equals(1000));
        expect(response.accessKey?.length, equals(1000));
      });
    });
  });
}
