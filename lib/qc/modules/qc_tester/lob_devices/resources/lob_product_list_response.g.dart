// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lob_product_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LobProductListResponse _$LobProductListResponseFromJson(
        Map<String, dynamic> json) =>
    LobProductListResponse(
      json['r_id'] as String?,
      (json['dt'] as List<dynamic>?)
          ?.map((e) => LobProductListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['tc'] as int?,
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
      'dt': instance.productList,
      'tc': instance.tc,
    };

LobProductListData _$LobProductListDataFromJson(Map<String, dynamic> json) =>
    LobProductListData(
      json['id'] as int?,
      json['n'] as String?,
      json['bid'] as int?,
      json['b'] as String?,
      json['pmid'] as int?,
    );

Map<String, dynamic> _$LobProductListDataToJson(LobProductListData instance) =>
    <String, dynamic>{
      'id': instance.productId,
      'n': instance.name,
      'bid': instance.brandId,
      'b': instance.brand,
      'pmid': instance.productMasterId,
    };
