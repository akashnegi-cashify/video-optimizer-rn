// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'box_charger_tracking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoxChargerTrackingResponse _$BoxChargerTrackingResponseFromJson(
        Map<String, dynamic> json) =>
    BoxChargerTrackingResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )..boxChargerTrackingData = json['dt'] == null
        ? null
        : BoxChargerTrackingData.fromJson(json['dt'] as Map<String, dynamic>);

Map<String, dynamic> _$BoxChargerTrackingResponseToJson(
        BoxChargerTrackingResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.boxChargerTrackingData,
    };

BoxChargerTrackingData _$BoxChargerTrackingDataFromJson(
        Map<String, dynamic> json) =>
    BoxChargerTrackingData(
      json['hc'] as int?,
      json['hb'] as int?,
    );

Map<String, dynamic> _$BoxChargerTrackingDataToJson(
        BoxChargerTrackingData instance) =>
    <String, dynamic>{
      'hc': instance.hasCharger,
      'hb': instance.hasBox,
    };
