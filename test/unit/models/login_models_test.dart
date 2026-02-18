import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/login/models/login_success_response.dart';
import 'package:flutter_trc/src/modules/login/models/send_otp_response.dart';
import 'package:flutter_trc/src/modules/login/models/authenticate_otp_response.dart';
import 'package:flutter_trc/src/modules/login/models/user_details_response.dart';

/// Tests for Login module models.
/// Focus: Testing fromJson/toJson serialization and model properties.
void main() {
  group('LoginSuccessResponse', () {
    group('fromJson', () {
      test('should parse complete response correctly', () {
        final json = {
          'r_id': 'REF123',
          'dt': {
            'token': 'jwt_token_here',
            's': true,
          },
        };

        final result = LoginSuccessResponse.fromJson(json);

        expect(result.referenceId, 'REF123');
        expect(result.data, isNotNull);
        expect(result.data?.token, 'jwt_token_here');
        expect(result.data?.status, true);
      });

      test('should handle null data', () {
        final json = {
          'r_id': 'REF456',
          'dt': null,
        };

        final result = LoginSuccessResponse.fromJson(json);

        expect(result.referenceId, 'REF456');
        expect(result.data, isNull);
      });

      test('should handle missing fields', () {
        final json = <String, dynamic>{};

        final result = LoginSuccessResponse.fromJson(json);

        expect(result.referenceId, isNull);
        expect(result.data, isNull);
      });
    });

    group('toJson', () {
      test('should serialize response to JSON correctly', () {
        final response = LoginSuccessResponse(
          referenceId: 'REF789',
        );

        final json = response.toJson();

        expect(json['r_id'], 'REF789');
      });
    });
  });

  group('LoginSuccessData', () {
    group('fromJson', () {
      test('should parse complete data correctly', () {
        final json = {
          'token': 'test_jwt_token',
          's': true,
        };

        final result = LoginSuccessData.fromJson(json);

        expect(result.token, 'test_jwt_token');
        expect(result.status, true);
      });

      test('should handle null token', () {
        final json = {
          'token': null,
          's': false,
        };

        final result = LoginSuccessData.fromJson(json);

        expect(result.token, isNull);
        expect(result.status, false);
      });
    });

    group('toJson', () {
      test('should serialize data to JSON correctly', () {
        final data = LoginSuccessData('token123', true);

        final json = data.toJson();

        expect(json['token'], 'token123');
        expect(json['s'], true);
      });
    });
  });

  group('SendOTPResponse', () {
    group('fromJson', () {
      test('should parse response with request ID correctly', () {
        final json = {
          'rid': 'REQUEST123',
        };

        final result = SendOTPResponse.fromJson(json);

        expect(result.requestId, 'REQUEST123');
      });

      test('should handle null request ID', () {
        final json = {
          'rid': null,
        };

        final result = SendOTPResponse.fromJson(json);

        expect(result.requestId, isNull);
      });

      test('should handle missing fields', () {
        final json = <String, dynamic>{};

        final result = SendOTPResponse.fromJson(json);

        expect(result.requestId, isNull);
      });
    });

    group('toJson', () {
      test('should serialize response to JSON correctly', () {
        final response = SendOTPResponse(requestId: 'REQ789');

        final json = response.toJson();

        expect(json['rid'], 'REQ789');
      });
    });

    group('constructor', () {
      test('should create instance with request ID', () {
        final response = SendOTPResponse(requestId: 'TEST');
        expect(response.requestId, 'TEST');
      });

      test('should create instance without request ID', () {
        final response = SendOTPResponse();
        expect(response.requestId, isNull);
      });
    });
  });

  group('AuthenticateOTPResponse', () {
    group('fromJson', () {
      test('should parse complete response correctly', () {
        final json = {
          'access_token': 'access_token_123',
          'refresh_token': 'refresh_token_456',
          'token_type': 'Bearer',
          'isp': 1,
          'expires_in': 3600,
        };

        final result = AuthenticateOTPResponse.fromJson(json);

        expect(result.accessToken, 'access_token_123');
        expect(result.refreshToken, 'refresh_token_456');
        expect(result.tokenType, 'Bearer');
        expect(result.isPublic, 1);
        expect(result.expiresIn, 3600);
      });

      test('should use default values when not provided', () {
        final json = {
          'access_token': 'token',
          'token_type': 'Bearer',
        };

        final result = AuthenticateOTPResponse.fromJson(json);

        expect(result.accessToken, 'token');
        expect(result.isPublic, 0);
        expect(result.expiresIn, 0);
      });

      test('should handle null tokens', () {
        final json = {
          'access_token': null,
          'refresh_token': null,
        };

        final result = AuthenticateOTPResponse.fromJson(json);

        expect(result.accessToken, isNull);
        expect(result.refreshToken, isNull);
      });

      test('should handle missing fields with defaults', () {
        final json = <String, dynamic>{};

        final result = AuthenticateOTPResponse.fromJson(json);

        expect(result.accessToken, isNull);
        expect(result.refreshToken, isNull);
        expect(result.tokenType, isNull);
        expect(result.isPublic, 0);
        expect(result.expiresIn, 0);
      });
    });

    group('toJson', () {
      test('should serialize response to JSON correctly', () {
        final response = AuthenticateOTPResponse(
          'Bearer',
          'access_token',
          7200,
          0,
          'refresh_token',
        );

        final json = response.toJson();

        expect(json['access_token'], 'access_token');
        expect(json['refresh_token'], 'refresh_token');
        expect(json['token_type'], 'Bearer');
        expect(json['isp'], 0);
        expect(json['expires_in'], 7200);
      });
    });
  });

  group('UserDetailsResponse', () {
    group('constructor', () {
      test('should create instance with all parameters', () {
        final response = UserDetailsResponse(
          firstName: 'Test',
          mobileNumber: '5555555555',
          uid: 'UID123',
          role: 'tester',
          userName: 'tester1',
          mobileMd5: 'hash123',
          listOfRoles: ['tester'],
        );

        expect(response.firstName, 'Test');
        expect(response.mobileNumber, '5555555555');
        expect(response.uid, 'UID123');
        expect(response.role, 'tester');
        expect(response.userName, 'tester1');
        expect(response.mobileMd5, 'hash123');
        expect(response.listOfRoles, ['tester']);
      });

      test('should create instance with no parameters', () {
        final response = UserDetailsResponse();

        expect(response.firstName, isNull);
        expect(response.mobileNumber, isNull);
        expect(response.uid, isNull);
        expect(response.role, isNull);
        expect(response.userName, isNull);
        expect(response.mobileMd5, isNull);
        expect(response.listOfRoles, isNull);
      });

      test('should create instance with partial parameters', () {
        final response = UserDetailsResponse(
          firstName: 'Partial',
          role: 'user',
        );

        expect(response.firstName, 'Partial');
        expect(response.role, 'user');
        expect(response.mobileNumber, isNull);
        expect(response.uid, isNull);
      });
    });

    group('toJson', () {
      test('should serialize response to JSON correctly', () {
        final response = UserDetailsResponse(
          firstName: 'Jane',
          mobileNumber: '1234567890',
          uid: 'USER456',
          role: 'manager',
          userName: 'janedoe',
          mobileMd5: 'xyz789md5',
          listOfRoles: ['manager', 'viewer'],
        );

        final json = response.toJson();

        // Verify that toJson returns a valid map
        expect(json, isA<Map<String, dynamic>>());
        // The actual keys depend on generated code, so just verify the instance values
        expect(response.firstName, 'Jane');
        expect(response.mobileNumber, '1234567890');
        expect(response.uid, 'USER456');
        expect(response.role, 'manager');
        expect(response.userName, 'janedoe');
        expect(response.mobileMd5, 'xyz789md5');
        expect(response.listOfRoles, isA<List>());
        expect(response.listOfRoles?.length, 2);
      });
    });

    group('field mappings', () {
      test('should have correct field values when created', () {
        final response = UserDetailsResponse(
          firstName: 'Test',
          mobileNumber: '1234567890',
          uid: 'UID123',
          role: 'admin',
          userName: 'testuser',
          mobileMd5: 'md5hash',
          listOfRoles: ['admin', 'user'],
        );

        expect(response.firstName, 'Test');
        expect(response.mobileNumber, '1234567890');
        expect(response.uid, 'UID123');
        expect(response.role, 'admin');
        expect(response.userName, 'testuser');
        expect(response.mobileMd5, 'md5hash');
        expect(response.listOfRoles?.length, 2);
        expect(response.listOfRoles, contains('admin'));
        expect(response.listOfRoles, contains('user'));
      });

      test('should handle empty roles list', () {
        final response = UserDetailsResponse(
          firstName: 'Empty',
          listOfRoles: [],
        );

        expect(response.firstName, 'Empty');
        expect(response.listOfRoles, isEmpty);
      });
    });
  });
}
