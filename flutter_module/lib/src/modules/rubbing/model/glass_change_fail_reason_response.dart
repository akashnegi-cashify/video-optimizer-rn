import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'glass_change_fail_reason_response.g.dart';

@JsonSerializable()
class GlassChangeFailReasonResponse extends BaseResponse {
  @JsonKey(name: "dt")
  Map<String, String>? reasonMap;

  List<GlassChangeFailReasonItem> get reasonList {
    List<GlassChangeFailReasonItem> list = [];
    reasonMap?.forEach((key, value) {
      list.add(GlassChangeFailReasonItem(key, value));
    });
    return list;
  }

  GlassChangeFailReasonResponse(this.reasonMap, super.cashifyAlert, super.trackUrl);

  static GlassChangeFailReasonResponse fromJson(Map<String, dynamic> json) =>
      _$GlassChangeFailReasonResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GlassChangeFailReasonResponseToJson(this);
}

class GlassChangeFailReasonItem {
  String? key;
  String? value;

  GlassChangeFailReasonItem(this.key, this.value);
}
