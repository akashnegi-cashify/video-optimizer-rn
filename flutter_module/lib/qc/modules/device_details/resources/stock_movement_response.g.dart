// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_movement_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockMovementResponse _$StockMovementResponseFromJson(
        Map<String, dynamic> json) =>
    StockMovementResponse(
      (json['dt'] as List<dynamic>?)
          ?.map(
              (e) => StockMovementListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$StockMovementResponseToJson(
        StockMovementResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.stockMovementList,
    };

StockMovementListData _$StockMovementListDataFromJson(
        Map<String, dynamic> json) =>
    StockMovementListData(
      json['status'] as String?,
      json['remarks'] as String?,
      json['createdBy'] as String?,
      (json['createdAt'] as num?)?.toInt(),
      json['IsCurrentStatus'] as bool?,
    );

Map<String, dynamic> _$StockMovementListDataToJson(
        StockMovementListData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'remarks': instance.remark,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt,
      'IsCurrentStatus': instance.isCurrentStatus,
    };
