import 'package:core/core.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../modules/login/models/user_details_response.dart';

class UserDetails {
  UserDetailsResponse? userDetailsData;
  String? authToken;
  int? appVersion;

  UserDetails._();

  static final UserDetails _instance = UserDetails._();

  factory UserDetails() {
    return _instance;
  }

  void setUserDetailsData(String userAuthToken) {
    print('UserDetails.setUserDetailsData $userAuthToken');
    Map<String, dynamic> decodedUserAuth = JwtDecoder.decode(userAuthToken);
    Logger.debug('mydebug------UserDetails.setUserDetailsData-------------', [decodedUserAuth]);
    authToken = userAuthToken;
    userDetailsData = UserDetailsResponse.fromJson(decodedUserAuth);
  }

  void setAppVerison(int? appV) {
    print('UserDetails.setAppVerison $appV');
    appVersion = appV;
  }
}
