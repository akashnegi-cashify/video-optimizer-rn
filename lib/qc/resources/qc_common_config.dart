import 'package:csh_annotation/annotation.dart';

part 'qc_common_config.g.dart';

@ConfigModel()
class QcCommonConfigModel {
  @ConfigKey(name: "none")
  String? none;

  QcCommonConfigModel({this.none});

  static QcCommonConfigModel fromConfig(Map<String, dynamic> data) => _$QcCommonConfigModelFromConfig(data);
}
