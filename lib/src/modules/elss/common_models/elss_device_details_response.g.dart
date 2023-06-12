// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elss_device_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElssDeviceDetailsResponse _$ElssDeviceDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    ElssDeviceDetailsResponse(
      json['r_id'] as String?,
      json['em'] as String?,
      json['s'] as bool?,
      json['dt'] == null
          ? null
          : DeviceDetailsData.fromJson(json['dt'] as Map<String, dynamic>),
    )..success = json['success'] as bool?;

Map<String, dynamic> _$ElssDeviceDetailsResponseToJson(
        ElssDeviceDetailsResponse instance) =>
    <String, dynamic>{
      'r_id': instance.referenceId,
      's': instance.isSuccess,
      'success': instance.success,
      'em': instance.errorMessage,
      'dt': instance.deviceDetailsData,
    };

DeviceDetailsData _$DeviceDetailsDataFromJson(Map<String, dynamic> json) =>
    DeviceDetailsData(
      json['dbr'] as String?,
      json['rr'] as String?,
      json['dna'] as String?,
      (json['rrs'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      json['pid'] as int?,
      json['dst'] as String?,
      json['dcl'] as String?,
      json['imei'] as String?,
      json['drt'] as String?,
      json['isDetailsPresent'] as bool?,
      (json['rp'] as List<dynamic>?)
          ?.map((e) => ElssPart.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['dgr'] as String?,
      json['paal'] as bool?,
      json['isr'] as bool?,
      json['sgr'] as String?,
      json['sgc'] as String?,
      json['imrd'] as bool?,
    );

Map<String, dynamic> _$DeviceDetailsDataToJson(DeviceDetailsData instance) =>
    <String, dynamic>{
      'dna': instance.deviceName,
      'dbr': instance.deviceBarcode,
      'dst': instance.deviceStatus,
      'drt': instance.deviceRepairType,
      'dgr': instance.deviceGrade,
      'paal': instance.partAdditionAllowed,
      'dcl': instance.deviceColor,
      'pid': instance.productId,
      'isDetailsPresent': instance.isDetailsPresent,
      'imei': instance.imei,
      'rr': instance.requestReason,
      'rrs': instance.repairReasonList,
      'rp': instance.repairPartList,
      'isr': instance.isRubbingRequired,
      'sgr': instance.suggestedGrade,
      'sgc': instance.suggestedChannel,
      'imrd': instance.isMarkRepairedDevice,
    };
