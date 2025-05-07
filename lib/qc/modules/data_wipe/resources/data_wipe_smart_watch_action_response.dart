import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_wipe_smart_watch_action_response.g.dart';

@JsonSerializable()
class DataWipeSmartWatchActionResponse extends BaseResponse {
  @JsonKey(name: 'dt')
  Map<String, String>? dataWipeSmartWatchActionMap;

  DataWipeSmartWatchActionResponse(this.dataWipeSmartWatchActionMap, super.cashifyAlert, super.trackUrl);

  static DataWipeSmartWatchActionResponse fromJson(Map<String, dynamic> json) =>
      _$DataWipeSmartWatchActionResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DataWipeSmartWatchActionResponseToJson(this);

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
