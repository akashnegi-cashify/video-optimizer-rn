// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qc_parts_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QcPartsListResponse _$QcPartsListResponseFromJson(Map<String, dynamic> json) =>
    QcPartsListResponse(
      isSuccess: json['s'] as bool?,
      refId: json['r_id'] as String?,
      dataList: (json['dt'] as List<dynamic>?)
          ?.map((e) => QcPartListData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QcPartsListResponseToJson(
        QcPartsListResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      's': instance.isSuccess,
      'dt': instance.dataList,
    };

QcPartListData _$QcPartListDataFromJson(Map<String, dynamic> json) =>
    QcPartListData(
      prid: json['prid'] as int?,
      sku: json['sku'] as String?,
      partName: json['pn'] as String?,
      statusCode: json['stc'] as int?,
      status: json['st'] as String?,
      isBulk: json['isBulk'] as bool?,
      partBarcode: json['pbr'] as String?,
      isDamaged: json['isDamaged'] as bool?,
      requestedQuantity: json['rqty'] as int?,
    )..partColor = json['pc'] as String?;

Map<String, dynamic> _$QcPartListDataToJson(QcPartListData instance) =>
    <String, dynamic>{
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
    };
