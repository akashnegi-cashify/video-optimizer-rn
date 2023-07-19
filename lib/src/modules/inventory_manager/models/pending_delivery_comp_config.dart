import 'package:csh_annotation/annotation.dart';

part 'pending_delivery_comp_config.g.dart';

@ConfigModel()
class PendingDeliveryCompConfig {
  @ConfigKey(name: "none")
  String? none;

  PendingDeliveryCompConfig({
    this.none,
  });

  static PendingDeliveryCompConfig fromConfig(Map<String, dynamic> data) => _$PendingDeliveryCompConfigFromConfig(data);
}
