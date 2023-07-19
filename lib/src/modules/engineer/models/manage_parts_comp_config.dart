import 'package:csh_annotation/annotation.dart';

part 'manage_parts_comp_config.g.dart';

@ConfigModel()
class ManagePartsCompConfig {
  @ConfigKey(name: "none")
  String? none;

  ManagePartsCompConfig({this.none});

  static ManagePartsCompConfig fromConfig(Map<String, dynamic> data) => _$ManagePartsCompConfigFromConfig(data);
}
