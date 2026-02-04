// coverage:ignore-file
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
      dataList: (json['data'] as List<dynamic>?)
          ?.map((e) => ListResponsePendingDataResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListReceivePendingPartResponseToJson(
        ListReceivePendingPartResponse instance) =>
    <String, dynamic>{
      'r_id': instance.rid,
      's': instance.isSuccess,
      'data': instance.dataList,
    };

ListResponsePendingDataResponse _$ListResponsePendingDataResponseFromJson(
        Map<String, dynamic> json) =>
    ListResponsePendingDataResponse(
      prid: (json['prid'] as num?)?.toInt(),
      isUrgent: json['isUrgent'] as bool?,
      requestType: json['rt'] as String?,
      status: json['st'] as String?,
      statusCode: (json['stc'] as num?)?.toInt(),
      updatedBy: json['updby'] as String?,
      updatedAt: json['updat'] as String?,
      deviceName: json['dna'] as String?,
      deviceBarcode: json['dbr'] as String?,
      sku: json['sku'] as String?,
      partName: json['pn'] as String?,
      partColor: json['pc'] as String?,
      partVariant: json['pvn'] as String?,
      partBarcode: json['pbr'] as String?,
      requestedQty: (json['rqty'] as num?)?.toInt(),
      availableQty: (json['aqty'] as num?)?.toInt(),
      isDamaged: json['isDamaged'] as bool?,
      isBulk: json['isBulk'] as bool?,
      retrievedImages: (json['rvc'] as num?)?.toInt(),
      location: json['lc'] as String?,
      altPartName: json['apn'] as String?,
      altPartSku: json['asku'] as String?,
      altPartColor: json['apc'] as String?,
      altPartVariation: json['apvn'] as String?,
      altPartStatus: json['ast'] as String?,
    );

Map<String, dynamic> _$ListResponsePendingDataResponseToJson(
        ListResponsePendingDataResponse instance) =>
    <String, dynamic>{
      'prid': instance.prid,
      'isUrgent': instance.isUrgent,
      'rt': instance.requestType,
      'st': instance.status,
      'stc': instance.statusCode,
      'updby': instance.updatedBy,
      'updat': instance.updatedAt,
      'dna': instance.deviceName,
      'dbr': instance.deviceBarcode,
      'sku': instance.sku,
      'pn': instance.partName,
      'pc': instance.partColor,
      'pvn': instance.partVariant,
      'pbr': instance.partBarcode,
      'rqty': instance.requestedQty,
      'aqty': instance.availableQty,
      'isDamaged': instance.isDamaged,
      'isBulk': instance.isBulk,
      'rvc': instance.retrievedImages,
      'lc': instance.location,
      'apn': instance.altPartName,
      'asku': instance.altPartSku,
      'apc': instance.altPartColor,
      'apvn': instance.altPartVariation,
      'ast': instance.altPartStatus,
    };
