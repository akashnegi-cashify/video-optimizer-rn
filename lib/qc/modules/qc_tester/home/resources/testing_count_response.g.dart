// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testing_count_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestingCountResponse _$TestingCountResponseFromJson(
        Map<String, dynamic> json) =>
    TestingCountResponse(
      (json['c'] as num?)?.toInt(),
      (json['ud'] as num?)?.toInt(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$TestingCountResponseToJson(
        TestingCountResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'c': instance.testingDeviceCount,
      'ud': instance.lastUpdatedDate,
    };
