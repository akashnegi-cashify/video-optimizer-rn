import 'package:json_annotation/json_annotation.dart';

part 'stock_in_submit_response.g.dart';

@JsonSerializable()
class StockInSubmitResponse {
  @JsonKey(name: "success")
  bool? success;

  @JsonKey(name: "s")
  bool? status;

  @JsonKey(name: "cm")
  String? confirmationMessage;

  static StockInSubmitResponse fromJson(Map<String, dynamic> data) => _$StockInSubmitResponseFromJson(data);

  Map<String, dynamic> toJson() => _$StockInSubmitResponseToJson(this);
}
