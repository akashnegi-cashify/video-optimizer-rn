import 'package:components/user_details/user_details_response.dart';
import 'package:flutter_trc/src/services/console_service.dart';

class UserService {
  // return HttpClient.get<UserResponse>('/v1/logged-in/user', {
  // headers: UserService.getHeaders()
  // }).pipe(OAuth({tokenUrl}), tryParseJson(UserResponse))

  static Stream<UserDetailsResponse?> getUserDetails() {
    return ConsoleService().get("/v1/logged-in/user", UserDetailsResponse.fromJson);
  }
}
