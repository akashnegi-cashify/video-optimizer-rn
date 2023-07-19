import 'package:csh_annotation/annotation.dart';

part 'add_part_comp_config.g.dart';

@ConfigModel()
class AddPartCompConfig {
  @ConfigKey(name: "none")
  String? none;

  AddPartCompConfig({
    this.none,
  });

  static AddPartCompConfig fromConfig(Map<String, dynamic> data) => _$AddPartCompConfigFromConfig(data);
}
