// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_receive_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceReceiveResponse _$DeviceReceiveResponseFromJson(
        Map<String, dynamic> json) =>
    DeviceReceiveResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..refId = json['r_id'] as String?
      ..isSuccess = json['s'] as bool? ?? false
      ..errorMsg = json['em'] as String?
      ..successMessage = json['sm'] as String?
      ..data = json['dt'] == null
          ? null
          : DeviceReceiveData.fromJson(json['dt'] as Map<String, dynamic>);

Map<String, dynamic> _$DeviceReceiveResponseToJson(
        DeviceReceiveResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'r_id': instance.refId,
      's': instance.isSuccess,
      'em': instance.errorMsg,
      'sm': instance.successMessage,
      'dt': instance.data,
    };

DeviceReceiveData _$DeviceReceiveDataFromJson(Map<String, dynamic> json) =>
    DeviceReceiveData(
      json['pt'] as String?,
      json['dbr'] as String?,
      json['st'] as String?,
      json['rt'] as String?,
      json['isUrgent'] as bool?,
      json['ele'] as String?,
      json['ro'] as String?,
      (json['rs'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DeviceReceiveDataToJson(DeviceReceiveData instance) =>
    <String, dynamic>{
      'pt': instance.productTitle,
      'dbr': instance.deviceBarcode,
      'st': instance.status,
      'rt': instance.repairType,
      'ro': instance.repairOrder,
      'isUrgent': instance.isUrgent,
      'ele': instance.elssEngineerName,
      'rs': instance.rubbingOrGlassChangeStatus,
    };
