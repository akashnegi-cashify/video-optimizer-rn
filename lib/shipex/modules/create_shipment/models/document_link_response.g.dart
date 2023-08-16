// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_link_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentLinkResponse _$DocumentLinkResponseFromJson(
        Map<String, dynamic> json) =>
    DocumentLinkResponse(
      json['dt'] as String?,
      json['s'] as bool?,
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$DocumentLinkResponseToJson(
        DocumentLinkResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.documentLink,
      's': instance.status,
    };
