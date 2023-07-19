import 'package:csh_annotation/annotation.dart';

part 'pq_status_change_comp_config.g.dart';

@ConfigModel()
class PqStatusChangeCompConfig {
  @ConfigKey(name: "none")
  String? none;

  PqStatusChangeCompConfig({this.none});

  static PqStatusChangeCompConfig fromConfig(Map<String, dynamic> data) => _$PqStatusChangeCompConfigFromConfig(data);
}
