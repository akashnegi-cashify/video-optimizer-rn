import 'package:csh_annotation/annotation.dart';

part 'qc_action_comp_config.g.dart';

@ConfigModel()
class QcActionConfig {
  @ConfigKey(name: "b1t", label: "Button 1 Text", uiType: ConfigUIType.input)
  String? button1Text;
  @ConfigKey(name: "b2t", label: "Button 2 Text", uiType: ConfigUIType.input)
  String? button2Text;

  QcActionConfig({
    this.button1Text,
    this.button2Text,
  });

  static QcActionConfig fromConfig(Map<String, dynamic> data) => _$QcActionConfigFromConfig(data);
}
