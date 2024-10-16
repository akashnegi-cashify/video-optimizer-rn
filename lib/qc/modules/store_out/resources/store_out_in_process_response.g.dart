// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_out_in_process_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreOutInProcessResponse _$StoreOutInProcessResponseFromJson(
        Map<String, dynamic> json) =>
    StoreOutInProcessResponse(
      json['dt'] == null
          ? null
          : StoreOutInProcessData.fromJson(json['dt'] as Map<String, dynamic>),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$StoreOutInProcessResponseToJson(
        StoreOutInProcessResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.storeOutInProcessData,
    };

StoreOutInProcessData _$StoreOutInProcessDataFromJson(
        Map<String, dynamic> json) =>
    StoreOutInProcessData()..isStoreOutInProcess = json['isinstout'] as bool?;

Map<String, dynamic> _$StoreOutInProcessDataToJson(
        StoreOutInProcessData instance) =>
    <String, dynamic>{
      'isinstout': instance.isStoreOutInProcess,
    };
