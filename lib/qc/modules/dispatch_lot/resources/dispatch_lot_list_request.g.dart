// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dispatch_lot_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DispatchLotRequest _$DispatchLotRequestFromJson(Map<String, dynamic> json) =>
    DispatchLotRequest()
      ..pageNo = (json['os'] as num?)?.toInt()
      ..pageSize = (json['ps'] as num?)?.toInt()
      ..searchQuery = json['q'] as String?
      ..lotType = (json['chq'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList();

Map<String, dynamic> _$DispatchLotRequestToJson(DispatchLotRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('os', instance.pageNo);
  writeNotNull('ps', instance.pageSize);
  writeNotNull('q', instance.searchQuery);
  writeNotNull('chq', instance.lotType);
  return val;
}
