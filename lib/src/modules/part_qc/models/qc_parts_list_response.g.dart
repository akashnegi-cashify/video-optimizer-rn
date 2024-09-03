// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qc_parts_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QcPartsListResponse _$QcPartsListResponseFromJson(Map<String, dynamic> json) => QcPartsListResponse(
      isSuccess: json['s'] as bool?,
      refId: json['r_id'] as String?,
      dataList: (json['dt'] as List<dynamic>?)?.map((e) => QcPartListData.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$QcPartsListResponseToJson(QcPartsListResponse instance) => <String, dynamic>{
      'r_id': instance.refId,
      's': instance.isSuccess,
      'dt': instance.dataList,
    };

QcPartListData _$QcPartListDataFromJson(Map<String, dynamic> json) => QcPartListData(
      prid: (json['prid'] as num?)?.toInt(),
      sku: json['sku'] as String?,
      partName: json['pn'] as String?,
      statusCode: (json['stc'] as num?)?.toInt(),
      status: json['st'] as String?,
      isBulk: json['isBulk'] as bool?,
      partBarcode: json['pbr'] as String?,
      isDamaged: json['isDamaged'] as bool?,
      requestedQuantity: (json['rqty'] as num?)?.toInt(),
      partVariantName: json['pvn'] as String?,
    )..partColor = json['pc'] as String?;

Map<String, dynamic> _$QcPartListDataToJson(QcPartListData instance) => <String, dynamic>{
      'prid': instance.prid,
      'sku': instance.sku,
      'pn': instance.partName,
      'st': instance.status,
      'stc': instance.statusCode,
      'rqty': instance.requestedQuantity,
      'pbr': instance.partBarcode,
      'pc': instance.partColor,
      'isDamaged': instance.isDamaged,
      'isBulk': instance.isBulk,
      'pvn': instance.partVariantName,
    };
