// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qc_general_header_config.dart';

// **************************************************************************
// Generator: ConfigModelGen
// **************************************************************************

QCGeneralHeaderConfig _$QCGeneralHeaderConfigFromConfig(
        Map<String, dynamic> json) =>
    QCGeneralHeaderConfig(
      headerTitle: ConfigUtil.readValue(json['ht'], {
        "inputType": "text",
        "type": "String",
        "isRequired": false,
        "default": "QC"
      }) as String?,
      showBackButton: ConfigUtil.readValue(json['sbb'], {
        "inputType": "boolean",
        "isRequired": false,
        "default": true
      }) as bool?,
      showLogoutButton: ConfigUtil.readValue(json['slb'], {
        "inputType": "boolean",
        "isRequired": false,
        "default": false
      }) as bool?,
      showProfileButton: ConfigUtil.readValue(json['spb'], {
        "inputType": "boolean",
        "isRequired": false,
        "default": false
      }) as bool?,
    );
