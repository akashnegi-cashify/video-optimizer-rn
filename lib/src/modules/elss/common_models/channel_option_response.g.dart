// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_option_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelOptionResponse _$ChannelOptionResponseFromJson(
        Map<String, dynamic> json) =>
    ChannelOptionResponse(
      isSuccess: json['s'] as bool?,
      pm: json['pm'] as int?,
      refId: json['r_id'] as String?,
      channelOptionData: json['dt'] == null
          ? null
          : ChannelOptionDataModel.fromJson(json['dt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChannelOptionResponseToJson(
        ChannelOptionResponse instance) =>
    <String, dynamic>{
      's': instance.isSuccess,
      'pm': instance.pm,
      'r_id': instance.refId,
      'dt': instance.channelOptionData,
    };

ChannelOptionDataModel _$ChannelOptionDataModelFromJson(
        Map<String, dynamic> json) =>
    ChannelOptionDataModel(
      barcode: json['dbr'] as String?,
      defaultChannelOption: json['df'] == null
          ? null
          : ChannelOptionData.fromJson(json['df'] as Map<String, dynamic>),
      initialChannelOption: json['in'] == null
          ? null
          : ChannelOptionData.fromJson(json['in'] as Map<String, dynamic>),
      listOfChannelOption: (json['fi'] as List<dynamic>?)
          ?.map((e) => ChannelOptionData.fromJson(e as Map<String, dynamic>))
          .toList(),
      yourChannelSuggestion: json['yo'] == null
          ? null
          : ChannelOptionData.fromJson(json['yo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChannelOptionDataModelToJson(
        ChannelOptionDataModel instance) =>
    <String, dynamic>{
      'dbr': instance.barcode,
      'in': instance.initialChannelOption,
      'fi': instance.listOfChannelOption,
      'df': instance.defaultChannelOption,
      'yo': instance.yourChannelSuggestion,
    };

ChannelOptionData _$ChannelOptionDataFromJson(Map<String, dynamic> json) =>
    ChannelOptionData(
      optionId: json['oid'] as int?,
      channelName: json['ch'] as String?,
      channelOptionPrice: (json['pr'] as num?)?.toDouble(),
      grade: json['gr'] as String?,
      isRubbingAllowed: json['isr'] as bool?,
      requestedParts: (json['rp'] as List<dynamic>?)
          ?.map((e) => ElssPart.fromJson(e as Map<String, dynamic>))
          .toList(),
      repairType: json['rt'] as String?,
    );

Map<String, dynamic> _$ChannelOptionDataToJson(ChannelOptionData instance) =>
    <String, dynamic>{
      'oid': instance.optionId,
      'ch': instance.channelName,
      'pr': instance.channelOptionPrice,
      'gr': instance.grade,
      'isr': instance.isRubbingAllowed,
      'rp': instance.requestedParts,
      'rt': instance.repairType,
    };
