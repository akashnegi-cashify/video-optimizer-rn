import 'package:csh_annotation/annotation.dart';

part 'rider_home_comp_config.g.dart';

@ConfigModel()
class RiderHomeCompConfig {
  @ConfigKey(name: "none")
  String? none;

  RiderHomeCompConfig({
    this.none,
  });

  static RiderHomeCompConfig fromConfig(Map<String, dynamic> data) => _$RiderHomeCompConfigFromConfig(data);
}
