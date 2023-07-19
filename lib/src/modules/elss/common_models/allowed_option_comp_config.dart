import 'package:csh_annotation/annotation.dart';

part 'allowed_option_comp_config.g.dart';

@ConfigModel()
class AllowedOptionConfig {
  @ConfigKey(name: "none")
  String? none;

  AllowedOptionConfig({this.none});

  static AllowedOptionConfig fromConfig(Map<String, dynamic> data) => _$AllowedOptionConfigFromConfig(data);
}
