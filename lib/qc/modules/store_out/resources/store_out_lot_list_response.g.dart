// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_out_lot_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreOutLotListResponse _$StoreOutLotListResponseFromJson(
        Map<String, dynamic> json) =>
    StoreOutLotListResponse(
      lotList: (json['dt'] as List<dynamic>?)
          ?.map((e) => StoreOutLotListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..totalCount = (json['tc'] as num?)?.toInt()
      ..status = json['s'] as bool?;

Map<String, dynamic> _$StoreOutLotListResponseToJson(
        StoreOutLotListResponse instance) =>
    <String, dynamic>{
      'dt': instance.lotList,
      'tc': instance.totalCount,
      's': instance.status,
    };

StoreOutLotListItem _$StoreOutLotListItemFromJson(Map<String, dynamic> json) =>
    StoreOutLotListItem(
      lotId: (json['lotId'] as num?)?.toInt(),
      lotCount: (json['lotCount'] as num?)?.toInt(),
      lotGrpName: json['lotGroupName'] as String?,
      lotType: json['lotType'] as String?,
      ch: json['channel'] as String?,
      deviceCount: (json['deviceCount'] as num?)?.toInt(),
      isStoreOutInProcess: json['isInStoreOut'] as bool?,
      facilityId: (json['facilityId'] as num?)?.toInt(),
      facilityName: json['facilityName'] as String?,
    );

Map<String, dynamic> _$StoreOutLotListItemToJson(
        StoreOutLotListItem instance) =>
    <String, dynamic>{
      'lotId': instance.lotId,
      'lotCount': instance.lotCount,
      'lotGroupName': instance.lotGrpName,
      'lotType': instance.lotType,
      'channel': instance.ch,
      'deviceCount': instance.deviceCount,
      'isInStoreOut': instance.isStoreOutInProcess,
      'facilityId': instance.facilityId,
      'facilityName': instance.facilityName,
    };
