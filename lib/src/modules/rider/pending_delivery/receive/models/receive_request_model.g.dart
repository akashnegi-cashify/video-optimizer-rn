// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receive_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request()
  ..pageNo = json['pno'] as int?
  ..listNo = json['ln'] as int?
  ..barcode = json['br'] as String?
  ..fp = json['fp'] == null
      ? null
      : FacilityPart.fromJson(json['fp'] as Map<String, dynamic>);

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'pno': instance.pageNo,
      'ln': instance.listNo,
      'br': instance.barcode,
      'fp': instance.fp,
    };

FacilityPart _$FacilityPartFromJson(Map<String, dynamic> json) =>
    FacilityPart()..isUrgent = json['is_urgent'] as bool? ?? false;

Map<String, dynamic> _$FacilityPartToJson(FacilityPart instance) =>
    <String, dynamic>{
      'is_urgent': instance.isUrgent,
    };
