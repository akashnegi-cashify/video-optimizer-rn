import 'package:csh_annotation/annotation.dart';

part 'receive_rubbing_device_comp_config.g.dart';

@ConfigModel()
class ReceiveRubbingDeviceCompConfig {
  @ConfigKey(name: "none")
  String? none;

  ReceiveRubbingDeviceCompConfig({
    this.none,
  });

  static ReceiveRubbingDeviceCompConfig fromConfig(Map<String, dynamic> data) =>
      _$ReceiveRubbingDeviceCompConfigFromConfig(data);
}
