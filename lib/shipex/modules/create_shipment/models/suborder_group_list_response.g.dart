// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suborder_group_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubOrderGroupListResponse _$SubOrderGroupListResponseFromJson(
        Map<String, dynamic> json) =>
    SubOrderGroupListResponse(
      (json['dt'] as List<dynamic>?)
          ?.map(
              (e) => SubOrderGroupListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$SubOrderGroupListResponseToJson(
        SubOrderGroupListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.subOrderList,
    };

SubOrderGroupListData _$SubOrderGroupListDataFromJson(
        Map<String, dynamic> json) =>
    SubOrderGroupListData(
      json['id'] as int?,
      json['n'] as String?,
      json['lt'] as int?,
      json['ltn'] as String?,
      json['pbar'] as String?,
    );

Map<String, dynamic> _$SubOrderGroupListDataToJson(
        SubOrderGroupListData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'n': instance.name,
      'lt': instance.lotType,
      'ltn': instance.lotTypeName,
      'pbar': instance.packagingBarcode,
    };
