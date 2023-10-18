import 'package:json_annotation/json_annotation.dart';

part 'store_out_bin_list_response.g.dart';

@JsonSerializable()
class StoreOutBinListResponse {
  @JsonKey(name: 'dt')
  List<StoreOutBinListItem?>? binList;


  StoreOutBinListResponse({this.binList});

  static StoreOutBinListResponse fromJson(Map<String, dynamic> data) => _$StoreOutBinListResponseFromJson(data);

  Map<String, dynamic> toJson() => _$StoreOutBinListResponseToJson(this);
}

@JsonSerializable()
class StoreOutBinListItem {
  static StoreOutBinListItem fromJson(Map<String, dynamic> data) => _$StoreOutBinListItemFromJson(data);

  Map<String, dynamic> toJson() => _$StoreOutBinListItemToJson(this);

  @JsonKey(name: 'tc')
  int? totalCount;

  @JsonKey(name: 'ln')
  String? lotName;

  @JsonKey(name: 'ic')
  int? ic;

  StoreOutBinListItem({
    this.totalCount,
    this.lotName,
    this.ic,
  });
}

//"dt": [
//     {
//       "r_id": "54da450f-cdd7-425e-ac22-0a49723e063d",
//       "tc": 1,
//       "ln": "GURGAON-1220021614082671319",
//       "ic": 0
//     }
//   ]
