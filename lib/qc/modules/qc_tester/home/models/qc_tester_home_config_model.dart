import 'package:csh_annotation/annotation.dart';

part 'qc_tester_home_config_model.g.dart';

@ConfigModel()
class QcTesterHomeConfigModel {
  @ConfigKey(name: "none")
  String? none;

  QcTesterHomeConfigModel({this.none});

  static QcTesterHomeConfigModel fromConfig(Map<String, dynamic> data) => _$QcTesterHomeConfigModelFromConfig(data);
}
