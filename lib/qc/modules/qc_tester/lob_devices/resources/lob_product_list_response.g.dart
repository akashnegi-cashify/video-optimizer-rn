// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lob_product_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LobProductListResponse _$LobProductListResponseFromJson(
        Map<String, dynamic> json) =>
    LobProductListResponse(
      json['r_id'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => LobProductListData.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..cashifyAlert = json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>)
      ..trackUrl = json['turl'] as String?;

Map<String, dynamic> _$LobProductListResponseToJson(
        LobProductListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'r_id': instance.rId,
      'data': instance.productList,
    };

LobProductListData _$LobProductListDataFromJson(Map<String, dynamic> json) =>
    LobProductListData(
      (json['productId'] as num?)?.toInt(),
      json['productName'] as String?,
      (json['brandId'] as num?)?.toInt(),
      json['brandName'] as String?,
      (json['productMasterId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LobProductListDataToJson(LobProductListData instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.name,
      'brandId': instance.brandId,
      'brandName': instance.brand,
      'productMasterId': instance.productMasterId,
    };
