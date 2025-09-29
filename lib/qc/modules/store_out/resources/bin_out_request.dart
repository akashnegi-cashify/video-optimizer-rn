import 'package:json_annotation/json_annotation.dart';

part 'bin_out_request.g.dart';

@JsonSerializable()
class BinOutRequest {

  String? stockBarcode;
  String? locBarcode;


  BinOutRequest({this.stockBarcode, this.locBarcode,});

  static BinOutRequest fromJson(Map<String, dynamic> data) => _$BinOutRequestFromJson(data);

  Map<String, dynamic> toJson() => _$BinOutRequestToJson(this);

}
