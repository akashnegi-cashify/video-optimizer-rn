import 'package:csh_annotation/annotation.dart';

part 'add_device_media_comp_config.g.dart';

@ConfigModel()
class AddDeviceMediaCompConfig {
  @ConfigKey(name: "none")
  String? none;

  AddDeviceMediaCompConfig({this.none});

  static AddDeviceMediaCompConfig fromConfig(Map<String, dynamic> data) => _$AddDeviceMediaCompConfigFromConfig(data);
}
