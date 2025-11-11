import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_wipe_filter_list_response.g.dart';

@JsonSerializable()
class DataWipeFilterListResponse extends BaseResponse {
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, DataWipeFilterData>? dataWipeFilterMap;

  DataWipeFilterListResponse(super.cashifyAlert, super.trackUrl);

  static DataWipeFilterListResponse fromJson(Map<String, dynamic> json) {
    // Support both formats:
    // Old: { "__ca": ..., "turl": ..., "dt": { "status": {...}, ... } }
    // New: { "__ca": ..., "turl": ..., "status": {...}, ... } (no 'dt' wrapper)
    final response = DataWipeFilterListResponse(
      json['__ca'] == null ? null : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

    Map<String, dynamic> rawMap;
    if (json['dt'] is Map<String, dynamic>) {
      rawMap = (json['dt'] as Map<String, dynamic>);
    } else {
      rawMap = Map<String, dynamic>.from(json);
      // Remove non-filter keys if present
      rawMap.remove('__ca');
      rawMap.remove('turl');
    }

    response.dataWipeFilterMap = Map.fromEntries(
      rawMap.entries
          .where((entry) => entry.value is Map)
          .map(
            (entry) => MapEntry(
              entry.key,
              DataWipeFilterData.fromJson(
                Map<String, dynamic>.from(entry.value as Map),
              ),
            ),
          ),
    );

    return response;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      '__ca': cashifyAlert,
      'turl': trackUrl,
    };
    // Serialize filters at the top-level (no 'dt' wrapper)
    if (dataWipeFilterMap != null) {
      dataWipeFilterMap!.forEach((key, value) {
        json[key] = value.toJson();
      });
    }
    return json;
  }
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
