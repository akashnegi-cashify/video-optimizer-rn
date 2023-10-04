import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../models/login_comp_param.dart';
import '../screens/login_screen.dart';

part 'login_component.g.dart';

@CshComponent(
    key: LoginComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.loginComponentKey,
    params: LoginCompParamKeys.values,
    paramModel: LoginCompParam)
class LoginComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_login_comp";

  const LoginComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((param) {
      return CombinedLoginWidget(
        loginType: param.loginType,
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
