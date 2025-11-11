import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_wipe_smart_watch_action_response.g.dart';

@JsonSerializable()
class DataWipeSmartWatchActionResponse extends BaseResponse {
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, String>? dataWipeSmartWatchActionMap;

  DataWipeSmartWatchActionResponse(this.dataWipeSmartWatchActionMap, super.cashifyAlert, super.trackUrl);

  static DataWipeSmartWatchActionResponse fromJson(Map<String, dynamic> json) {
    final response = DataWipeSmartWatchActionResponse(
      null,
      json['__ca'] == null ? null : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

    Map<String, dynamic> rawMap;
    if (json['dt'] is Map<String, dynamic>) {
      rawMap = json['dt'] as Map<String, dynamic>;
    } else {
      rawMap = Map<String, dynamic>.from(json);
      rawMap.remove('__ca');
      rawMap.remove('turl');
    }

    response.dataWipeSmartWatchActionMap = rawMap.map((key, value) => MapEntry(key, value == null ? '' : value.toString()));
    return response;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      '__ca': cashifyAlert,
      'turl': trackUrl,
    };
    if (dataWipeSmartWatchActionMap != null) {
      dataWipeSmartWatchActionMap!.forEach((key, value) {
        json[key] = value;
      });
    }
    return json;
  }

  List<ActionItem>? toList() {
    List<ActionItem> actionItemList = [];
    if (dataWipeSmartWatchActionMap != null) {
      actionItemList = dataWipeSmartWatchActionMap!.entries.map((entry) => ActionItem(entry.key, entry.value)).toList();
    }
    return actionItemList;
  }
}

class ActionItem {
  final String key;
  final String label;

  ActionItem(this.key, this.label);
}
