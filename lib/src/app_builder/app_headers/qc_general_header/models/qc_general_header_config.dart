import 'package:csh_annotation/annotation.dart';

part 'qc_general_header_config.g.dart';

@ConfigModel()
class QCGeneralHeaderConfig {
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

  QCGeneralHeaderConfig({
    this.headerTitle,
    this.showBackButton,
    this.showLogoutButton,
  });

  static QCGeneralHeaderConfig fromConfig(Map<String, dynamic> data) => _$QCGeneralHeaderConfigFromConfig(data);
}
