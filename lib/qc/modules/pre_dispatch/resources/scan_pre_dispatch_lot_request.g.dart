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
    ScanPreDispatchRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('lgn', instance.lotGroupName);
  writeNotNull('qr_code', instance.qrCode);
  return val;
}
