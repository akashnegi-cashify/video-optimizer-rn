import '../modules/login/models/user_details_response.dart';

class UserDetails {
  UserDetailsResponse? userDetailsData;

  UserDetails._();

  static final UserDetails _instance = UserDetails._();

  factory UserDetails() {
    return _instance;
  }

  void setUserDetailsData(UserDetailsResponse data) {
    userDetailsData = data;
  }
}
