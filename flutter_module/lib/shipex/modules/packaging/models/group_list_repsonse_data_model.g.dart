// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_list_repsonse_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupListResponseModel _$GroupListResponseModelFromJson(
        Map<String, dynamic> json) =>
    GroupListResponseModel(
      groupDataList: (json['dt'] as List<dynamic>?)
          ?.map(
              (e) => GroupListDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      rId: json['r_id'] as String?,
    );

Map<String, dynamic> _$GroupListResponseModelToJson(
        GroupListResponseModel instance) =>
    <String, dynamic>{
      'r_id': instance.rId,
      'dt': instance.groupDataList,
    };

GroupListDataResponse _$GroupListDataResponseFromJson(
        Map<String, dynamic> json) =>
    GroupListDataResponse(
      name: json['n'] as String?,
      icdv: json['icdv'] as bool?,
      id: (json['id'] as num?)?.toInt(),
      irv: json['irv'] as bool?,
      lt: (json['lt'] as num?)?.toInt(),
      ltn: json['ltn'] as String?,
      quantity: (json['qty'] as num?)?.toInt(),
      ral: json['ral'] as bool?,
      rgawbi: json['rgawbi'] as bool?,
      rpewb: json['rpewb'] as bool?,
      rsal: json['rsal'] as bool?,
      s: (json['s'] as num?)?.toInt(),
      sewb: json['sewb'] as bool?,
      shipmentDescription: json['sd'] as String?,
    );

Map<String, dynamic> _$GroupListDataResponseToJson(
        GroupListDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'n': instance.name,
      'lt': instance.lt,
      'ltn': instance.ltn,
      's': instance.s,
      'sd': instance.shipmentDescription,
      'qty': instance.quantity,
      'ral': instance.ral,
      'rsal': instance.rsal,
      'irv': instance.irv,
      'icdv': instance.icdv,
      'sewb': instance.sewb,
      'rpewb': instance.rpewb,
      'rgawbi': instance.rgawbi,
    };
