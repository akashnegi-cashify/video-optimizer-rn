// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suborder_group_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubOrderGroupDetailResponse _$SubOrderGroupDetailResponseFromJson(
        Map<String, dynamic> json) =>
    SubOrderGroupDetailResponse(
      json['id'] as int?,
      json['n'] as String?,
      json['lt'] as int?,
      json['ltn'] as String?,
      json['pbar'] as String?,
    )
      ..invoiceLink = json['il'] as String?
      ..courierName = json['cn'] as String?
      ..courierAwb = json['ca'] as String?
      ..createDate =
          json['cd'] == null ? null : DateTime.parse(json['cd'] as String)
      ..facilityId = json['fi'] as int?
      ..facilityName = json['fn'] as String?
      ..vendorName = json['vn'] as String?
      ..status = json['s'] as int?
      ..statusDesc = json['sd'] as String?
      ..totalAmt = (json['ta'] as num?)?.toDouble()
      ..totalQty = json['qty'] as int?
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
          : VendorResponse.fromJson(json['vd'] as Map<String, dynamic>);

Map<String, dynamic> _$SubOrderGroupDetailResponseToJson(
        SubOrderGroupDetailResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'n': instance.name,
      'lt': instance.lotType,
      'ltn': instance.lotTypeName,
      'pbar': instance.packagingBarcode,
      'il': instance.invoiceLink,
      'cn': instance.courierName,
      'ca': instance.courierAwb,
      'cd': instance.createDate?.toIso8601String(),
      'fi': instance.facilityId,
      'fn': instance.facilityName,
      'vn': instance.vendorName,
      's': instance.status,
      'sd': instance.statusDesc,
      'ta': instance.totalAmt,
      'qty': instance.totalQty,
      'billAddr': instance.billingAddress,
      'shprAddr': instance.shipperAddress,
      'shipAddr': instance.shippingAddress,
      'vd': instance.vendorDetails,
    };
