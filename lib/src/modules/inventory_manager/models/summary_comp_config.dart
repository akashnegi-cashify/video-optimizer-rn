import 'package:csh_annotation/annotation.dart';

part 'summary_comp_config.g.dart';

@ConfigModel()
class SummaryCompConfig {
  @ConfigKey(name: "none")
  String? none;

  SummaryCompConfig({this.none});

  static SummaryCompConfig fromConfig(Map<String, dynamic> data) => _$SummaryCompConfigFromConfig(data);
}
