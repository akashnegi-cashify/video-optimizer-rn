// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_calculator_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyCalculatorResponse _$MyCalculatorResponseFromJson(
        Map<String, dynamic> json) =>
    MyCalculatorResponse(
      json['productName'] as String?,
      (json['bid'] as num?)?.toInt(),
      (json['cid'] as num?)?.toInt(),
      (json['plc'] as List<dynamic>?)
          ?.map((e) => ProductLineCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['epcfg'] as List<dynamic>?)
          ?.map((e) =>
              CalculatorResponseConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['cfg'] as List<dynamic>?)
          ?.map((e) =>
              CalculatorResponseConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['imageUrl'] as String?,
      json['imei_key'] as String?,
      (json['xmd'] as num?)?.toInt(),
      (json['isa'] as num?)?.toInt(),
      (json['pid'] as num?)?.toInt(),
      (json['plid'] as num?)?.toInt(),
      (json['sse'] as num?)?.toInt() ?? 0,
      (json['r'] as List<dynamic>?)
          ?.map((e) => RuleResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['st'] as String?,
      json['sp'] as bool?,
      (json['us'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      (json['dcr'] as num?)?.toInt(),
      (json['da'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    )
      ..manualAuditQuestions = (json['maq'] as List<dynamic>?)
          ?.map((e) =>
              ManualAuditQuestionItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..deviceName = json['pn'] as String?
      ..brandName = json['bn'] as String?;

Map<String, dynamic> _$MyCalculatorResponseToJson(
        MyCalculatorResponse instance) =>
    <String, dynamic>{
      'productName': instance.productName,
      'imageUrl': instance.imageUrl,
      'sse': instance.ruleExecutionMode,
      'dcr': instance.defaultRuleId,
      'cid': instance.calId,
      'plid': instance.productLineId,
      'bid': instance.brandId,
      'pid': instance.productId,
      'plc': instance.categories,
      'r': instance.rules,
      'cfg': instance.configPart,
      'epcfg': instance.configEPart,
      'sp': instance.showPrice,
      'xmd': instance.isExpressCity,
      'isa': instance.isServiceAvailable,
      'imei_key': instance.imeiKey,
      'us': instance.userSelection,
      'st': instance.selectionType,
      'da': instance.diagnoAccuracy,
      'maq': instance.manualAuditQuestions,
      'pn': instance.deviceName,
      'bn': instance.brandName,
    };

ManualAuditQuestionItem _$ManualAuditQuestionItemFromJson(
        Map<String, dynamic> json) =>
    ManualAuditQuestionItem(
      (json['mmid'] as num?)?.toInt(),
      json['q'] as String?,
    );

Map<String, dynamic> _$ManualAuditQuestionItemToJson(
        ManualAuditQuestionItem instance) =>
    <String, dynamic>{
      'mmid': instance.manualMasterId,
      'q': instance.question,
    };
