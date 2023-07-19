import 'package:csh_annotation/annotation.dart';

part 'wip_details_comp_config.g.dart';

@ConfigModel()
class WIPDetailsCompConfig {
  @ConfigKey(name: "none")
  String? none;

  WIPDetailsCompConfig({
    this.none,
  });

  static WIPDetailsCompConfig fromConfig(Map<String, dynamic> data) => _$WIPDetailsCompConfigFromConfig(data);
}
