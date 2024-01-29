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

  @JsonKey(name: "did")
  int? deviceId;

  StLotDetailResponse(this.lotName, this.modelName, this.barcode, this.destination, this.location, this.deviceCount,
      this.scanCount, this.storage, this.deviceId, super.cashifyAlert, super.trackUrl);

  static StLotDetailResponse fromJson(Map<String, dynamic> json) => _$StLotDetailResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StLotDetailResponseToJson(this);

  void setData(StLotDetailResponse? data) {
    if (data == null) return;
    lotName = data.lotName ?? lotName;
    modelName = data.modelName ?? modelName;
    barcode = data.barcode ?? barcode;
    destination = data.destination ?? destination;
    location = data.location ?? location;
    deviceCount = data.deviceCount ?? deviceCount;
    scanCount = data.scanCount ?? scanCount;
    storage = data.storage ?? storage;
    deviceId = data.deviceId ?? deviceId;
  }
}
