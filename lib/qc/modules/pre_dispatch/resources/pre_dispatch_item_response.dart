import 'package:json_annotation/json_annotation.dart';

part 'pre_dispatch_item_response.g.dart';

@JsonSerializable()
class PreDispatchItemResponse {
  @JsonKey(name: "dt")
  List<PreDispatchItem?>? items;

  @JsonKey(name: "tc")
  int? totalCount;

  @JsonKey(name: "success")
  bool? success;

  @JsonKey(name: "s")
  bool? status;

  static PreDispatchItemResponse fromJson(Map<String, dynamic> data) => _$PreDispatchItemResponseFromJson(data);

  Map<String, dynamic> toJson() => _$PreDispatchItemResponseToJson(this);

  PreDispatchItemResponse({
    this.items,
    this.totalCount,
    this.success,
    this.status,
  });
}

@JsonSerializable()
class PreDispatchItem {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "did")
  int? deviceId;

  @JsonKey(name: "mpid")
  int? mpid;

  @JsonKey(name: "qr_code")
  String? qrCode;

  @JsonKey(name: "m")
  String? model;

  @JsonKey(name: "b")
  String? brand;

  @JsonKey(name: "im")
  String? imei;

  @JsonKey(name: "s")
  int? status;

  @JsonKey(name: "gr")
  String? grade;

  @JsonKey(name: "pt")
  String? productTitle;

  @JsonKey(name: "ta")
  int? testAge;

  @JsonKey(name: "sd")
  String? statusDescription;

  PreDispatchItem({
    this.id,
    this.deviceId,
    this.mpid,
    this.qrCode,
    this.model,
    this.brand,
    this.imei,
    this.status,
    this.grade,
    this.productTitle,
    this.testAge,
    this.statusDescription,
  });

  static PreDispatchItem fromJson(Map<String, dynamic> data) => _$PreDispatchItemFromJson(data);

  Map<String, dynamic> toJson() => _$PreDispatchItemToJson(this);
}
