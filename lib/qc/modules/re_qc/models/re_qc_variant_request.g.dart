// GENERATED CODE - DO NOT MODIFY BY HAND

part of 're_qc_variant_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReQcVariantRequest _$ReQcVariantRequestFromJson(Map<String, dynamic> json) =>
    ReQcVariantRequest(
      imageUrl: json['iurl'] as String?,
      variantId: (json['vi'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReQcVariantRequestToJson(ReQcVariantRequest instance) =>
    <String, dynamic>{
      'iurl': instance.imageUrl,
      'vi': instance.variantId,
    };
