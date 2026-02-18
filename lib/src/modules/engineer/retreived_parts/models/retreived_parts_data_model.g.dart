// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retreived_parts_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetrievedPartsDataModel _$RetrievedPartsDataModelFromJson(
        Map<String, dynamic> json) =>
    RetrievedPartsDataModel(
      categoryCode: json['ccd'] as String?,
      barcode: json['rp'] as String?,
      partRetrievedId: (json['prid'] as num?)?.toInt(),
      retrievedPartImages:
          (json['rpimg'] as List<dynamic>?)?.map((e) => e as String).toList(),
      retrievedPartsReasonId: (json['rprid'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RetrievedPartsDataModelToJson(
        RetrievedPartsDataModel instance) =>
    <String, dynamic>{
      'prid': instance.partRetrievedId,
      'ccd': instance.categoryCode,
      'rprid': instance.retrievedPartsReasonId,
      'rp': instance.barcode,
      'rpimg': instance.retrievedPartImages,
    };
