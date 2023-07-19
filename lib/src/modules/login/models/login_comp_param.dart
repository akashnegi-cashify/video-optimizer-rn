import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class LoginCompParam {
  @ParamKey(key: LoginCompParamKeys.isLoginFromQC)
  bool? isLoginFromQC;

  LoginCompParam({
    this.isLoginFromQC,
  });
}

enum LoginCompParamKeys with AbsParamKey {
  isLoginFromQC("qcl");

  @override
  final String value;

  const LoginCompParamKeys(this.value);
}
