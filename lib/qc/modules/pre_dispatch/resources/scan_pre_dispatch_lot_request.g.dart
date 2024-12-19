// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_pre_dispatch_lot_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanPreDispatchRequest _$ScanPreDispatchRequestFromJson(
        Map<String, dynamic> json) =>
    ScanPreDispatchRequest(
      lotGroupName: json['lgn'] as String?,
      qrCode: json['qr_code'] as String?,
    );

Map<String, dynamic> _$ScanPreDispatchRequestToJson(
        ScanPreDispatchRequest instance) =>
    <String, dynamic>{
      if (instance.lotGroupName case final value?) 'lgn': value,
      if (instance.qrCode case final value?) 'qr_code': value,
    };
