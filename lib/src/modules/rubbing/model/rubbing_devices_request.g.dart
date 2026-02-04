// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rubbing_devices_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RubbingDeviceListRequest _$RubbingDeviceListRequestFromJson(
        Map<String, dynamic> json) =>
    RubbingDeviceListRequest()
      ..pageNo = (json['pno'] as num).toInt()
      ..pageSize = (json['ln'] as num).toInt()
      ..searchQuery = json['fp'] == null
          ? null
          : SearchQuery.fromJson(json['fp'] as Map<String, dynamic>);

Map<String, dynamic> _$RubbingDeviceListRequestToJson(
        RubbingDeviceListRequest instance) =>
    <String, dynamic>{
      'pno': instance.pageNo,
      'ln': instance.pageSize,
      'fp': instance.searchQuery,
    };
