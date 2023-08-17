import 'package:csh_annotation/annotation.dart';

import '../resources/login_types.dart';

@CshPageParam()
class LoginCompParam {
  @ParamKey(key: LoginCompParamKeys.loginTypes)
  LoginTypes? loginType;

  LoginCompParam({
    this.loginType,
  });
}

enum LoginCompParamKeys with AbsParamKey {
  loginTypes("lt");

  @override
  final String value;

  const LoginCompParamKeys(this.value);
}
