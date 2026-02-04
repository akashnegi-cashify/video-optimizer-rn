// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expected_shipment_provider_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpectedShipmentProviderResponse _$ExpectedShipmentProviderResponseFromJson(
        Map<String, dynamic> json) =>
    ExpectedShipmentProviderResponse(
      json['dt'] == null
          ? null
          : ShipmentProviderListData.fromJson(
              json['dt'] as Map<String, dynamic>),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$ExpectedShipmentProviderResponseToJson(
        ExpectedShipmentProviderResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.expectedProvider,
    };
