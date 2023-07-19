import 'package:csh_annotation/annotation.dart';

part 'shipex_general_header_config.g.dart';

@ConfigModel()
class ShipexGeneralHeaderConfig {
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

  ShipexGeneralHeaderConfig({
    this.headerTitle,
    this.showBackButton,
    this.showLogoutButton,
  });

  static ShipexGeneralHeaderConfig fromConfig(Map<String, dynamic> data) => _$ShipexGeneralHeaderConfigFromConfig(data);
}
