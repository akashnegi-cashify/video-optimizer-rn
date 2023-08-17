// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_lot_list_repsonse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupLotListResponse _$GroupLotListResponseFromJson(
        Map<String, dynamic> json) =>
    GroupLotListResponse(
      groupLotList: (json['dt'] as List<dynamic>?)
          ?.map((e) => GroupLotListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      rId: json['r_id'] as String?,
    );

Map<String, dynamic> _$GroupLotListResponseToJson(
        GroupLotListResponse instance) =>
    <String, dynamic>{
      'r_id': instance.rId,
      'dt': instance.groupLotList,
    };

GroupLotListData _$GroupLotListDataFromJson(Map<String, dynamic> json) =>
    GroupLotListData(
      json['id'] as int?,
      json['n'] as String?,
      json['s'] as int?,
      json['sd'] as String?,
      json['qty'] as int?,
      json['pbar'] as String?,
      json['mcb'] as String?,
    );

Map<String, dynamic> _$GroupLotListDataToJson(GroupLotListData instance) =>
    <String, dynamic>{
      'id': instance.lotId,
      'n': instance.name,
      's': instance.status,
      'sd': instance.statusDescription,
      'qty': instance.quantity,
      'pbar': instance.packagingBarcode,
      'mcb': instance.monitoringCameraBarcode,
    };
