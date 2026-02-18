// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_part_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnPartResponse _$ReturnPartResponseFromJson(Map<String, dynamic> json) =>
    ReturnPartResponse(
      refid: json['r_id'] as String?,
      listData: json['dt'] == null
          ? null
          : ReturnItemPageData.fromJson(json['dt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReturnPartResponseToJson(ReturnPartResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refid,
      'dt': instance.listData,
    };

ReturnItemData _$ReturnItemDataFromJson(Map<String, dynamic> json) =>
    ReturnItemData(
      prid: (json['prid'] as num?)?.toInt(),
      isUrgent: json['isUrgent'] as bool?,
      requestType: json['rt'] as String?,
      status: json['st'] as String?,
      statusCode: (json['stc'] as num?)?.toInt(),
      updatedBy: json['updby'] as String?,
      updatedAt: (json['updat'] as num?)?.toInt(),
      deviceName: json['dna'] as String?,
      deviceBarcode: json['dbr'] as String?,
      sku: json['sku'] as String?,
      partName: json['pn'] as String?,
      partColor: json['pc'] as String?,
      partVariantName: json['pvn'] as String?,
      partBarcode: json['pbr'] as String?,
      requestedQuantity: (json['rqty'] as num?)?.toInt(),
      availableQuantity: (json['aqty'] as num?)?.toInt(),
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

Map<String, dynamic> _$ReturnItemDataToJson(ReturnItemData instance) =>
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
      'pvn': instance.partVariantName,
      'pbr': instance.partBarcode,
      'rqty': instance.requestedQuantity,
      'aqty': instance.availableQuantity,
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

ReturnItemPageData _$ReturnItemPageDataFromJson(Map<String, dynamic> json) =>
    ReturnItemPageData(
      totalPage: (json['tp'] as num?)?.toInt(),
      listOfData: (json['pl'] as List<dynamic>?)
          ?.map((e) => ReturnItemData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalRecord: (json['tr'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReturnItemPageDataToJson(ReturnItemPageData instance) =>
    <String, dynamic>{
      'pl': instance.listOfData,
      'tp': instance.totalPage,
      'tr': instance.totalRecord,
    };

ReturnPartListApiResponse _$ReturnPartListApiResponseFromJson(Map<String, dynamic> json) =>
    ReturnPartListApiResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )..data = (json['data'] as List<dynamic>?)
        ?.map((e) => ReturnItemData.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$ReturnPartListApiResponseToJson(ReturnPartListApiResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'data': instance.data,
    };
