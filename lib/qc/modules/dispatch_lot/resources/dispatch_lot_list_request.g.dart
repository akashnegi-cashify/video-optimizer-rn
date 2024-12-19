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

Map<String, dynamic> _$DispatchLotRequestToJson(DispatchLotRequest instance) =>
    <String, dynamic>{
      if (instance.pageNo case final value?) 'os': value,
      if (instance.pageSize case final value?) 'ps': value,
      if (instance.searchQuery case final value?) 'q': value,
      if (instance.lotType case final value?) 'chq': value,
    };
