import 'package:csh_annotation/annotation.dart';

part 'rubbing_home_comp_config.g.dart';

@ConfigModel()
class RubbingHomeCompConfig {
  @ConfigKey(name: "none")
  String? none;

  RubbingHomeCompConfig({
    this.none,
  });

  static RubbingHomeCompConfig fromConfig(Map<String, dynamic> data) => _$RubbingHomeCompConfigFromConfig(data);
}
