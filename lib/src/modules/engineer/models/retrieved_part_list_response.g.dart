// coverage:ignore-file
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
    )..retrievedPartListResponse = json['dt'] == null
        ? null
        : RetrievedPartList.fromJson(json['dt'] as Map<String, dynamic>);

Map<String, dynamic> _$RetrievedPartListResponseToJson(
        RetrievedPartListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.retrievedPartListResponse,
    };

RetrievedPartList _$RetrievedPartListFromJson(Map<String, dynamic> json) =>
    RetrievedPartList()
      ..retrievedPartList = (json['dl'] as List<dynamic>?)
          ?.map(
              (e) => RetrievedPartListData.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$RetrievedPartListToJson(RetrievedPartList instance) =>
    <String, dynamic>{
      'dl': instance.retrievedPartList,
    };

RetrievedPartListData _$RetrievedPartListDataFromJson(
        Map<String, dynamic> json) =>
    RetrievedPartListData(
      json['sku'] as String?,
      json['partName'] as String?,
      json['deviceBarcode'] as String?,
      json['retrievedPartBarcode'] as String?,
      (json['partId'] as num?)?.toInt(),
      json['reason'] as String?,
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['remark'] as String?,
    )..partVariationName = json['partVariationName'] as String?;

Map<String, dynamic> _$RetrievedPartListDataToJson(
        RetrievedPartListData instance) =>
    <String, dynamic>{
      'partId': instance.partId,
      'sku': instance.sku,
      'partName': instance.partName,
      'partVariationName': instance.partVariationName,
      'deviceBarcode': instance.deviceBarcode,
      'retrievedPartBarcode': instance.retrievedPartBarcode,
      'reason': instance.reason,
      'remark': instance.remark,
      'images': instance.imageUrls,
    };
