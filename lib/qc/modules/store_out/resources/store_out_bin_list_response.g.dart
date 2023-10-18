// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_out_bin_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreOutBinListResponse _$StoreOutBinListResponseFromJson(
        Map<String, dynamic> json) =>
    StoreOutBinListResponse(
      binList: (json['dt'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : StoreOutBinListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StoreOutBinListResponseToJson(
        StoreOutBinListResponse instance) =>
    <String, dynamic>{
      'dt': instance.binList,
    };

StoreOutBinListItem _$StoreOutBinListItemFromJson(Map<String, dynamic> json) =>
    StoreOutBinListItem(
      totalCount: json['tc'] as int?,
      lotName: json['ln'] as String?,
      ic: json['ic'] as int?,
    );

Map<String, dynamic> _$StoreOutBinListItemToJson(
        StoreOutBinListItem instance) =>
    <String, dynamic>{
      'tc': instance.totalCount,
      'ln': instance.lotName,
      'ic': instance.ic,
    };
