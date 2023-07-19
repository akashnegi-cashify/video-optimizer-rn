import 'package:csh_annotation/annotation.dart';

part 'my_devices_comp_config.g.dart';

@ConfigModel()
class MyDevicesCompConfig {
  @ConfigKey(name: "none")
  String? none;

  MyDevicesCompConfig({
    this.none,
  });

  static MyDevicesCompConfig fromConfig(Map<String, dynamic> data) => _$MyDevicesCompConfigFromConfig(data);
}
