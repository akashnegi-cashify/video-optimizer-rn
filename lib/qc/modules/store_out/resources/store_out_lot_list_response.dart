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

  // v1/store-out/list item fields
  @JsonKey(name: 'lotId')
  int? lotId;

  @JsonKey(name: 'lotCount')
  int? lotCount;

  @JsonKey(name: 'lotGroupName')
  String? lotGrpName;

  @JsonKey(name: 'lotType')
  String? lotType;

  @JsonKey(name: 'channel')
  String? ch;

  @JsonKey(name: 'deviceCount')
  int? deviceCount;

  @JsonKey(name: 'isInStoreOut')
  bool? isStoreOutInProcess;

  @JsonKey(name: 'facilityId')
  int? facilityId;

  @JsonKey(name: 'facilityName')
  String? facilityName;

  StoreOutLotListItem({
    this.lotId,
    this.lotCount,
    this.lotGrpName,
    this.lotType,
    this.ch,
    this.deviceCount,
    this.isStoreOutInProcess,
    this.facilityId,
    this.facilityName,
  });
}
