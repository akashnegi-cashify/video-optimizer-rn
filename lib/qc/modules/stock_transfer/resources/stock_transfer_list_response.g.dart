// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_transfer_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockTransferListResponse _$StockTransferListResponseFromJson(
        Map<String, dynamic> json) =>
    StockTransferListResponse(
      (json['dt'] as List<dynamic>?)
          ?.map(
              (e) => StockTransferListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['tc'] as int?,
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$StockTransferListResponseToJson(
        StockTransferListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.lotList,
      'tc': instance.lotListCount,
    };

StockTransferListData _$StockTransferListDataFromJson(
        Map<String, dynamic> json) =>
    StockTransferListData(
      lotId: json['id'] as int?,
      lotName: json['na'] as String?,
      deviceCount: json['dc'] as int?,
      destinationFacility: json['dst'] as String?,
      statusCode: json['stc'] as int?,
      status: json['st'] as String?,
    );

Map<String, dynamic> _$StockTransferListDataToJson(
        StockTransferListData instance) =>
    <String, dynamic>{
      'id': instance.lotId,
      'na': instance.lotName,
      'dc': instance.deviceCount,
      'dst': instance.destinationFacility,
      'stc': instance.statusCode,
      'st': instance.status,
    };
