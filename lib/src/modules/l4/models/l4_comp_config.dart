import 'package:csh_annotation/annotation.dart';

part 'l4_comp_config.g.dart';
@ConfigModel()
class L4CompConfig {
  @ConfigKey(name: "none")
  String? none;

  L4CompConfig({
    this.none,
  });
  static L4CompConfig fromConfig(Map<String, dynamic> data)=> _$L4CompConfigFromConfig(data);
}
