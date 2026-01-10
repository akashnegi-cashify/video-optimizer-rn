import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_movement_response.g.dart';

@JsonSerializable()
class StockMovementResponse extends BaseResponse {
  @JsonKey(name: 'dt')
  List<StockMovementListData>? stockMovementList;

  StockMovementResponse(this.stockMovementList, super.cashifyAlert, super.trackUrl);

  static StockMovementResponse fromJson(Map<String, dynamic> json) => _$StockMovementResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StockMovementResponseToJson(this);
}

@JsonSerializable()
class StockMovementListData {

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'remarks')
  String? remark;

  @JsonKey(name: 'createdBy')
  String? createdBy;

  @JsonKey(name: 'createdAt')
  int? createdAt;

  @JsonKey(name: 'IsCurrentStatus')
  bool? isCurrentStatus;

  StockMovementListData(this.status, this.remark, this.createdBy, this.createdAt, this.isCurrentStatus);

  static StockMovementListData fromJson(Map<String, dynamic> json) => _$StockMovementListDataFromJson(json);

  Map<String, dynamic> toJson() => _$StockMovementListDataToJson(this);
}
