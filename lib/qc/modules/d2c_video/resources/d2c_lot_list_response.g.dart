// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'd2c_lot_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

D2cLotListResponse _$D2cLotListResponseFromJson(Map<String, dynamic> json) =>
    D2cLotListResponse(
      (json['dt'] as List<dynamic>?)
          ?.map((e) => D2cLotListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$D2cLotListResponseToJson(D2cLotListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.d2cLotList,
    };

D2cLotListData _$D2cLotListDataFromJson(Map<String, dynamic> json) =>
    D2cLotListData(
      (json['lotId'] as num?)?.toInt(),
      json['groupLotName'] as String?,
      (json['facilityId'] as num?)?.toInt(),
      json['facilityName'] as String?,
    );

Map<String, dynamic> _$D2cLotListDataToJson(D2cLotListData instance) =>
    <String, dynamic>{
      'lotId': instance.lotId,
      'groupLotName': instance.groupLotName,
      'facilityId': instance.facilityId,
      'facilityName': instance.facilityName,
    };
