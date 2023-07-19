import 'package:csh_annotation/annotation.dart';

part 'part_selection_comp_config.g.dart';

@ConfigModel()
class PartSelectionCompConfig {
  @ConfigKey(name: "none")
  String? none;

  PartSelectionCompConfig({this.none});

  static PartSelectionCompConfig fromConfig(Map<String, dynamic> data) => _$PartSelectionCompConfigFromConfig(data);
}
