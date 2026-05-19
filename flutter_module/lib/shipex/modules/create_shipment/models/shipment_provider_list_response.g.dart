// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_provider_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipmentProviderListResponse _$ShipmentProviderListResponseFromJson(
        Map<String, dynamic> json) =>
    ShipmentProviderListResponse(
      (json['dt'] as List<dynamic>?)
          ?.map((e) =>
              ShipmentProviderListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$ShipmentProviderListResponseToJson(
        ShipmentProviderListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.providerList,
    };

ShipmentProviderListData _$ShipmentProviderListDataFromJson(
        Map<String, dynamic> json) =>
    ShipmentProviderListData(
      key: json['k'] as String?,
      name: json['n'] as String?,
    );

Map<String, dynamic> _$ShipmentProviderListDataToJson(
        ShipmentProviderListData instance) =>
    <String, dynamic>{
      'k': instance.key,
      'n': instance.name,
    };
