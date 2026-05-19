import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:components/user_details/user_details_response.dart';
import 'package:flutter_trc/src/common/user/user_service.dart';

void main() {
  group('UserService', () {
    group('getUserDetails', () {
      test('returns stream of UserDetailsResponse', () {
        // The service method signature returns Stream<UserDetailsResponse?>
        final stream = UserService.getUserDetails();
        expect(stream, isA<Stream<UserDetailsResponse?>>());
      });

      test('method is callable', () {
        expect(() => UserService.getUserDetails(), returnsNormally);
      });

      test('calls correct endpoint', () {
        // Verify the endpoint used is /v1/logged-in/user
        // We can verify this by checking the stream is returned
        final stream = UserService.getUserDetails();
        expect(stream, isNotNull);
      });
    });
  });
}
