// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packaging_sub_order_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackagingSubOrderListResponse _$PackagingSubOrderListResponseFromJson(
        Map<String, dynamic> json) =>
    PackagingSubOrderListResponse(
      (json['dt'] as List<dynamic>?)
          ?.map((e) =>
              PackagingSubOrderListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$PackagingSubOrderListResponseToJson(
        PackagingSubOrderListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.subOrderList,
    };

PackagingSubOrderListData _$PackagingSubOrderListDataFromJson(
        Map<String, dynamic> json) =>
    PackagingSubOrderListData(
      json['name'] as String?,
      json['ln'] as String?,
      json['inv'] as String?,
      json['id'] as int?,
      json['qty'] as int?,
    );

Map<String, dynamic> _$PackagingSubOrderListDataToJson(
        PackagingSubOrderListData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'ln': instance.lotName,
      'inv': instance.invoiceBarcode,
      'id': instance.id,
      'qty': instance.quantity,
    };
