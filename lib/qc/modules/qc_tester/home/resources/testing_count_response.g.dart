// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testing_count_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestingCountResponse _$TestingCountResponseFromJson(
        Map<String, dynamic> json) =>
    TestingCountResponse(
      json['dt'] == null
          ? null
          : TestingCountData.fromJson(json['dt'] as Map<String, dynamic>),
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
      'dt': instance.testingDeviceData,
    };

TestingCountData _$TestingCountDataFromJson(Map<String, dynamic> json) =>
    TestingCountData()
      ..testingDeviceCount = (json['count'] as num?)?.toInt()
      ..lastUpdatedDate = (json['lastUpdate'] as num?)?.toInt();

Map<String, dynamic> _$TestingCountDataToJson(TestingCountData instance) =>
    <String, dynamic>{
      'count': instance.testingDeviceCount,
      'lastUpdate': instance.lastUpdatedDate,
    };
