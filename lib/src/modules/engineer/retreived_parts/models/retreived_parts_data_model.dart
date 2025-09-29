import 'package:json_annotation/json_annotation.dart';

part 'retreived_parts_data_model.g.dart';

@JsonSerializable()
class RetrievedPartsDataModel {
  @JsonKey(name: "prid")
  int? partRetrievedId;
  @JsonKey(name: "ccd")
  String? categoryCode;
  @JsonKey(name: "rprid")
  int? retrievedPartsReasonId;
  @JsonKey(name: "rp")
  String? barcode;
  @JsonKey(name: "rpimg")
  List<String>? retrievedPartImages;

  RetrievedPartsDataModel({
    this.categoryCode,
    this.barcode,
    this.partRetrievedId,
    this.retrievedPartImages,
    this.retrievedPartsReasonId,
  });

  static RetrievedPartsDataModel fromJson(Map<String, dynamic> data) => _$RetrievedPartsDataModelFromJson(data);

  Map<String, dynamic> toJson() => _$RetrievedPartsDataModelToJson(this);
}
