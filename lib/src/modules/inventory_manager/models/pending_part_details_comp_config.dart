import 'package:csh_annotation/annotation.dart';

part 'pending_part_details_comp_config.g.dart';

@ConfigModel()
class PendingPartDetailsCompConfig {
  @ConfigKey(name: "none")
  String? none;

  PendingPartDetailsCompConfig({this.none});

  static PendingPartDetailsCompConfig fromConfig(Map<String, dynamic> data) =>
      _$PendingPartDetailsCompConfigFromConfig(data);
}
