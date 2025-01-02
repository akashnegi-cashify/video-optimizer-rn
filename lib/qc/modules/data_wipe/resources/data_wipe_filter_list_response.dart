import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_wipe_filter_list_response.g.dart';

@JsonSerializable()
class DataWipeFilterListResponse extends BaseResponse {
  @JsonKey(name: 'dt')
  Map<String, DataWipeFilterData>? dataWipeFilterMap;

  DataWipeFilterListResponse(super.cashifyAlert, super.trackUrl);

  static DataWipeFilterListResponse fromJson(Map<String, dynamic> json) => _$DataWipeFilterListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DataWipeFilterListResponseToJson(this);
}

@JsonSerializable()
class DataWipeFilterData {
  @JsonKey(name: "fname")
  String? filterName;

  @JsonKey(name: "ftype")
  int? filterType;

  @JsonKey(name: "fval")
  List<DataWipFilterListItem>? filterList;

  static DataWipeFilterData fromJson(Map<String, dynamic> json) => _$DataWipeFilterDataFromJson(json);

  Map<String, dynamic> toJson() => _$DataWipeFilterDataToJson(this);
}

@JsonSerializable()
class DataWipFilterListItem {
  @JsonKey(name: "k")
  int? id;

  @JsonKey(name: "v")
  String? label;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isSelected;

  static DataWipFilterListItem fromJson(Map<String, dynamic> json) => _$DataWipFilterListItemFromJson(json);

  Map<String, dynamic> toJson() => _$DataWipFilterListItemToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is DataWipFilterListItem) {
      return id == other.id;
    }
    return false;
  }

  @override
  int get hashCode => Object.hashAll([id, label]);
}
