// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'box_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoxListResponse _$BoxListResponseFromJson(Map<String, dynamic> json) =>
    BoxListResponse(
      (json['dt'] as List<dynamic>?)
          ?.map((e) => BoxListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$BoxListResponseToJson(BoxListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.boxList,
    };

BoxListData _$BoxListDataFromJson(Map<String, dynamic> json) => BoxListData(
      id: json['id'] as int?,
      boxName: json['bname'] as String?,
    );

Map<String, dynamic> _$BoxListDataToJson(BoxListData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bname': instance.boxName,
    };
