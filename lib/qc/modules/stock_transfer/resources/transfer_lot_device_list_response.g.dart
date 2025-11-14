// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_lot_device_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferLotDetailListResponse _$TransferLotDetailListResponseFromJson(
        Map<String, dynamic> json) =>
    TransferLotDetailListResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              TransferLotDetailListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$TransferLotDetailListResponseToJson(
        TransferLotDetailListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'data': instance.data,
    };

TransferLotDetailListData _$TransferLotDetailListDataFromJson(
        Map<String, dynamic> json) =>
    TransferLotDetailListData(
      (json['id'] as num?)?.toInt(),
      (json['statusCode'] as num?)?.toInt(),
      json['qrCode'] as String?,
      json['lotName'] as String?,
      json['model'] as String?,
      json['brand'] as String?, 
      json['imei1'] as String?,
      json['imei2'] as String?,
      json['serialNumber'] as String?,
      json['createdBy'] as String?,
      (json['createDate'] as num?)?.toInt(),
      (json['receiveDate'] as num?)?.toInt(),
      json['receivedBy'] as String?,
    );

Map<String, dynamic> _$TransferLotDetailListDataToJson(
        TransferLotDetailListData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'statusCode': instance.statusCode,
      'qrCode': instance.qrCode,
      'lotName': instance.lotName,
      'model': instance.model,
      'brand': instance.brand,
      'imei1': instance.imei1,  
      'imei2': instance.imei2,
      'serialNumber': instance.serialNumber,
      'createdBy': instance.createdBy,
      'createDate': instance.createDate,
      'receiveDate': instance.receiveDate,
      'receivedBy': instance.receivedBy,
    };



