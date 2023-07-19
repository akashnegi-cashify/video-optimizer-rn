import 'package:csh_annotation/annotation.dart';

part 'home_comp_config.g.dart';

@ConfigModel()
class HomeConfigModel {
  @ConfigKey(name: "none")
  String? none;

  HomeConfigModel({
    this.none,
  });

  static HomeConfigModel fromConfig(Map<String, dynamic> data) => _$HomeConfigModelFromConfig(data);
}
