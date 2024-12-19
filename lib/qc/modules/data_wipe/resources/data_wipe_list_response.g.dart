// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_wipe_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataWipeListResponse _$DataWipeListResponseFromJson(
        Map<String, dynamic> json) =>
    DataWipeListResponse(
      (json['dt'] as List<dynamic>?)
          ?.map((e) => DataWipeListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$DataWipeListResponseToJson(
        DataWipeListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.dataWipeList,
    };

DataWipeListItem _$DataWipeListItemFromJson(Map<String, dynamic> json) =>
    DataWipeListItem(
      (json['id'] as num?)?.toInt(),
      json['qrCode'] as String?,
      json['ep'] as String?,
      json['sd'] as String?,
      (json['sc'] as num?)?.toInt(),
      json['pn'] as String?,
    );

Map<String, dynamic> _$DataWipeListItemToJson(DataWipeListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qrCode': instance.qrCode,
      'ep': instance.erasureProvider,
      'sd': instance.status,
      'sc': instance.statusCode,
      'pn': instance.productName,
    };
