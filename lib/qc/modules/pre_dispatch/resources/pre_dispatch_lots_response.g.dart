// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_dispatch_lots_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreDispatchLotsResponse _$PreDispatchLotsResponseFromJson(
        Map<String, dynamic> json) =>
    PreDispatchLotsResponse(
      lots: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : PreDispatchLotInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
      currentPageSize: (json['currentPageSize'] as num?)?.toInt(),
      currentPageNumber: (json['currentPageNumber'] as num?)?.toInt(),
      hasNext: json['hasNext'] as bool?,
    );

Map<String, dynamic> _$PreDispatchLotsResponseToJson(
        PreDispatchLotsResponse instance) =>
    <String, dynamic>{
      'data': instance.lots,
      'totalCount': instance.totalCount,
      'currentPageSize': instance.currentPageSize,
      'currentPageNumber': instance.currentPageNumber,
      'hasNext': instance.hasNext,
    };

PreDispatchLotInfo _$PreDispatchLotInfoFromJson(Map<String, dynamic> json) =>
    PreDispatchLotInfo(
      lotId: (json['lotId'] as num?)?.toInt(),
      lotGroupName: json['lotGroupName'] as String?,
      lotCount: (json['lotCount'] as num?)?.toInt(),
      scanPending: (json['scanPending'] as num?)?.toInt(),
      scanDone: (json['scanDone'] as num?)?.toInt(),
      channel: json['channel'] as String?,
      lotType: json['lotType'] as String?,
    );

Map<String, dynamic> _$PreDispatchLotInfoToJson(PreDispatchLotInfo instance) =>
    <String, dynamic>{
      'lotId': instance.lotId,
      'lotGroupName': instance.lotGroupName,
      'lotCount': instance.lotCount,
      'scanPending': instance.scanPending,
      'scanDone': instance.scanDone,
      'channel': instance.channel,
      'lotType': instance.lotType,
    };
