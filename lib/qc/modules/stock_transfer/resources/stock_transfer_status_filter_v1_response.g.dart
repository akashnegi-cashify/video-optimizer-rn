// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_transfer_status_filter_v1_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockTransferStatusFilterV1Response _$StockTransferStatusFilterV1ResponseFromJson(
        Map<String, dynamic> json) =>
    StockTransferStatusFilterV1Response(
      (json['dt'] as List<dynamic>?)
          ?.map((e) =>
              StockTransferStatusFilterData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['s'] as bool?,
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$StockTransferStatusFilterV1ResponseToJson(
        StockTransferStatusFilterV1Response instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.filterList,
      's': instance.success,
    };

StockTransferStatusFilterData _$StockTransferStatusFilterDataFromJson(
        Map<String, dynamic> json) =>
    StockTransferStatusFilterData(
      name: json['v'] as String?,
      id: json['k'] as String?,
    );

Map<String, dynamic> _$StockTransferStatusFilterDataToJson(
        StockTransferStatusFilterData instance) =>
    <String, dynamic>{
      'v': instance.name,
      'k': instance.id,
    };


