import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/modules/login/resources/collector_user_controller.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../modules/login/models/user_details_response.dart';

class UserDetails {
  UserDetailsResponse? _userDetailsData;
  String? authToken;

  UserDetails._();

  static final UserDetails _instance = UserDetails._();

  factory UserDetails() {
    return _instance;
  }

  UserDetailsResponse? get userDetailsData => _userDetailsData;

  void setUserDetailsData(String userAuthToken) {
    print('UserDetails.setUserDetailsData $userAuthToken');
    Map<String, dynamic> decodedUserAuth = JwtDecoder.decode(userAuthToken);
    Logger.debug('mydebug------UserDetails.setUserDetailsData-------------', [decodedUserAuth]);
    authToken = userAuthToken;
    _userDetailsData = UserDetailsResponse.fromJson(decodedUserAuth);
  }

  bool isEngineerRole() {
    if (Validator.isListNullOrEmpty(userDetailsData?.listOfRoles)) {
      return false;
    }

    return userDetailsData!.listOfRoles!.contains(UserRoles.ROLE_ENGINEER);
  }
}
