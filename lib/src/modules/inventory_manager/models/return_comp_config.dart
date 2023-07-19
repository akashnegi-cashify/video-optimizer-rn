import 'package:csh_annotation/annotation.dart';

part 'return_comp_config.g.dart';

@ConfigModel()
class ReturnCompConfig {
  @ConfigKey(name: "none")
  String? none;

  ReturnCompConfig({this.none});

  static ReturnCompConfig fromConfig(Map<String, dynamic> data) => _$ReturnCompConfigFromConfig(data);
}
