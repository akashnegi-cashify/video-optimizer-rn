
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/models/address_response.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/models/suborder_group_list_response.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/models/vendor_response.dart';
import 'package:intl/intl.dart';
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
  int? createDate;

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

  @JsonKey(name: 'billAddr')
  AddressResponse? billingAddress;

  @JsonKey(name: 'shprAddr')
  AddressResponse? shipperAddress;

  @JsonKey(name: 'shipAddr')
  AddressResponse? shippingAddress;

  @JsonKey(name: 'vd')
  VendorResponse? vendorDetails;

  @JsonKey(name: "state")
  String? state;

  SubOrderGroupDetailResponse(
      super.id, super.name, super.lotType, super.lotTypeName, super.packagingBarcode, super.totalQty, super.shipmentId);

  static SubOrderGroupDetailResponse fromJson(Map<String, dynamic> json) => _$SubOrderGroupDetailResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SubOrderGroupDetailResponseToJson(this);

  Map<String, String> getLabelAndValueData() {
    return {
      if (!Validator.isNullOrEmpty(courierName)) "Courier Name ": courierName!,
      if (!Validator.isNullOrEmpty(courierAwb)) "Courier AWB": courierAwb!,
      if (createDate != null)
        "Created Date": DateFormat("dd MMM yyyy, hh:mm aa").format(DateTime.fromMillisecondsSinceEpoch(createDate!)),
      if (facilityId != null) "Facility Id": facilityId.toString(),
      if (!Validator.isNullOrEmpty(facilityName)) "Facility Name": facilityName!,
      if (!Validator.isNullOrEmpty(statusDesc)) "Status": statusDesc!,
      if (totalAmt != null) "Total Amount": totalAmt!.toStringAsFixed(2),
      if (billingAddress != null)
        "Billing Address":
            "${billingAddress?.savedAddress1 ?? ""}, ${billingAddress?.city ?? ""}, ${billingAddress?.state ?? ""}, ${billingAddress?.pinCode ?? ""}",
      if (shipperAddress != null)
        "Shipper's Address":
            "${shipperAddress?.savedAddress1 ?? ""}, ${shipperAddress?.city ?? ""}, ${shipperAddress?.state ?? ""}, ${shipperAddress?.pinCode ?? ""}",
      if (shippingAddress != null)
        "Shipping Address":
            "${shippingAddress?.savedAddress1 ?? ""}, ${shippingAddress?.city ?? ""}, ${shippingAddress?.state ?? ""}, ${shippingAddress?.pinCode ?? ""}",
      if (!Validator.isNullOrEmpty(vendorName)) "Vendor Name": vendorName!,
      if (vendorDetails != null && !Validator.isNullOrEmpty(vendorDetails!.customerCode))
        "Vendor Customer Code": vendorDetails!.customerCode!,
      if (vendorDetails != null && !Validator.isNullOrEmpty(vendorDetails!.businessName))
        "Vendor Business Name": vendorDetails!.businessName!,
      if (vendorDetails != null && !Validator.isNullOrEmpty(vendorDetails!.email))
        "Vendor Email": vendorDetails!.email!,
      if (vendorDetails != null && !Validator.isNullOrEmpty(vendorDetails!.name)) "Vendor Name": vendorDetails!.name!,
      if (!Validator.isNullOrEmpty(pinCode)) "PinCode": pinCode!,
      if (!Validator.isNullOrEmpty(state)) "State": state!,
    };
  }
}
