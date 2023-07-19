// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trc_executive_config_model.dart';

// **************************************************************************
// Generator: ConfigModelGen
// **************************************************************************

TrcExecutiveConfigModel _$TrcExecutiveConfigModelFromConfig(
        Map<String, dynamic> json) =>
    TrcExecutiveConfigModel(
      buttonText: ConfigUtil.readValue(json['bt'], {
        "inputType": "text",
        "type": "String",
        "isRequired": false,
        "default": "Receive Device"
      }) as String?,
    );
