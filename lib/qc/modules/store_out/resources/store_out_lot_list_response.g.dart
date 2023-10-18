// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_out_lot_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreOutLotListResponse _$StoreOutLotListResponseFromJson(
        Map<String, dynamic> json) =>
    StoreOutLotListResponse(
      lotList: (json['dt'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : StoreOutLotListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..totalCount = json['tc'] as int?
      ..status = json['s'] as bool?;

Map<String, dynamic> _$StoreOutLotListResponseToJson(
        StoreOutLotListResponse instance) =>
    <String, dynamic>{
      'dt': instance.lotList,
      'tc': instance.totalCount,
      's': instance.status,
    };

StoreOutLotListItem _$StoreOutLotListItemFromJson(Map<String, dynamic> json) =>
    StoreOutLotListItem(
      lotCount: json['lc'] as int?,
      lotGrpName: json['lgn'] as String?,
      lotType: json['lt'] as String?,
      ch: json['ch'] as String?,
      deviceCount: json['dc'] as int?,
    );

Map<String, dynamic> _$StoreOutLotListItemToJson(
        StoreOutLotListItem instance) =>
    <String, dynamic>{
      'lc': instance.lotCount,
      'lgn': instance.lotGrpName,
      'lt': instance.lotType,
      'ch': instance.ch,
      'dc': instance.deviceCount,
    };
