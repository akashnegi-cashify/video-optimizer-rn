import 'package:csh_annotation/annotation.dart';

part 'splash_config.g.dart';

@ConfigModel()
class SplashConfigModel {
  @ConfigKey(name: "none", defaultValue: "none")
  String? none;

  SplashConfigModel({
    this.none,
  });

  static SplashConfigModel fromConfig(Map<String, dynamic> data) => _$SplashConfigModelFromConfig(data);
}
