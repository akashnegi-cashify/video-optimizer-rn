import 'package:csh_annotation/annotation.dart';

part 'pending_part_list_comp.config.g.dart';

@ConfigModel()
class PendingPartListCompConfig {
  @ConfigKey(name: "none")
  String? none;

  PendingPartListCompConfig({
    this.none,
  });

  static PendingPartListCompConfig fromConfig(Map<String, dynamic> data) => _$PendingPartListCompConfigFromConfig(data);
}
