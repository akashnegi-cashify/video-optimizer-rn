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
    PreDispatchLotRequest instance) {
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
      lotType: (json['lt'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      barcode: json['br'] as String?,
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
  writeNotNull('br', instance.barcode);
  return val;
}
