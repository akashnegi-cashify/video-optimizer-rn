// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_out_bin_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreOutBinListResponse _$StoreOutBinListResponseFromJson(
        Map<String, dynamic> json) =>
    StoreOutBinListResponse(
      binList: (json['listList'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : StoreOutBinListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      pm: (json['pm'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StoreOutBinListResponseToJson(
        StoreOutBinListResponse instance) =>
    <String, dynamic>{
      'listList': instance.binList,
      'pm': instance.pm,
    };

StoreOutBinListItem _$StoreOutBinListItemFromJson(Map<String, dynamic> json) =>
    StoreOutBinListItem(
      lotId: (json['lotId'] as num?)?.toInt(),
      counter: (json['counter'] as num?)?.toInt(),
      lotName: json['lotName'] as String?,
      isCompleted: (json['isCompleted'] as num?)?.toInt(),
      pm: (json['pm'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StoreOutBinListItemToJson(
        StoreOutBinListItem instance) =>
    <String, dynamic>{
      'lotId': instance.lotId,
      'lotName': instance.lotName,
      'counter': instance.counter,
      'isCompleted': instance.isCompleted,
      'pm': instance.pm,
    };
