// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retreived_part_required_list_reponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetrievedPartRequiredResponse _$RetrievedPartRequiredResponseFromJson(
        Map<String, dynamic> json) =>
    RetrievedPartRequiredResponse(
      rId: json['r_id'] as String?,
      data: json['dt'] == null
          ? null
          : RetrievedPartRequiredData.fromJson(
              json['dt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RetrievedPartRequiredResponseToJson(
        RetrievedPartRequiredResponse instance) =>
    <String, dynamic>{
      'r_id': instance.rId,
      'dt': instance.data,
    };

RetrievedPartRequiredData _$RetrievedPartRequiredDataFromJson(
        Map<String, dynamic> json) =>
    RetrievedPartRequiredData(
      rId: json['r_id'] as String?,
      partList: (json['pl'] as List<dynamic>?)
          ?.map((e) =>
              RetrievedPartListResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RetrievedPartRequiredDataToJson(
        RetrievedPartRequiredData instance) =>
    <String, dynamic>{
      'r_id': instance.rId,
      'pl': instance.partList,
    };

RetrievedPartListResponseData _$RetrievedPartListResponseDataFromJson(
        Map<String, dynamic> json) =>
    RetrievedPartListResponseData(
      categoryCode: json['ccd'] as String?,
      partRequestId: (json['prid'] as num?)?.toInt(),
      partRequestName: json['prn'] as String?,
      productRequiredReasonList: (json['prr'] as List<dynamic>?)
          ?.map((e) =>
              RetrievedPartReasonListData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RetrievedPartListResponseDataToJson(
        RetrievedPartListResponseData instance) =>
    <String, dynamic>{
      'prn': instance.partRequestName,
      'prid': instance.partRequestId,
      'ccd': instance.categoryCode,
      'prr': instance.productRequiredReasonList,
    };
