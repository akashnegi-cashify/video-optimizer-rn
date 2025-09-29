import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../models/login_comp_param.dart';
import '../resources/login_types.dart';

part 'login_screen.g.dart';

@CshPage(key: LoginScreen.pageKey, pageGroup: PageGroup.loginPageKey, params: LoginCompParamKeys.values)
class LoginScreenArguments extends BaseArguments {
  final LoginTypes? loginType;

  LoginScreenArguments({
    this.loginType,
  }) : super(LoginScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[LoginCompParamKeys.loginTypes.value] = loginType;
    return data;
  }
}

class LoginScreen extends BaseScreen<LoginScreenArguments> {
  static const String pageKey = "TRC_Login_screen";
  static const String route = "/login_screen";

  const LoginScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
