// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packaging_sub_order_item_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackagingSubOrderItemListResponse _$PackagingSubOrderItemListResponseFromJson(
        Map<String, dynamic> json) =>
    PackagingSubOrderItemListResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )..subOrderItemList = (json['dt'] as List<dynamic>?)
        ?.map((e) =>
            PackagingSubOrderItemListData.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$PackagingSubOrderItemListResponseToJson(
        PackagingSubOrderItemListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.subOrderItemList,
    };

PackagingSubOrderItemListData _$PackagingSubOrderItemListDataFromJson(
        Map<String, dynamic> json) =>
    PackagingSubOrderItemListData(
      json['pn'] as String?,
      json['bn'] as String?,
      json['sd'] as String?,
      (json['s'] as num?)?.toInt(),
      json['udid'] as String?,
      json['qr_code'] as String?,
      (json['id'] as num?)?.toInt(),
      (json['qty'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PackagingSubOrderItemListDataToJson(
        PackagingSubOrderItemListData instance) =>
    <String, dynamic>{
      'pn': instance.productName,
      'bn': instance.brandName,
      'sd': instance.status,
      's': instance.statusCode,
      'udid': instance.udid,
      'qr_code': instance.qrCode,
      'id': instance.id,
      'qty': instance.quantity,
    };
