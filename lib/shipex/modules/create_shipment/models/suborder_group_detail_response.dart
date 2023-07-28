import 'package:flutter_trc/shipex/modules/create_shipment/models/address_response.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/models/suborder_group_list_response.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/models/vendor_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'suborder_group_detail_response.g.dart';

@JsonSerializable()
class SubOrderGroupDetailResponse extends SubOrderGroupListData {

  @JsonKey(name: 'il')
  String? invoiceLink;

  @JsonKey(name: "cn")
  String? courierName;

  @JsonKey(name: "ca")
  String? courierAwb;

  @JsonKey(name: 'cd')
  DateTime? createDate;

  @JsonKey(name: 'fi')
  int? facilityId;

  @JsonKey(name: 'fn')
  String? facilityName;

  @JsonKey(name: 'vn')
  String? vendorName;

  @JsonKey(name: 's')
  int? status;

  @JsonKey(name: 'sd')
  String? statusDesc;

  @JsonKey(name: 'ta')
  double? totalAmt;

  @JsonKey(name: 'qty')
  int? totalQty;

  @JsonKey(name: 'billAddr')
  AddressResponse? billingAddress;

  @JsonKey(name: 'shprAddr')
  AddressResponse? shipperAddress;

  @JsonKey(name: 'shipAddr')
  AddressResponse? shippingAddress;

  @JsonKey(name: 'vd')
  VendorResponse? vendorDetails;

  SubOrderGroupDetailResponse(super.id, super.name, super.lotType, super.lotTypeName, super.packagingBarcode);

  static SubOrderGroupDetailResponse fromJson(Map<String, dynamic> json) => _$SubOrderGroupDetailResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SubOrderGroupDetailResponseToJson(this);
}
