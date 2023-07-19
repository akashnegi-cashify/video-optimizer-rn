import 'package:csh_annotation/annotation.dart';

part 'none_config_model.g.dart';

@ConfigModel()
class NoneConfigModel {
  @ConfigKey(name: "none")
  String? none;

  NoneConfigModel({this.none});

  static NoneConfigModel fromConfig(Map<String, dynamic> data) => _$NoneConfigModelFromConfig(data);
}