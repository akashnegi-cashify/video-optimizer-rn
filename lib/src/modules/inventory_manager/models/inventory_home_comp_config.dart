import 'package:csh_annotation/annotation.dart';
part 'inventory_home_comp_config.g.dart';

@ConfigModel()
class InventoryHomeCompConfig {
  @ConfigKey(name: "none")
  String? none;

  InventoryHomeCompConfig({this.none});

  static InventoryHomeCompConfig fromConfig(Map<String, dynamic> data) => _$InventoryHomeCompConfigFromConfig(data);
}
