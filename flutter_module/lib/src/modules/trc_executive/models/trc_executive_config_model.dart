import 'package:csh_annotation/annotation.dart';

part 'trc_executive_config_model.g.dart';

@ConfigModel()
class TrcExecutiveConfigModel {
  @ConfigKey(
      name: "bt",
      label: "button Title",
      uiType: ConfigUIType.input,
      inputType: ConfigInputType.text,
      defaultValue: "Receive Device")
  String? buttonText;

  TrcExecutiveConfigModel({
    this.buttonText,
  });

  static TrcExecutiveConfigModel fromConfig(Map<String, dynamic> data) => _$TrcExecutiveConfigModelFromConfig(data);
}
