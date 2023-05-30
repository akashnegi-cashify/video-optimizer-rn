// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_part_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnPartResponse _$ReturnPartResponseFromJson(Map<String, dynamic> json) =>
    ReturnPartResponse(
      isSuccess: json['s'] as bool?,
      refid: json['r_id'] as String?,
      listData: json['dt'] == null
          ? null
          : ReturnItemPageData.fromJson(json['dt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReturnPartResponseToJson(ReturnPartResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refid,
      's': instance.isSuccess,
      'dt': instance.listData,
    };

ReturnItemData _$ReturnItemDataFromJson(Map<String, dynamic> json) =>
    ReturnItemData(
      statusCode: json['stc'] as int?,
      prid: json['prid'] as int?,
      status: json['st'] as String?,
      productBarcode: json['pbr'] as String?,
      sku: json['sku'] as String?,
      productName: json['pn'] as String?,
      isBulk: json['isBulk'] as bool?,
      isDamaged: json['isDamaged'] as bool?,
      requestedQuantity: json['rqty'] as int?,
    );

Map<String, dynamic> _$ReturnItemDataToJson(ReturnItemData instance) =>
    <String, dynamic>{
      'prid': instance.prid,
      'sku': instance.sku,
      'pn': instance.productName,
      'st': instance.status,
      'stc': instance.statusCode,
      'rqty': instance.requestedQuantity,
      'pbr': instance.productBarcode,
      'isDamaged': instance.isDamaged,
      'isBulk': instance.isBulk,
    };

ReturnItemPageData _$ReturnItemPageDataFromJson(Map<String, dynamic> json) =>
    ReturnItemPageData(
      totalPage: json['tp'] as int?,
      listOfData: (json['pl'] as List<dynamic>?)
          ?.map((e) => ReturnItemData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalRecord: json['tr'] as int?,
    );

Map<String, dynamic> _$ReturnItemPageDataToJson(ReturnItemPageData instance) =>
    <String, dynamic>{
      'pl': instance.listOfData,
      'tp': instance.totalPage,
      'tr': instance.totalRecord,
    };
