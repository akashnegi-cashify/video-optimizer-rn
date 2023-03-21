// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_receive_pending_part_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListReceivePendingPartResponse _$ListReceivePendingPartResponseFromJson(
        Map<String, dynamic> json) =>
    ListReceivePendingPartResponse(
      isSuccess: json['s'] as bool?,
      rid: json['r_id'] as String?,
      dataList: (json['dt'] as List<dynamic>?)
          ?.map((e) => ListResponsePendingDataResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListReceivePendingPartResponseToJson(
        ListReceivePendingPartResponse instance) =>
    <String, dynamic>{
      'r_id': instance.rid,
      's': instance.isSuccess,
      'dt': instance.dataList,
    };

ListResponsePendingDataResponse _$ListResponsePendingDataResponseFromJson(
        Map<String, dynamic> json) =>
    ListResponsePendingDataResponse(
      prid: json['prid'] as int?,
      partBarcode: json['pbr'] as String?,
      partName: json['pn'] as String?,
      isBulk: json['isBulk'] as bool?,
      sku: json['sku'] as String?,
      status: json['st'] as String?,
      statusCode: json['stc'] as int?,
      partColour: json['pc'] as String?,
      requestedQuantity: json['rqty'] as int?,
    );

Map<String, dynamic> _$ListResponsePendingDataResponseToJson(
        ListResponsePendingDataResponse instance) =>
    <String, dynamic>{
      'prid': instance.prid,
      'sku': instance.sku,
      'pn': instance.partName,
      'pc': instance.partColour,
      'st': instance.status,
      'stc': instance.statusCode,
      'rqty': instance.requestedQuantity,
      'pbr': instance.partBarcode,
      'isBulk': instance.isBulk,
    };
