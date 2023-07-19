import 'package:csh_annotation/annotation.dart';

part 'assigned_device_details_comp_config.g.dart';

@ConfigModel()
class AssignedDeviceDetailsCompConfig {
  @ConfigKey(name: "none")
  String? none;

  AssignedDeviceDetailsCompConfig({this.none});

  static AssignedDeviceDetailsCompConfig fromConfig(Map<String, dynamic> data) =>
      _$AssignedDeviceDetailsCompConfigFromConfig(data);
}
