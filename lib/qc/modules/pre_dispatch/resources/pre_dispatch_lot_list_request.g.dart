// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_dispatch_lot_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreDispatchLotRequest _$PreDispatchLotRequestFromJson(
        Map<String, dynamic> json) =>
    PreDispatchLotRequest(
      pageNo: json['offset'] as int?,
      pageSize: json['pageSize'] as int?,
      filterMap: json['filterMap'] == null
          ? null
          : FilterMap.fromJson(json['filterMap'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreDispatchLotRequestToJson(
    PreDispatchLotRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('offset', instance.pageNo);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('filterMap', instance.filterMap);
  return val;
}

FilterMap _$FilterMapFromJson(Map<String, dynamic> json) => FilterMap(
      searchQuery: json['q'] as String?,
      lotType: json['lt'] as String?,
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
