import 'package:csh_annotation/annotation.dart';

part 'part_qc_home_comp_config.g.dart';

@ConfigModel()
class PartQcHomeCompConfig {
  @ConfigKey(name: "none")
  String? none;

  PartQcHomeCompConfig({
    this.none,
  });

  static PartQcHomeCompConfig fromConfig(Map<String, dynamic> data) => _$PartQcHomeCompConfigFromConfig(data);
}
