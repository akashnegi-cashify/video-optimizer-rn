import 'package:json_annotation/json_annotation.dart';

part 'store_out_bin_list_response.g.dart';

@JsonSerializable()
class StoreOutBinListResponse {
  /// CshApiTable-style list container
  @JsonKey(name: 'listList')
  List<StoreOutBinListItem?>? binList;

  /// Performance monitoring metric
  @JsonKey(name: 'pm')
  double? pm;

  StoreOutBinListResponse({this.binList, this.pm});

  static StoreOutBinListResponse fromJson(Map<String, dynamic> data) => _$StoreOutBinListResponseFromJson(data);

  Map<String, dynamic> toJson() => _$StoreOutBinListResponseToJson(this);
}

@JsonSerializable()
class StoreOutBinListItem {
  static StoreOutBinListItem fromJson(Map<String, dynamic> data) => _$StoreOutBinListItemFromJson(data);

  Map<String, dynamic> toJson() => _$StoreOutBinListItemToJson(this);

  @JsonKey(name: 'lotId')
  int? lotId;

  @JsonKey(name: 'lotName')
  String? lotName;

  /// Number of lots / devices for this bin entry
  @JsonKey(name: 'counter')
  int? counter;

  /// Completion flag (0/1)
  @JsonKey(name: 'isCompleted')
  int? isCompleted;

  /// Row-level performance monitoring
  @JsonKey(name: 'pm')
  double? pm;

  StoreOutBinListItem({
    this.lotId,
    this.counter,
    this.lotName,
    this.isCompleted,
    this.pm,
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
