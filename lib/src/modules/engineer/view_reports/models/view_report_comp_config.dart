import 'package:csh_annotation/annotation.dart';

part 'view_report_comp_config.g.dart';

@ConfigModel()
class ViewReportCompConfig {
  @ConfigKey(name: "none")
  String? none;

  ViewReportCompConfig({this.none});

  static ViewReportCompConfig fromConfig(Map<String, dynamic> data) => _$ViewReportCompConfigFromConfig(data);
}
