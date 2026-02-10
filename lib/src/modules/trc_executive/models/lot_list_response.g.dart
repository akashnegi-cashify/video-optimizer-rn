// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lot_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotListResponse _$LotListResponseFromJson(Map<String, dynamic> json) => LotListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null ? null : LotItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LotListResponseToJson(LotListResponse instance) => <String, dynamic>{
      'data': instance.data,
      'totalCount': instance.totalCount,
    };

LotItem _$LotItemFromJson(Map<String, dynamic> json) => LotItem(
      lotId: (json['lotId'] as num?)?.toInt(),
      lotName: json['lotName'] as String?,
      counter: (json['counter'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LotItemToJson(LotItem instance) => <String, dynamic>{
      'lotId': instance.lotId,
      'lotName': instance.lotName,
      'counter': instance.counter,
    };
