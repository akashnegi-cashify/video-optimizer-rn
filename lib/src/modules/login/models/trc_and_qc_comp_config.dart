import 'package:csh_annotation/annotation.dart';

part 'trc_and_qc_comp_config.g.dart';

@ConfigModel()
class TrcAndQcCompConfig {
  @ConfigKey(name: "none")
  String? none;

  TrcAndQcCompConfig({
    this.none,
  });

  static TrcAndQcCompConfig fromConfig(Map<String, dynamic> data) => _$TrcAndQcCompConfigFromConfig(data);
}
