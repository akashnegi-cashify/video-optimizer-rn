import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_transfer_status_filter_response.g.dart';

@JsonSerializable()
class StockTransferStatusFilterResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<StockTransferStatusFilterData>? filterList;

  @JsonKey(name: "s")
  bool? success;

  StockTransferStatusFilterResponse(this.filterList, this.success, super.cashifyAlert, super.trackUrl);

  static StockTransferStatusFilterResponse fromJson(Map<String, dynamic> json) =>
      _$StockTransferStatusFilterResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StockTransferStatusFilterResponseToJson(this);
}

@JsonSerializable()
class StockTransferStatusFilterData {
  @JsonKey(name: "v")
  String? name;

  @JsonKey(name: "k")
  int? id;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isSelected;

  StockTransferStatusFilterData({this.name, this.id, this.isSelected});

  StockTransferStatusFilterData clone() => StockTransferStatusFilterData(name: name, id: id, isSelected: isSelected);

  static StockTransferStatusFilterData fromJson(Map<String, dynamic> json) =>
      _$StockTransferStatusFilterDataFromJson(json);

  Map<String, dynamic> toJson() => _$StockTransferStatusFilterDataToJson(this);
}
