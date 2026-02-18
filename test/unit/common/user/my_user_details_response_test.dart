import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:components/user_details/user_details_response.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/common/user/my_user_details_response.dart';

class MockUserDetailsResponse extends Mock implements UserDetailsResponse {}
class MockPermissionResponse extends Mock implements PermissionResponse {}

void main() {
  group('MyUserDetailsResponse', () {
    group('constructor', () {
      test('creates instance with both responses', () {
        final userDetails = MockUserDetailsResponse();
        final permissions = MockPermissionResponse();
        
        final response = MyUserDetailsResponse(userDetails, permissions);
        
        expect(response.userDetailsResponse, userDetails);
        expect(response.permissionResponse, permissions);
      });

      test('creates instance with null userDetailsResponse', () {
        final permissions = MockPermissionResponse();
        
        final response = MyUserDetailsResponse(null, permissions);
        
        expect(response.userDetailsResponse, isNull);
        expect(response.permissionResponse, permissions);
      });

      test('creates instance with null permissionResponse', () {
        final userDetails = MockUserDetailsResponse();
        
        final response = MyUserDetailsResponse(userDetails, null);
        
        expect(response.userDetailsResponse, userDetails);
        expect(response.permissionResponse, isNull);
      });

      test('creates instance with both null', () {
        final response = MyUserDetailsResponse(null, null);
        
        expect(response.userDetailsResponse, isNull);
        expect(response.permissionResponse, isNull);
      });
    });

    group('property access', () {
      test('can read userDetailsResponse', () {
        final userDetails = MockUserDetailsResponse();
        final response = MyUserDetailsResponse(userDetails, null);
        
        expect(response.userDetailsResponse, isA<UserDetailsResponse>());
      });

      test('can read permissionResponse', () {
        final permissions = MockPermissionResponse();
        final response = MyUserDetailsResponse(null, permissions);
        
        expect(response.permissionResponse, isA<PermissionResponse>());
      });
    });

    group('property assignment', () {
      test('can update userDetailsResponse', () {
        final response = MyUserDetailsResponse(null, null);
        final userDetails = MockUserDetailsResponse();
        
        response.userDetailsResponse = userDetails;
        
        expect(response.userDetailsResponse, userDetails);
      });

      test('can update permissionResponse', () {
        final response = MyUserDetailsResponse(null, null);
        final permissions = MockPermissionResponse();
        
        response.permissionResponse = permissions;
        
        expect(response.permissionResponse, permissions);
      });

      test('can set userDetailsResponse to null', () {
        final userDetails = MockUserDetailsResponse();
        final response = MyUserDetailsResponse(userDetails, null);
        
        response.userDetailsResponse = null;
        
        expect(response.userDetailsResponse, isNull);
      });

      test('can set permissionResponse to null', () {
        final permissions = MockPermissionResponse();
        final response = MyUserDetailsResponse(null, permissions);
        
        response.permissionResponse = null;
        
        expect(response.permissionResponse, isNull);
      });
    });
  });
}
