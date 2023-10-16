import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'st_lot_details_response.g.dart';

@JsonSerializable()
class StLotDetailResponse extends BaseResponse {
  @JsonKey(name: "ln")
  String? lotName;

  @JsonKey(name: "mo")
  String? modelName;

  @JsonKey(name: "qr")
  String? barcode;

  @JsonKey(name: "dst")
  String? destination;

  @JsonKey(name: "lo")
  String? location;

  @JsonKey(name: "dcnt")
  int? deviceCount;

  @JsonKey(name: "scnt")
  int? scanCount;

  @JsonKey(name: "st")
  String? storage;

  StLotDetailResponse(this.lotName, this.modelName, this.barcode, this.destination, this.location, this.deviceCount,
      this.scanCount, this.storage, super.cashifyAlert, super.trackUrl);

  static StLotDetailResponse fromJson(Map<String, dynamic> json) => _$StLotDetailResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StLotDetailResponseToJson(this);
}
