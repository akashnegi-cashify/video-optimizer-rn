// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qc_repost_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QcRepostResponse _$QcRepostResponseFromJson(Map<String, dynamic> json) =>
    QcRepostResponse()
      ..rId = json['r_id'] as String?
      ..categoryList = (json['dt'] as List<dynamic>?)
          ?.map((e) =>
              QcRepostCategoryResponseList.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$QcRepostResponseToJson(QcRepostResponse instance) =>
    <String, dynamic>{
      'r_id': instance.rId,
      'dt': instance.categoryList,
    };

QcRepostCategoryResponseList _$QcRepostCategoryResponseListFromJson(
        Map<String, dynamic> json) =>
    QcRepostCategoryResponseList(
      count: (json['c'] as num?)?.toInt(),
      productCategory: json['pc'] as String?,
      categoryCode: json['cc'] as String?,
    );

Map<String, dynamic> _$QcRepostCategoryResponseListToJson(
        QcRepostCategoryResponseList instance) =>
    <String, dynamic>{
      'pc': instance.productCategory,
      'c': instance.count,
      'cc': instance.categoryCode,
    };
