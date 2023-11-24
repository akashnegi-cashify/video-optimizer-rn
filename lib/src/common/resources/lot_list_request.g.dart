// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lot_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotListRequest _$LotListRequestFromJson(Map<String, dynamic> json) =>
    LotListRequest(
      pageNo: json['offset'] as int?,
      pageSize: json['pageSize'] as int?,
      filterMap: json['filterObjectMap'] == null
          ? null
          : FilterMap.fromJson(json['filterObjectMap'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LotListRequestToJson(LotListRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('offset', instance.pageNo);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('filterObjectMap', instance.filterMap);
  return val;
}

FilterMap _$FilterMapFromJson(Map<String, dynamic> json) => FilterMap(
      searchQuery: json['q'] as String?,
      lotType: (json['lt'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FilterMapToJson(FilterMap instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('q', instance.searchQuery);
  writeNotNull('lt', instance.lotType);
  return val;
}
