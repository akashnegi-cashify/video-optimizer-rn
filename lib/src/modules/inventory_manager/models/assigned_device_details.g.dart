// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assigned_device_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignedDeviceDetails _$AssignedDeviceDetailsFromJson(
        Map<String, dynamic> json) =>
    AssignedDeviceDetails(
      isSuccess: json['s'] as bool?,
      refId: json['r_id'] as String?,
      detailsData: json['dt'] == null
          ? null
          : AssignDeviceDetailsData.fromJson(
              json['dt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AssignedDeviceDetailsToJson(
        AssignedDeviceDetails instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      's': instance.isSuccess,
      'dt': instance.detailsData,
    };

AssignDeviceDetailsData _$AssignDeviceDetailsDataFromJson(
        Map<String, dynamic> json) =>
    AssignDeviceDetailsData(
      did: (json['deviceId'] as num?)?.toInt(),
      lc: json['location'] as String?,
      engineerName: json['engineerName'] as String?,
      deviceBarcode: json['deviceBarcode'] as String?,
      status: json['status'] as String?,
      grade: json['grade'] as String?,
      repairType: json['repairType'] as String?,
      productName: json['productTitle'] as String?,
      deadRemark: json['dr'] as String?,
      returnCount: (json['returnCount'] as num?)?.toInt(),
      isScrewMediaUploaded: json['ismu'] as bool?,
      imei: json['dimei'] as String?,
      repairReasonList:
          (json['rrs'] as List<dynamic>?)?.map((e) => e as String).toList(),
      returnReason: json['rr'] as String?,
      color: json['deviceColor'] as String?,
      serialNumber: json['sno'] as String?,
      isUrgent: json['isUrgent'] as bool?,
      skewImageTaken: json['skewImageTaken'] as bool?,
    );

Map<String, dynamic> _$AssignDeviceDetailsDataToJson(
        AssignDeviceDetailsData instance) =>
    <String, dynamic>{
      'deviceId': instance.did,
      'productTitle': instance.productName,
      'deviceBarcode': instance.deviceBarcode,
      'status': instance.status,
      'engineerName': instance.engineerName,
      'repairType': instance.repairType,
      'grade': instance.grade,
      'location': instance.lc,
      'dr': instance.deadRemark,
      'returnCount': instance.returnCount,
      'ismu': instance.isScrewMediaUploaded,
      'rr': instance.returnReason,
      'rrs': instance.repairReasonList,
      'dimei': instance.imei,
      'sno': instance.serialNumber,
      'dc': instance.color,
      'isUrgent': instance.isUrgent,
      'skewImageTaken': instance.skewImageTaken,
    };
