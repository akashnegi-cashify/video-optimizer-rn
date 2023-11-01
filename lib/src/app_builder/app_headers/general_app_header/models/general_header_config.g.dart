// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_header_config.dart';

// **************************************************************************
// Generator: ConfigModelGen
// **************************************************************************

GeneralHeaderConfig _$GeneralHeaderConfigFromConfig(
        Map<String, dynamic> json) =>
    GeneralHeaderConfig(
      headerTitle: ConfigUtil.readValue(json['ht'], {
        "inputType": "text",
        "type": "String",
        "isRequired": false,
        "default": "Tech Refurbish Center"
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
