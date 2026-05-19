import 'dart:async';

import 'package:components/user_details/user_details_response.dart' as console;
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/common/user/my_user_details_response.dart';
import 'package:flutter_trc/src/common/user/user_util.dart';
import 'package:flutter_trc/src/modules/login/resources/collector_user_controller.dart';
import 'package:flutter_trc/src/modules/rubbing/resources/rubbing_module_role_type.dart';

import '../modules/login/models/user_details_response.dart';

class UserDetails {
  UserDetailsResponse? _userDetailsData;
  MyUserDetailsResponse? _myUserDetailsResponse;
  RubbingModuleRoleType _rubbingRoleType = RubbingModuleRoleType.rubbing;

  UserDetails._();

  static final UserDetails _instance = UserDetails._();

  factory UserDetails() {
    return _instance;
  }

  UserDetailsResponse? get userDetailsData => _userDetailsData;

  console.UserDetailsResponse? get consoleUserDetail => _myUserDetailsResponse?.userDetailsResponse;

  PermissionResponse? get permissionResponse => _myUserDetailsResponse?.permissionResponse;

  setUserDetailsDataTemp(String token) {
    var completer = Completer<void>();
    UserUtil.onUserLoggedIn().then((value) {
      _myUserDetailsResponse = value;
      completer.complete();
    }, onError: (error) {
      completer.complete(error);
    });
    return completer.future;
  }

  Future<void> setUserDetailsData() {
    var completer = Completer<void>();
    UserUtil.onUserLoggedIn().then((value) {
      _myUserDetailsResponse = value;
      completer.complete();
    }, onError: (error) {
      completer.complete(error);
    });
    return completer.future;
  }

  List<String> getListOfPermissions() {
    List<String> permissions = [];
    _myUserDetailsResponse?.permissionResponse?.modules?.forEach((element) {
      element.permissionList?.forEach((permission) {
        permissions.add(permission.permissionKey!);
      });
    });
    return permissions;
  }

  bool isEngineerRole() {
    if (Validator.isListNullOrEmpty(userDetailsData?.listOfRoles)) {
      return false;
    }

    return userDetailsData!.listOfRoles!.contains(UserRoles.ROLE_ENGINEER);
  }

  setRubbingRoleType(RubbingModuleRoleType roleType) {
    _rubbingRoleType = roleType;
  }

  RubbingModuleRoleType getRubbingRoleType() {
    return _rubbingRoleType;
  }
}
