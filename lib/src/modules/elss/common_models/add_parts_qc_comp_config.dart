import 'package:csh_annotation/annotation.dart';

part 'add_parts_qc_comp_config.g.dart';

@ConfigModel()
class AddPartsQcCompConfig {
  @ConfigKey(name: "none")
  String? none;

  AddPartsQcCompConfig({
    this.none,
  });

  static AddPartsQcCompConfig fromConfig(Map<String, dynamic> data) => _$AddPartsQcCompConfigFromConfig(data);
}
