// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_calculator_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyCalculatorResponse _$MyCalculatorResponseFromJson(
        Map<String, dynamic> json) =>
    MyCalculatorResponse(
      json['productName'] as String?,
      json['bid'] as int?,
      json['cid'] as int?,
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
      json['xmd'] as int?,
      json['isa'] as int?,
      json['pid'] as int?,
      json['plid'] as int?,
      json['sse'] as int? ?? 0,
      (json['r'] as List<dynamic>?)
          ?.map((e) => RuleResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['st'] as String?,
      json['sp'] as bool?,
      (json['us'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as int),
      ),
      json['dcr'] as int?,
      (json['da'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as int),
      ),
    )..manualAuditQuestions = (json['maq'] as List<dynamic>?)
        ?.map(
            (e) => ManualAuditQuestionItem.fromJson(e as Map<String, dynamic>))
        .toList();

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
    };

ManualAuditQuestionItem _$ManualAuditQuestionItemFromJson(
        Map<String, dynamic> json) =>
    ManualAuditQuestionItem(
      json['mmid'] as int?,
      json['q'] as String?,
    );

Map<String, dynamic> _$ManualAuditQuestionItemToJson(
        ManualAuditQuestionItem instance) =>
    <String, dynamic>{
      'mmid': instance.manualMasterId,
      'q': instance.question,
    };
