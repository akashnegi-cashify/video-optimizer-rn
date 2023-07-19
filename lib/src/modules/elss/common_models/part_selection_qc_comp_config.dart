import 'package:csh_annotation/annotation.dart';

part 'part_selection_qc_comp_config.g.dart';

@ConfigModel()
class PartSelectionQCCompConfig {
  @ConfigKey(name: "none")
  String? none;

  PartSelectionQCCompConfig({
    this.none,
  });

  static PartSelectionQCCompConfig fromConfig(Map<String, dynamic> data) => _$PartSelectionQCCompConfigFromConfig(data);
}
