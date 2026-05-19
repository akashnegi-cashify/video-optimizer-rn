import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_transfer_status_filter_v1_response.g.dart';

@JsonSerializable()
class StockTransferStatusFilterV1Response extends BaseResponse {
  @JsonKey(name: "dt")
  List<StockTransferStatusFilterData>? filterList;

  StockTransferStatusFilterV1Response(this.filterList, super.cashifyAlert, super.trackUrl);

  static StockTransferStatusFilterV1Response fromJson(Map<String, dynamic> json) =>
      _$StockTransferStatusFilterV1ResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StockTransferStatusFilterV1ResponseToJson(this);
}

@JsonSerializable()
class StockTransferStatusFilterData {
  @JsonKey(name: "v")
  String? name;

  @JsonKey(name: "k")
  String? id;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isSelected;

  StockTransferStatusFilterData({this.name, this.id, this.isSelected});

  StockTransferStatusFilterData clone() => StockTransferStatusFilterData(name: name, id: id, isSelected: isSelected);

  static StockTransferStatusFilterData fromJson(Map<String, dynamic> json) =>
      _$StockTransferStatusFilterDataFromJson(json);

  Map<String, dynamic> toJson() => _$StockTransferStatusFilterDataToJson(this);
}
