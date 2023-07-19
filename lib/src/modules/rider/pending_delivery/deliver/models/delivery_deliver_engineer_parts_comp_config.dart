import 'package:csh_annotation/annotation.dart';

part 'delivery_deliver_engineer_parts_comp_config.g.dart';

@ConfigModel()
class DeliveryDeliverEngineerPartsCompConfig {
  @ConfigKey(name: "none")
  String? none;

  DeliveryDeliverEngineerPartsCompConfig({
    this.none,
  });

  static DeliveryDeliverEngineerPartsCompConfig fromConfig(Map<String, dynamic> data) =>
      _$DeliveryDeliverEngineerPartsCompConfigFromConfig(data);
}
