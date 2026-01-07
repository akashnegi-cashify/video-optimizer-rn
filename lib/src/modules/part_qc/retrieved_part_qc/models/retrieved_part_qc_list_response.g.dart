// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrieved_part_qc_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetrievedPartQcListData _$RetrievedPartQcListDataFromJson(Map<String, dynamic> json) =>
    RetrievedPartQcListData(
      extractedPartId: (json['extractedPartId'] as num?)?.toInt(),
      partId: (json['partId'] as num?)?.toInt(),
      sku: json['sku'] as String?,
      partName: json['partName'] as String?,
      deviceBarcode: json['deviceBarcode'] as String?,
      retrievedPartBarcode: json['retrievedPartBarcode'] as String?,
      status: json['status'] as String?,
      createdBy: json['createdBy'] as String?,
      createDate: (json['createDate'] as num?)?.toInt(),
      qcby: json['qcby'] as String?,
      assignedTo: json['assignedTo'] as String?,
      reason: json['reason'] as String?,
      remark: json['remark'] as String?,
      partVariationName: json['partVariationName'] as String?,
      images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RetrievedPartQcListDataToJson(RetrievedPartQcListData instance) =>
    <String, dynamic>{
      'extractedPartId': instance.extractedPartId,
      'partId': instance.partId,
      'sku': instance.sku,
      'partName': instance.partName,
      'deviceBarcode': instance.deviceBarcode,
      'retrievedPartBarcode': instance.retrievedPartBarcode,
      'status': instance.status,
      'createdBy': instance.createdBy,
      'createDate': instance.createDate,
      'qcby': instance.qcby,
      'assignedTo': instance.assignedTo,
      'reason': instance.reason,
      'remark': instance.remark,
      'partVariationName': instance.partVariationName,
      'images': instance.images,
    };

