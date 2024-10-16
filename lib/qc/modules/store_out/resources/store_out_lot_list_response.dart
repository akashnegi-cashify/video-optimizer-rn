import 'package:json_annotation/json_annotation.dart';

part 'store_out_lot_list_response.g.dart';

@JsonSerializable()
class StoreOutLotListResponse {
  @JsonKey(name: 'dt')
  List<StoreOutLotListItem>? lotList;

  @JsonKey(name: 'tc')
  int? totalCount;

  @JsonKey(name: 's')
  bool? status;


  StoreOutLotListResponse({this.lotList});

  static StoreOutLotListResponse fromJson(Map<String, dynamic> data) => _$StoreOutLotListResponseFromJson(data);

  Map<String, dynamic> toJson() => _$StoreOutLotListResponseToJson(this);

  bool isValid(){
    return status == true;
  }
}

@JsonSerializable()
class StoreOutLotListItem {
  static StoreOutLotListItem fromJson(Map<String, dynamic> data) => _$StoreOutLotListItemFromJson(data);

  Map<String, dynamic> toJson() => _$StoreOutLotListItemToJson(this);

  @JsonKey(name: 'lot_id')
  int? lotId;

  @JsonKey(name: 'lc')
  int? lotCount;

  @JsonKey(name: 'lgn')
  String? lotGrpName;

  @JsonKey(name: 'lt')
  String? lotType;

  @JsonKey(name: 'ch')
  String? ch;

  @JsonKey(name: 'dc')
  int? deviceCount;

  @JsonKey(name: 'isinstout')
  bool? isStoreOutInProcess;

  StoreOutLotListItem({
    this.lotId,
    this.lotCount,
    this.lotGrpName,
    this.lotType,
    this.ch,
    this.deviceCount,
    this.isStoreOutInProcess,
  });
}
