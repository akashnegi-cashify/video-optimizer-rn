// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_dispatch_lot_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreDispatchLotRequest _$PreDispatchLotRequestFromJson(
        Map<String, dynamic> json) =>
    PreDispatchLotRequest(
      pageNo: (json['offset'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      filterMap: json['filterObjectMap'] == null
          ? null
          : FilterMap.fromJson(json['filterObjectMap'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreDispatchLotRequestToJson(
        PreDispatchLotRequest instance) =>
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
      barcode: json['br'] as String?,
    );

Map<String, dynamic> _$FilterMapToJson(FilterMap instance) => <String, dynamic>{
      if (instance.searchQuery case final value?) 'q': value,
      if (instance.lotType case final value?) 'lt': value,
      if (instance.barcode case final value?) 'br': value,
    };
