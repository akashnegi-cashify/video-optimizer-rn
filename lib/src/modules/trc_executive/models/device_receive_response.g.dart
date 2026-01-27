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
      json['productTitle'] as String?,
      json['deviceBarcode'] as String?,
      json['status'] as String?,
      json['repairType'] as String?,
      json['isUrgent'] as bool?,
      json['ele'] as String?,
      json['repairOrderNo'] as String?,
      (json['rubbingStatus'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DeviceReceiveDataToJson(DeviceReceiveData instance) =>
    <String, dynamic>{
      'productTitle': instance.productTitle,
      'deviceBarcode': instance.deviceBarcode,
      'status': instance.status,
      'repairType': instance.repairType,
      'repairOrderNo': instance.repairOrder,
      'isUrgent': instance.isUrgent,
      'elssEngineerName': instance.elssEngineerName,
      'rubbingStatus': instance.rubbingOrGlassChangeStatus,
    };
