// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lot_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotListRequest _$LotListRequestFromJson(Map<String, dynamic> json) =>
    LotListRequest(
      pageNo: (json['offset'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      filterMap: json['filterObjectMap'] == null
          ? null
          : FilterMap.fromJson(json['filterObjectMap'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LotListRequestToJson(LotListRequest instance) =>
    <String, dynamic>{
      if (instance.pageNo case final value?) 'offset': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.filterMap case final value?) 'filterObjectMap': value,
    };

FilterMap _$FilterMapFromJson(Map<String, dynamic> json) => FilterMap(
      searchQuery: json['q'] as String?,
      lotType: (json['lt'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      isStoreOut: (json['iso'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FilterMapToJson(FilterMap instance) => <String, dynamic>{
      if (instance.searchQuery case final value?) 'q': value,
      if (instance.lotType case final value?) 'lt': value,
      if (instance.isStoreOut case final value?) 'iso': value,
    };
