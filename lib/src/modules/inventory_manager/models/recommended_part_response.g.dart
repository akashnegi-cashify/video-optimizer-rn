// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended_part_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendedPartResponse _$RecommendedPartResponseFromJson(
        Map<String, dynamic> json) =>
    RecommendedPartResponse(
      isSuccess: json['s'] as bool?,
      dataResponse: json['dt'] == null
          ? null
          : RecommendedPartData.fromJson(json['dt'] as Map<String, dynamic>),
      refId: json['r_id'] as String?,
    );

Map<String, dynamic> _$RecommendedPartResponseToJson(
        RecommendedPartResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      's': instance.isSuccess,
      'dt': instance.dataResponse,
    };

RecommendedPartData _$RecommendedPartDataFromJson(Map<String, dynamic> json) =>
    RecommendedPartData(
      barcode: json['pbr'] as String?,
      recommendedQuantity: (json['rqty'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RecommendedPartDataToJson(
        RecommendedPartData instance) =>
    <String, dynamic>{
      'rqty': instance.recommendedQuantity,
      'pbr': instance.barcode,
    };
