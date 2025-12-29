import 'package:components/user_details/user_details_response.dart';
import 'package:core_widgets/core_widgets.dart';

class MyUserDetailsResponse {
  UserDetailsResponse? userDetailsResponse;
  PermissionResponse? permissionResponse;

  MyUserDetailsResponse(this.userDetailsResponse, this.permissionResponse);
}
