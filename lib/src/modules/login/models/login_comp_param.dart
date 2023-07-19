import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class LoginCompParam {
  @ParamKey(key: LoginCompParamKeys.isLoginFromQC, defaultValue: false)
  bool? isLoginFromQC;
  @ParamKey(key: LoginCompParamKeys.isLoginFromShipex, defaultValue: false)
  bool? isLoginFromShipex;

  LoginCompParam({
    this.isLoginFromShipex,
    this.isLoginFromQC,
  });
}

enum LoginCompParamKeys with AbsParamKey {
  isLoginFromShipex("sl"),
  isLoginFromQC("qcl");

  @override
  final String value;

  const LoginCompParamKeys(this.value);
}
