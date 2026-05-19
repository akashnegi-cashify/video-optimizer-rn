import 'package:json_annotation/json_annotation.dart';

part 'retrieved_part_qc_list_response.g.dart';

@JsonSerializable()
class RetrievedPartQcListData {
  @JsonKey(name: "extractedPartId")
  int? extractedPartId;
  @JsonKey(name: "partId")
  int? partId;
  @JsonKey(name: "sku")
  String? sku;
  @JsonKey(name: "partName")
  String? partName;
  @JsonKey(name: "deviceBarcode")
  String? deviceBarcode;
  @JsonKey(name: "retrievedPartBarcode")
  String? retrievedPartBarcode;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "createdBy")
  String? createdBy;
  @JsonKey(name: "createDate")
  int? createDate;
  @JsonKey(name: "qcby")
  String? qcby;
  @JsonKey(name: "assignedTo")
  String? assignedTo;
  @JsonKey(name: "reason")
  String? reason;
  @JsonKey(name: "remark")
  String? remark;
  @JsonKey(name: "partVariationName")
  String? partVariationName;
  @JsonKey(name: "images")
  List<String>? images;

  RetrievedPartQcListData({
    this.extractedPartId,
    this.partId,
    this.sku,
    this.partName,
    this.deviceBarcode,
    this.retrievedPartBarcode,
    this.status,
    this.createdBy,
    this.createDate,
    this.qcby,
    this.assignedTo,
    this.reason,
    this.remark,
    this.partVariationName,
    this.images,
  });

  static RetrievedPartQcListData fromJson(Map<String, dynamic> json) => _$RetrievedPartQcListDataFromJson(json);

  Map<String, dynamic> toJson() => _$RetrievedPartQcListDataToJson(this);
}

