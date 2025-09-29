// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collected_order_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectedOrderListResponse _$CollectedOrderListResponseFromJson(
        Map<String, dynamic> json) =>
    CollectedOrderListResponse(
      (json['col'] as List<dynamic>?)
          ?.map(
              (e) => CollectedOrderListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['anl'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$CollectedOrderListResponseToJson(
        CollectedOrderListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'col': instance.collectedOrderList,
      'anl': instance.deliveryAgentList,
    };

CollectedOrderListData _$CollectedOrderListDataFromJson(
        Map<String, dynamic> json) =>
    CollectedOrderListData(
      deliveryAgentName: json['an'] as String?,
      time: (json['tm'] as num?)?.toInt(),
      quantity: (json['dc'] as num?)?.toInt(),
      entryByUserName: json['un'] as String?,
      facilityName: json['fn'] as String?,
      imgUrl: json['im'] as String?,
    );

Map<String, dynamic> _$CollectedOrderListDataToJson(
        CollectedOrderListData instance) =>
    <String, dynamic>{
      'an': instance.deliveryAgentName,
      'tm': instance.time,
      'dc': instance.quantity,
      'un': instance.entryByUserName,
      'fn': instance.facilityName,
      'im': instance.imgUrl,
    };
