import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transfer_lot_header_response.g.dart';

@JsonSerializable()
class TransferLotHeaderResponse extends BaseResponse {
  @JsonKey(name: "name")
  String? lotName;

  @JsonKey(name: "deviceCount")
  int? deviceCount;

  @JsonKey(name: "status")
  int? statusCode;

  @JsonKey(name: "toFacilityName")
  String? toFacilityName;

  @JsonKey(name: "statusDesc")
  String? statusDesc;

  TransferLotHeaderResponse(this.lotName, this.deviceCount, this.statusCode, this.toFacilityName, this.statusDesc,
      super.cashifyAlert, super.trackUrl);

  static TransferLotHeaderResponse fromJson(Map<String, dynamic> json) => _$TransferLotHeaderResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TransferLotHeaderResponseToJson(this);
}
