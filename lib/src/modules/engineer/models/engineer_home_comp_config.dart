import 'package:csh_annotation/annotation.dart';

part 'engineer_home_comp_config.g.dart';

@ConfigModel()
class EngineerHomeCompConfig {
  @ConfigKey(name: "none")
  String? none;

  EngineerHomeCompConfig({
    this.none,
  });

  static EngineerHomeCompConfig fromConfig(Map<String, dynamic> data) => _$EngineerHomeCompConfigFromConfig(data);
}
