// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suborder_group_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubOrderGroupDetailResponse _$SubOrderGroupDetailResponseFromJson(
        Map<String, dynamic> json) =>
    SubOrderGroupDetailResponse(
      (json['id'] as num?)?.toInt(),
      json['n'] as String?,
      (json['lt'] as num?)?.toInt(),
      json['ltn'] as String?,
      json['pbar'] as String?,
      (json['qty'] as num?)?.toInt(),
      (json['si'] as num?)?.toInt(),
    )
      ..pinCode = json['pin'] as String?
      ..monitoringCameraRecordStartDateTime = (json['mcrsdt'] as num?)?.toInt()
      ..monitoringCameraBarcode = json['mcb'] as String?
      ..invoiceLink = json['il'] as String?
      ..courierName = json['cn'] as String?
      ..courierAwb = json['ca'] as String?
      ..createDate = (json['cd'] as num?)?.toInt()
      ..facilityId = (json['fi'] as num?)?.toInt()
      ..facilityName = json['fn'] as String?
      ..vendorName = json['vn'] as String?
      ..status = (json['s'] as num?)?.toInt()
      ..statusDesc = json['sd'] as String?
      ..totalAmt = (json['ta'] as num?)?.toDouble()
      ..billingAddress = json['billAddr'] == null
          ? null
          : AddressResponse.fromJson(json['billAddr'] as Map<String, dynamic>)
      ..shipperAddress = json['shprAddr'] == null
          ? null
          : AddressResponse.fromJson(json['shprAddr'] as Map<String, dynamic>)
      ..shippingAddress = json['shipAddr'] == null
          ? null
          : AddressResponse.fromJson(json['shipAddr'] as Map<String, dynamic>)
      ..vendorDetails = json['vd'] == null
          ? null
          : VendorResponse.fromJson(json['vd'] as Map<String, dynamic>)
      ..state = json['state'] as String?;

Map<String, dynamic> _$SubOrderGroupDetailResponseToJson(
        SubOrderGroupDetailResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'n': instance.name,
      'lt': instance.lotType,
      'ltn': instance.lotTypeName,
      'pbar': instance.packagingBarcode,
      'qty': instance.totalQty,
      'si': instance.shipmentId,
      'pin': instance.pinCode,
      'mcrsdt': instance.monitoringCameraRecordStartDateTime,
      'mcb': instance.monitoringCameraBarcode,
      'il': instance.invoiceLink,
      'cn': instance.courierName,
      'ca': instance.courierAwb,
      'cd': instance.createDate,
      'fi': instance.facilityId,
      'fn': instance.facilityName,
      'vn': instance.vendorName,
      's': instance.status,
      'sd': instance.statusDesc,
      'ta': instance.totalAmt,
      'billAddr': instance.billingAddress,
      'shprAddr': instance.shipperAddress,
      'shipAddr': instance.shippingAddress,
      'vd': instance.vendorDetails,
      'state': instance.state,
    };
