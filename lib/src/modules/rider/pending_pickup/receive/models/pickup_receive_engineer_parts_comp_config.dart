import 'package:csh_annotation/annotation.dart';

part 'pickup_receive_engineer_parts_comp_config.g.dart';

@ConfigModel()
class PickupReceiveEngineerPartsCompConfig {
  @ConfigKey(name: "none")
  String? none;

  PickupReceiveEngineerPartsCompConfig({
    this.none,
  });

  static PickupReceiveEngineerPartsCompConfig fromConfig(Map<String, dynamic> data) =>
      _$PickupReceiveEngineerPartsCompConfigFromConfig(data);
}
