// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_in_submit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockInSubmitResponse _$StockInSubmitResponseFromJson(
        Map<String, dynamic> json) =>
    StockInSubmitResponse()
      ..success = json['success'] as bool?
      ..status = json['s'] as bool?
      ..confirmationMessage = json['cm'] as String?;

Map<String, dynamic> _$StockInSubmitResponseToJson(
        StockInSubmitResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      's': instance.status,
      'cm': instance.confirmationMessage,
    };
