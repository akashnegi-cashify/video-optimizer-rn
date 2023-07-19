import 'package:csh_annotation/annotation.dart';

part 'assigned_part_details_comp_config.g.dart';

@ConfigModel()
class AssignedPartDetailsConfig {
  @ConfigKey(name: "none")
  String? none;

  AssignedPartDetailsConfig({this.none});

  static AssignedPartDetailsConfig fromConfig(Map<String, dynamic> data) => _$AssignedPartDetailsConfigFromConfig(data);
}
