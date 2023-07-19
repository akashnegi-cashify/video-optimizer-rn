import 'package:csh_annotation/annotation.dart';

part 'device_scanner_component_config.g.dart';

@ConfigModel()
class DeviceScannerConfigModel {
  @ConfigKey(name: "none")
  String? none;

  DeviceScannerConfigModel({this.none});

  static DeviceScannerConfigModel fromConfig(Map<String, dynamic> data) => _$DeviceScannerConfigModelFromConfig(data);
}
