import 'package:csh_annotation/annotation.dart';

part 'login_comp_config.g.dart';

@ConfigModel()
class LoginCompConfig {
  @ConfigKey(name: "none")
  String? none;

  LoginCompConfig({
    this.none,
  });

  static LoginCompConfig fromConfig(Map<String, dynamic> data) => _$LoginCompConfigFromConfig(data);
}
