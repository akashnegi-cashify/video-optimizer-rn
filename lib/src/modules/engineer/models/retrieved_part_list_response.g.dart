// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrieved_part_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetrievedPartListResponse _$RetrievedPartListResponseFromJson(
        Map<String, dynamic> json) =>
    RetrievedPartListResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )..retrievedPartListData = (json['dt'] as List<dynamic>?)
        ?.map((e) => RetrievedPartListData.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$RetrievedPartListResponseToJson(
        RetrievedPartListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.retrievedPartListData,
    };

RetrievedPartListData _$RetrievedPartListDataFromJson(
        Map<String, dynamic> json) =>
    RetrievedPartListData(
      json['sku'] as String?,
      json['pn'] as String?,
      json['dbr'] as String?,
      json['rpbr'] as String?,
    );

Map<String, dynamic> _$RetrievedPartListDataToJson(
        RetrievedPartListData instance) =>
    <String, dynamic>{
      'sku': instance.sku,
      'pn': instance.partName,
      'dbr': instance.deviceBarcode,
      'rpbr': instance.retrievedPartBarcode,
    };
