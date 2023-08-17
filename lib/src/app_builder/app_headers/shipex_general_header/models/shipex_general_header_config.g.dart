// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipex_general_header_config.dart';

// **************************************************************************
// Generator: ConfigModelGen
// **************************************************************************

ShipexGeneralHeaderConfig _$ShipexGeneralHeaderConfigFromConfig(
        Map<String, dynamic> json) =>
    ShipexGeneralHeaderConfig(
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
    );
