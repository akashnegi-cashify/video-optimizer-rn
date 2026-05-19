// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rms_general_header_config.dart';

// **************************************************************************
// Generator: ConfigModelGen
// **************************************************************************

RmsGeneralHeaderConfig _$RmsGeneralHeaderConfigFromConfig(
        Map<String, dynamic> json) =>
    RmsGeneralHeaderConfig(
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
