import 'package:csh_annotation/annotation.dart';

part 'return_item_status_comp_config.g.dart';

@ConfigModel()
class ReturnItemStatusCompConfig {
  @ConfigKey(name: "none")
  String? none;

  ReturnItemStatusCompConfig({
    this.none,
  });

  static ReturnItemStatusCompConfig fromConfig(Map<String, dynamic> data) =>
      _$ReturnItemStatusCompConfigFromConfig(data);
}
