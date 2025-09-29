import 'package:json_annotation/json_annotation.dart';

part 'normal_lot_out_request.g.dart';

@JsonSerializable()
class NormalLotOutRequest {

  @JsonKey(name: 'qr_code')
  String? stockBarcode;

  @JsonKey(name: 'stbr')
  String? locBarcode;

  @JsonKey(name: 'lgn')
  String? lotName;


  NormalLotOutRequest({this.stockBarcode, this.locBarcode,this.lotName,});

  static NormalLotOutRequest fromJson(Map<String, dynamic> data) => _$NormalLotOutRequestFromJson(data);

  Map<String, dynamic> toJson() => _$NormalLotOutRequestToJson(this);

}
