import 'package:csh_annotation/annotation.dart';

part 'rms_general_header_config.g.dart';

@ConfigModel()
class RmsGeneralHeaderConfig {
  @ConfigKey(
      name: "ht",
      inputType: ConfigInputType.text,
      uiType: ConfigUIType.input,
      label: "Header Title",
      defaultValue: "QC")
  String? headerTitle;
  @ConfigKey(
      name: "sbb",
      inputType: ConfigInputType.boolean,
      uiType: ConfigUIType.toggle,
      label: "Show Back Button",
      defaultValue: true)
  bool? showBackButton;
  @ConfigKey(
      name: "slb",
      inputType: ConfigInputType.boolean,
      uiType: ConfigUIType.toggle,
      label: "Show Logout Button",
      defaultValue: false)
  bool? showLogoutButton;
  @ConfigKey(
      name: "spb",
      inputType: ConfigInputType.boolean,
      uiType: ConfigUIType.toggle,
      label: "Show Profile Button",
      defaultValue: false)
  bool? showProfileButton;

  RmsGeneralHeaderConfig({
    this.headerTitle,
    this.showBackButton,
    this.showLogoutButton,
    this.showProfileButton,
  });

  static RmsGeneralHeaderConfig fromConfig(Map<String, dynamic> data) => _$RmsGeneralHeaderConfigFromConfig(data);
}
