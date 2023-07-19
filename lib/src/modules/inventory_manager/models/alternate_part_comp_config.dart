import 'package:csh_annotation/annotation.dart';

part 'alternate_part_comp_config.g.dart';

@ConfigModel()
class AlternatePartConfig {
  @ConfigKey(name: "none")
  String? none;

  AlternatePartConfig({this.none});

  static AlternatePartConfig fromConfig(Map<String, dynamic> data) => _$AlternatePartConfigFromConfig(data);
}
