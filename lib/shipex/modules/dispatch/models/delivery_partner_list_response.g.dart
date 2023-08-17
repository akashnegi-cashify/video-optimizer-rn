// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_partner_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryPartnerListResponse _$DeliveryPartnerListResponseFromJson(
        Map<String, dynamic> json) =>
    DeliveryPartnerListResponse(
      (json['dt'] as List<dynamic>?)
          ?.map((e) =>
              DeliveryPartnerListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$DeliveryPartnerListResponseToJson(
        DeliveryPartnerListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.deliveryPartnerList,
    };

DeliveryPartnerListData _$DeliveryPartnerListDataFromJson(
        Map<String, dynamic> json) =>
    DeliveryPartnerListData(
      json['n'] as String?,
      json['k'] as String?,
    );

Map<String, dynamic> _$DeliveryPartnerListDataToJson(
        DeliveryPartnerListData instance) =>
    <String, dynamic>{
      'n': instance.name,
      'k': instance.key,
    };
