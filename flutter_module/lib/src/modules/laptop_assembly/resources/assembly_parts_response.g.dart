// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assembly_parts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssemblyPartsResponse _$AssemblyPartsResponseFromJson(
        Map<String, dynamic> json) =>
    AssemblyPartsResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..isSuccess = json['s'] as bool? ?? false
      ..errorMsg = json['em'] as String?
      ..responseData = (json['dt'] as List<dynamic>?)
          ?.map((e) => AssemblyChildPart.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$AssemblyPartsResponseToJson(
        AssemblyPartsResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      's': instance.isSuccess,
      'em': instance.errorMsg,
      'dt': instance.responseData,
    };

AssemblyChildPart _$AssemblyChildPartFromJson(Map<String, dynamic> json) =>
    AssemblyChildPart(
      deviceId: (json['did'] as num?)?.toInt(),
      deviceBarcode: json['dbr'] as String?,
      partName: json['pn'] as String?,
      statusCode: (json['sc'] as num?)?.toInt(),
      statusDescription: json['sd'] as String?,
    );

Map<String, dynamic> _$AssemblyChildPartToJson(AssemblyChildPart instance) =>
    <String, dynamic>{
      'did': instance.deviceId,
      'dbr': instance.deviceBarcode,
      'pn': instance.partName,
      'sc': instance.statusCode,
      'sd': instance.statusDescription,
    };
