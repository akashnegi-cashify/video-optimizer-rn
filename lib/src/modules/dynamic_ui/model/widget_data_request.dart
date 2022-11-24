import 'package:console_flutter_template/src/modules/dynamic_ui/model/dashboard_widget_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'widget_data_request.g.dart';

@JsonSerializable()
class WidgetDateRequest {
  @JsonKey(name: 'widget')
  String? widgetKey;
  @JsonKey(name: 'templateFilters')
  List<TemplateFilterList>? templateFilters;

  static WidgetDateRequest fromJson(Map<String, dynamic> data) => _$WidgetDateRequestFromJson(data);

  Map<String, dynamic> toJson() => _$WidgetDateRequestToJson(this);

  WidgetDateRequest({
    this.widgetKey,
    this.templateFilters,
  });
}
