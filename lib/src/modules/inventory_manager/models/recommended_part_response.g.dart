// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended_part_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendedPartResponse _$RecommendedPartResponseFromJson(
        Map<String, dynamic> json) =>
    RecommendedPartResponse(
      dataList: (json['dt'] as List<dynamic>?)
          ?.map((e) => RecommendedPartData.fromJson(e as Map<String, dynamic>))
          .toList(),
      refId: json['r_id'] as String?,
    );

Map<String, dynamic> _$RecommendedPartResponseToJson(
        RecommendedPartResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      'dt': instance.dataList,
    };

RecommendedPartData _$RecommendedPartDataFromJson(Map<String, dynamic> json) =>
    RecommendedPartData(
      barcode: json['pbr'] as String?,
      recommendedQuantity: (json['rqty'] as num?)?.toInt(),
      location: json['lc'] as String?,
    );

Map<String, dynamic> _$RecommendedPartDataToJson(
        RecommendedPartData instance) =>
    <String, dynamic>{
      'rqty': instance.recommendedQuantity,
      'pbr': instance.barcode,
      'lc': instance.location,
    };
