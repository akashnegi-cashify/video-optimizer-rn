// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receive_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response _$ResponseFromJson(Map<String, dynamic> json) => Response()
  ..rid = json['r_id'] as String?
  ..data = json['dt'] == null
      ? null
      : Data.fromJson(json['dt'] as Map<String, dynamic>);

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'r_id': instance.rid,
      'dt': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data()
  ..partList = (json['pl'] as List<dynamic>?)
      ?.map((e) => Part.fromJson(e as Map<String, dynamic>))
      .toList()
  ..totalPage = (json['tp'] as num?)?.toInt();

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'pl': instance.partList,
      'tp': instance.totalPage,
    };

Part _$PartFromJson(Map<String, dynamic> json) => Part()
  ..partName = json['pn'] as String? ?? ''
  ..partBarcode = json['pbr'] as String? ?? ''
  ..partSku = json['sku'] as String? ?? ''
  ..deviceName = json['dna'] as String? ?? ''
  ..partColor = json['pc'] as String? ?? ''
  ..deviceBarcode = json['dbr'] as String? ?? ''
  ..partId = (json['prid'] as num).toInt()
  ..isBulk = json['isBulk'] as bool?
  ..partVariantName = json['pvn'] as String?
  ..isUrgent = json['isUrgent'] as bool? ?? false
  ..inventoryManageName = json['im'] as String? ?? '';

Map<String, dynamic> _$PartToJson(Part instance) => <String, dynamic>{
      'pn': instance.partName,
      'pbr': instance.partBarcode,
      'sku': instance.partSku,
      'dna': instance.deviceName,
      'pc': instance.partColor,
      'dbr': instance.deviceBarcode,
      'prid': instance.partId,
      'isBulk': instance.isBulk,
      'pvn': instance.partVariantName,
      'isUrgent': instance.isUrgent,
      'im': instance.inventoryManageName,
    };
