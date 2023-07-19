import 'package:csh_annotation/annotation.dart';

part 'elss_home_comp_config.g.dart';

@ConfigModel()
class ElssHomeCompConfig {
  @ConfigKey(name: "none")
  String? none;

  ElssHomeCompConfig({
    this.none,
  });

  static ElssHomeCompConfig fromConfig(Map<String, dynamic> data) => _$ElssHomeCompConfigFromConfig(data);
}
