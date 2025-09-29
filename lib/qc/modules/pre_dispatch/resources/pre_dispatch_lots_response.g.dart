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
      lotGroupName: json['lgn'] as String?,
      lotQty: (json['lc'] as num?)?.toInt(),
      pendingQty: (json['sp'] as num?)?.toInt(),
      scannedQty: (json['sd'] as num?)?.toInt(),
      lotType: json['lt'] as String?,
    );

Map<String, dynamic> _$PreDispatchLotInfoToJson(PreDispatchLotInfo instance) =>
    <String, dynamic>{
      'lgn': instance.lotGroupName,
      'lc': instance.lotQty,
      'sp': instance.pendingQty,
      'sd': instance.scannedQty,
      'lt': instance.lotType,
    };
