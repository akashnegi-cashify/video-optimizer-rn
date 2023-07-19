import 'package:csh_annotation/annotation.dart';

part 'elss_status_comp_config.g.dart';

@ConfigModel()
class ElssStatusCompConfig {
  @ConfigKey(name: "none")
  String? none;

  ElssStatusCompConfig({
    this.none,
  });

  static ElssStatusCompConfig fromConfig(Map<String, dynamic> data) => _$ElssStatusCompConfigFromConfig(data);
}
