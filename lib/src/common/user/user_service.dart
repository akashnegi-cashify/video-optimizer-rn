import 'dart:convert';

import 'package:components/user_details/user_details_response.dart';
import 'package:core_widgets/core_widgets.dart' hide ConsoleService;
import 'package:flutter_trc/src/services/console_service.dart';

class UserService {
  // return HttpClient.get<UserResponse>('/v1/logged-in/user', {
  // headers: UserService.getHeaders()
  // }).pipe(OAuth({tokenUrl}), tryParseJson(UserResponse))

  static Stream<UserDetailsResponse?> getUserDetails() {
    return ConsoleService().get("/v1/logged-in/user", UserDetailsResponse.fromJson);
  }

  static Stream<PermissionResponse?> getUserPermissions(String? mobileMd5) {
    Map<String, String?> req = {"userId": mobileMd5};

    return ConsoleService().post("/v1/module-permission-user", PermissionResponse.fromJson, body: jsonEncode(req));
  }
}
