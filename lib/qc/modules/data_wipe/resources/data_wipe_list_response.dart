import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_wipe_list_response.g.dart';

@JsonSerializable()
class DataWipeListResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<DataWipeListItem>? dataWipeList;

  DataWipeListResponse(this.dataWipeList, super.cashifyAlert, super.trackUrl);

  static DataWipeListResponse fromJson(Map<String, dynamic> json) => _$DataWipeListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DataWipeListResponseToJson(this);
}

@JsonSerializable()
class DataWipeListItem {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "qrCode")
  String? qrCode;

  @JsonKey(name: "ep")
  String? erasureProvider;

  @JsonKey(name: "sd")
  String? status;

  @JsonKey(name: "sc")
  int? statusCode;

  @JsonKey(name: "pn")
  String? productName;

  @JsonKey(name: "em")
  String? errorMessage;

  @JsonKey(name: "apiname")
  String? categoryKey;

  @JsonKey(name: "imei")
  String? imei1;

  @JsonKey(name: "imei2")
  String? imei2;

  @JsonKey(name: "sno")
  String? serialNo;

  @JsonKey(name: "epc")
  int? erasureProviderKey;

  DataWipeListItem(
    this.id,
    this.qrCode,
    this.erasureProvider,
    this.status,
    this.statusCode,
    this.productName,
    this.errorMessage,
    this.categoryKey,
    this.imei1,
    this.imei2,
    this.serialNo,
    this.erasureProviderKey,
  );

  static DataWipeListItem fromJson(Map<String, dynamic> json) => _$DataWipeListItemFromJson(json);

  Map<String, dynamic> toJson() => _$DataWipeListItemToJson(this);
}
