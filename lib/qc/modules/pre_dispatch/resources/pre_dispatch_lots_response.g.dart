// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_dispatch_lots_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreDispatchLotsResponse _$PreDispatchLotsResponseFromJson(
        Map<String, dynamic> json) =>
    PreDispatchLotsResponse(
      lots: (json['dt'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : PreDispatchLotInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalLot: (json['tc'] as num?)?.toInt(),
      isSuccess: json['s'] as bool?,
    );

Map<String, dynamic> _$PreDispatchLotsResponseToJson(
        PreDispatchLotsResponse instance) =>
    <String, dynamic>{
      'dt': instance.lots,
      'tc': instance.totalLot,
      's': instance.isSuccess,
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
