// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_pre_dispatch_lot_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanPreDispatchRequest _$ScanPreDispatchRequestFromJson(
        Map<String, dynamic> json) =>
    ScanPreDispatchRequest(
      lotGroupName: json['lotGroupName'] as String?,
      qrCode: json['qrCode'] as String?,
    );

Map<String, dynamic> _$ScanPreDispatchRequestToJson(
        ScanPreDispatchRequest instance) =>
    <String, dynamic>{
      if (instance.lotGroupName case final value?) 'lotGroupName': value,
      if (instance.qrCode case final value?) 'qrCode': value,
    };
