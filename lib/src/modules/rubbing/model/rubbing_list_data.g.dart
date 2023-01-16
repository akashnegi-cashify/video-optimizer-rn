// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rubbing_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RubbingListData _$RubbingListDataFromJson(Map<String, dynamic> json) =>
    RubbingListData()
      ..tp = json['tp'] as int?
      ..tr = json['tr'] as int?
      ..deviceList = (json['dl'] as List<dynamic>)
          .map((e) => RubbingDeviceData.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$RubbingListDataToJson(RubbingListData instance) =>
    <String, dynamic>{
      'tp': instance.tp,
      'tr': instance.tr,
      'dl': instance.deviceList,
    };
