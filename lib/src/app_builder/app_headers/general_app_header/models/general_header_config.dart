import 'package:csh_annotation/annotation.dart';

part 'general_header_config.g.dart';

@ConfigModel()
class GeneralHeaderConfig {
  @ConfigKey(
      name: "ht",
      inputType: ConfigInputType.text,
      uiType: ConfigUIType.input,
      label: "Header Title",
      defaultValue: "Tech Refurbish Center")
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

  GeneralHeaderConfig({
    this.headerTitle,
    this.showBackButton,
    this.showLogoutButton,
    this.showProfileButton,
  });

  static GeneralHeaderConfig fromConfig(Map<String, dynamic> data) => _$GeneralHeaderConfigFromConfig(data);
}
